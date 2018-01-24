package com.hs.common.model;

import java.util.Date;
import java.util.List;

/**
 * MP_USERS的Model
 * @author xzm
 *
 */
public class UserModel {

	private Long userId;
	private Long orgId;
	private String userCode;
	private String userName;
	private String password;
	private String isLocked;
	private Date passwordExpiredDate;
	private String authorType;
	private String ahthorMethod;
	private String telNo;
	private String avatar;
	private String cover;
	private String nickName;
	private String gender;
	private String signature;
	private String email;
	private String qq;
	private String userArea;
	private String wechatNo;
	private String userStatus;
	private Date  disableDate;
	private Long deviceId;
	private String pushChannelId;
	private String desktopChannelId;
	private String osName;
	private String sourceCode;
	private String sourceId;
	private String osVersion;
	private String sysVersion;
	private String phoneVendor;
	private String phoneModel;
	private String userPyName;
	private String userPyShortName;
	private Date pcFirstLogin;
	private Date mobileFirstLogin;
	private String isPublic;
	private String uuid;
	private Long createdBy;
	private Date lastUpdateDate;
	private Long lastUpdatedBy;
	private Date creationDate;
	private String attribute1;
	private String attribute2;
	private String attribute3;
	private String attribute4;
	private String attribute5;
	private String attribute6;
	private String attribute7;
	private String attribute8;
	private String attribute9;
	private String attribute10;
	private String attribute11;
	private String attribute12;
	private String attribute13;
	private String attribute14;
	private String attribute15;
	private String authStatus;
	private List<String> roleCodeList;//关联角色列表
	
	public UserModel() {}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getOrgId() {
		return orgId;
	}

	public void setOrgId(Long orgId) {
		this.orgId = orgId;
	}

	public String getUserCode() {
		return userCode;
	}

	public void setUserCode(String userCode) {
		this.userCode = userCode;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getIsLocked() {
		return isLocked;
	}

	public void setIsLocked(String isLocked) {
		this.isLocked = isLocked;
	}
	
	public Date getPasswordExpiredDate() {
		return passwordExpiredDate;
	}

	public void setPasswordExpiredDate(Date passwordExpiredDate) {
		this.passwordExpiredDate = passwordExpiredDate;
	}

	public String getAuthorType() {
		return authorType;
	}

	public void setAuthorType(String authorType) {
		this.authorType = authorType;
	}

	public String getAhthorMethod() {
		return ahthorMethod;
	}

	public void setAhthorMethod(String ahthorMethod) {
		this.ahthorMethod = ahthorMethod;
	}

	public String getTelNo() {
		return telNo;
	}

	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getUserArea() {
		return userArea;
	}

	public void setUserArea(String userArea) {
		this.userArea = userArea;
	}

	public String getWechatNo() {
		return wechatNo;
	}

	public void setWechatNo(String wechatNo) {
		this.wechatNo = wechatNo;
	}

	public String getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public Date getDisableDate() {
		return disableDate;
	}

	public void setDisableDate(Date disableDate) {
		this.disableDate = disableDate;
	}

	public Long getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(Long deviceId) {
		this.deviceId = deviceId;
	}

	public String getPushChannelId() {
		return pushChannelId;
	}

	public void setPushChannelId(String pushChannelId) {
		this.pushChannelId = pushChannelId;
	}

	public String getDesktopChannelId() {
		return desktopChannelId;
	}

	public void setDesktopChannelId(String desktopChannelId) {
		this.desktopChannelId = desktopChannelId;
	}

	public String getOsName() {
		return osName;
	}

	public void setOsName(String osName) {
		this.osName = osName;
	}

	public String getSourceCode() {
		return sourceCode;
	}

	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}

	public String getSourceId() {
		return sourceId;
	}

	public void setSourceId(String sourceId) {
		this.sourceId = sourceId;
	}

	public String getOsVersion() {
		return osVersion;
	}

	public void setOsVersion(String osVersion) {
		this.osVersion = osVersion;
	}

	public String getSysVersion() {
		return sysVersion;
	}

	public void setSysVersion(String sysVersion) {
		this.sysVersion = sysVersion;
	}

	public String getPhoneVendor() {
		return phoneVendor;
	}

	public void setPhoneVendor(String phoneVendor) {
		this.phoneVendor = phoneVendor;
	}

	public String getPhoneModel() {
		return phoneModel;
	}

	public void setPhoneModel(String phoneModel) {
		this.phoneModel = phoneModel;
	}

	public String getUserPyName() {
		return userPyName;
	}

	public void setUserPyName(String userPyName) {
		this.userPyName = userPyName;
	}

	public String getUserPyShortName() {
		return userPyShortName;
	}

	public void setUserPyShortName(String userPyShortName) {
		this.userPyShortName = userPyShortName;
	}

	public Date getPcFirstLogin() {
		return pcFirstLogin;
	}

	public void setPcFirstLogin(Date pcFirstLogin) {
		this.pcFirstLogin = pcFirstLogin;
	}

	public Date getMobileFirstLogin() {
		return mobileFirstLogin;
	}

	public void setMobileFirstLogin(Date mobileFirstLogin) {
		this.mobileFirstLogin = mobileFirstLogin;
	}

