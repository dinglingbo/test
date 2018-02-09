package com.hs.common;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.eos.foundation.common.utils.CryptoUtil;
import com.eos.system.annotation.Bizlet;
import com.hs.common.model.Contribution;
import com.hs.common.model.Group;
import com.hs.common.model.InitPlatformDataObjectModel;
import com.hs.common.model.InitPlatformModel;
import com.hs.common.model.Module;
import com.hs.common.model.OrgModel;
import com.hs.common.model.RoleModel;
import com.hs.common.model.UserDataObjectModel;
import com.hs.common.model.UserModel;
import commonj.sdo.DataObject;

@Bizlet("")
public class Env {

	private static String basePath;

	private static String newsServerURL;// 新闻服务器URL地址
	private static String initXmlPath;// 初始化数据库XML路径
	private static String roleXmlPath;// 角色模板XML路径
	private static String platformAdminMenuXmlPath;// 平台管理员菜单模板XML路径
	private static String orgAdminMenuXmlPath;// 机构管理员菜单模板XML路径

	private static Map<String, Contribution> ctrMap = new HashMap<String, Contribution>();// 配置Map

	private static InitPlatformModel initPlatformTemplate;// 用于初始化平台的模板

	@Bizlet("")
	public static String reLoadEnv() {
		if (Env.basePath != null) {
			initContribution(Env.basePath);// 重新加载配置文件
		}
		return "已重新加载配置文件，basePath：" + Env.basePath;
	}

	public static void envInit(String basePath) {
		Env.basePath = basePath;
		// 初始化Env.xml
		initContribution(Env.basePath);
		if (null == Env.newsServerURL || "".equalsIgnoreCase(Env.newsServerURL)) {
			Env.newsServerURL = Env.getContributionConfig("com.vplus.newsmgr",
					"newsCfg", "newsURL", "newsServerURL");
		}
		if (null == Env.initXmlPath || "".equalsIgnoreCase(Env.initXmlPath)) {
			Env.initXmlPath = Env.getContributionConfig("com.vplus.orgmgr",
					"orgCfg", "orgXml", "com.vplus.initXmlPath");
		}
		if (null == Env.roleXmlPath || "".equalsIgnoreCase(Env.roleXmlPath)) {
			Env.roleXmlPath = Env.getContributionConfig("com.vplus.orgmgr",
					"orgCfg", "orgXml", "com.vplus.template.roleXmlPath");
		}
		if (null == Env.platformAdminMenuXmlPath
				|| "".equalsIgnoreCase(Env.platformAdminMenuXmlPath)) {
			Env.platformAdminMenuXmlPath = Env.getContributionConfig(
					"com.vplus.orgmgr", "orgCfg", "orgXml",
					"com.vplus.template.platformAdmin.menuXmlPath");
		}
		if (null == Env.orgAdminMenuXmlPath
				|| "".equalsIgnoreCase(Env.orgAdminMenuXmlPath)) {
			Env.orgAdminMenuXmlPath = Env.getContributionConfig(
					"com.vplus.orgmgr", "orgCfg", "orgXml",
					"com.vplus.template.orgAdmin.menuXmlPath");
		}
	}

	@Bizlet("")
	public static String getBasePath() {
		return basePath;
	}

	public static String getNewsServerURL() {
		return newsServerURL;
	}

	public static String getInitXmlPath() {
		return Env.initXmlPath;
	}

	public static String getRoleXmlPath() {
		return Env.roleXmlPath;
	}

	public static String getPlatformAdminMenuXmlPath() {
		return platformAdminMenuXmlPath;
	}

	public static String getOrgAdminMenuXmlPath() {
		return orgAdminMenuXmlPath;
	}

