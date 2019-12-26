USE devops_ci_repository;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for T_REPOSITORY
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_REPOSITORY` (
  `REPOSITORY_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PROJECT_ID` varchar(32) NOT NULL,
  `USER_ID` varchar(64) NOT NULL DEFAULT '',
  `ALIAS_NAME` varchar(255) NOT NULL,
  `URL` varchar(255) NOT NULL,
  `TYPE` varchar(20) NOT NULL,
  `CREATED_TIME` timestamp NOT NULL DEFAULT '2019-08-01 00:00:00',
  `UPDATED_TIME` timestamp NOT NULL DEFAULT '2019-08-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `IS_DELETED` bit(1) NOT NULL,
  PRIMARY KEY (`REPOSITORY_ID`),
  KEY `PROJECT_ID` (`PROJECT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_REPOSITORY_CODE_GIT
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_REPOSITORY_CODE_GIT` (
  `REPOSITORY_ID` bigint(20) NOT NULL,
  `PROJECT_NAME` varchar(255) NOT NULL,
  `USER_NAME` varchar(64) NOT NULL,
  `CREATED_TIME` timestamp NOT NULL DEFAULT '2019-08-01 00:00:00',
  `UPDATED_TIME` timestamp NOT NULL DEFAULT '2019-08-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `CREDENTIAL_ID` varchar(64) NOT NULL,
  `AUTH_TYPE` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`REPOSITORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_REPOSITORY_CODE_GITLAB
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_REPOSITORY_CODE_GITLAB` (
  `REPOSITORY_ID` bigint(20) NOT NULL,
  `PROJECT_NAME` varchar(255) NOT NULL,
  `CREDENTIAL_ID` varchar(64) NOT NULL,
  `CREATED_TIME` timestamp NOT NULL DEFAULT '2019-08-01 00:00:00',
  `UPDATED_TIME` timestamp NOT NULL DEFAULT '2019-08-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `USER_NAME` varchar(64) NOT NULL,
  PRIMARY KEY (`REPOSITORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_REPOSITORY_CODE_SVN
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_REPOSITORY_CODE_SVN` (
  `REPOSITORY_ID` bigint(20) NOT NULL,
  `REGION` varchar(255) NOT NULL,
  `PROJECT_NAME` varchar(255) NOT NULL,
  `USER_NAME` varchar(64) NOT NULL,
  `CREATED_TIME` timestamp NOT NULL DEFAULT '2019-08-01 00:00:00',
  `UPDATED_TIME` timestamp NOT NULL DEFAULT '2019-08-01 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `CREDENTIAL_ID` varchar(64) NOT NULL,
  `SVN_TYPE` varchar(32) DEFAULT '',
  PRIMARY KEY (`REPOSITORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_REPOSITORY_COMMIT
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_REPOSITORY_COMMIT` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `BUILD_ID` varchar(34) DEFAULT NULL,
  `PIPELINE_ID` varchar(34) DEFAULT NULL,
  `REPO_ID` bigint(20) DEFAULT NULL,
  `TYPE` smallint(6) DEFAULT NULL COMMENT '1-svn, 2-git, 3-gitlab',
  `COMMIT` varchar(64) DEFAULT NULL,
  `COMMITTER` varchar(32) DEFAULT NULL,
  `COMMIT_TIME` datetime DEFAULT NULL,
  `COMMENT` longtext,
  `ELEMENT_ID` varchar(34) DEFAULT NULL,
  `REPO_NAME` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `PIPELINE_REPO_KEY` (`PIPELINE_ID`,`BUILD_ID`),
  KEY `BUILD_ID_INDEX` (`BUILD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_REPOSITORY_GITHUB
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_REPOSITORY_GITHUB` (
  `REPOSITORY_ID` bigint(20) NOT NULL,
  `CREDENTIAL_ID` varchar(128) DEFAULT NULL,
  `PROJECT_NAME` varchar(255) NOT NULL,
  `USER_NAME` varchar(64) NOT NULL,
  `CREATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UPDATED_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`REPOSITORY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_REPOSITORY_GITHUB_TOKEN
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_REPOSITORY_GITHUB_TOKEN` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(64) NOT NULL,
  `ACCESS_TOKEN` varchar(96) NOT NULL,
  `TOKEN_TYPE` varchar(64) NOT NULL,
  `SCOPE` text NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `UPDATE_TIME` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_ID` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for T_REPOSITORY_GIT_TOKEN
-- ----------------------------

CREATE TABLE IF NOT EXISTS `T_REPOSITORY_GTI_TOKEN` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USER_ID` varchar(64) DEFAULT NULL,
  `ACCESS_TOKEN` varchar(96) DEFAULT NULL,
  `REFRESH_TOKEN` varchar(96) DEFAULT NULL,
  `TOKEN_TYPE` varchar(64) DEFAULT NULL,
  `EXPIRES_IN` bigint(20) DEFAULT NULL,
  `CREATE_TIME` datetime DEFAULT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'token的创建时间'
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_ID` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
