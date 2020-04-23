package com.tencent.devops.openapi.resources.apigw.v2

import com.tencent.devops.common.api.pojo.Result
import com.tencent.devops.common.client.Client
import com.tencent.devops.common.web.RestResource
import com.tencent.devops.environment.api.ServiceEnvironmentResource
import com.tencent.devops.environment.api.ServiceNodeResource
import com.tencent.devops.environment.pojo.EnvWithPermission
import com.tencent.devops.environment.pojo.NodeBaseInfo
import com.tencent.devops.environment.pojo.NodeWithPermission
import com.tencent.devops.openapi.api.apigw.v2.ApigwEnvironmentResourceV2
import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Autowired

@RestResource
class ApigwEnvironmentResourceV2 @Autowired constructor(
    private val client: Client
) : ApigwEnvironmentResourceV2 {
    override fun listUsableServerNodes(
        appCode: String?,
        apigwType: String?,
        userId: String,
        projectId: String
    ): Result<List<NodeWithPermission>> {
        logger.info("listUsableServerNodes userId[$userId] project[$projectId]")
        return client.get(ServiceNodeResource::class).listUsableServerNodes(userId, projectId)
    }

    override fun listUsableServerEnvs(
        appCode: String?,
        apigwType: String?,
        userId: String,
        projectId: String
    ): Result<List<EnvWithPermission>> {
        logger.info("listUsableServerEnvs userId[$userId] project[$projectId]")
        return client.get(ServiceEnvironmentResource:: class).listUsableServerEnvs(userId, projectId)
    }

    override fun listRawByEnvNames(
        appCode: String?,
        apigwType: String?,
        userId: String,
        projectId: String,
        envNames: List<String>
    ): Result<List<EnvWithPermission>> {
        logger.info("listRawByEnvNames userId[$userId] project[$projectId] envNames[$envNames]")
        return client.get(ServiceEnvironmentResource:: class).listRawByEnvNames(userId, projectId, envNames)
    }

    override fun listRawByEnvHashIds(
        appCode: String?,
        apigwType: String?,
        userId: String,
        projectId: String,
        envHashIds: List<String>
    ): Result<List<EnvWithPermission>> {
        logger.info("listRawByEnvNames userId[$userId] project[$projectId] envHashIds[$envHashIds]")
        return client.get(ServiceEnvironmentResource::class).listRawByEnvHashIds(userId, projectId, envHashIds)
    }

    override fun listRawByHashIds(
        appCode: String?,
        apigwType: String?,
        userId: String,
        projectId: String,
        nodeHashIds: List<String>
    ): Result<List<NodeBaseInfo>> {
        logger.info("listRawByEnvNames userId[$userId] project[$projectId] nodeHashIds[$nodeHashIds]")
        return client.get(ServiceNodeResource::class).listRawByHashIds(userId, projectId, nodeHashIds)
    }

    companion object {
        private val logger = LoggerFactory.getLogger(ApigwEnvironmentResourceV2::class.java)
    }
}