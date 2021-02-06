package com.hs.kinginterface;

public class Material {
	long FMATERIALID;
	String FNumber;
	String FName;
	String FOldNumber;

	CommonFNumber FCreateOrgId;
	CommonFNumber FUseOrgId;
	
	public long getFMATERIALID() {
		return FMATERIALID;
	}
	public void setFMATERIALID(long fMATERIALID) {
		FMATERIALID = fMATERIALID;
	}
	public String getFNumber() {
		return FNumber;
	}
	public void setFNumber(String fNumber) {
		FNumber = fNumber;
	}
	public String getFName() {
		return FName;
	}
	public void setFName(String fName) {
		FName = fName;
	}
	public String getFOldNumber() {
		return FOldNumber;
	}
	public void setFOldNumber(String fOldNumber) {
		FOldNumber = fOldNumber;
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
