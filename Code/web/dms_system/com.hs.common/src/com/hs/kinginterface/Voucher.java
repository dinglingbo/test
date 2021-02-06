package com.hs.kinginterface;

import java.util.List;

public class Voucher {
	
	CommonFNumber FAccountBookID;//账簿
	
	String FDate;  //日期：FDate  (必填项)
	String FBUSDATE;  //业务日期
	
	CommonFNumber FVOUCHERGROUPID; //凭证字  PRE001 记
	
	String FVOUCHERGROUPNO;  //业务日期  凭证号：FVOUCHERGROUPNO  (必填项)  月内递增，还是一直递增
	String FYEAR;
	String FDocumentStatus; // 审核状态 Z
	boolean FISADJUSTVOUCHER; // 是否调整期凭证 false
	String FPERIOD;
	
	CommonFNumber FSourceBillKey; // 业务类型  目前金塔固定只有  78050206-2fa6-40e3-b7c8-bd608146fa38  手工录入这一个类型
	
	List<VoucherEntity> FEntity;

	public CommonFNumber getFAccountBookID() {
		return FAccountBookID;
	}

	public void setFAccountBookID(CommonFNumber fAccountBookID) {
		FAccountBookID = fAccountBookID;
	}

	public String getFDate() {
		return FDate;
	}

	public void setFDate(String fDate) {
		FDate = fDate;
	}

	public String getFBUSDATE() {
		return FBUSDATE;
	}

	public void setFBUSDATE(String fBUSDATE) {
		FBUSDATE = fBUSDATE;
	}

	public CommonFNumber getFVOUCHERGROUPID() {
		return FVOUCHERGROUPID;
	}

	public void setFVOUCHERGROUPID(CommonFNumber fVOUCHERGROUPID) {
		FVOUCHERGROUPID = fVOUCHERGROUPID;
	}

	public String getFVOUCHERGROUPNO() {
		return FVOUCHERGROUPNO;
	}

	public void setFVOUCHERGROUPNO(String fVOUCHERGROUPNO) {
		FVOUCHERGROUPNO = fVOUCHERGROUPNO;
	}

	public String getFYEAR() {
		return FYEAR;
	}

	public void setFYEAR(String fYEAR) {
		FYEAR = fYEAR;
	}

	public String getFDocumentStatus() {
		return FDocumentStatus;
	}

	public void setFDocumentStatus(String fDocumentStatus) {
		FDocumentStatus = fDocumentStatus;
	}

	public boolean getFISADJUSTVOUCHER() {
		return FISADJUSTVOUCHER;
	}

	public void setFISADJUSTVOUCHER(boolean fISADJUSTVOUCHER) {
		FISADJUSTVOUCHER = fISADJUSTVOUCHER;
	}

	public String getFPERIOD() {
		return FPERIOD;
	}

	public void setFPERIOD(String fPERIOD) {
		FPERIOD = fPERIOD;
	}

	public CommonFNumber getFSourceBillKey() {
		return FSourceBillKey;
	}

	public void setFSourceBillKey(CommonFNumber fSourceBillKey) {
		FSourceBillKey = fSourceBillKey;
	}

	public List<VoucherEntity> getFEntity() {
		return FEntity;
	}

	public void setFEntity(List<VoucherEntity> fEntity) {
		FEntity = fEntity;
	}

}
