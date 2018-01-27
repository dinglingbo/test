package com.hs.common.model;

import java.util.Arrays;

import commonj.sdo.DataObject;

public class InitPlatformDataObjectModel {

	private DataObject orgDO;
	private DataObject[] roleDOs;
	private UserDataObjectModel[] userDOM;
	
	public InitPlatformDataObjectModel() {}

	public InitPlatformDataObjectModel(DataObject orgDO, DataObject[] roleDOs,
			UserDataObjectModel[] userDOM) {
		this.orgDO = orgDO;
		this.roleDOs = roleDOs;
		this.userDOM = userDOM;
	}

	public DataObject getOrgDO() {
		return orgDO;
	}

	public void setOrgDO(DataObject orgDO) {
		this.orgDO = orgDO;
	}

	public DataObject[] getRoleDOs() {
		return roleDOs;
	}

	public void setRoleDOs(DataObject[] roleDOs) {
		this.roleDOs = roleDOs;
	}

	public UserDataObjectModel[] getUserDOM() {
		return userDOM;
	}

	public void setUserDOM(UserDataObjectModel[] userDOM) {
		this.userDOM = userDOM;
	}

	@Override
	public String toString() {
		return "InitPlatformDataObjectModel [orgDO=" + orgDO + ", roleDOs="
				+ Arrays.toString(roleDOs) + ", userDOM="
				+ Arrays.toString(userDOM) + "]";
	}

}
