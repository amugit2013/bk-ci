USE devops_ci_project;
SET NAMES utf8mb4;

-- 服务初始化
INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (3, '代码库(Code)', 2, 'devops/codelib/', '/codelib/', 'amd', '', '/codelib/codelib.css', '/codelib/codelib.js', b'1', b'1', 'path', 'ok', 'system', '2019-06-05 17:12:47', 'system', '2019-06-05 17:12:47', b'0', '', '', 99);
INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (4, '流水线(Pipeline)', 2, 'devops/pipelines/', '/pipeline/', 'iframe', '/pipeline/', '', '', b'1', b'1', 'path', 'ok', 'system', '2019-06-05 17:12:47', NULL, '2019-06-05 17:12:47', b'0', NULL, NULL, 97);
INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (5, '制品库(Artifactory)', 2, 'devops/artifactory/', '/artifactory/', 'amd', '', '/artifactory/artifactory.css', '/artifactory/artifactory.js', b'1', b'1', 'path', 'disable', 'system', '2019-06-05 17:12:48', 'system', '2019-06-05 17:12:48', b'1', '', '', 96);
INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (22, '凭证管理(Ticket)', 8, 'devops/ticket/', '/ticket/', 'amd', '', '/ticket/ticket.css', '/ticket/ticket.js', b'1', b'1', 'path', 'ok', 'system', '2019-06-05 17:13:26', 'system', '2019-06-05 17:13:26', b'0', '', '', 95);
INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (24, '环境管理(Env)', 4, 'devops/environment/', '/environment/', 'amd', '', '/environment/environment.css', '/environment/environment.js', b'1', b'1', 'path', 'ok', 'system', '2019-06-05 17:13:27', 'system', '2019-06-05 17:13:27', b'0', '', '', 94);
INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (29, '研发商店(Store)', 8, '/devops/store/', '/store/', 'amd', '', '/store/store.css', '/store/store.js', b'0', b'1', 'path', 'ok', 'system', '2019-06-05 17:13:29', 'system', '2019-06-05 17:13:29', b'0', '', '', 93);
INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (27, '质量红线(Gate)', 3, '/devops/quality/', '/quality/', 'amd', '', '/quality/quality.css', '/quality/quality.js', b'1', b'1', 'path', 'disable', 'system', '2019-06-05 17:13:29', 'system', '2019-06-05 17:13:29', b'1', '', '', 92);
INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (32, '代码检查(CodeCC)', 2, 'devops/codecc/', '/codecc/', 'iframe', '/codecc/', '', '', b'1', b'1', 'path', 'disable', 'system', '2019-06-05 17:12:47', NULL, '2019-06-05 17:12:47', b'1', NULL, NULL, 89);
-- INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (30, '度量数据(Measure)', 2, 'devops/measure/', '/measure/', 'iframe', '/measure/', '', '', b'1', b'1', 'path', 'ok', 'system', '2019-06-05 17:12:47', NULL, '2019-06-05 17:12:47', b'0', NULL, NULL, 91);
-- INSERT IGNORE INTO `T_SERVICE`(`id`, `name`, `service_type_id`, `link`, `link_new`, `inject_type`, `iframe_url`, `css_url`, `js_url`, `show_project_list`, `show_nav`, `project_id_type`, `status`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `gray_css_url`, `gray_js_url`, `weight`) VALUES (31, '敏捷开发(Teamwork)', 1, 'devops/teamwork/', '/teamwork/', 'amd', '', '/teamwork/teamwork.css', '/teamwork/teamwork.js', b'1', b'1', 'path', 'ok', 'system', '2019-06-05 17:12:48', 'system', '2019-06-05 17:12:48', b'0', '', '', 90);

