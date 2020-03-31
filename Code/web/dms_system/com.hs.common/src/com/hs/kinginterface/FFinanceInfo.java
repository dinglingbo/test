package com.hs.kinginterface;

public class FFinanceInfo {
	
	CommonFNumber FCustomerId;

	CommonFNumber FPayCurrencyId;

	public CommonFNumber getFPayCurrencyId() {
		return FPayCurrencyId;
	}

	public void setFPayCurrencyId(CommonFNumber fPayCurrencyId) {
		FPayCurrencyId = fPayCurrencyId;
	}

	public CommonFNumber getFCustomerId() {
		return FCustomerId;
	}

	public void setFCustomerId(CommonFNumber fCustomerId) {
		FCustomerId = fCustomerId;
	}
}
