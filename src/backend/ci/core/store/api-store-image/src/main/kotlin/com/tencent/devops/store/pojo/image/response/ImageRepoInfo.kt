package com.tencent.devops.store.pojo.image.response

import com.tencent.devops.common.pipeline.type.docker.ImageType
import io.swagger.annotations.ApiModel
import io.swagger.annotations.ApiModelProperty

/**
 * @Description
 * @Date 2019/9/17
 * @Version 1.0
 */
@ApiModel("镜像详情")
data class ImageRepoInfo(

    @ApiModelProperty("镜像来源 BKDEVOPS:蓝盾，THIRD:第三方", required = true)
    val sourceType: ImageType,

    @ApiModelProperty("镜像完整路径", required = true)
    val completeImageName: String,

    @ApiModelProperty("凭证Id", required = true)
    val ticketId: String,

    @ApiModelProperty("初始化凭证的项目", required = true)
    val ticketProject: String
)