-- 服务分类初始化
-- INSERT IGNORE INTO `T_SERVICE_TYPE`(`id`, `title`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `weight`) VALUES (1, '项目管理', 'system', '2019-06-05 17:13:55', 'system', '2019-06-05 17:13:55', b'0', NULL);
INSERT IGNORE INTO `T_SERVICE_TYPE`(`id`, `title`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `weight`) VALUES (2, '开发', 'system', '2018-12-06 20:49:24', 'system', '2018-12-06 20:49:24', b'0', NULL);
INSERT IGNORE INTO `T_SERVICE_TYPE`(`id`, `title`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `weight`) VALUES (3, '测试', 'system', '2019-06-05 17:13:58', 'system', '2019-06-05 17:13:58', b'0', NULL);
INSERT IGNORE INTO `T_SERVICE_TYPE`(`id`, `title`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `weight`) VALUES (4, '部署', 'system', '2019-06-05 17:13:59', 'system', '2019-06-05 17:13:59', b'0', NULL);
-- INSERT IGNORE INTO `T_SERVICE_TYPE`(`id`, `title`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `weight`) VALUES (5, '运营', 'system', '2019-06-05 17:14:00', 'system', '2019-06-05 17:14:00', b'1', NULL);
-- INSERT IGNORE INTO `T_SERVICE_TYPE`(`id`, `title`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `weight`) VALUES (6, '安全', 'system', '2019-06-05 17:14:01', 'system', '2019-06-05 17:14:01', b'1', NULL);
-- INSERT IGNORE INTO `T_SERVICE_TYPE`(`id`, `title`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `weight`) VALUES (7, '研发商店', 'system', '2019-06-05 17:14:02', 'system', '2019-06-05 17:14:02', b'0', NULL);
INSERT IGNORE INTO `T_SERVICE_TYPE`(`id`, `title`, `created_user`, `created_time`, `updated_user`, `updated_time`, `deleted`, `weight`) VALUES (8, '管理工具', 'system', '2019-06-05 17:14:02', 'system', '2019-06-05 17:14:02', b'0', NULL);

