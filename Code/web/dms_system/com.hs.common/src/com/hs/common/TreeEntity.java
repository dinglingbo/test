package com.hs.common;

import java.util.List;

public interface TreeEntity<E> {
	public String getMenuPrimeKey();
    public String getParentId();
    public String getLinkAction();
    public List<E> getChildrenMenuTreeNodeList();
    public void setChildrenMenuTreeNodeList(List<E> childList);
}
