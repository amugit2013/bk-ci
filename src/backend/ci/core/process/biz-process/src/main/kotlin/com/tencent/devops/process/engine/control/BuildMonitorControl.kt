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

package com.tencent.devops.process.engine.control

import com.tencent.devops.common.api.util.timestampmilli
import com.tencent.devops.common.event.dispatcher.pipeline.PipelineEventDispatcher
import com.tencent.devops.common.event.enums.ActionType
import com.tencent.devops.common.pipeline.enums.BuildStatus
import com.tencent.devops.common.service.utils.MessageCodeUtil
import com.tencent.devops.log.utils.LogUtils
import com.tencent.devops.process.constant.ProcessMessageCode.ERROR_TIMEOUT_IN_BUILD_QUEUE
import com.tencent.devops.process.constant.ProcessMessageCode.ERROR_TIMEOUT_IN_RUNNING
import com.tencent.devops.process.engine.pojo.BuildInfo
import com.tencent.devops.process.engine.pojo.PipelineBuildContainer
import com.tencent.devops.process.engine.pojo.event.PipelineBuildFinishEvent
import com.tencent.devops.process.engine.pojo.event.PipelineBuildMonitorEvent
import com.tencent.devops.process.engine.pojo.event.PipelineBuildStartEvent
import com.tencent.devops.process.engine.service.PipelineRuntimeExtService
import com.tencent.devops.process.engine.service.PipelineRuntimeService
import com.tencent.devops.common.api.pojo.ErrorCode
import com.tencent.devops.common.api.pojo.ErrorType
import com.tencent.devops.process.engine.common.Timeout
import com.tencent.devops.process.engine.pojo.PipelineBuildStage
import com.tencent.devops.process.engine.pojo.event.PipelineBuildStageEvent
import com.tencent.devops.process.pojo.mq.PipelineBuildContainerEvent
import com.tencent.devops.process.service.PipelineSettingService
import org.slf4j.LoggerFactory
import org.springframework.amqp.rabbit.core.RabbitTemplate
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.util.concurrent.TimeUnit

/**
 * 构建控制器
 * @version 1.0
 */
