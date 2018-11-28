package com.hs.common;

import java.util.List;

/*
 *  childrenMenuTreeNodeList: null
	displayOrder: 1
	expandPath: null
	functionCode: "application_manage"
	imagePath: null
	level: 2
	linkAction: "/coframe/framework/application/application_manage.jsp"
	linkResId: "application_manage"
	linkType: "function"
	menuCode: "menu_app_function"
	menuId: 0
	menuName: "应用功能管理"
	menuPrimeKey: "3"
	menuSeq: ".1.3."
	openMode: null
	parentMenuTreeNode: null
 * */
public class Menu implements TreeEntity<Menu>{
	public String menuPrimeKey;//id;
    public String menuName;//name;
    public String parentId;
    public List<Menu> childrenMenuTreeNodeList;
    public Integer displayOrder;
    public String expandPath;
    public String functionCode;
    public String imagePath;
    public Integer level;
    public String linkAction;
    public String linkResId;
    public String linkType;
    public String menuCode;
    public Integer menuId;
    public String menuSeq;
    public String openMode;
    public String parentMenuTreeNode;
	public String getMenuPrimeKey() {
		return menuPrimeKey;
	}
	public void setMenuPrimeKey(String menuPrimeKey) {
		this.menuPrimeKey = menuPrimeKey;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public List<Menu> getChildrenMenuTreeNodeList() {
		return childrenMenuTreeNodeList;
	}
	public void setChildrenMenuTreeNodeList(List<Menu> childrenMenuTreeNodeList) {
		this.childrenMenuTreeNodeList = childrenMenuTreeNodeList;
	}
	public Integer getDisplayOrder() {
		return displayOrder;
	}
	public void setDisplayOrder(Integer displayOrder) {
		this.displayOrder = displayOrder;
	}
	public String getExpandPath() {
		return expandPath;
	}
	public void setExpandPath(String expandPath) {
		this.expandPath = expandPath;
	}
	public String getFunctionCode() {
		return functionCode;
	}
	public void setFunctionCode(String functionCode) {
		this.functionCode = functionCode;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public String getLinkAction() {
		return linkAction;
	}
	public void setLinkAction(String linkAction) {
		this.linkAction = linkAction;
	}
	public String getLinkResId() {
		return linkResId;
	}
	public void setLinkResId(String linkResId) {
		this.linkResId = linkResId;
	}
	public String getLinkType() {
		return linkType;
	}
	public void setLinkType(String linkType) {
		this.linkType = linkType;
	}
	public String getMenuCode() {
		return menuCode;
	}
	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
	public Integer getMenuId() {
		return menuId;
	}
	public void setMenuId(Integer menuId) {
		this.menuId = menuId;
	}
	public String getMenuSeq() {
		return menuSeq;
	}
	public void setMenuSeq(String menuSeq) {
		this.menuSeq = menuSeq;
	}
	public String getOpenMode() {
		return openMode;
	}
	public void setOpenMode(String openMode) {
		this.openMode = openMode;
	}
	public String getParentMenuTreeNode() {
		return parentMenuTreeNode;
	}
	public void setParentMenuTreeNode(String parentMenuTreeNode) {
		this.parentMenuTreeNode = parentMenuTreeNode;
	}
	
	


}
