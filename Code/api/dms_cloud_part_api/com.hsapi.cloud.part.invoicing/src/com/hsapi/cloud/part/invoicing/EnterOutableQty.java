package com.hsapi.cloud.part.invoicing;

import java.util.Date;

public class EnterOutableQty {
	private Integer id;
	private Float outableQty;
	private Integer mainId; 
	private Integer sourceId; 
	private Integer rootId; 
	private Integer storeId;
	private Integer partId;
	private String partCode;
	private String partName;
	private String fullName;
	private String enterUnitId;
	private String systemUnitId;
	private Float enterQty;
	private Float enterPrice;
	private Float enterAmt;
	private Float trueOutableQty;
	private Integer taxSign;
	private Float taxRate;
	private Float taxPrice;
	private Float taxAmt;
	private Float noTaxPrice;
	private Float noTaxAmt;
	private Float taxDiff;
	private Float rtnPrice;
	private Float rtnAmt;
	private Date enterDate;
	private Integer preDetailId;
	private Integer orderDetailId;
	private Integer orderMainId;
	private Integer branchStockAge;
	private Integer chainStockAge;
	private Integer guestId;
	private String guestName;
	private String remark;
	private String  code;
	private String  name; 
	private String  oemCode;
	private String  partBrandId;
	private String  carModelName;
	private String  spec;
	private String  direction;
	private String  color;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public float getOutableQty() {
		return outableQty;
	}
	public void setOutableQty(float outableQty) {
		this.outableQty = outableQty;
	}
	public Integer getMainId() {
		return mainId;
	}
	public void setMainId(Integer mainId) {
		this.mainId = mainId;
	}
	public Integer getSourceId() {
		return sourceId;
	}
	public void setSourceId(Integer sourceId) {
		this.sourceId = sourceId;
	}
	public Integer getRootId() {
		return rootId;
	}
	public void setRootId(Integer rootId) {
		this.rootId = rootId;
	}
	public Integer getStoreId() {
		return storeId;
	}
	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}
	public Integer getPartId() {
		return partId;
	}
	public void setPartId(Integer partId) {
		this.partId = partId;
	}
	public String getPartCode() {
		return partCode;
	}
	public void setPartCode(String partCode) {
		this.partCode = partCode;
	}
	public String getPartName() {
		return partName;
	}
	public void setPartName(String partName) {
		this.partName = partName;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getEnterUnitId() {
		return enterUnitId;
	}
	public void setEnterUnitId(String enterUnitId) {
		this.enterUnitId = enterUnitId;
	}
	public String getSystemUnitId() {
		return systemUnitId;
	}
	public void setSystemUnitId(String systemUnitId) {
		this.systemUnitId = systemUnitId;
	}
	public float getEnterQty() {
		return enterQty;
	}
	public void setEnterQty(float enterQty) {
		this.enterQty = enterQty;
	}
	public float getEnterPrice() {
		return enterPrice;
	}
	public void setEnterPrice(float enterPrice) {
		this.enterPrice = enterPrice;
	}
	public float getEnterAmt() {
		return enterAmt;
	}
	public void setEnterAmt(float enterAmt) {
		this.enterAmt = enterAmt;
	}
	public float getTrueOutableQty() {
		return trueOutableQty;
	}
	public void setTrueOutableQty(float trueOutableQty) {
		this.trueOutableQty = trueOutableQty;
	}
	public Integer getTaxSign() {
		return taxSign;
	}
	public void setTaxSign(Integer taxSign) {
		this.taxSign = taxSign;
	}
	public float getTaxRate() {
		return taxRate;
	}
	public void setTaxRate(float taxRate) {
		this.taxRate = taxRate;
	}
	public float getTaxPrice() {
		return taxPrice;
	}
	public void setTaxPrice(float taxPrice) {
		this.taxPrice = taxPrice;
	}
	public float getTaxAmt() {
		return taxAmt;
	}
	public void setTaxAmt(float taxAmt) {
		this.taxAmt = taxAmt;
	}
	public float getNoTaxPrice() {
		return noTaxPrice;
	}
	public void setNoTaxPrice(float noTaxPrice) {
		this.noTaxPrice = noTaxPrice;
	}
	public float getNoTaxAmt() {
		return noTaxAmt;
	}
	public void setNoTaxAmt(float noTaxAmt) {
		this.noTaxAmt = noTaxAmt;
	}
	public float getTaxDiff() {
		return taxDiff;
	}
	public void setTaxDiff(float taxDiff) {
		this.taxDiff = taxDiff;
	}
	public float getRtnPrice() {
		return rtnPrice;
	}
	public void setRtnPrice(float rtnPrice) {
		this.rtnPrice = rtnPrice;
	}
	public float getRtnAmt() {
		return rtnAmt;
	}
	public void setRtnAmt(float rtnAmt) {
		this.rtnAmt = rtnAmt;
	}
	public Date getEnterDate() {
		return enterDate;
	}
	public void setEnterDate(Date enterDate) {
		this.enterDate = enterDate;
	}
	public Integer getPreDetailId() {
		return preDetailId;
	}
	public void setPreDetailId(Integer preDetailId) {
		this.preDetailId = preDetailId;
	}
	public Integer getOrderDetailId() {
		return orderDetailId;
	}
	public void setOrderDetailId(Integer orderDetailId) {
		this.orderDetailId = orderDetailId;
	}
	public Integer getOrderMainId() {
		return orderMainId;
	}
	public void setOrderMainId(Integer orderMainId) {
		this.orderMainId = orderMainId;
	}
	public Integer getBranchStockAge() {
		return branchStockAge;
	}
	public void setBranchStockAge(Integer branchStockAge) {
		this.branchStockAge = branchStockAge;
	}
	public Integer getChainStockAge() {
		return chainStockAge;
	}
	public void setChainStockAge(Integer chainStockAge) {
		this.chainStockAge = chainStockAge;
	}
	public Integer getGuestId() {
		return guestId;
	}
	public void setGuestId(Integer guestId) {
		this.guestId = guestId;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getOemCode() {
		return oemCode;
	}
	public void setOemCode(String oemCode) {
		this.oemCode = oemCode;
	}
	public String getPartBrandId() {
		return partBrandId;
	}
	public void setPartBrandId(String partBrandId) {
		this.partBrandId = partBrandId;
	}
	public String getCarModelName() {
		return carModelName;
	}
	public void setCarModelName(String carModelName) {
		this.carModelName = carModelName;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}

	
	
}
