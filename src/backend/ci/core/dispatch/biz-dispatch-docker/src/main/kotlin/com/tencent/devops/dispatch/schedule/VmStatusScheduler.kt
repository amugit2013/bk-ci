package com.tencent.devops.dispatch.schedule

import com.fasterxml.jackson.module.kotlin.jacksonObjectMapper
import com.fasterxml.jackson.module.kotlin.readValue
import com.tencent.devops.common.api.util.OkhttpUtils
import com.tencent.devops.common.redis.RedisLock
import com.tencent.devops.common.redis.RedisOperation
import com.tencent.devops.dispatch.dao.DockerIPInfoDao
import okhttp3.Request
import org.jooq.DSLContext
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.scheduling.annotation.Scheduled
import org.springframework.stereotype.Component

@Component
class VmStatusScheduler @Autowired constructor(
    private val dslContext: DSLContext,
    private val dockerIpInfoDao: DockerIPInfoDao,
    private val redisOperation: RedisOperation
) {
    companion object {
        private val logger = LoggerFactory.getLogger(VmStatusScheduler::class.java)
        private const val jobLockKey = "dispatch_idc_cron_volume_fresh_job"
    }

    @Scheduled(cron = "0 0/1 * * * ?")
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

    fun executeTask() {
        var grayEnv = false
        val gray = System.getProperty("gray.project", "none")
        if (gray == "grayproject") {
            grayEnv = true
        }
        logger.info("getAvailableDockerIp gray: $gray")
        val idcIpList = dockerIpInfoDao.getEnableIdcIpList(dslContext, grayEnv)
        idcIpList.parallelStream().forEach {
            val itIdcIp = it.idcIp as String
            val capacity = it.capacity as Int
            val enable = it.enable as Boolean
            val url = "http://$itIdcIp/api/docker/container/count"
            val request = Request.Builder().url(url)
                .addHeader("Accept", "application/json; charset=utf-8")
                .addHeader("Content-Type", "application/json; charset=utf-8")
                .build()

            logger.info("Docker VM status fresh url: $url")
            OkhttpUtils.doHttp(request).use { resp ->
                val responseBody = resp.body()!!.string()
                logger.info("Docker VM $itIdcIp status fresh responseBody: $responseBody")
                val response: Map<String, Any> = jacksonObjectMapper().readValue(responseBody)
                if (response["status"] == 0) {
                    val usedNum = response["data"] as Int
                    dockerIpInfoDao.update(dslContext, itIdcIp, capacity, usedNum, enable)
                } else {
                    val msg = response["message"] as String
                    logger.error("Get Docker VM container failed, msg: $msg")

                    throw RuntimeException("Get Docker VM container failed, msg: $msg")
                }
            }
        }
    }
}