package com.hsapi.cloud.part.invoicing;

import java.io.Serializable;
import java.util.Date;

public class StoreInvocing implements Serializable {
	private Integer id;
	private Integer dc;
	private Integer orgid;
	private Integer storeId;
	private String serviceId;
	private Integer billMainId;
	private Integer billDetailId;
	private String billTypeId;
	private Long guestId;
	private String guestName;
	private Integer partId;
	private String partCode;
	private String partName;
	private Float qcQty;
	private Float qcPrice;
	private Float qcAmt;
	private Float qty;
	private Float price;
	private Float amt;
	private Float costPrice;
	private Float costAmt;
	private Float balaQty;
	private Float balaPrice;
	private Float balaAmt;
	private String remark;
	private Integer creatorId;
	private String creator;
	private Date createDate;
	private Integer operatorId;
	private String operator;
	private Date operateDate;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getDc() {
		return dc;
	}
	public void setDc(Integer dc) {
		this.dc = dc;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public Integer getStoreId() {
		return storeId;
	}
	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}
	public String getServiceId() {
		return serviceId;
	}
	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}
	public Integer getBillMainId() {
		return billMainId;
	}
	public void setBillMainId(Integer billMainId) {
		this.billMainId = billMainId;
	}
	public Integer getBillDetailId() {
		return billDetailId;
	}
	public void setBillDetailId(Integer billDetailId) {
		this.billDetailId = billDetailId;
	}
	public String getBillTypeId() {
		return billTypeId;
	}
	public void setBillTypeId(String billTypeId) {
		this.billTypeId = billTypeId;
	}
	public Long getGuestId() {
		return guestId;
	}
	public void setGuestId(Long guestId) {
		this.guestId = guestId;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
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
	public Float getQcQty() {
		return qcQty;
	}
	public void setQcQty(Float qcQty) {
		this.qcQty = qcQty;
	}
	public Float getQcPrice() {
		return qcPrice;
	}
	public void setQcPrice(Float qcPrice) {
		this.qcPrice = qcPrice;
	}
	public Float getQcAmt() {
		return qcAmt;
	}
	public void setQcAmt(Float qcAmt) {
		this.qcAmt = qcAmt;
	}
	public Float getQty() {
		return qty;
	}
	public void setQty(Float qty) {
		this.qty = qty;
	}
	public Float getPrice() {
		return price;
	}
	public void setPrice(Float price) {
		this.price = price;
	}
	public Float getAmt() {
		return amt;
	}
	public void setAmt(Float amt) {
		this.amt = amt;
	}
	public Float getCostPrice() {
		return costPrice;
	}
	public void setCostPrice(Float costPrice) {
		this.costPrice = costPrice;
	}
	public Float getCostAmt() {
		return costAmt;
	}
	public void setCostAmt(Float costAmt) {
		this.costAmt = costAmt;
	}
	public Float getBalaQty() {
		return balaQty;
	}
	public void setBalaQty(Float balaQty) {
		this.balaQty = balaQty;
	}
	public Float getBalaPrice() {
		return balaPrice;
	}
	public void setBalaPrice(Float balaPrice) {
		this.balaPrice = balaPrice;
	}
	public Float getBalaAmt() {
		return balaAmt;
	}
	public void setBalaAmt(Float balaAmt) {
		this.balaAmt = balaAmt;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(Integer creatorId) {
		this.creatorId = creatorId;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Integer getOperatorId() {
		return operatorId;
	}
	public void setOperatorId(Integer operatorId) {
		this.operatorId = operatorId;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public Date getOperateDate() {
		return operateDate;
	}
	public void setOperateDate(Date operateDate) {
		this.operateDate = operateDate;
	}



}
