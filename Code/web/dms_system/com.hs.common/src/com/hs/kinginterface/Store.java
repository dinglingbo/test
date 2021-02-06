package com.hs.kinginterface;

public class Store {
	
	CommonFNumber FCreateOrgId;//创建组织
	CommonFNumber FUseOrgId;//使用组织
	
	String FName;//名称
	String FNumber;//编码
	public String getFNumber() {
		return FNumber;
	}
	public void setFNumber(String fNumber) {
		FNumber = fNumber;
	}
	String FStockProperty;//仓库属性  1
	String FStockStatusType;//库存状态类型  0,1,2,3,4,5,6,7,8
	String FSortingPriority;//拣货优先级（1~9999） 1
	
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
	public String getFName() {
		return FName;
	}
	public void setFName(String fName) {
		FName = fName;
	}
	public String getFStockProperty() {
		return FStockProperty;
	}
	public void setFStockProperty(String fStockProperty) {
		FStockProperty = fStockProperty;
	}
	public String getFStockStatusType() {
		return FStockStatusType;
	}
	public void setFStockStatusType(String fStockStatusType) {
		FStockStatusType = fStockStatusType;
	}
	public String getFSortingPriority() {
		return FSortingPriority;
	}
	public void setFSortingPriority(String fSortingPriority) {
		FSortingPriority = fSortingPriority;
	}
	


}
