package com.hs.kinginterface;

public class Staff {
	
	String FName;//员工姓名
	String FStaffNumber;//员工编号 唯一
	String FJoinDate;//入职日期
	
	CommonFNumber FCreateOrgId;//创建组织
	CommonFNumber FUseOrgId;//使用组织
	public String getFName() {
		return FName;
	}
	public void setFName(String fName) {
		FName = fName;
	}
	public String getFStaffNumber() {
		return FStaffNumber;
	}
	public void setFStaffNumber(String fStaffNumber) {
		FStaffNumber = fStaffNumber;
	}
	public String getFJoinDate() {
		return FJoinDate;
	}
	public void setFJoinDate(String fJoinDate) {
		FJoinDate = fJoinDate;
	}
	public CommonFNumber getFCreateOrgId() {
		return FCreateOrgId;
	}
	public void setFCreateOrgId(CommonFNumber fCreateOrgId) {
		FCreateOrgId = fCreateOrgId;
	}
	public CommonFNumber getFUseOrgId() {
		return FUseOrgId;
	}
	public void setFUseOrgId(CommonFNumber fUseOrgId) {
		FUseOrgId = fUseOrgId;
	}

	

}
