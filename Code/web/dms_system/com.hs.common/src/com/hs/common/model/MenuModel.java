package com.hs.common.model;

import java.util.List;

public class MenuModel {

	private String menuName;
	private String menuCode;
	private String menuURL;
	private Long seqNo;
	private String menuIcon;
	private String createdBy;
	private String lastUpdatedBy;
	private List<MenuModel> children;
	private String isLeaf;
	private Long parentMenuId;
	
	public MenuModel() {}

	public MenuModel(String menuName, String menuCode, String menuURL,
			Long seqNo, String menuIcon, String createdBy,
			String lastUpdatedBy, List<MenuModel> children, String isLeaf,
			Long parentMenuId) {
		this.menuName = menuName;
		this.menuCode = menuCode;
		this.menuURL = menuURL;
		this.seqNo = seqNo;
		this.menuIcon = menuIcon;
		this.createdBy = createdBy;
		this.lastUpdatedBy = lastUpdatedBy;
		this.children = children;
		this.isLeaf = isLeaf;
		this.parentMenuId = parentMenuId;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public String getMenuURL() {
		return menuURL;
	}

	public void setMenuURL(String menuURL) {
		this.menuURL = menuURL;
	}

	public Long getSeqNo() {
		return seqNo;
	}

	public void setSeqNo(Long seqNo) {
		this.seqNo = seqNo;
	}

	public String getMenuIcon() {
		return menuIcon;
	}

	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}

	public String getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public String getLastUpdatedBy() {
		return lastUpdatedBy;
	}

	public void setLastUpdatedBy(String lastUpdatedBy) {
		this.lastUpdatedBy = lastUpdatedBy;
	}

	public List<MenuModel> getChildren() {
		return children;
	}

	public void setChildren(List<MenuModel> children) {
		this.children = children;
	}

	public String getIsLeaf() {
		return isLeaf;
	}

	public void setIsLeaf(String isLeaf) {
		this.isLeaf = isLeaf;
	}

	public Long getParentMenuId() {
		return parentMenuId;
	}

	public void setParentMenuId(Long parentMenuId) {
		this.parentMenuId = parentMenuId;
	}

	@Override
	public String toString() {
		return "MenuModel [menuName=" + menuName + ", menuCode=" + menuCode
				+ ", menuURL=" + menuURL + ", seqNo=" + seqNo + ", menuIcon="
				+ menuIcon + ", createdBy=" + createdBy + ", lastUpdatedBy="
				+ lastUpdatedBy + ", children=" + children + ", isLeaf="
				+ isLeaf + ", parentMenuId=" + parentMenuId + "]";
	}

}
