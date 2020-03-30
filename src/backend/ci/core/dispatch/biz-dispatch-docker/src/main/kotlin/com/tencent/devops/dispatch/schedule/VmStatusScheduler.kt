package com.tencent.devops.dispatch.schedule

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
import com.tencent.devops.common.api.util.OkhttpUtils
import com.tencent.devops.common.redis.RedisLock
import com.tencent.devops.common.redis.RedisOperation
import com.tencent.devops.dispatch.dao.PipelineDockerIPInfoDao
import com.tencent.devops.model.dispatch.tables.records.TDispatchPipelineDockerIpInfoRecord
import okhttp3.Request
import org.jooq.DSLContext
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.beans.factory.annotation.Value
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component
import java.lang.Exception
import java.net.URLEncoder

@Component
class VmStatusScheduler @Autowired constructor(
    private val dslContext: DSLContext,
    private val pipelineDockerIpInfoDao: PipelineDockerIPInfoDao,
    private val redisOperation: RedisOperation
) {
    companion object {
        private val logger = LoggerFactory.getLogger(VmStatusScheduler::class.java)
        private const val jobLockKey = "dispatch_idc_cron_volume_fresh_job"
    }

    @Value("\${devopsGateway.idcProxy}")
    val idcProxy: String? = null

    @Scheduled(cron = "0 0/5 * * * ?")
    fun run() {
        logger.info("VolumeStatusUpdateJob start")

        val redisLock = RedisLock(redisOperation, jobLockKey, 3600L)
        try {
            val lockSuccess = redisLock.tryLock()
            if (lockSuccess) {
                logger.info("IDC VM status fresh start")
                executeTask()
            }
        } catch (e: Throwable) {
            logger.error("IDC VM status fresh exception", e)
        } finally {
            redisLock.unlock()
        }
    }

    private fun executeTask() {
        var grayEnv = false
        val gray = System.getProperty("gray.project", "none")
        if (gray == "grayproject") {
            grayEnv = true
        }
        logger.info("getAvailableDockerIp gray: $gray")
        val dockerIpList = pipelineDockerIpInfoDao.getEnableDockerIpList(dslContext, grayEnv)
        dockerIpList.parallelStream().forEach {
            singleTask(it)
        }
    }

    private fun singleTask(it: TDispatchPipelineDockerIpInfoRecord) {
        val itDockerIp = it.dockerIp as String
        val capacity = it.capacity as Int
        val enable = it.enable as Boolean
        val url = "http://$itDockerIp/api/docker/host/load"
        val proxyUrl = "$idcProxy/proxy-devnet?url=${urlEncode(url)}"
        val request = Request.Builder().url(proxyUrl)
            .addHeader("Accept", "application/json; charset=utf-8")
            .addHeader("Content-Type", "application/json; charset=utf-8")
            .build()

        logger.info("Docker VM status fresh url: $proxyUrl")
        try {
            OkhttpUtils.doHttp(request).use { resp ->
                val responseBody = resp.body()!!.string()
                logger.info("Docker VM $itDockerIp status fresh responseBody: $responseBody")
                val response: Map<String, Any> = jacksonObjectMapper().readValue(responseBody)
                if (response["status"] == 0) {
                    val dockerHostLoad: Map<String, Any> = response["data"] as LinkedHashMap<String, Any>
                    val usedNum = dockerHostLoad["usedContainerNum"] as Int
                    val averageCpuLoad = dockerHostLoad["averageCpuLoad"] as Int
                    val averageMemLoad = dockerHostLoad["averageMemLoad"] as Int
                    val averageDiskLoad = dockerHostLoad["averageDiskLoad"] as Int
                    val averageDiskIOLoad = dockerHostLoad["averageDiskIOLoad"] as Int
                    pipelineDockerIpInfoDao.update(dslContext, itDockerIp, capacity, usedNum, averageCpuLoad,
                        averageMemLoad, averageDiskLoad, averageDiskIOLoad, enable)
                } else {
                    val msg = response["message"] as String
                    logger.error("Get Docker VM container failed, msg: $msg")

                }
            }
        } catch (e: Exception) {
            // 更新容器状态
            pipelineDockerIpInfoDao.updateDockerIpStatus(dslContext, it.id, false)
            logger.error("Get Docker VM: $itDockerIp container failed.", e)
        }
    }

    private fun urlEncode(s: String) = URLEncoder.encode(s, "UTF-8")
}