package com.hsapi.system.kingkong;

public class Customer {
	long CustID;
	String FNumber;
	String FName;
	String FShortName;
	CommonFNumber FCreateOrgId;
	CommonFNumber FTRADINGCURRID;
	String FPriority;
	
	public long getCustID() {
		return CustID;
	}
	public void setCustID(long custID) {
		CustID = custID;
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
	public String getFShortName() {
		return FShortName;
	}
	public void setFShortName(String fShortName) {
		FShortName = fShortName;
	}
	

	public String getFPriority() {
		return FPriority;
	}
	public void setFPriority(String fName) {
		FPriority = fName;
	}

	public CommonFNumber getFCreateOrgId() {
		return FCreateOrgId;
	}
	public void setFCreateOrgId(CommonFNumber fCreateOrgId) {
		FCreateOrgId = fCreateOrgId;
	}
	

	public String getFTRADINGCURRID() {
		return FShortName;
	}
	public void setFTRADINGCURRID(CommonFNumber ftradingcurrid) {
		FTRADINGCURRID = ftradingcurrid;
	}

}
