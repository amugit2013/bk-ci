INSERT INTO devops_ee_store.T_ATOM (`ID`, `NAME`, `ATOM_CODE`, `CLASS_TYPE`, `SERVICE_SCOPE`, `JOB_TYPE`, `OS`, `CLASSIFY_ID`, `DOCS_LINK`, `ATOM_TYPE`, `ATOM_STATUS`, `ATOM_STATUS_MSG`, `SUMMARY`, `DESCRIPTION`, `CATEGROY`, `VERSION`, `LOGO_URL`, `ICON`, `DEFAULT_FLAG`, `LATEST_FLAG`, `BUILD_LESS_RUN_FLAG`, `REPOSITORY_HASH_ID`, `CODE_SRC`, `PAY_FLAG`, `HTML_TEMPLATE_VERSION`, `PROPS`, `DATA`, `PUBLISHER`, `WEIGHT`, `CREATOR`, `MODIFIER`, `CREATE_TIME`, `UPDATE_TIME`, `VISIBILITY_LEVEL`) VALUES 
  ('0040d6cada704faf843cd28f5e787e61', '拉取Gitlab仓库代码', 'CODE_GITLAB', 'CODE_GITLAB', '[ \"pipeline\" ]', 'AGENT', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', 'babff353027b4763a7fd127f61ae80e7', '', 0, 7, NULL, '', '', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FCODE_GITLAB.png', NULL, True, True, True, NULL, NULL, False, '1.0', '{\"repositoryHashId\":{\"rule\":{},\"hasAddItem\":true,\"component\":\"git-request-selector\",\"required\":true,\"label\":\"代码库\",\"searchable\":true,\"default\":\"\",\"url\":\"/repository/api/user/repositories/{projectId}/hasPermissionList?permission=USE&repositoryType=CODE_GITLAB&page=1&pageSize=100\",\"paramId\":\"repositoryHashId\",\"paramName\":\"aliasName\",\"tools\":{\"edit\":true,\"del\":false}},\"gitPullMode\":{\"rule\":{\"pullmode\":true},\"component\":\"code-mode-selector\",\"required\":true,\"text\":\"指定拉取方式\",\"default\":\"\"},\"path\":{\"rule\":{},\"type\":\"text\",\"component\":\"vuex-input\",\"label\":\"代码保存路径\",\"required\":false,\"default\":\"\",\"placeholder\":\"请填写工作空间相对目录，不填则默认为工作空间根目录\",\"desc\":\"指定一个相对于当前工作空间的目录路径存放下拉的代码\"},\"strategy\":{\"rule\":{},\"type\":\"enum\",\"component\":\"enum-input\",\"required\":true,\"label\":\"拉取策略\",\"list\":[{\"value\":\"REVERT_UPDATE\",\"label\":\"Revert Update\"},{\"value\":\"FRESH_CHECKOUT\",\"label\":\"Fresh Checkout\"},{\"value\":\"INCREMENT_UPDATE\",\"label\":\"Increment Update\"}],\"default\":\"REVERT_UPDATE\",\"desc\":\"Revert Update: 增量,每次先\\\"git revert\\\",再\\\"git pull\\\"\\n\\n Fresh Checkout: 全量,每次都会全新clone代码,之前会delete整个工作空间\\n\\n Increment Update: 增量,只使用\\\"git pull\\\",并不清除冲突及历史缓存文件\"},\"enableSubmodule\":{\"rule\":{},\"type\":\"boolean\",\"component\":\"atom-checkbox\",\"required\":false,\"text\":\"启用Submodule\",\"default\":true,\"desc\":\"勾选则启用Submodule，不勾选则不启用\"}}', '{}', 'admin', 0, 'admin', 'admin', '2019-02-28 15:21:12', '2019-04-24 16:40:32', 0),
  ('0a1c7837b53e4c459c50f3228f0ed317', '定时触发', 'timerTrigger', 'timerTrigger', '', 'AGENT', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', 'e1bea5430f574f9ea3e0312dc7de9efa', '', 0, 7, NULL, '可通过后台定时任务方式启动流水线，支持快速定时和linux crontab高级定时', '可通过后台定时任务方式启动流水线，支持快速定时和linux crontab高级定时', 0, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FtimerTrigger.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\"newExpression\":{\"label\":\"基础规则\",\"required\":true,\"component\":\"cron-timer\"},\"advanceExpression\":{\"label\":\"计划任务规则\",\"required\":false,\"component\":\"vuex-textarea\"},\"noScm\":{\"component\":\"atom-checkbox\",\"required\":false}}', '{}', 'admin', 8, 'admin', 'admin', '2019-03-04 18:09:39', '2019-04-18 13:41:48', 0),
  ('0a725392ced3451fa42e0a0949f7298e', '子流水线调用', 'subPipelineCall', 'subPipelineCall', '[ \"pipeline\" ]', 'AGENT_LESS', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', 'e5de5b6e525e4b0abf6b1d88d2242fe7', '', 0, 7, NULL, '以同步/异步的方式调用当前项目内的其它流水线', '以同步/异步的方式调用当前项目内的其它流水线', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FsubPipelineCall.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\"subPipelineId\":{\"rule\":{},\"url\":\"/process/api/user/pipelines/{projectId}/hasPermissionList?permission=EXECUTE&excludePipelineId={pipelineId}&limit=-1\",\"component\":\"request-selector\",\"required\":true,\"label\":\"子流水线\",\"searchable\":true,\"default\":\"\",\"paramId\":\"pipelineId\",\"paramName\":\"pipelineName\",\"hidden\":false,\"desc\":\"选择其他流水线并执行\"},\"asynchronous\":{\"rule\":{},\"type\":\"enum\",\"component\":\"enum-input\",\"required\":true,\"label\":\"执行方式\",\"list\":[{\"value\":false,\"label\":\"同步\"},{\"value\":true,\"label\":\"异步\"}],\"default\":true,\"desc\":\"同步：触发后继续等待执行结果，有结果后再决定是否继续\\n 异步：触发成功后继续，不会等待\"},\"parameters\":{\"rule\":{},\"url\":\"/process/api/user/builds/{projectId}/{pipelineId}/manualStartupInfo\",\"component\":\"params-view\",\"required\":false,\"label\":\"参数\"}}', '{}', 'admin', 1, 'admin', 'admin', '2019-03-04 18:09:41', '2019-04-18 14:30:07', 0),
  ('21ecf2043eee4ad29ccddc63620f35f7', '归档构件', 'singleArchive', 'singleArchive', '[ \"pipeline\" ]', 'AGENT', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', '75c96e7aa24f481789300cd1737b1ae1', '', 0, 7, NULL, '将构件从构建机推送到蓝盾版本仓库', '将构件从构建机推送到蓝盾版本仓库', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FsingleArchive.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\"filePath\":{\"rule\":{},\"type\":\"text\",\"component\":\"vuex-input\",\"required\":true,\"label\":\"待归档文件\",\"placeholder\":\"需要归档的文件列表，支持*通配符，不支持归档目录，不支持归档.md5、.DS_store、.sha1、.sha256结尾文件\",\"default\":\"\",\"desc\":\"归档当前工作空间相对路径或绝对路径目录下的构建产物，可以用通配符匹配，支持多个路径(以英文 , 隔开)，不支持归档目录，不支持归档.md5、.DS_store、.sha1、.sha256结尾文件\"},\"customize\":{\"rule\":{},\"type\":\"boolean\",\"component\":\"atom-checkbox\",\"text\":\"归档至自定义版本仓库\",\"default\":false,\"desc\":\"流水线仓库：以流水线名称+构建号自动生成的目录结构\\n自定义版本仓库：可自定义版本仓库目录结构，不存在将自动创建\",\"tips\":\"function (element, urlJoin, handlePath) {\\n                            const { filePath, destPath, customize } = element\\n                            const srcPrefix = filePath.startsWith(''/'') ? '''' : ''${WORKSPACE}/''\\n                            const destPrefix = customize ? ''版本仓库/'' : ''版本仓库/${PIPELINE_NAME}/${BUILD_ID}/''\\n\\n                            return {\\n                                visible: !!filePath && !customize,\\n                                srcTips: urlJoin(srcPrefix, handlePath(filePath)),\\n                                pathTips: urlJoin(destPrefix, handlePath(destPath), handlePath(filePath, true))\\n                            }\\n                        }\"},\"destPath\":{\"rule\":{},\"type\":\"text\",\"component\":\"vuex-input\",\"label\":\"\",\"placeholder\":\"归档至版本仓库的相对路径，默认为./,所填写路径请以/结尾\",\"default\":\"./\",\"isHidden\":\"function (element) { return !element.customize }\",\"tips\":\"function (element, urlJoin, handlePath) {\\n                            const { filePath, destPath, customize } = element\\n                            const srcPrefix = filePath.startsWith(''/'') ? '''' : ''${WORKSPACE}/''\\n                            const destPrefix = customize ? ''版本仓库/'' : ''版本仓库/${PIPELINE_NAME}/${BUILD_ID}/''\\n\\n                            return {\\n                                visible: !!filePath && customize,\\n                                srcTips: urlJoin(srcPrefix, handlePath(filePath)),\\n                                pathTips: urlJoin(destPrefix, handlePath(destPath), handlePath(filePath, true))\\n                            }\\n                        }\"}}', '{}', 'admin', 93, 'admin', 'admin', '2019-03-04 18:09:40', '2019-04-18 13:37:27', 0),
  ('440777dc24fe4aeca1e51d813214b05f', '拉取构件-自定义仓库', 'customizeArchiveGet', 'customizeArchiveGet', '[ \"pipeline\" ]', 'AGENT', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', '75c96e7aa24f481789300cd1737b1ae1', '', 0, 7, NULL, '从自定义路径的版本仓库中拉取已归档构件', '从自定义路径的版本仓库中拉取已归档构件', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FcustomizeArchiveGet.png', NULL, True, True, True, NULL, NULL, False, '1.0', '{\"downloadPaths\":{\"rule\":{},\"type\":\"text\",\"required\":true,\"component\":\"vuex-input\",\"label\":\"待下载文件路径\",\"placeholder\":\"待下载文件路径(多个路径用逗号隔开),支持Glob通配符\",\"default\":\"\",\"desc\":\"版本仓库构件的路径，例如：tmp/aa.txt\"},\"destPath\":{\"rule\":{},\"type\":\"text\",\"component\":\"vuex-input\",\"label\":\"下载文件目标路径\",\"placeholder\":\"下载文件目标路径，默认为当前工作空间\",\"default\":\"\",\"desc\":\"下载到本地的路径，例如：home/data/\",\"tips\":\"function (element, urlJoin, handlePath) {\\n                            const { downloadPaths, destPath } = element\\n                            const prefix = ''版本仓库/''\\n                            \\n                            return {\\n                                visible: !!downloadPaths,\\n                                srcTips: urlJoin(prefix, handlePath(downloadPaths)),\\n                                pathTips: urlJoin(''${WORKSPACE}/'', destPath, handlePath(downloadPaths, true))\\n                            }\\n                        }\"},\"notFoundContinue\":{\"rule\":{},\"type\":\"boolean\",\"component\":\"atom-checkbox\",\"required\":true,\"text\":\"匹配不到文件时继续执行\",\"default\":false}}', '{}', 'admin', 1, 'admin', 'admin', '2019-03-04 18:09:40', '2019-04-18 13:38:14', 0),
  ('5eac29e36ce74fd4827df820d4fd51d8', '拉取GitHub', 'GITHUB', 'GITHUB', '[ \"pipeline\" ]', 'AGENT', '[ \"LINUX\" ]', 'babff353027b4763a7fd127f61ae80e7', '', 0, 7, NULL, '从GitHub上拉取指定代码库', '从GitHub上拉取指定代码库', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FGITHUB.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\"repositoryType\":{\"rule\":{},\"type\":\"enum\",\"component\":\"enum-input\",\"required\":true,\"label\":\"代码库\",\"list\":[{\"value\":\"ID\",\"label\":\"按代码库选择\"},{\"value\":\"NAME\",\"label\":\"按代码库别名输入\"}],\"default\":\"ID\",\"desc\":\"\"},\"repositoryHashId\":{\"rule\":{},\"label\":\"\",\"hasAddItem\":true,\"component\":\"request-selector\",\"searchable\":true,\"placeholder\":\"请选择代码库名称\",\"required\":true,\"hidden\":true,\"default\":\"\",\"url\":\"/repository/api/user/repositories/{projectId}/hasPermissionList?permission=USE&repositoryType=GITHUB&page=1&pageSize=100\",\"paramId\":\"repositoryHashId\",\"paramName\":\"aliasName\",\"tools\":{\"edit\":true,\"del\":false}},\"repositoryName\":{\"rule\":{},\"type\":\"text\",\"component\":\"vuex-input\",\"required\":true,\"hidden\":true,\"label\":\"\",\"placeholder\":\"请输入代码库别名\",\"default\":\"\"},\"gitPullMode\":{\"rule\":{\"pullmode\":true},\"component\":\"code-mode-input\",\"required\":true,\"text\":\"指定拉取方式\",\"default\":\"\"},\"path\":{\"rule\":{},\"type\":\"text\",\"component\":\"vuex-input\",\"required\":false,\"label\":\"代码保存路径\",\"default\":\"\",\"placeholder\":\"请填写工作空间相对目录，不填则默认为工作空间根目录\",\"desc\":\"指定一个相对于当前工作空间的目录路径存放下拉的代码\"},\"strategy\":{\"rule\":{},\"type\":\"enum\",\"component\":\"enum-input\",\"required\":true,\"label\":\"拉取策略\",\"list\":[{\"value\":\"REVERT_UPDATE\",\"label\":\"Revert Update\"},{\"value\":\"FRESH_CHECKOUT\",\"label\":\"Fresh Checkout\"},{\"value\":\"INCREMENT_UPDATE\",\"label\":\"Increment Update\"}],\"default\":\"REVERT_UPDATE\",\"desc\":\"Revert Update: 增量,每次先\\\"git reset--head\\\",再\\\"git pull\\\"\\n\\n Fresh Checkout: 全量,每次都会全新clone代码,之前会delete整个工作空间\\n\\n Increment Update: 增量,只使用\\\"git pull\\\",并不清除冲突及历史缓存文件\"},\"enableSubmodule\":{\"rule\":{},\"type\":\"boolean\",\"component\":\"atom-checkbox\",\"required\":false,\"text\":\"启用Submodule\",\"default\":true,\"desc\":\"勾选则启用Submodule，不勾选则不启用\"},\"enableVirtualMergeBranch\":{\"rule\":{},\"type\":\"boolean\",\"component\":\"atom-checkbox\",\"required\":false,\"text\":\"PR事件触发时执行Pre-Merge\",\"default\":false,\"desc\":\"我们会在PR事件触发时尝试Merge源分支到目标分支，冲突将直接判定为失败\"}}', '{}', 'admin', 2, 'admin', 'admin', '2019-03-04 18:09:40', '2019-04-18 13:38:49', 0),
  ('6868f24a5b14479683dcd6d63fdb9b42', '人工审核', 'manualReviewUserTask', 'manualReviewUserTask', '[ \"pipeline\" ]', 'AGENT_LESS', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', 'e5de5b6e525e4b0abf6b1d88d2242fe7', '', 0, 7, NULL, '', '', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FmanualReviewUserTask.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\n    \"reviewUsers\": {\n        \"rule\": {},\n        \"required\": true,\n        \"label\": \"审核人\",\n        \"component\": \"user-input\",\n        \"placeholder\": \"支持环境变量(${var})，多个环境变量以英文逗号分隔\",\n        \"default\": []\n    }\n}', '{}', 'admin', 1, 'admin', 'admin', '2019-03-04 18:09:42', '2019-04-18 13:26:57', 0),
  ('9edcb7a2dadf419589e63f636d929ffa', '拉取构件-流水线仓库', 'buildArchiveGet', 'buildArchiveGet', '[ \"pipeline\" ]', 'AGENT', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', '75c96e7aa24f481789300cd1737b1ae1', '', 0, 7, NULL, '从流水线路径的版本仓库中拉取构件', '从流水线路径的版本仓库中拉取构件', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FbuildArchiveGet.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\"pipelineId\":{\"rule\":{},\"required\":true,\"type\":\"text\",\"component\":\"request-selector\",\"label\":\"流水线\",\"default\":\"\",\"list\":[],\"url\":\"/process/api/user/archive/{projectId}/getAllPipelines?page=1&pagesize=-1\",\"paramId\":\"pipelineId\",\"paramName\":\"pipelineName\"},\"buildNoType\":{\"rule\":{},\"type\":\"enum\",\"required\":true,\"component\":\"enum-input\",\"label\":\"构建号\",\"list\":[{\"value\":\"LASTEST\",\"label\":\"最新构建号\"},{\"value\":\"ASSIGN\",\"label\":\"指定构建号\"}],\"default\":\"LASTEST\"},\"buildNo\":{\"rule\":{},\"type\":\"text\",\"required\":true,\"component\":\"selector\",\"label\":\"\",\"default\":\"\",\"list\":[],\"hidden\":true},\"srcPaths\":{\"rule\":{},\"type\":\"text\",\"required\":true,\"component\":\"vuex-input\",\"label\":\"待下载文件路径\",\"placeholder\":\"支持Glob通配符，多个路径用逗号隔开\",\"default\":\"\",\"desc\":\"版本仓库构件的路径，例如：tmp/aa.txt\"},\"destPath\":{\"rule\":{},\"type\":\"text\",\"required\":false,\"component\":\"vuex-input\",\"label\":\"下载到本地路径\",\"placeholder\":\"不填则为当前工作空间路径\",\"default\":\"\",\"desc\":\"下载到本地的路径，例如：home/data/\"},\"notFoundContinue\":{\"rule\":{},\"type\":\"boolean\",\"component\":\"atom-checkbox\",\"required\":true,\"text\":\"匹配不到文件时继续执行\",\"default\":false}}', '{}', 'admin', 90, 'admin', 'admin', '2019-03-04 18:09:40', '2019-04-24 16:37:46', 0),
  ('a1c216facd7b4ffa99a2041830482aee', 'Batch Script', 'windowsScript', 'windowsScript', '[ \"pipeline\" ]', 'AGENT', '[ \"WINDOWS\" ]', '75c96e7aa24f481789300cd1737b1ae1', '', 0, 7, NULL, '在Windows构建机上运行.bat 或 .cmd脚本', '在Windows构建机上运行.bat 或 .cmd脚本，运行目录为构建机的${WORKSPACE}下', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FwindowsScript.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\"scriptType\":{\"rule\":{},\"type\":\"enum\",\"label\":\"脚本类型\",\"required\":true,\"component\":\"enum-input\",\"list\":[{\"id\":\"batchfile\",\"value\":\"BAT\",\"label\":\"bat\"}],\"default\":\"BAT\"},\"script\":{\"rule\":{},\"type\":\"text\",\"label\":\"脚本内容\",\"required\":true,\"default\":\"REM 您可以通过setEnv函数设置插件间传递的参数\\nREM call:setEnv \\\"FILENAME\\\" \\\"package.zip\\\"\\nREM 然后在后续的插件的表单中使用${FILENAME}引用这个变量\\n\\nREM 您可以在质量红线中创建自定义指标，然后通过setGateValue函数设置指标值\\nREM call:setGateValue \\\"CodeCoverage\\\" $myValue\\nREM 然后在质量红线选择相应指标和阈值。若不满足，流水线在执行时将会被卡住\\n\\nREM cd ${WORKSPACE} 可进入当前工作空间目录\",\"component\":\"atom-ace-editor\",\"desc\":\"1、脚本将在构建机对应的%WORKSPACE%下运行\\n 2、如何在脚本中解决各种语言的依赖:\",\"descLink\":\"\",\"descLinkText\":\"点击查看\"}}', '{}', 'admin', 98, 'admin', 'admin', '2019-03-04 18:09:40', '2019-04-18 14:36:54', 0),
  ('c82507989cf442288d03c6520369febb', '手动触发', 'manualTrigger', 'manualTrigger', '[ \"pipeline\" ]', 'AGENT', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', 'e1bea5430f574f9ea3e0312dc7de9efa', '', 0, 7, NULL, '可通过Web页面或蓝盾手机APP手动运行流水线', '可通过Web页面或蓝盾手机APP手动运行流水线', 0, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FmanualTrigger.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\"canElementSkip\":{\"rule\":{},\"type\":\"boolean\",\"component\":\"atom-checkbox\",\"required\":true,\"text\":\"手动触发执行时可跳过插件\",\"default\":true,\"desc\":\"执行时插件可跳过\"},\"useLatestParameters\":{\"rule\":{},\"type\":\"boolean\",\"component\":\"atom-checkbox\",\"required\":true,\"text\":\"手动触发执行时使用最近一次构建参数值\",\"default\":true,\"desc\":\"执行时使用上次参数\"}}', '{}', 'admin', 9, 'admin', 'admin', '2019-03-04 18:09:39', '2019-05-07 20:03:12', 0),
  ('cb0fafe8ca264b739932eb94e46a7fa3', 'Bash', 'linuxScript', 'linuxScript', '[ \"pipeline\" ]', 'AGENT', '[ \"LINUX\", \"MACOS\" ]', '75c96e7aa24f481789300cd1737b1ae1', '', 0, 7, NULL, '在macOS、Linux上运行Bash脚本', '在macOS、Linux上运行Bash脚本，运行目录为构建机的${WORKSPACE}下', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FlinuxScript.png', NULL, True, True, True, NULL, NULL, False, '1.0', '{\"scriptType\":{\"rule\":{},\"type\":\"enum\",\"label\":\"脚本类型\",\"required\":true,\"component\":\"enum-input\",\"list\":[{\"id\":\"sh\",\"value\":\"SHELL\",\"label\":\"Shell\"}],\"default\":\"SHELL\"},\"script\":{\"rule\":{},\"type\":\"text\",\"label\":\"脚本内容\",\"required\":true,\"default\":\"# 您可以通过setEnv函数设置插件间传递的参数\\n# setEnv \\\"FILENAME\\\" \\\"package.zip\\\"\\n# 然后在后续的插件的表单中使用${FILENAME}引用这个变量\\n\\n# 您可以在质量红线中创建自定义指标，然后通过setGateValue函数设置指标值\\n# setGateValue \\\"CodeCoverage\\\" $myValue\\n# 然后在质量红线选择相应指标和阈值。若不满足，流水线在执行时将会被卡住\\n\\n# cd ${WORKSPACE} 可进入当前工作空间目录\",\"component\":\"atom-ace-editor\",\"desc\":\"1、脚本将在构建机对应的${WORKSPACE}下运行\\n 2、如何在脚本中解决各种语言的依赖:\",\"descLink\":\"\",\"descLinkText\":\"点击查看\"},\"continueNoneZero\":{\"rule\":{},\"component\":\"atom-checkbox\",\"text\":\"每行命令运行返回值非零时，继续执行脚本\",\"default\":false},\"scriptTurbo\":{\"rule\":{},\"label\":\"\",\"text\":\"启用编译加速\",\"desc\":\"一个脚本任务原子只能有一个编译加速任务\",\"component\":\"check-inline\",\"default\":false,\"isInline\":true,\"inlineLabel\":\"编译加速\",\"hasQuote\":true,\"quoteText\":[\"警告：关联的编译加速任务为C++语言，使用了distcc+ccache加速方案，需修改编译脚本。distcc修改如下：\",\"cmake --参数   修改为   bk-cmake -a \\\"--参数\\\"\",\"make --参数   修改为   bk-make -a \\\"--参数\\\"\"],\"quoteDesc\":[\"distcc默认采用4台加速机器进行分布式编译，总核数16\",\"ccache默认采用1024Mb大小目录进行缓存\",\"如需升级资源请企业微信联系蓝盾助手DevOps\"]},\"enableArchiveFile\":{\"rule\":{},\"type\":\"boolean\",\"component\":\"atom-checkbox\",\"text\":\"脚本返回非零时归档文件\",\"default\":false},\"archiveFile\":{\"rule\":{},\"type\":\"text\",\"component\":\"vuex-input\",\"label\":\"待归档文件\",\"default\":\"\",\"isHidden\":\"function (element) { return !element.enableArchiveFile }\",\"required\":true,\"desc\":\"可归档用于调试或定位的log文件等\",\"placeholder\":\"可归档用于调试或定位的log文件等\"}}', '{}', 'admin', 99, 'admin', 'admin', '2019-03-04 18:09:40', '2019-04-18 13:41:17', 0),
  ('d47de844527f45f68eb659dafbfc272e', '远程触发', 'remoteTrigger', 'remoteTrigger', '[ \"pipeline\" ]', 'AGENT', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', 'e1bea5430f574f9ea3e0312dc7de9efa', '', 0, 7, NULL, '可通过远程命令行调用方式启动本流水线，同时支持IDC和Devnet环境', '可通过远程命令行调用方式启动本流水线，同时支持IDC和Devnet环境', 0, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FremoteTrigger.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\"remoteToken\":{\"label\":\"\",\"required\":false,\"component\":\"remote-curl-url\",\"default\":\"\"}}', '{}', 'admin', 2, 'admin', 'admin', '2019-03-04 18:09:39', '2019-04-18 13:42:42', 0),
  ('ea1d4d582a3147fdb29a04168cc79a43', '归档报告', 'reportArchive', 'reportArchive', '[ \"pipeline\" ]', 'AGENT', '[ \"LINUX\", \"MACOS\", \"WINDOWS\" ]', '75c96e7aa24f481789300cd1737b1ae1', '', 0, 7, NULL, '可将构建机上的html报告归档至蓝盾，同时发送邮件出来', '可将构建机上的html报告归档至蓝盾，同时发送邮件出来', 1, '1.0.0', '/ms/artifactory/api/user/artifactories/file/download?filePath=%2Ffile%2Fpng%2FreportArchive.png', NULL, True, True, False, NULL, NULL, False, '1.0', '{\n    \"fileDir\": {\n        \"type\": \"text\",\n        \"required\": true,\n        \"component\": \"vuex-input\",\n        \"label\": \"待展示的产出物报告路径（该路径下所有子文件均会被归档）\",\n        \"placeholder\": \"./report/\",\n        \"desc\": \"目前支持html文件的自动渲染\"\n    },\n    \"indexFile\": {\n        \"type\": \"text\",\n        \"required\": true,\n        \"component\": \"vuex-input\",\n        \"label\": \"入口文件\",\n        \"placeholder\": \"index.html\"\n    },\n    \"reportName\": {\n        \"type\": \"text\",\n        \"required\": true,\n        \"component\": \"vuex-input\",\n        \"label\": \"标签别名\",\n        \"placeholder\": \"请输入自定义报告名称\"\n    },\n    \"enableEmail\": {\n        \"rule\": {},\n        \"type\": \"boolean\",\n        \"required\": false,\n        \"text\": \"\",\n        \"desc\": \"\",\n        \"default\": true\n    },\n    \"emailReceivers\": {\n        \"rule\": {},\n        \"component\": \"staff-input\",\n        \"required\": true,\n        \"label\": \"收件人\",\n        \"placeholder\": \"\",\n        \"default\": []\n    },\n    \"emailTitle\": {\n        \"type\": \"text\",\n        \"required\": true,\n        \"component\": \"vuex-input\",\n        \"label\": \"邮件主题\",\n        \"placeholder\": \"请输入邮件主题\",\n        \"default\": \"【${pipeline.name}】  #${pipeline.build.num} 自定义报告已归档\"\n    }\n}', '{}', 'admin', 90, 'admin', 'admin', '2019-03-04 18:09:40', '2019-04-19 15:05:17', 0);
