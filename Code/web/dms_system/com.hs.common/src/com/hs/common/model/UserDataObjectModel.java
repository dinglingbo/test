package com.hs.common.model;

import java.util.Arrays;

import commonj.sdo.DataObject;

public class UserDataObjectModel {

	private DataObject userDO;
	private DataObject[] roleMemberDOs;
	
	public UserDataObjectModel() {}

	public UserDataObjectModel(DataObject userDO, DataObject[] roleMemberDOs) {
		this.userDO = userDO;
		this.roleMemberDOs = roleMemberDOs;
	}

	public DataObject getUserDO() {
		return userDO;
	}

	public void setUserDO(DataObject userDO) {
		this.userDO = userDO;
	}

	public DataObject[] getRoleMemberDOs() {
		return roleMemberDOs;
	}

	public void setRoleMemberDOs(DataObject[] roleMemberDOs) {
		this.roleMemberDOs = roleMemberDOs;
	}

	@Override
	public String toString() {
		return "UserDataObjectModel [userDO=" + userDO + ", roleMemberDOs="
				+ Arrays.toString(roleMemberDOs) + "]";
	}
	
}
