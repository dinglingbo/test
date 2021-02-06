package com.hs.kinginterface;

public class AssistantData {
	
	String FDataValue;//名称
	String FNumber;//编码 唯一
	
	CommonFNumber FId;//创建组织 类别  厂牌 CX

	public String getFDataValue() {
		return FDataValue;
	}

	public void setFDataValue(String fDataValue) {
		FDataValue = fDataValue;
	}

	public String getFNumber() {
		return FNumber;
	}

	public void setFNumber(String fNumber) {
		FNumber = fNumber;
	}

	public CommonFNumber getFId() {
		return FId;
	}

	public void setFId(CommonFNumber fId) {
		FId = fId;
	}


}
