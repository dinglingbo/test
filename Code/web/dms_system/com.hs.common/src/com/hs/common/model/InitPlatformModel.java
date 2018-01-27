package com.hs.common.model;

import java.util.List;

public class InitPlatformModel {

	private OrgModel orgModel;
	private List<RoleModel> roleModels;
	private List<UserModel> userModels;
	
	public InitPlatformModel() {}

	public InitPlatformModel(OrgModel orgModel, List<RoleModel> roleModels,
			List<UserModel> userModels) {
		this.orgModel = orgModel;
		this.roleModels = roleModels;
		this.userModels = userModels;
	}

	public OrgModel getOrgModel() {
		return orgModel;
	}

	public void setOrgModel(OrgModel orgModel) {
		this.orgModel = orgModel;
	}

	public List<RoleModel> getRoleModels() {
		return roleModels;
	}

	public void setRoleModels(List<RoleModel> roleModels) {
		this.roleModels = roleModels;
	}

	public List<UserModel> getUserModels() {
		return userModels;
	}

	public void setUserModels(List<UserModel> userModels) {
		this.userModels = userModels;
	}

	@Override
	public String toString() {
		return "InitPlatformModel [orgModel=" + orgModel + ", roleModels="
				+ roleModels + ", userModels=" + userModels + "]";
	}
	
}