	public static void generateInitPlatformModel() {
		InitPlatformModel initPlatformModel = null;
		String filePath = Env.basePath + Env.initXmlPath;
		File file = new File(filePath);
		if (!file.exists()) {// 平台初始化模板不存在
			System.out.println("找不到平台初始化模板！路径为：" + filePath);
		} else {// 平台初始化模板存在
			try {
				initPlatformModel = new InitPlatformModel();
				SAXReader reader = new SAXReader();
				Document document = reader.read(file);
				Element env = document.getRootElement();
				Element platform = env.element("platform");
				Element mpOrgs = platform.element("mpOrgs");// 平台机构
				OrgModel orgModel = parseOrgModel(mpOrgs);// 解析平台机构
				Element mpRolesList = platform.element("mpRolesList");// 平台管理员角色列表
				List<RoleModel> roleModels = parseRoleModel(mpRolesList);// 解析平台管理员角色列表
				Element mpUsersList = platform.element("mpUsersList");// 平台管理员列表
				List<UserModel> userModels = parseUserModel(mpUsersList);// 解析用户成员列表

				initPlatformModel.setOrgModel(orgModel);// 设置平台机构
				initPlatformModel.setRoleModels(roleModels);// 设置平台管理员角色列表
				initPlatformModel.setUserModels(userModels);// 设置平台管理员列表
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}

		Env.initPlatformTemplate = initPlatformModel;
	}

	/* 解析平台机构 */
	private static OrgModel parseOrgModel(Element mpOrgs) {
		OrgModel orgModel = null;
		if (null != mpOrgs) {
			orgModel = new OrgModel();
			/* 可修改字段 */
			orgModel.setOrgName(mpOrgs.elementTextTrim("orgName"));
			orgModel.setOrgFullName(mpOrgs.elementTextTrim("orgFullName"));
			orgModel.setOrgCode(mpOrgs.elementTextTrim("orgCode"));
			/* 固定字段 */
			orgModel.setCreatedBy(Long.parseLong(mpOrgs
					.elementTextTrim("createdBy")));
			orgModel.setLastUpdatedBy(Long.parseLong(mpOrgs
					.elementTextTrim("lastUpdatedBy")));
			orgModel.setOrgType(mpOrgs.elementTextTrim("orgType"));
			orgModel.setOrgStatus(mpOrgs.elementTextTrim("orgStatus"));
			orgModel.setAuthorStatus(mpOrgs.elementTextTrim("authorStatus"));
			orgModel.setSiblingAllowAccess(mpOrgs
					.elementTextTrim("siblingAllowAccess"));
			orgModel.setParentAllowAccess(mpOrgs
					.elementTextTrim("parentAllowAccess"));
			orgModel.setAllowAccessOthers(mpOrgs
					.elementTextTrim("allowAccessOthers"));
			orgModel.setFriendAuth(mpOrgs.elementTextTrim("friendAuth"));
			orgModel.setCreationDate(new Date());
			orgModel.setLastUpdateDate(new Date());
		}

		return orgModel;
	}

	/* 解析平台管理员角色列表 */
	private static List<RoleModel> parseRoleModel(Element mpRolesListEle) {
		List<RoleModel> roleModels = new ArrayList<RoleModel>();
		RoleModel roleModel = null;
		if (null != mpRolesListEle) {
			for (Element mpRoles : (List<Element>) mpRolesListEle
					.elements("mpRoles")) {
				roleModel = new RoleModel();
				/* 可修改字段 */
				roleModel.setRoleName(mpRoles.elementTextTrim("roleName"));
				roleModel.setRoleCode(mpRoles.elementTextTrim("roleCode"));
				/* 固定字段 */
				roleModel.setIsSystem(mpRoles.elementTextTrim("isSystem"));
				roleModel.setRoleStatus(mpRoles.elementTextTrim("roleStatus"));
				roleModel.setCreatedBy(Long.parseLong(mpRoles
						.elementTextTrim("createdBy")));
				roleModel.setLastUpdatedBy(Long.parseLong(mpRoles
						.elementTextTrim("lastUpdatedBy")));
				roleModel.setCreationDate(new Date());
				roleModel.setLastUpdateDate(new Date());

				roleModels.add(roleModel);
			}
		}

		return roleModels;
	}

	/* 解析用户成员列表 */
	private static List<UserModel> parseUserModel(Element mpUsersListEle) {
		List<UserModel> userModels = new ArrayList<UserModel>();
		UserModel userModel = null;
		List<String> roleCodes = new ArrayList<String>();
		if (null != mpUsersListEle) {
			for (Element mpUsers : (List<Element>) mpUsersListEle
					.elements("mpUsers")) {
				userModel = new UserModel();
				/* 可修改字段 */
				userModel.setUserName(mpUsers.elementTextTrim("userName"));
				userModel.setUserCode(mpUsers.elementTextTrim("userCode"));
				userModel.setPassword(CryptoUtil.digestByMD5(mpUsers
						.elementTextTrim("password")));
				/* 固定字段 */
				userModel.setIsLocked(mpUsers.elementTextTrim("isLocked"));
				userModel.setAuthorType(mpUsers.elementTextTrim("authorType"));
				userModel.setUserStatus(mpUsers.elementTextTrim("userStatus"));
				userModel.setIsPublic(mpUsers.elementTextTrim("isPublic"));
				userModel.setCreatedBy(Long.parseLong(mpUsers
						.elementTextTrim("createdBy")));
				userModel.setLastUpdatedBy(Long.parseLong(mpUsers
						.elementTextTrim("lastUpdatedBy")));
				userModel.setAuthStatus(mpUsers.elementTextTrim("authStatus"));
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.YEAR, 100);// 密码有效期为100年
				userModel.setPasswordExpiredDate(cal.getTime());
				userModel.setCreationDate(new Date());
				userModel.setLastUpdateDate(new Date());
				/* 关联角色列表 */
				Element roleCodeList = mpUsers.element("roleCodeList");
				roleCodes.clear();// 清空关联角色列表
				for (Element roleCode : (List<Element>) roleCodeList
						.elements("roleCode")) {
					roleCodes.add(roleCode.getTextTrim());
				}
				userModel.setRoleCodeList(roleCodes);// 设置关联角色

				userModels.add(userModel);
			}
		}

		return userModels;
	}

