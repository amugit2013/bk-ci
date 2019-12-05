USE devops_ci_process;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for T_BUILD_STARTUP_PARAM
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_BUILD_STARTUP_PARAM` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `BUILD_ID` varchar(64) NOT NULL,
  `PARAM` mediumtext NOT NULL,
  `PROJECT_ID` varchar(64) DEFAULT NULL,
  `PIPELINE_ID` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `BUILD_ID` (`BUILD_ID`),
  KEY `IDX_DEL` (`PROJECT_ID`,`PIPELINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_METADATA
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_METADATA` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` varchar(32) NOT NULL,
  `PIPELINE_ID` varchar(34) NOT NULL,
  `BUILD_ID` varchar(34) NOT NULL,
  `META_DATA_ID` varchar(128) NOT NULL,
  `META_DATA_VALUE` varchar(255) NOT NULL,
  `CREATE_TIME` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `BUILD_ID` (`BUILD_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_BUILD_CONTAINER
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_BUILD_CONTAINER` (
  `PROJECT_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `PIPELINE_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `BUILD_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `STAGE_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `CONTAINER_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `CONTAINER_TYPE` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `SEQ` int(11) NOT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `START_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `END_TIME` timestamp NULL DEFAULT NULL,
  `COST` int(11) DEFAULT '0',
  `EXECUTE_COUNT` int(11) DEFAULT '1',
  `CONDITIONS` mediumtext COLLATE utf8mb4_bin,
  PRIMARY KEY (`BUILD_ID`,`STAGE_ID`,`CONTAINER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for T_PIPELINE_BUILD_DETAIL
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_BUILD_DETAIL` (
  `BUILD_ID` varchar(34) NOT NULL,
  `BUILD_NUM` int(20) DEFAULT NULL,
  `MODEL` mediumtext,
  `START_USER` varchar(32) DEFAULT NULL,
  `TRIGGER` varchar(32) DEFAULT NULL,
  `START_TIME` datetime DEFAULT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(32) DEFAULT NULL,
  `CANCEL_USER` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`BUILD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_BUILD_HISTORY
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_BUILD_HISTORY` (
  `BUILD_ID` varchar(34) NOT NULL,
  `PARENT_BUILD_ID` varchar(34) DEFAULT NULL,
  `PARENT_TASK_ID` varchar(34) DEFAULT NULL,
  `BUILD_NUM` int(20) DEFAULT '0',
  `PROJECT_ID` varchar(64) NOT NULL,
  `PIPELINE_ID` varchar(34) NOT NULL,
  `VERSION` int(11) DEFAULT NULL,
  `START_USER` varchar(64) DEFAULT NULL,
  `TRIGGER` varchar(32) NOT NULL,
  `START_TIME` timestamp NULL DEFAULT NULL,
  `END_TIME` timestamp NULL DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `TASK_COUNT` int(11) DEFAULT NULL,
  `FIRST_TASK_ID` varchar(34) DEFAULT NULL,
  `CHANNEL` varchar(32) DEFAULT NULL,
  `TRIGGER_USER` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `MATERIAL` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `QUEUE_TIME` timestamp NULL DEFAULT NULL,
  `ARTIFACT_INFO` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `REMARK` varchar(4096) DEFAULT NULL,
  `EXECUTE_TIME` bigint(20) DEFAULT NULL,
  `BUILD_PARAMETERS` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `WEBHOOK_TYPE` varchar(64) DEFAULT NULL,
  `RECOMMEND_VERSION` varchar(64) DEFAULT NULL,
  `ERROR_TYPE` int(11) DEFAULT NULL,
  `ERROR_CODE` int(11) DEFAULT NULL COMMENT '错误码',
  `ERROR_MSG` text COMMENT '错误描述',
  PRIMARY KEY (`BUILD_ID`),
  KEY `STATUS_KEY` (`PROJECT_ID`,`PIPELINE_ID`,`STATUS`),
  KEY `LATEST_BUILD_KEY` (`PIPELINE_ID`,`BUILD_NUM`),
  KEY `inx_tpbh_status` (`STATUS`),
  KEY `inx_tpbh_start_time` (`START_TIME`),
  KEY `inx_tpbh_end_time` (`END_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- ----------------------------
-- Table structure for T_PIPELINE_BUILD_STAGE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_BUILD_STAGE` (
  `PROJECT_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `PIPELINE_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `BUILD_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `STAGE_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `SEQ` int(11) NOT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `START_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `END_TIME` timestamp NULL DEFAULT NULL,
  `COST` int(11) DEFAULT '0',
  `EXECUTE_COUNT` int(11) DEFAULT '1',
  PRIMARY KEY (`BUILD_ID`,`STAGE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for T_PIPELINE_BUILD_SUMMARY
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_BUILD_SUMMARY` (
  `PIPELINE_ID` varchar(34) NOT NULL,
  `PROJECT_ID` varchar(64) NOT NULL,
  `BUILD_NUM` int(11) DEFAULT '0',
  `BUILD_NO` int(11) DEFAULT '0',
  `FINISH_COUNT` int(11) DEFAULT '0',
  `RUNNING_COUNT` int(11) DEFAULT '0',
  `QUEUE_COUNT` int(11) DEFAULT '0',
  `LATEST_BUILD_ID` varchar(34) DEFAULT NULL,
  `LATEST_TASK_ID` varchar(34) DEFAULT NULL,
  `LATEST_START_USER` varchar(64) DEFAULT NULL,
  `LATEST_START_TIME` timestamp NULL DEFAULT NULL,
  `LATEST_END_TIME` timestamp NULL DEFAULT NULL,
  `LATEST_TASK_COUNT` int(11) DEFAULT NULL,
  `LATEST_TASK_NAME` varchar(128) DEFAULT NULL,
  `LATEST_STATUS` int(11) DEFAULT NULL,
  PRIMARY KEY (`PIPELINE_ID`),
  KEY `PRJOECT_ID` (`PROJECT_ID`,`PIPELINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_BUILD_TASK
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_BUILD_TASK` (
  `PIPELINE_ID` varchar(34) NOT NULL,
  `PROJECT_ID` varchar(64) NOT NULL,
  `BUILD_ID` varchar(34) NOT NULL,
  `STAGE_ID` varchar(34) NOT NULL,
  `CONTAINER_ID` varchar(34) NOT NULL,
  `TASK_NAME` varchar(128) DEFAULT NULL,
  `TASK_ID` varchar(34) NOT NULL,
  `TASK_PARAMS` mediumtext,
  `TASK_TYPE` varchar(64) NOT NULL,
  `TASK_ATOM` varchar(128) DEFAULT NULL,
  `START_TIME` timestamp NULL DEFAULT NULL,
  `END_TIME` timestamp NULL DEFAULT NULL,
  `STARTER` varchar(64) NOT NULL,
  `APPROVER` varchar(64) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  `EXECUTE_COUNT` int(11) DEFAULT '0',
  `TASK_SEQ` int(11) DEFAULT '1',
  `SUB_BUILD_ID` varchar(34) DEFAULT NULL,
  `CONTAINER_TYPE` varchar(45) DEFAULT NULL,
  `ADDITIONAL_OPTIONS` mediumtext,
  `TOTAL_TIME`        bigint(20)  DEFAULT NULL,
  `ERROR_TYPE`        int(11)     DEFAULT NULL,
  `ERROR_CODE`        int(11)     DEFAULT NULL COMMENT '错误码',
  `ERROR_MSG`         text COMMENT '错误描述',
  `CONTAINER_HASH_ID` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`BUILD_ID`,`TASK_ID`),
  KEY `STAT_PROJECT_RUN` (`PROJECT_ID`,`STATUS`),
  KEY `PROJECT_PIPELINE` (`PROJECT_ID`,`PIPELINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_BUILD_VAR
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_BUILD_VAR` (
  `BUILD_ID` varchar(34) NOT NULL,
  `KEY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `VALUE` varchar(4000) DEFAULT NULL,
  `PROJECT_ID` varchar(64) DEFAULT NULL,
  `PIPELINE_ID` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`BUILD_ID`,`KEY`),
  KEY `IDX_SEARCH_BUILD_ID` (`PROJECT_ID`,`PIPELINE_ID`, `KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_CONTAINER_MONITOR
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_CONTAINER_MONITOR` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OS_TYPE` varchar(32) NOT NULL,
  `BUILD_TYPE` varchar(32) NOT NULL,
  `MAX_STARTUP_TIME` bigint(20) NOT NULL,
  `MAX_EXECUTE_TIME` bigint(20) NOT NULL,
  `USERS` varchar(1024) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `OS_TYPE` (`OS_TYPE`,`BUILD_TYPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_FAILURE_NOTIFY_USER
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_FAILURE_NOTIFY_USER` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(32) DEFAULT '',
  `NOTIFY_TYPES` varchar(32) DEFAULT '',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_ID` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_FAVOR
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_FAVOR` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` varchar(64) NOT NULL,
  `PIPELINE_ID` varchar(64) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `CREATE_USER` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PIPELINE_ID` (`PIPELINE_ID`,`CREATE_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_GROUP
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_GROUP` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` varchar(32) NOT NULL,
  `NAME` varchar(64) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `UPDATE_TIME` datetime NOT NULL,
  `CREATE_USER` varchar(64) NOT NULL DEFAULT '',
  `UPDATE_USER` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PROJECT_ID` (`PROJECT_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_INFO
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_INFO` (
  `PIPELINE_ID` varchar(34) NOT NULL DEFAULT '',
  `PROJECT_ID` varchar(64) NOT NULL,
  `PIPELINE_NAME` varchar(255) NOT NULL,
  `PIPELINE_DESC` varchar(255) DEFAULT NULL,
  `VERSION` int(11) DEFAULT '1',
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CREATOR` varchar(64) NOT NULL,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  `LAST_MODIFY_USER` varchar(64) NOT NULL,
  `CHANNEL` varchar(32) DEFAULT NULL,
  `MANUAL_STARTUP` int(11) DEFAULT '1',
  `ELEMENT_SKIP` int(11) DEFAULT '0',
  `TASK_COUNT` int(11) DEFAULT '0',
  `DELETE` bit(1) DEFAULT b'0',
  PRIMARY KEY (`PIPELINE_ID`),
  UNIQUE KEY `T_PIPELINE_INFO_NAME_uindex` (`PROJECT_ID`,`PIPELINE_NAME`),
  KEY `PROJECT_ID` (`PROJECT_ID`,`PIPELINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_JOB_MUTEX_GROUP
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_JOB_MUTEX_GROUP` (
  `PROJECT_ID` varchar(64) NOT NULL,
  `JOB_MUTEX_GROUP_NAME` varchar(127) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`PROJECT_ID`,`JOB_MUTEX_GROUP_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_LABEL
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_LABEL` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `GROUP_ID` bigint(20) NOT NULL,
  `NAME` varchar(64) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `UPDATE_TIME` datetime NOT NULL,
  `CREATE_USER` varchar(64) NOT NULL DEFAULT '',
  `UPDATE_USER` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `GROUP_ID` (`GROUP_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_LABEL_PIPELINE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_LABEL_PIPELINE` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PIPELINE_ID` varchar(34) NOT NULL,
  `LABEL_ID` bigint(20) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `CREATE_USER` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PIPELINE_ID` (`PIPELINE_ID`,`LABEL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_MODEL_TASK
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_MODEL_TASK` (
  `PIPELINE_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `PROJECT_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `STAGE_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `CONTAINER_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `TASK_ID` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `TASK_NAME` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `CLASS_TYPE` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `TASK_ATOM` varchar(128) COLLATE utf8mb4_bin DEFAULT NULL,
  `TASK_SEQ` int(11) DEFAULT '1',
  `TASK_PARAMS` mediumtext COLLATE utf8mb4_bin,
  `OS` varchar(45) COLLATE utf8mb4_bin DEFAULT NULL,
  `ADDITIONAL_OPTIONS` mediumtext CHARACTER SET utf8mb4,
  `ATOM_CODE` varchar(32) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`PIPELINE_ID`,`PROJECT_ID`,`STAGE_ID`,`CONTAINER_ID`,`TASK_ID`),
  KEY `STAT_PROJECT_RUN` (`PROJECT_ID`),
  KEY `PROJECT_PIPELINE` (`PROJECT_ID`,`PIPELINE_ID`),
  KEY `ATOM_CODE` (`ATOM_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- ----------------------------
-- Table structure for T_PIPELINE_MUTEX_GROUP
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_MUTEX_GROUP` (
  `PROJECT_ID` varchar(64) NOT NULL,
  `GROUP_NAME` varchar(127) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`PROJECT_ID`,`GROUP_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_REMOTE_AUTH
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_REMOTE_AUTH` (
  `PIPELINE_ID` varchar(34) NOT NULL,
  `PIPELINE_AUTH` varchar(32) NOT NULL,
  `PROJECT_ID` varchar(32) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `CREATE_USER` varchar(64) NOT NULL,
  PRIMARY KEY (`PIPELINE_ID`),
  UNIQUE KEY `PIPELINE_AUTH` (`PIPELINE_AUTH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_RESOURCE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_RESOURCE` (
  `PIPELINE_ID` varchar(34) NOT NULL,
  `VERSION` int(11) NOT NULL DEFAULT '1',
  `MODEL` mediumtext,
  PRIMARY KEY (`PIPELINE_ID`,`VERSION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_SETTING
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_SETTING` (
  `PIPELINE_ID` varchar(34) NOT NULL,
  `DESC` varchar(1024) DEFAULT NULL,
  `RUN_TYPE` int(11) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `SUCCESS_RECEIVER` mediumtext,
  `FAIL_RECEIVER` mediumtext,
  `SUCCESS_GROUP` mediumtext,
  `FAIL_GROUP` mediumtext,
  `SUCCESS_TYPE` varchar(32) DEFAULT NULL,
  `FAIL_TYPE` varchar(32) DEFAULT NULL,
  `PROJECT_ID` varchar(64) DEFAULT NULL,
  `SUCCESS_WECHAT_GROUP_FLAG` bit(1) NOT NULL DEFAULT b'0',
  `SUCCESS_WECHAT_GROUP` varchar(1024) NOT NULL DEFAULT '',
  `FAIL_WECHAT_GROUP_FLAG` bit(1) NOT NULL DEFAULT b'0',
  `FAIL_WECHAT_GROUP` varchar(1024) NOT NULL DEFAULT '',
  `RUN_LOCK_TYPE` int(11) DEFAULT '1',
  `SUCCESS_DETAIL_FLAG` bit(1) DEFAULT b'0',
  `FAIL_DETAIL_FLAG` bit(1) DEFAULT b'0',
  `SUCCESS_CONTENT` longtext,
  `FAIL_CONTENT` longtext,
  `WAIT_QUEUE_TIME_SECOND` int(11) DEFAULT '7200',
  `MAX_QUEUE_SIZE` int(11) DEFAULT '10',
  `IS_TEMPLATE` bit(1) DEFAULT b'0',
  PRIMARY KEY (`PIPELINE_ID`),
  UNIQUE KEY `PROJECT_ID` (`PROJECT_ID`,`NAME`,`IS_TEMPLATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_TEMPLATE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_TEMPLATE` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TYPE` varchar(32) NOT NULL DEFAULT 'FREEDOM',
  `CATEGORY` varchar(128) DEFAULT NULL,
  `TEMPLATE_NAME` varchar(64) NOT NULL,
  `ICON` varchar(32) NOT NULL DEFAULT '',
  `LOGO_URL` varchar(512) DEFAULT NULL,
  `PROJECT_CODE` varchar(32) DEFAULT NULL,
  `SRC_TEMPLATE_ID` varchar(32) DEFAULT NULL,
  `AUTHOR` varchar(64) NOT NULL DEFAULT '',
  `ATOMNUM` int(11) NOT NULL,
  `PUBLIC_FLAG` bit(1) NOT NULL DEFAULT b'0',
  `TEMPLATE` mediumtext,
  `CREATOR` varchar(32) NOT NULL,
  `CREATE_TIME` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `SRC_TEMPLATE_ID` (`SRC_TEMPLATE_ID`),
  KEY `PROJECT_CODE` (`PROJECT_CODE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_TIMER
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_TIMER` (
  `PROJECT_ID` varchar(32) NOT NULL,
  `PIPELINE_ID` varchar(34) NOT NULL,
  `CRONTAB` varchar(2048) NOT NULL,
  `CREATOR` varchar(64) NOT NULL,
  `CREATE_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `CHANNEL` varchar(32) NOT NULL DEFAULT 'CODECC',
  PRIMARY KEY (`PROJECT_ID`,`PIPELINE_ID`),
  UNIQUE KEY `IDX_PIPELINE_ID` (`PIPELINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_USER
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_USER` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PIPELINE_ID` varchar(34) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `UPDATE_TIME` datetime NOT NULL,
  `CREATE_USER` varchar(64) NOT NULL,
  `UPDATE_USER` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PIPELINE_ID` (`PIPELINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_VIEW
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_VIEW` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` varchar(32) NOT NULL,
  `NAME` varchar(64) NOT NULL,
  `FILTER_BY_PIPEINE_NAME` varchar(128) DEFAULT '',
  `FILTER_BY_CREATOR` varchar(64) DEFAULT '',
  `CREATE_TIME` datetime NOT NULL,
  `UPDATE_TIME` datetime NOT NULL,
  `CREATE_USER` varchar(64) NOT NULL,
  `IS_PROJECT` bit(1) DEFAULT b'0',
  `LOGIC` varchar(32) DEFAULT 'AND',
  `FILTERS` mediumtext,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PROJECT_NAME` (`PROJECT_ID`,`NAME`,`CREATE_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_VIEW_LABEL
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_VIEW_LABEL` (
  `VIEW_ID` bigint(20) NOT NULL,
  `LABEL_ID` bigint(20) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  PRIMARY KEY (`VIEW_ID`,`LABEL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_VIEW_PROJECT
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_VIEW_PROJECT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `VIEW_ID` bigint(20) NOT NULL,
  `PROJECT_ID` varchar(32) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `UPDATE_TIME` datetime NOT NULL,
  `CREATE_USER` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PROJECT_ID` (`PROJECT_ID`,`CREATE_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_VIEW_USER_LAST_VIEW
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_VIEW_USER_LAST_VIEW` (
  `USER_ID` varchar(32) NOT NULL,
  `PROJECT_ID` varchar(32) NOT NULL,
  `VIEW_ID` varchar(64) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `UPDATE_TIME` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`USER_ID`,`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_VIEW_USER_SETTINGS
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_VIEW_USER_SETTINGS` (
  `USER_ID` varchar(255) NOT NULL,
  `PROJECT_ID` varchar(32) NOT NULL,
  `SETTINGS` mediumtext NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `UPDATE_TIME` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`USER_ID`,`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PIPELINE_WEBHOOK
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PIPELINE_WEBHOOK` (
  `REPOSITORY_TYPE` varchar(64) NOT NULL,
  `PROJECT_ID` varchar(32) NOT NULL,
  `PIPELINE_ID` varchar(34) NOT NULL,
  `REPO_HASH_ID` varchar(45) DEFAULT NULL,
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `REPO_NAME` varchar(128) DEFAULT NULL,
  `REPO_TYPE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_T_PIPELINE_WEBHOOK_T_PIPELINE_INFO1_idx` (`PIPELINE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_REPORT
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_REPORT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` varchar(32) NOT NULL,
  `PIPELINE_ID` varchar(34) NOT NULL,
  `BUILD_ID` varchar(34) NOT NULL,
  `ELEMENT_ID` varchar(34) NOT NULL,
  `TYPE` varchar(32) NOT NULL DEFAULT 'INTERNAL' ,
  `INDEX_FILE` mediumtext NOT NULL,
  `NAME` text NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `UPDATE_TIME` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `PROJECT_ID_PIPELINE_ID_BUILD_ID_ELEMENT_ID` (`PROJECT_ID`,`PIPELINE_ID`,`BUILD_ID`,`ELEMENT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_TEMPLATE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_TEMPLATE` (
  `VERSION` bigint(11) NOT NULL AUTO_INCREMENT,
  `ID` varchar(32) NOT NULL,
  `TEMPLATE_NAME` varchar(64) NOT NULL,
  `PROJECT_ID` varchar(34) NOT NULL,
  `VERSION_NAME` varchar(64) NOT NULL,
  `CREATOR` varchar(64) NOT NULL,
  `CREATED_TIME` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `TEMPLATE` mediumtext,
  `TYPE` varchar(32) NOT NULL DEFAULT 'CUSTOMIZE',
  `CATEGORY` varchar(128) DEFAULT NULL,
  `LOGO_URL` varchar(512) DEFAULT NULL,
  `SRC_TEMPLATE_ID` varchar(32) DEFAULT NULL,
  `STORE_FLAG` bit(1) DEFAULT b'0',
  `WEIGHT` int(11) DEFAULT '0',
  PRIMARY KEY (`VERSION`),
  KEY `PROJECT_ID` (`PROJECT_ID`),
  KEY `SRC_TEMPLATE_ID` (`SRC_TEMPLATE_ID`),
  KEY `TYPE` (`TYPE`),
  KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_TEMPLATE_PIPELINE
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_TEMPLATE_PIPELINE` (
  `PIPELINE_ID` varchar(34) NOT NULL,
  `VERSION` bigint(20) NOT NULL,
  `VERSION_NAME` varchar(64) NOT NULL,
  `TEMPLATE_ID` varchar(32) NOT NULL,
  `CREATOR` varchar(64) NOT NULL,
  `UPDATOR` varchar(64) NOT NULL,
  `CREATED_TIME` datetime NOT NULL,
  `UPDATED_TIME` datetime NOT NULL,
  `BUILD_NO` text,
  `PARAM` mediumtext,
  PRIMARY KEY (`PIPELINE_ID`),
  KEY `TEMPLATE_ID` (`TEMPLATE_ID`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_PROJECT_PIPELINE_CALLBACK
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_PROJECT_PIPELINE_CALLBACK` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` varchar(64) NOT NULL,
  `EVENTS` varchar(255) DEFAULT NULL,
  `CALLBACK_URL` varchar(255) NOT NULL,
  `CREATOR` varchar(64) NOT NULL,
  `UPDATOR` varchar(64) NOT NULL,
  `CREATED_TIME` datetime NOT NULL,
  `UPDATED_TIME` datetime NOT NULL,
  `SECRET_TOKEN` text DEFAULT NULL COMMENT 'Send to your with http header: X-DEVOPS-WEBHOOK-TOKEN',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDX_PROJECT_CALLBACK` (`PROJECT_ID`, `CALLBACK_URL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
