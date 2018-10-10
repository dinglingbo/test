package com.hs.common;

import java.io.File;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class InitEnvironmentListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent event) {
		String basePath = null;
		basePath = "/data/appConfig" + File.separator + "dmsEnv"
				+ File.separator;// + "env.xml";
		// basePath = event.getServletContext().getRealPath("");// 环境配置文件根目录
		Env.envInit(basePath);// 将系统配置读进Env单例
		
		Env.generateInitPlatformModel();// 解析初始化数据库XML
		// RoleTemplate.generateRoleTemplate();//加载机构管理员角色模板
		// MenuTemplate.generateMenuTemplate();//加载平台管理员菜单模板和机构管理员菜单模板

		// 系统启动后需要手动调用 com.vplus.init.init.initPlatform 实现数据库的初始化

	}

	@Override
	public void contextDestroyed(ServletContextEvent event) {

	}

}
