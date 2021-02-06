package com.hs.kinginterface;

import java.io.Serializable;

public class VoucherEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;

	String FEXPLANATION;//摘要
	
	CommonFNumber FACCOUNTID;//科目编码：FACCOUNTID  (必填项)
	
	CommonFDetailID FDetailID;
	
	CommonFNumber FCURRENCYID;//币别：FCURRENCYID  (必填项)  PRE001   需要确定每种科目的维度对应哪些属性
	
	CommonFNumber FEXCHANGERATETYPE;// 汇率类型：FEXCHANGERATETYPE  (必填项)  HLTX01_SYS
	
	Double FEXCHANGERATE; //1.0 汇率
	
	
	String FBUSNO;//业务编号：FBUSNO
	
	Double FAMOUNTFOR; //  原币金额 
	
	Double FDEBIT; //借方金额
	
	Double FCREDIT; //贷方金额

	public String getFEXPLANATION() {
		return FEXPLANATION;
	}

	public void setFEXPLANATION(String fEXPLANATION) {
		FEXPLANATION = fEXPLANATION;
	}

	public CommonFNumber getFACCOUNTID() {
		return FACCOUNTID;
	}

	public void setFACCOUNTID(CommonFNumber fACCOUNTID) {
		FACCOUNTID = fACCOUNTID;
	}

	public CommonFDetailID getFDetailID() {
		return FDetailID;
	}

	public void setFDetailID(CommonFDetailID fDetailID) {
		FDetailID = fDetailID;
	}

	public CommonFNumber getFCURRENCYID() {
		return FCURRENCYID;
	}

	public void setFCURRENCYID(CommonFNumber fCURRENCYID) {
		FCURRENCYID = fCURRENCYID;
	}

	public CommonFNumber getFEXCHANGERATETYPE() {
		return FEXCHANGERATETYPE;
	}

	public void setFEXCHANGERATETYPE(CommonFNumber fEXCHANGERATETYPE) {
		FEXCHANGERATETYPE = fEXCHANGERATETYPE;
	}

	public Double getFEXCHANGERATE() {
		return FEXCHANGERATE;
	}

	public void setFEXCHANGERATE(Double fEXCHANGERATE) {
		FEXCHANGERATE = fEXCHANGERATE;
	}

	public String getFBUSNO() {
		return FBUSNO;
	}

	public void setFBUSNO(String fBUSNO) {
		FBUSNO = fBUSNO;
	}

	public Double getFAMOUNTFOR() {
		return FAMOUNTFOR;
	}

	public void setFAMOUNTFOR(Double fAMOUNTFOR) {
		FAMOUNTFOR = fAMOUNTFOR;
	}

	public Double getFDEBIT() {
		return FDEBIT;
	}

	public void setFDEBIT(Double fDEBIT) {
		FDEBIT = fDEBIT;
	}

	public Double getFCREDIT() {
		return FCREDIT;
	}

	public void setFCREDIT(Double fCREDIT) {
		FCREDIT = fCREDIT;
	}
	
	

}