	/* InitPlatformModel转换成DataObject */
	@Bizlet("")
	public static InitPlatformDataObjectModel parseInitPlatformModel2DataObject() {
		OrgModel orgModel = Env.initPlatformTemplate.getOrgModel();
		List<RoleModel> rolesModel = Env.initPlatformTemplate.getRoleModels();
		List<UserModel> usersModel = Env.initPlatformTemplate.getUserModels();

		DataObject orgDO = parseOrgModel2DataObject(orgModel);
		DataObject[] roleDOs = parseRoleModels2DataObject(rolesModel);
		UserDataObjectModel[] userDOMs = parseUserModels2DataObject(usersModel,
				roleDOs);

		return new InitPlatformDataObjectModel(orgDO, roleDOs, userDOMs);
	}

	/* OrgModel转换成DataObject */
	private static DataObject parseOrgModel2DataObject(OrgModel orgModel) {
		DataObject orgDO = null;
		try {
			orgDO = com.eos.foundation.data.DataObjectUtil
					.createDataObject("com.vplus.data.org.MpOrgs");
			orgDO.set("orgId", com.eos.foundation.database.DatabaseExt
					.getNextSequence("MpOrgs.orgId"));
			orgDO.set("orgName", orgModel.getOrgName());
			orgDO.set("orgFullName", orgModel.getOrgFullName());
			orgDO.set("orgCode", orgModel.getOrgCode());
			orgDO.set("createdBy", orgModel.getCreatedBy());
			orgDO.set("lastUpdatedBy", orgModel.getLastUpdatedBy());
			orgDO.set("orgType", orgModel.getOrgType());
			orgDO.set("orgStatus", orgModel.getOrgStatus());
			orgDO.set("authorStatus", orgModel.getAuthorStatus());
			orgDO.set("siblingAllowAccess", orgModel.getSiblingAllowAccess());
			orgDO.set("parentAllowAccess", orgModel.getParentAllowAccess());
			orgDO.set("allowAccessOthers", orgModel.getAllowAccessOthers());
			orgDO.set("friendAuth", orgModel.getFriendAuth());
			orgDO.set("creationDate", orgModel.getCreationDate());
			orgDO.set("lastUpdateDate", orgModel.getLastUpdateDate());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return orgDO;
	}

	/* roleModels转换成DataObject */
	private static DataObject[] parseRoleModels2DataObject(
			List<RoleModel> roleModels) {
		List<DataObject> list = new ArrayList<DataObject>();
		DataObject roleDO = null;
		try {
			for (RoleModel roleModel : roleModels) {
				roleDO = com.eos.foundation.data.DataObjectUtil
						.createDataObject("com.vplus.data.sys.MpRoles");
				roleDO.set("roleId", com.eos.foundation.database.DatabaseExt
						.getNextSequence("MpRoles.roleId"));
				roleDO.set("roleName", roleModel.getRoleName());
				roleDO.set("roleCode", roleModel.getRoleCode());
				roleDO.set("isSystem", roleModel.getIsSystem());
				roleDO.set("roleStatus", roleModel.getRoleStatus());
				roleDO.set("createdBy", roleModel.getCreatedBy());
				roleDO.set("lastUpdatedBy", roleModel.getLastUpdatedBy());
				roleDO.set("creationDate", roleModel.getCreationDate());
				roleDO.set("lastUpdateDate", roleModel.getLastUpdateDate());

				list.add(roleDO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list.toArray(new DataObject[list.size()]);
	}

	/* userModels转换成DataObject */
	private static UserDataObjectModel[] parseUserModels2DataObject(
			List<UserModel> userModels, DataObject[] rolesDO) {
		List<UserDataObjectModel> list = new ArrayList<UserDataObjectModel>();
		List<DataObject> roleMemberList = new ArrayList<DataObject>();
		UserDataObjectModel userDOM = null;
		DataObject userDO = null;
		try {
			for (UserModel userModel : userModels) {
				userDOM = new UserDataObjectModel();
				userDO = com.eos.foundation.data.DataObjectUtil
						.createDataObject("com.vplus.data.sys.MpUsers");
				userDO.set("userId", com.eos.foundation.database.DatabaseExt
						.getNextSequence("MpUsers.userId"));
				userDO.set("userName", userModel.getUserName());
				userDO.set("userCode", userModel.getUserCode());
				userDO.set("password", userModel.getPassword());
				userDO.set("isLocked", userModel.getIsLocked());
				userDO.set("authorType", userModel.getAuthorType());
				userDO.set("userStatus", userModel.getUserStatus());
				userDO.set("isPublic", userModel.getIsPublic());
				userDO.set("createdBy", userModel.getCreatedBy());
				userDO.set("lastUpdatedBy", userModel.getLastUpdatedBy());
				userDO.set("authStatus", userModel.getAuthStatus());
				userDO.set("passwordExpiredDate",
						userModel.getPasswordExpiredDate());
				userDO.set("creationDate", userModel.getCreationDate());
				userDO.set("lastUpdateDate", userModel.getLastUpdateDate());
				userDO.set("userPyName",
						PY4JUtils.converterToSpell(userModel.getUserName()));
				userDO.set("userPyShortName", PY4JUtils
						.converterToFirstSpell(userModel.getUserName()));
				// 保存该用户关联的角色
				roleMemberList.clear();
				List<String> roleCodeList = userModel.getRoleCodeList();
				DataObject roleDO = null;
				DataObject roleMemberDO = null;
				for (String roleCode : roleCodeList) {
					roleDO = getRoleDataObjectByRoleCode(roleCode, rolesDO);
					roleMemberDO = com.eos.foundation.data.DataObjectUtil
							.createDataObject("com.vplus.data.sys.MpRoleMembers");
					roleMemberDO.set("memberId",
							com.eos.foundation.database.DatabaseExt
									.getNextSequence("MpRoleMembers.memberId"));
					roleMemberDO.set("roleId", roleDO.get("roleId"));
					roleMemberDO.set("memberSourceId", userDO.get("userId"));
					roleMemberDO.set("memberType", "USER");
					roleMemberDO.set("includeChild", "N");
					roleMemberDO.set("roleCode", roleCode);
					roleMemberList.add(roleMemberDO);
				}
				userDOM.setUserDO(userDO);
				userDOM.setRoleMemberDOs(roleMemberList
						.toArray(new DataObject[roleMemberList.size()]));
				list.add(userDOM);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list.toArray(new UserDataObjectModel[list.size()]);
	}

	private static DataObject getRoleDataObjectByRoleCode(String roleCode,
			DataObject[] rolesDO) {
		for (DataObject roleDO : rolesDO) {
			if (roleCode.equalsIgnoreCase(roleDO.getString("roleCode"))) {
				return roleDO;
			}
		}

		return null;
	}

	/* 初始化项目配置Contribution */
	private synchronized static void initContribution(String path) {
		path += "env.xml";
		File file = new File(path);
		if (!file.exists()) {// 配置不存在
			System.out.println("找不到配置文件！路径为：" + path);
		} else {// 读取配置文件
			System.out.println("初始化配置，配置文件路径为：" + path);
			List<Element> conEles = null;
			String ctrName = null;
			List<Element> modEles = null;
			String modName = null;
			List<Element> groEles = null;
			String groName = null;
			List<Element> cvEles = null;
			String key = null;
			String val = null;

			Module module = null;
			Group group = null;
			Contribution contribution = null;
			try {
				ctrMap.clear();
				SAXReader reader = new SAXReader();
				Document document = reader.read(file);
				Element env = document.getRootElement();
				conEles = env.elements("contribution");
				for (Element conEle : conEles) {
					contribution = new Contribution();
					ctrName = conEle.attributeValue("name");
					modEles = conEle.elements("module");
					for (Element modEle : modEles) {
						module = new Module();
						modName = modEle.attributeValue("name");
						groEles = modEle.elements("group");
						for (Element groEle : groEles) {
							group = new Group();
							groName = groEle.attributeValue("name");
							cvEles = groEle.elements("configValue");
							for (Element cvEle : cvEles) {
								key = cvEle.attributeValue("key");
								val = cvEle.getTextTrim();
								group.setConfigValue(key, val);
							}
							module.setGroup(groName, group);
						}
						contribution.setModule(modName, module);
					}
					ctrMap.put(ctrName, contribution);
				}
				System.out.println("配置文件初始化成功！");
			} catch (DocumentException e) {
				e.printStackTrace();
			}
		}
	}

	private static String getCtrMap(String ctrName, String module,
			String group, String key) {
		Contribution contributionModel = null;
		if (ctrMap.containsKey(ctrName)) {// ctrName是否存在
			contributionModel = ctrMap.get(ctrName);
		} else {
			return null;
		}
		Module moduleModel = null;
		if (null != contributionModel && contributionModel.containsKey(module)) {// module是否存在
			moduleModel = contributionModel.getModule(module);
		} else {
			return null;
		}
		Group groupModel = null;
		if (null != moduleModel && moduleModel.containsKey(group)) {// group是否存在
			groupModel = moduleModel.getGroup(group);
		} else {
			return null;
		}
		String val = null;
		if (null != groupModel && groupModel.containsKey(key)) {// key是否存在
			val = groupModel.getConfigValue(key);
		}
		return val;
	}

	/**
	 * 获取指定contribution属性中一个配置参数值.
	 * 
	 * @param ctrName
	 *            contribution name
	 * @param module
	 *            模块
	 * @param group
	 *            组
	 * @param key
	 *            键
	 * @return
	 */
	@Bizlet("")
	public static String getContributionConfig(String ctrName, String module,
			String group, String key) {
		String val = getCtrMap(ctrName, module, group, key);
		return val;
	}

	public static void main(String[] args) {
		String path = "/data/appConfig/dmsEnv/";
		Env.initContribution(path);

	}

}