	public String getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(String isPublic) {
		this.isPublic = isPublic;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public Long getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}

	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}

	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}

	public Long getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(Long lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public String getAttribute1() {
		return attribute1;
	}

	public void setAttribute1(String attribute1) {
		this.attribute1 = attribute1;
	}

	public String getAttribute2() {
		return attribute2;
	}

	public void setAttribute2(String attribute2) {
		this.attribute2 = attribute2;
	}

	public String getAttribute3() {
		return attribute3;
	}

	public void setAttribute3(String attribute3) {
		this.attribute3 = attribute3;
	}

	public String getAttribute4() {
		return attribute4;
	}

	public void setAttribute4(String attribute4) {
		this.attribute4 = attribute4;
	}

	public String getAttribute5() {
		return attribute5;
	}

	public void setAttribute5(String attribute5) {
		this.attribute5 = attribute5;
	}

	public String getAttribute6() {
		return attribute6;
	}

	public void setAttribute6(String attribute6) {
		this.attribute6 = attribute6;
	}

	public String getAttribute7() {
		return attribute7;
	}

	public void setAttribute7(String attribute7) {
		this.attribute7 = attribute7;
	}

	public String getAttribute8() {
		return attribute8;
	}

	public void setAttribute8(String attribute8) {
		this.attribute8 = attribute8;
	}

	public String getAttribute9() {
		return attribute9;
	}

	public void setAttribute9(String attribute9) {
		this.attribute9 = attribute9;
	}

	public String getAttribute10() {
		return attribute10;
	}

	public void setAttribute10(String attribute10) {
		this.attribute10 = attribute10;
	}

	public String getAttribute11() {
		return attribute11;
	}

	public void setAttribute11(String attribute11) {
		this.attribute11 = attribute11;
	}

	public String getAttribute12() {
		return attribute12;
	}

	public void setAttribute12(String attribute12) {
		this.attribute12 = attribute12;
	}

	public String getAttribute13() {
		return attribute13;
	}

	public void setAttribute13(String attribute13) {
		this.attribute13 = attribute13;
	}

	public String getAttribute14() {
		return attribute14;
	}

	public void setAttribute14(String attribute14) {
		this.attribute14 = attribute14;
	}

	public String getAttribute15() {
		return attribute15;
	}

	public void setAttribute15(String attribute15) {
		this.attribute15 = attribute15;
	}

	public String getAuthStatus() {
		return authStatus;
	}

	public void setAuthStatus(String authStatus) {
		this.authStatus = authStatus;
	}

	public List<String> getRoleCodeList() {
		return roleCodeList;
	}

	public void setRoleCodeList(List<String> roleCodeList) {
		this.roleCodeList = roleCodeList;
	}

	@Override
	public String toString() {
		return "UserModel [userId=" + userId + ", orgId=" + orgId
				+ ", userCode=" + userCode + ", userName=" + userName
				+ ", password=" + password + ", isLocked=" + isLocked
				+ ", passwordExpiredDate=" + passwordExpiredDate
				+ ", authorType=" + authorType + ", ahthorMethod="
				+ ahthorMethod + ", telNo=" + telNo + ", avatar=" + avatar
				+ ", cover=" + cover + ", nickName=" + nickName + ", gender="
				+ gender + ", signature=" + signature + ", email=" + email
				+ ", qq=" + qq + ", userArea=" + userArea + ", wechatNo="
				+ wechatNo + ", userStatus=" + userStatus + ", disableDate="
				+ disableDate + ", deviceId=" + deviceId + ", pushChannelId="
				+ pushChannelId + ", desktopChannelId=" + desktopChannelId
				+ ", osName=" + osName + ", sourceCode=" + sourceCode
				+ ", sourceId=" + sourceId + ", osVersion=" + osVersion
				+ ", sysVersion=" + sysVersion + ", phoneVendor=" + phoneVendor
				+ ", phoneModel=" + phoneModel + ", userPyName=" + userPyName
				+ ", userPyShortName=" + userPyShortName + ", pcFirstLogin="
				+ pcFirstLogin + ", mobileFirstLogin=" + mobileFirstLogin
				+ ", isPublic=" + isPublic + ", uuid=" + uuid + ", createdBy="
				+ createdBy + ", lastUpdateDate=" + lastUpdateDate
				+ ", lastUpdatedBy=" + lastUpdatedBy + ", creationDate="
				+ creationDate + ", attribute1=" + attribute1 + ", attribute2="
				+ attribute2 + ", attribute3=" + attribute3 + ", attribute4="
				+ attribute4 + ", attribute5=" + attribute5 + ", attribute6="
				+ attribute6 + ", attribute7=" + attribute7 + ", attribute8="
				+ attribute8 + ", attribute9=" + attribute9 + ", attribute10="
				+ attribute10 + ", attribute11=" + attribute11
				+ ", attribute12=" + attribute12 + ", attribute13="
				+ attribute13 + ", attribute14=" + attribute14
				+ ", attribute15=" + attribute15 + ", authStatus=" + authStatus
				+ ", roleCodeList=" + roleCodeList + "]";
	}
	
}
