package com.hs.kinginterface;

public class Supplier {
	long FSupplierId;
	String FNumber;
	CommonFNumber FUseOrgId;
	CommonFNumber FCreateOrgId;
	String FName;
	String FShortName;
	FFinanceInfo FFinanceInfo;
	public long getFSupplierId() {
		return FSupplierId;
	}
	public void setFSupplierId(long fSupplierId) {
		FSupplierId = fSupplierId;
	}
	public String getFNumber() {
		return FNumber;
	}
	public void setFNumber(String fNumber) {
		FNumber = fNumber;
	}
	public CommonFNumber getFUseOrgId() {
		return FUseOrgId;
	}
	public void setFUseOrgId(CommonFNumber fUseOrgId) {
		FUseOrgId = fUseOrgId;
	}
	public CommonFNumber getFCreateOrgId() {
		return FCreateOrgId;
	}
	public void setFCreateOrgId(CommonFNumber fCreateOrgId) {
		FCreateOrgId = fCreateOrgId;
	}
	public String getFName() {
		return FName;
	}
	public void setFName(String fName) {
		FName = fName;
	}
	public String getFShortName() {
		return FShortName;
	}
	public void setFShortName(String fShortName) {
		FShortName = fShortName;
	}
	public FFinanceInfo getFFinanceInfo() {
		return FFinanceInfo;
	}
	public void setFFinanceInfo(FFinanceInfo fFinanceInfo) {
		FFinanceInfo = fFinanceInfo;
	}
	

}
