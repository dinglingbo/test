package com.chedao.websocket.webserver.user.model;

import java.io.Serializable;
import java.util.List;

public class ImFriendUserData implements Serializable {
	private static final long serialVersionUID = 1L;
	
	public Long id;//分组ID
	public String groupname;//好友分组Name
	public List<ImFriendUserInfoData> list;//分组好友列表
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getGroupname() {
		return groupname;
	}
	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}
	public List<ImFriendUserInfoData> getList() {
		return list;
	}
	public void setList(List<ImFriendUserInfoData> list) {
		this.list = list;
	}
 
	
}
