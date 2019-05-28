更新的步骤:
    1.后台添加：
		添加com.hsapi.wechat.autoServiceBackstage.weChatStoreActivity.componentType营销活动的构建包.
		更改了com.huasheng.usersWechat.storeSql.namingsql命名sql文件，添加了queryWechatStoreActivityInfo的sql语句.
		导入了wxb_activition_account，wxb_store_activity表
      2.前端后台页面：添加了
		autoServiceSys/weChatActivities/addStoreActivities.jsp
		autoServiceSys/weChatActivities/storeActivitiesManagement.jsp
     3.数据库：
	1.创建wxb_activition_account，wxb_store_activity表，（可能已经有了，如果没有就创建）
	2.wxb_activition_account表插入数据：
		insert into `wxb_activition_account` (`account_id`, `activition_acct`, `activition_sacct`, `activition_pwd`, `staff_login`, `empid`, `empName`, `orgid`, `tenant_id`) values('1','18674656852','幻尘凡世','asd1109907430','0','862','宜修壹',NULL,NULL);
	3.wxb_business_dict表插入数据：
		insert into `wxb_business_dict` (`dict_id`, `dict_name`, `dict_content`, `dict_notes`, `dict_url`) values('31','MENU_STORE_ACTIVITIES','MENU_URL','门店营销活动列表页面','/activityList');  
    4.创建后台菜单在精准营销下面：
	营销活动：http://qxy.7xdr.com/dms/autoServiceSys/weChatActivities/activitiesLogin.jsp?activitionMean=MENU_STORE_ACTIVITIES