SET NAMES utf8mb4;
USE devops_ci_process;

-- 空白流水线模板
INSERT IGNORE INTO `T_TEMPLATE` (`VERSION`, `ID`, `TEMPLATE_NAME`, `PROJECT_ID`, `VERSION_NAME`, `CREATOR`, `CREATED_TIME`, `TEMPLATE`, `TYPE`, `CATEGORY`, `LOGO_URL`, `SRC_TEMPLATE_ID`, `STORE_FLAG`, `WEIGHT`) VALUES
  (1, '072d516d300b4812a4f652f585eacc36', '空白流水线', '', 'init', '', '2019-05-23 16:24:02', '{\n  \"name\" : \"空白流水线\",\n  \"desc\" : \"\",\n  \"stages\" : [ {\n    \"containers\" : [ {\n      \"@type\" : \"trigger\",\n      \"name\" : \"构建触发\",\n      \"elements\" : [ {\n        \"@type\" : \"manualTrigger\",\n        \"name\" : \"手动触发\",\n        \"id\" : \"T-1-1-1\",\n        \"properties\" : [ ]\n      } ]\n    } ],\n    \"id\" : \"stage-1\"\n  }]\n}', 'PUBLIC', '', NULL, NULL, 0, 100);
