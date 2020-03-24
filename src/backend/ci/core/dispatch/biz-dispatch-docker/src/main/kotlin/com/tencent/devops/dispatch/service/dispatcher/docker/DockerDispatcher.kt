/*
 * Tencent is pleased to support the open source community by making BK-CI 蓝鲸持续集成平台 available.
 *
 * Copyright (C) 2019 THL A29 Limited, a Tencent company.  All rights reserved.
 *
 * BK-CI 蓝鲸持续集成平台 is licensed under the MIT license.
 *
 * A copy of the MIT License is included in this file.
 *
 *
 * Terms of the MIT License:
 * ---------------------------------------------------
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
 * LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
 * NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.tencent.devops.dispatch.service.dispatcher.docker

import com.tencent.devops.common.pipeline.type.docker.DockerDispatchType
import com.tencent.devops.common.redis.RedisOperation
import com.tencent.devops.dispatch.client.DockerHostClient
import com.tencent.devops.dispatch.dao.PipelineDockerIPInfoDao
import com.tencent.devops.dispatch.dao.PipelineDockerTaskSimpleDao
import com.tencent.devops.dispatch.pojo.VolumeStatus
import com.tencent.devops.dispatch.service.DockerHostBuildService
import com.tencent.devops.dispatch.service.dispatcher.Dispatcher
import com.tencent.devops.dispatch.utils.DockerHostLock
import com.tencent.devops.log.utils.LogUtils
import com.tencent.devops.process.pojo.mq.PipelineAgentShutdownEvent
import com.tencent.devops.process.pojo.mq.PipelineAgentStartupEvent
import org.jooq.DSLContext
import org.slf4j.LoggerFactory
import org.springframework.amqp.rabbit.core.RabbitTemplate
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Component

@Component
class DockerDispatcher @Autowired constructor(
    private val rabbitTemplate: RabbitTemplate,
    private val dockerHostBuildService: DockerHostBuildService,
    private val dockerHostClient: DockerHostClient,
    private val pipelineDockerTaskSimpleDao: PipelineDockerTaskSimpleDao,
    private val pipelineDockerIpInfoDao: PipelineDockerIPInfoDao,
    private val dslContext: DSLContext,
    private val redisOperation: RedisOperation
    ) : Dispatcher {

    companion object {
        private val logger = LoggerFactory.getLogger(DockerDispatcher::class.java)
    }

    override fun canDispatch(pipelineAgentStartupEvent: PipelineAgentStartupEvent) =
        pipelineAgentStartupEvent.dispatchType is DockerDispatchType

    override fun startUp(pipelineAgentStartupEvent: PipelineAgentStartupEvent) {
        val dockerDispatch = pipelineAgentStartupEvent.dispatchType as DockerDispatchType
        LogUtils.addLine(
            rabbitTemplate,
            pipelineAgentStartupEvent.buildId,
            "Start docker ${dockerDispatch.dockerBuildVersion} for the build",
            "",
            pipelineAgentStartupEvent.containerHashId,
            pipelineAgentStartupEvent.executeCount ?: 1
        )

        val taskHistory = pipelineDockerTaskSimpleDao.getByPipelineIdAndVMSeq(dslContext, pipelineAgentStartupEvent.pipelineId, pipelineAgentStartupEvent.vmSeqId)
        var dockerIp: String
        if (taskHistory != null) {
            dockerIp = taskHistory.dockerIp
            // 查看当前IP负载情况，当前IP负载未超额（内存低于90%且硬盘低于90%），可直接下发，当负载超额，重新选择构建机
            val ipInfo = pipelineDockerIpInfoDao.getDockerIpInfo(dslContext, dockerIp)
            if (ipInfo.diskLoad > 90 || ipInfo.memLoad > 90) {
                dockerIp = dockerHostClient.getAvailableDockerIp()
                pipelineDockerTaskSimpleDao.updateDockerIp(dslContext, pipelineAgentStartupEvent.pipelineId, pipelineAgentStartupEvent.vmSeqId, dockerIp)
                logger.info("${pipelineAgentStartupEvent.pipelineId}|${pipelineAgentStartupEvent.buildId}|${pipelineAgentStartupEvent.vmSeqId}| origin host: ${taskHistory.dockerIp} " +
                        "overload, DiskLoad: ${ipInfo.diskLoad}|MemLoad: ${ipInfo.memLoad}, switch to new host: $dockerIp")
            }

            // 更新状态running
            pipelineDockerTaskSimpleDao.updateStatus(dslContext, pipelineAgentStartupEvent.pipelineId, pipelineAgentStartupEvent.vmSeqId, VolumeStatus.RUNNING.status)
        } else {
            dockerIp = dockerHostClient.getAvailableDockerIp()

            pipelineDockerTaskSimpleDao.create(
                dslContext,
                pipelineAgentStartupEvent.pipelineId,
                pipelineAgentStartupEvent.vmSeqId,
                dockerIp,
                VolumeStatus.RUNNING.status
            )
        }

        try {
            dockerHostClient.startBuild(pipelineAgentStartupEvent, dockerIp)
        } catch (e: Exception) {
            logger.error("[${pipelineAgentStartupEvent.projectId}|${pipelineAgentStartupEvent.pipelineId}|${pipelineAgentStartupEvent.buildId}] Start build Docker VM failed.", e)
            pipelineDockerTaskSimpleDao.updateStatus(dslContext, pipelineAgentStartupEvent.pipelineId, pipelineAgentStartupEvent.vmSeqId, VolumeStatus.FAILURE.status)
            throw RuntimeException(e.message)
        }
    }

    override fun shutdown(pipelineAgentShutdownEvent: PipelineAgentShutdownEvent) {
        dockerHostBuildService.finishDockerBuild(
            pipelineAgentShutdownEvent.buildId,
            pipelineAgentShutdownEvent.vmSeqId,
            pipelineAgentShutdownEvent.buildResult
        )

        logger.info("On shutdown - ($pipelineAgentShutdownEvent|$)")
        val lock = DockerHostLock(redisOperation, pipelineAgentShutdownEvent.pipelineId)
        try {
            lock.lock()
            if (pipelineAgentShutdownEvent.vmSeqId != null) {
                val taskHistory = pipelineDockerTaskSimpleDao.getByPipelineIdAndVMSeq(dslContext, pipelineAgentShutdownEvent.pipelineId, pipelineAgentShutdownEvent.vmSeqId!!)
                dockerHostClient.endBuild(pipelineAgentShutdownEvent, taskHistory!!.dockerIp as String, taskHistory.containerId as String)
                pipelineDockerTaskSimpleDao.updateStatus(dslContext, pipelineAgentShutdownEvent.pipelineId, pipelineAgentShutdownEvent.vmSeqId!!, VolumeStatus.FINISH.status)
            } else {
                val taskHistoryList = pipelineDockerTaskSimpleDao.getByPipelineId(dslContext, pipelineAgentShutdownEvent.pipelineId)
                taskHistoryList.forEach {
                    dockerHostClient.endBuild(pipelineAgentShutdownEvent, it.dockerIp as String, it.containerId as String)
                    if (it.status == VolumeStatus.RUNNING.status) {
                        pipelineDockerTaskSimpleDao.updateStatus(dslContext, pipelineAgentShutdownEvent.pipelineId, it.vmSeq as String, VolumeStatus.FINISH.status)
                    }
                }
            }
        } catch (e: Exception) {
            logger.info("[${pipelineAgentShutdownEvent.projectId}|${pipelineAgentShutdownEvent.pipelineId}|${pipelineAgentShutdownEvent.buildId}] Shutdown Docker job failed. msg:${e.message}")
            throw RuntimeException("停止构建机失败，错误信息:${e.message}")
        } finally {
            lock.unlock()
        }
    }

//    override fun canDispatch(buildMessage: PipelineBuildMessage) =
//        buildMessage.dispatchType.buildType == BuildType.DOCKER
//
//    override fun build(buildMessage: PipelineBuildMessage) {
//        val dockerDispatch = buildMessage.dispatchType as DockerDispatchType
//        LogUtils.addLine(client, buildMessage.buildId, "Start docker ${dockerDispatch.dockerBuildVersion} for the build", "", buildMessage.executeCount ?: 1)
//        dockerHostBuildService.dockerHostBuild(buildMessage)
//    }
//
//    override fun finish(buildFinishMessage: PipelineFinishMessage) {
//        dockerHostBuildService.finishDockerBuild(
//            buildFinishMessage.buildId,
//            buildFinishMessage.vmSeqId,
//            buildFinishMessage.buildResult
//        )
//    }
}
