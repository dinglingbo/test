package com.hs.kinginterface;

public class Department {
	
	String FName;//名称
	String FEffectDate;//生效日期
	String FLapseDate;//失效日期   9999-12-31 00:00:00
	
	CommonFNumber FCreateOrgId;//创建组织
	CommonFNumber FUseOrgId;//使用组织

	CommonFNumber FDeptProperty;//部门属性   DP02_SYS 管理部门
	CommonFNumber FGroup;//部门分组  001 销售部
	
	public String getFName() {
		return FName;
	}
	public void setFName(String fName) {
		FName = fName;
	}
	public String getFEffectDate() {
		return FEffectDate;
	}
	public void setFEffectDate(String fEffectDate) {
		FEffectDate = fEffectDate;
	}
	public String getFLapseDate() {
		return FLapseDate;
	}
	public void setFLapseDate(String fLapseDate) {
		FLapseDate = fLapseDate;
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
	public CommonFNumber getFDeptProperty() {
		return FDeptProperty;
	}
	public void setFDeptProperty(CommonFNumber fDeptProperty) {
		FDeptProperty = fDeptProperty;
	}
	public CommonFNumber getFGroup() {
		return FGroup;
	}
	public void setFGroup(CommonFNumber fGroup) {
		FGroup = fGroup;
	}
	
	

}