-- 错误码初始化
INSERT IGNORE INTO `T_MESSAGE_CODE_DETAIL` (`ID`, `MESSAGE_CODE`, `MODULE_CODE`, `MESSAGE_DETAIL_ZH_CN`, `MESSAGE_DETAIL_ZH_TW`, `MESSAGE_DETAIL_EN`) VALUES
  ('40fb0ad10a8a11e9b8da14050aafaa15', '2100001', '00', '系统内部繁忙，请稍后再试', '系統內部繁忙，請稍後再試', 'System busy, please try again later'),
  ('41000cf40a8a11e9b8da14050aafaa15', '2100002', '00', '{0}不能为空', '{0}不能爲空', '{0} cannot be empty'),
  ('35e05d0e329911e9b8da14050aafaa15', '2100003', '00', '{0}已经存在系统，请换一个再试', '{0}已經存在系統，請換一個再試', '{0}  already exists in system, please try another one'),
  ('12fe02000a8a11e9b8da14050aafaa15', '2100004', '00', '{0}为非法数据', '{0}爲非法數據', '{0} is illegal data'),
  ('5781b9600f0b11e9b8da14050aafaa15', '2100005', '00', '无效的token，请先oauth认证', '無效的token，請先oauth認證', 'Invalid token, please use oauth authentication first'),
  ('22d551f3130d11e9b8da14050aafaa15', '2100006', '00', '您没有操作权限', '您沒有操作權限', 'You have no operation rights'),
  ('32d561f3130d11e9b8da14050aafaa15', '2100007', '00', '找不到任何有效的[{0}]服务提供者', '找不到任何有效的[{0}]服務提供者', 'No valid [{0}] service providers were found'),
  ('a53337a7efcb4fb281d5ae8c361063a5', '2101901', '01', '运行中状态，忽略重试的请求', '運行中狀態，忽略重試的請求', 'Ignoring duplicate requests'),
  ('2b582818b10446608b307e9d721b3369', '2101902', '01', '请设置Job运行条件时的自定义变量', '請設置Job運行条件時的自定義變量', 'Please set the custom variable of the Job run condition'),
  ('9c81c81a8ffa4f019e07679711ecce2c', '2101903', '01', '{0}运行达到({1})分钟，超时结束运行!', '{0}運行達到({1})分鐘，超時結束運行!', 'The {0} run reaches ({1}) minutes and terminates the timeout!'),
  ('39567a9bcb9e47118e40bb07b4585f9e', '2101904', '01', '排队超时，取消运行! [{0}]', '排隊超時，取消運行! [{0}]', 'Queuing timed out, canceled running! [{0}]'),
  ('ed0d752586074fa692cd448a0c93a36f', '2101991', '01', 'Windows暂时没有公共构建机可用，请联系持续集成助手添加', 'Windows暫時沒有公共構建機可用，請聯系持續集成助手添加', 'There is no public build machine available for Windows, please contact continuous integration assistant to add'),
  ('a53337a7efcb4fb281d5ae8c361nn3a0', '2101100', '01', '流水线构建[{0}]不存在', '流水線構建[{0}]不存在', 'Pipeline build [{0}] does not exist'),
  ('a53337a7efcb4fb281d5ae8c361nn3a1', '2101101', '01', '流水线[{0}]不存在', '流水線[{0}]不存在', 'Pipeline [{0}] does not exist'),
  ('a53337a7efcb4fb281d5ae8c361nn3a2', '2101001', '01', '子流水线id不存在', '子流水線id不存在', 'Subpipeline id does not exist'),
  ('a53337a7efcb4fb281d5ae8c361nn3a3', '2101002', '01', '子流水线不存在', '子流水線不存在', 'Subpipeline does not exist'),
  ('a53337a7efcb4fb281d5ae8c361nn3a4', '2101010', '01', '插件不存在', '插件不存在', 'Plug-in does not exist'),
  ('a53337a7efcb4fb281d5ae8c361nn3a5', '2101038', '01', '流水线不存在', '流水線不存在', 'Pipeline does not exist'),
  ('a53337a7efcb4fb281d5ae8c361nn3a6', '2101039', '01', '流水线的模型不存在', '流水線的模型不存在', 'The pipeline model does not exist'),
  ('a53337a7efcb4fb281d5ae8c361nn3a7', '2101040', '01', '流水线的模型中指定构建容器{0}不存在', '流水線的模型中指定構建容器{0}不存在', 'The specified build container {0} does not exist in the pipeline model'),
  ('a53337a7efcb4fb281d5ae8c361nn3a8', '2101041', '01', '流水线的定时触发器保存失败', '流水線的定時觸發器保存失敗', 'Pipeline timing trigger failed to save'),
  ('a53337a7efcb4fb281d5ae8c361nn3a9', '2101043', '01', '流水线的定时触发器删除失败', '流水線的定時觸發器刪除失敗', 'Pipeline timing trigger deletion failed'),
  ('a53337a7efcb4fb281d5ae8c361nn3t0', '2101047', '01', '流水线锁定', '流水線鎖定', 'Pipeline locking'),
  ('a53337a7efcb4fb281d5ae8c361nn3t1', '2101049', '01', '流水线队列满', '流水線隊列滿', 'Pipeline queue full'),
  ('a53337a7efcb4fb281d5ae8c361nn3t2', '2101050', '01', '第三方构建机状态异常', '第三方構建機狀態異常', 'The third party build machine is in an abnormal state'),
  ('1063dd33193d11e9b8da14050aafaa15', '2102001', '02', '{0}类型文件不支持上传，您可以上传{1}类型文件', '{0}類型文件不支持上傳，您可以上傳{1}類型文件', 'Upload is not supported for {0} type files. You can upload {1} type files'),
  ('e8272cf0193f11e9b8da14050aafaa15', '2102002', '02', '上传的文件不能超过{0}', '上傳的文件不能超過{0}', 'Upload files cannot exceed {0}'),
  ('55913ac708c211e86792fa163e50f2b5', '2115001', '15', '创建GIT代码库失败，请稍后再试', '創建GIT代碼庫失敗，請稍後再試', 'Failed to create GIT repository, please try again later'),
  ('eea5ebc0764311e9934328b4488474ef', '2115002', '15', '更新GIT代码库失败，请稍后再试', '更新GIT代碼庫失敗，請稍后再試', 'Failed to update GIT repository, Please try again later'),
  ('eea5f3a8764311e9934328b4488474ef', '2115003', '15', 'GIT代码添加成员{0}失败，请稍后再试', 'GIT代碼添加成員{0}失敗，請稍后再試', 'GIT code failed to add member {0}, Try again later'),
  ('eea6ebc0789311e9934328b4488474ef', '2115004', '15', '代码库迁移至{0}项目组失败，请稍后再试', '代碼庫遷移至{0}項目組失敗，請稍後再試', 'The code base migration to the {0} project team failed. Please try again later'),
  ('500e478c0a8a11e9b8da14050aafaa15', '2120001', '20', '您没有查询该插件的权限', '您沒有查詢該插件的權限', 'You do not have permission to query this plugin'),
  ('501388d40a8a11e9b8da14050aafaa15', '2120002', '20', '您没有查询该项目的权限', '您沒有查詢該項目的權限', 'You do not have permission to query the project'),
  ('faf87b6a0b0d11e9b8da14050aafaa15', '2120003', '20', '创建代码库失败，请检查新建的代码库是否已存在或oauth认证信息是否有效', '創建代碼庫失敗，請檢查新建的代碼庫是否已存在或oauth認證信息是否有效', 'Failed to create the code base. Please check whether the new code base already exists or whether the oauth authentication information is valid'),
  ('5f87f16417cc11e9b8da14050aafaa15', '2120005', '20', '拉取插件json配置文件失败,请确认文件是否正确上传至代码库', '拉取插件json配置文件失敗,請確認文件是否正確上傳至代碼庫', 'Failed to pull the plugin json configuration file. Please make sure the file is uploaded to the code base correctly'),
  ('eea081a410da11e9b8da14050aafaa15', '2120006', '20', '插件json配置文件{0}节点不能为空', '插件json配置文件{0}節點不能爲空', 'The plugin json configuration file {0} node cannot be empty'),
  ('eea49e8610da11e9b8da14050aafaa15', '2120007', '20', '插件json配置文件{0}字段与系统录入不一致', '插件json配置文件{0}字段與系統錄入不一致', 'The plugin json configuration file {0} field is inconsistent with system entry'),
  ('f38d2cd5133b11e9b8da14050aafaa15', '2120008', '20', '发布流程状态流转顺序不正确', '發布流程狀態流轉順序不正確', 'Incorrect order of publishing process state flow'),
  ('570fc45d17d411e9b8da14050aafaa15', '2120009', '20', '插件{0}的{1}版本发布流程未结束，请稍后再试', '插件{0}的{1}版本發布流程未結束，請稍後再試', 'The release process of {1} version of plugin {0} is not complete, please try again later'),
  ('83a1109a305011e9b8da14050aafaa15', '2120010', '20', '插件升级的版本号{0}错误，应为{1}', '插件升級的版本號{0}錯誤，應爲{1}', 'Plugin upgrade version number {0} error, should be {1}'),
  ('e8b34be330d811e9b8da14050aafaa15', '2120011', '20', '插件logo的尺寸必须为{0}x{1}', '插件logo的尺寸必須爲{0}x{1}', 'The size of the plugin logo must be {0}x{1}'),
  ('fcb156f730eb11e9b8da14050aafaa15', '2120012', '20', '{0}类型logo文件不支持上传，您可以上传{1}类型logo文件', '{0}類型logo文件不支持上傳，您可以上傳{1}類型logo文件', '{0} type logo file does not support uploading, you can upload {1} type logo file'),
  ('fcb7508030eb11e9b8da14050aafaa15', '2120013', '20', '上传的logo文件大小不能超过{0}', '上傳的logo文件大小不能超過{0}', 'The uploaded logo file size cannot exceed {0}'),
  ('dc70622239a711e9b8da14050aafaa15', '2120014', '20', '请检查插件配置文件{0}是否上传至原子代码库，或者格式是否正确', '請檢查插件配置文件{0}是否上傳至原子代碼庫，或者格式是否正確', 'please check if the configuration file {0} is uploaded to the code base, or if the format is correct'),
  ('4b63ca0f32a745eabcdf1fb50be40f8b', '2120015', '20', '你不在{0}插件的可见范围之内，如需调整插件的可见范围请联系插件的发布者', '妳不在{0}插件的可見範圍之內，如需調整插件的可見範圍請聯系插件的發布者', 'You are not within the visibility of the {0} plugin. To adjust the visibility of the plugin please contact the plugin''s publisher'),
  ('feffa901619311e9934328b4488474ef', '2120016', '20', '管理员个数不能少于1个', '管理員個數不能少於1個', 'The number of administrators cannot be less than one'),
  ('feffb134619311e9934328b4488474ef', '2120201', '20', '{0}模板的{1}版本发布未结束，请稍后再试', '{0}模板的{1}版本發布未結束，請稍後再試', 'The {1} version of the {0} template has not been released. Please try again later'),
  ('feffb605619311e9934328b4488474ef', '2120202', '20', '模板发布流程中状态变更顺序不正确', '模板發布流程中狀態變更順序不正確', 'Incorrect order of state changes in template release process'),
  ('feffbaae619311e9934328b4488474ef', '2120203', '20', '模板的可见范围不在{0}插件的可见范围之内，如需调整插件的可见范围请联系插件的发布者', '模板的可見範圍不在{0}插件的可見範圍之內，如需調整插件的可見範圍請聯繫插件的發布者', 'The visible range of the template is not within the visible range of the {0} plugin. To adjust the visible range of the plugin, please contact the publisher of the plugin'),
  ('feffbf0b619311e9934328b4488474ef', '2120204', '20', '模版下的插件{0}尚未安装，请先安装后再使用', '模版下的插件{0}尚未安裝，請先安裝後再使用', 'The plugin {0} under the template has not been installed. Please install it before using it'),
  ('835d8f25802611e9934328b4488474ef', '2120205', '20', '模版{0}已发布到商店，请先下架再删除', '模版{0}已發布到商店，請先下架再刪除', 'The template {0} has been released to the store, please remove it first and then delete it.'),
  ('b8ff4a03cb7f44868f549b39913095c5', '2120206', '20', '模版{0}已安装到其他项目下使用，请勿移除', '模版{0}已安裝到其他項目下使用，請勿移除', 'Template {0} is already installed under other projects, please do not remove'),
  ('eda48918763d11e9934328b4488474ef', '2120401', '20', '字段名{0}已存在', '字段名{0}已存在', 'Field name {0} already exists'),
  ('feffc329619311e9934328b4488474ef', '2120901', '20', '你已点赞过', '你已點贊過', 'You have already passed thumb up'),
  ('feffc744619311e9934328b4488474ef', '2120902', '20', '你没有权限将组件安装到项目：{0}', '你沒有權限將組件安裝到項目：{0}', 'You do not have permission to install components into the project: {0}'),
  ('feffcb67619311e9934328b4488474ef', '2120903', '20', '你已评论过，无法继续添加评论，但可以对评论进行修改', '你已評論過，無法繼續添加評論，但可以對評論進行修改', 'You have commented, can not continue to add comments, but the comments can be modified'),
  ('feffd0f0619311e9934328b4488474ef', '2120904', '20', '该分类下还有项目正在使用的组件，不允许直接删除', '該分類下還有項目正在使用的組件，不允許直接刪除', 'There are also components under this category that are being used by the project and are not allowed to be deleted directly'),
  ('deffc329619311e9936328b4488474ef', '2120905', '20', '请确认上传的包是否正确', '請確認上傳的包是否正確', 'Please confirm that the package uploaded is correct'),
  ('bd26ecd3585e40e080626a5c29fcedb1', 'begin', '00', '开始', '開始', 'begin'),
  ('bd26ecd3585e40e080626a5c29fcedb2', 'commit', '00', '提交', '提交', 'commit'),
  ('bd26ecd3585e40e080626a5c29fcedb7', 'doing', '00', '执行中', '執行中', 'doing'),
  ('bd26ecd3585e40e080626a5c29fcedb4', 'end', '00', '结束', '結束', 'end'),
  ('bd26ecd3585e40e080626a5c29fcedb8', 'fail', '00', '失败', '失敗', 'end'),
  ('5b2fbe9fb31a45e99cc7ffb2b690bcd2', 'hottest', '20', '最热', '最熱', 'hottest'),
  ('bd26ecd3585e40e080626a5c29fcedb9', 'ing', '00', '中', '中', 'ing'),
  ('5b2fbe9fb31a45e99cc7ffb2b690bcd1', 'latest', '20', '最新', '最新', 'latest'),
  ('5b2fbe9fb31a45e99cc7ffb2b690bcda', 'STORE_ATOM_STATUS_TESTING', '20', '测试中', '测试中', 'TESTING'),
  ('bd26ecd3585e40e080626a5c29fcedb0', 'STORE_ATOM_STATUS_UNDERCARRIAGED', '20', '已下架', '已下架', 'UNDERCARRIAGED'),
  ('fc005dcfd74c4072a5de13e7a6319728', 'STORE_ATOM_STATUS_UNDERCARRIAGING', '20', '下架中', '下架中', 'UNDERCARRIAGING'),
  ('bd26ecd3585e40e080626a5c29fcedb5', 'success', '00', '成功', '成功', 'success'),
  ('bd26ecd3585e40e080626a5c29fcedb3', 'test', '00', '测试', '測試', 'test'),
  ('bd26ecd3585e40e080626a5c29fcedb6', 'undo', '00', '未执行', '未執行', 'undo'),
  ('5b2fbe9fb31a45e99cc7ffb2b690bcd3', 'unRelease', '20', '取消发布', '取消發布', 'unRelease');