@Service
class BuildMonitorControl @Autowired constructor(
    private val rabbitTemplate: RabbitTemplate,
    private val pipelineEventDispatcher: PipelineEventDispatcher,
    private val pipelineSettingService: PipelineSettingService,
    private val pipelineRuntimeService: PipelineRuntimeService,
    private val pipelineRuntimeExtService: PipelineRuntimeExtService
) {

    private val logger = LoggerFactory.getLogger(javaClass)!!

    fun handle(event: PipelineBuildMonitorEvent): Boolean {

        val buildId = event.buildId
        val buildInfo = pipelineRuntimeService.getBuildInfo(buildId) ?: return false
        if (BuildStatus.isFinish(buildInfo.status)) {
            logger.info("[$buildId]|monitor| is ${buildInfo.status}")
            return true
        }

        return when {
            BuildStatus.isReadyToRun(buildInfo.status) -> monitorQueueBuild(event, buildInfo)
            else -> {
                monitorContainer(event)
                monitorStage(event)
            }
        }
    }

    private fun monitorContainer(event: PipelineBuildMonitorEvent): Boolean {

        val containers = pipelineRuntimeService.listContainers(event.buildId)
            .filter {
                !BuildStatus.isFinish(it.status)
            }

        if (containers.isEmpty()) {
            logger.info("[${event.buildId}]|monitor| have not need monitor job!")
            return true
        }

        var minInterval = CONTAINER_MAX_MILLS

        containers.forEach { container ->
            val interval = container.checkNextContainerMonitorIntervals(event.userId)
            // 根据最小的超时时间来决定下一次监控执行的时间
            if (interval in 1 until minInterval) {
                minInterval = interval
            }
        }

        if (minInterval < CONTAINER_MAX_MILLS) {
            logger.info("[${event.buildId}]|monitor_continue|pipelineId=${event.pipelineId}")
            event.delayMills = minInterval
            pipelineEventDispatcher.dispatch(event)
        }

        return true
    }

    private fun monitorStage(event: PipelineBuildMonitorEvent): Boolean {

        val stages = pipelineRuntimeService.listStages(event.buildId)
            .filter {
                !BuildStatus.isFinish(it.status)
            }

        if (stages.isEmpty()) {
            logger.info("[${event.buildId}]|monitor| have not need monitor stage!")
            return true
        }

        var minInterval = STAGE_MAX_MILLS

        stages.forEach { stage ->
            val interval = stage.checkNextStageMonitorIntervals(event.userId)
            // 根据最小的超时时间来决定下一次监控执行的时间
            if (interval in 1 until minInterval) {
                minInterval = interval
            }
        }

        if (minInterval < STAGE_MAX_MILLS) {
            logger.info("[${event.buildId}]|monitor_continue|pipelineId=${event.pipelineId}")
            event.delayMills = minInterval
            pipelineEventDispatcher.dispatch(event)
        }

        return true
    }

    companion object {
        val MAX_MINUTES = TimeUnit.DAYS.toMinutes(7L) // 7 * 24 * 60 = 10080 分钟 = 最多超时7天
        val CONTAINER_MAX_MILLS = TimeUnit.MINUTES.toMillis(MAX_MINUTES).toInt() + 1 // 毫秒+1
        val MAX_HOURS = TimeUnit.DAYS.toHours(30)
        val STAGE_MAX_MILLS = TimeUnit.HOURS.toMillis(MAX_HOURS).toInt() + 1
    }

    private fun PipelineBuildContainer.checkNextContainerMonitorIntervals(userId: String): Int {

        var interval = 0

        if (BuildStatus.isFinish(status)) {
            logger.info("[$buildId]|container=$containerId| is $status")
            return interval
        }
        var minute = controlOption?.jobControlOption?.timeout ?: Timeout.DEFAULT_TIMEOUT_MIN
        if (minute <= 0 || minute > MAX_MINUTES) {
            minute = MAX_MINUTES.toInt()
        }
        val timeoutMills = TimeUnit.MINUTES.toMillis(minute.toLong())

        val usedTimeMills: Long = if (BuildStatus.isRunning(status) && startTime != null) {
            System.currentTimeMillis() - startTime!!.timestampmilli()
        } else {
            0
        }

        logger.info("[$buildId]|container=$containerId|timeoutMills=$timeoutMills|useTimeMills=$usedTimeMills")

        interval = (timeoutMills - usedTimeMills).toInt()
        if (interval <= 0) {
            val tag = if (containerType == "normal") {
                "TIME_OUT_Job#$containerId(N)"
            } else {
                "TIME_OUT_Job#$containerId"
            }
            val errorInfo = MessageCodeUtil.generateResponseDataObject<String>(
                messageCode = ERROR_TIMEOUT_IN_RUNNING,
                params = arrayOf("Job", "$minute")
            )
            LogUtils.addRedLine(
                rabbitTemplate = rabbitTemplate,
                buildId = buildId,
                message = errorInfo.message ?: "Job运行达到($minute)分钟，超时结束运行!",
                tag = tag,
                jobId = containerId,
                executeCount = 1
            )
            logger.warn("[$buildId]|monitor_container_timeout|container=$containerId")
            // 终止当前容器下的任务
            pipelineEventDispatcher.dispatch(
                PipelineBuildContainerEvent(
                    source = "running_timeout",
                    projectId = projectId,
                    pipelineId = pipelineId,
                    userId = userId,
                    buildId = buildId,
                    stageId = stageId,
                    containerId = containerId,
                    containerType = containerType,
                    actionType = ActionType.TERMINATE,
                    reason = errorInfo.message ?: "Job运行达到($minute)分钟，超时结束运行!"
                )
            )
        }

        return interval
    }

    private fun PipelineBuildStage.checkNextStageMonitorIntervals(userId: String): Int {
        logger.warn("[$buildId]|prepare_monitor_stage|stage=$stageId")
        var interval = 0

        if (BuildStatus.STAGE_SUCCESS != status) {
            logger.info("[$buildId]|stage=$stageId| is $status")
            return interval
        }
        logger.warn("[$buildId]|start_monitor_stage|stage=$stageId")

        var hours = controlOption?.stageControlOption?.timeout ?: Timeout.DEFAULT_STAGE_TIMEOUT_HOURS
        if (hours <= 0 || hours > MAX_HOURS) {
            hours = MAX_HOURS.toInt()
        }
        val timeoutMills = TimeUnit.HOURS.toMillis(hours.toLong())

        val usedTimeMills: Long = if (startTime != null) {
            System.currentTimeMillis() - startTime!!.timestampmilli()
        } else {
            0
        }

        logger.info("[$buildId]|stage=$stageId|timeoutMills=$timeoutMills|useTimeMills=$usedTimeMills")

        interval = (timeoutMills - usedTimeMills).toInt()
        if (interval <= 0) {
            LogUtils.addRedLine(
                rabbitTemplate = rabbitTemplate,
                buildId = buildId,
                message = "审核触发时间超过($hours)小时，流水线将无法继续执行",
                tag = stageId,
                jobId = "",
                executeCount = 1
            )
            logger.warn("[$buildId]|monitor_stage_timeout|stage=$stageId")
            // 将改stage状态设为STAGE_SUCCESS
            pipelineEventDispatcher.dispatch(
                PipelineBuildStageEvent(
                    source = "running_timeout",
                    projectId = projectId,
                    pipelineId = pipelineId,
                    userId = userId,
                    buildId = buildId,
                    stageId = stageId,
                    actionType = ActionType.END
                )
            )
        }

        return interval
    }

    private fun monitorQueueBuild(event: PipelineBuildMonitorEvent, buildInfo: BuildInfo): Boolean {
        // 判断是否超时
        if (pipelineSettingService.isQueueTimeout(event.pipelineId, buildInfo.startTime!!)) {
            logger.info("[${event.buildId}]|monitor| queue timeout")
            val errorInfo = MessageCodeUtil.generateResponseDataObject<String>(
                messageCode = ERROR_TIMEOUT_IN_BUILD_QUEUE,
                params = arrayOf(event.buildId)
            )
            LogUtils.addRedLine(
                rabbitTemplate = rabbitTemplate,
                buildId = event.buildId,
                message = errorInfo.message ?: "排队超时，取消运行! [${event.buildId}]",
                tag = "QUEUE_TIME_OUT",
                jobId = "",
                executeCount = 1
            )
            pipelineEventDispatcher.dispatch(
                PipelineBuildFinishEvent(
                    source = "queue_timeout",
                    projectId = event.projectId,
                    pipelineId = event.pipelineId,
                    userId = event.userId,
                    buildId = event.buildId,
                    status = BuildStatus.QUEUE_TIMEOUT,
                    errorType = ErrorType.USER,
                    errorCode = ErrorCode.USER_JOB_OUTTIME_LIMIT,
                    errorMsg = "Job排队超时，请检查并发配置"
                )
            )
        } else {
            // 判断当前监控的排队构建是否可以尝试启动(仅当前是在队列中排第1位的构建可以)
            if (pipelineRuntimeExtService.queueCanPend2Start(event.pipelineId, buildInfo.buildId)) {
                logger.info("[${event.buildId}]|monitor| still queue, to start it!")
                pipelineEventDispatcher.dispatch(
                    PipelineBuildStartEvent(
                        source = "start_monitor",
                        projectId = buildInfo.projectId,
                        pipelineId = buildInfo.pipelineId,
                        userId = buildInfo.startUser,
                        buildId = buildInfo.buildId,
                        taskId = buildInfo.firstTaskId,
                        status = BuildStatus.RUNNING,
                        actionType = ActionType.START
                    )
                )
            }
            // next time to loop monitor
            pipelineEventDispatcher.dispatch(event)
        }

        return true
    }
}
