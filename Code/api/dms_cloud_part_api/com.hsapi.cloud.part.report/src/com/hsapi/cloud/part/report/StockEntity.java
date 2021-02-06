package com.hsapi.cloud.part.report;

import java.util.List;

public class StockEntity {
	private String corporation_tax;
	private String company_name;
	private String user_id;
	private String erp_type;
	private List<InventoryData> inventory_data;
	private String appkey;
	private String timestamp;
	private String sign;
	public String getCorporation_tax() {
		return corporation_tax;
	}
	public void setCorporation_tax(String corporation_tax) {
		this.corporation_tax = corporation_tax;
	}
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getErp_type() {
		return erp_type;
	}
	public void setErp_type(String erp_type) {
		this.erp_type = erp_type;
	}
	public List<InventoryData> getInventory_data() {
		return inventory_data;
	}
	public void setInventory_data(List<InventoryData> inventory_data) {
		this.inventory_data = inventory_data;
	}
	public String getAppkey() {
		return appkey;
	}
	public void setAppkey(String appkey) {
		this.appkey = appkey;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	
	

}
