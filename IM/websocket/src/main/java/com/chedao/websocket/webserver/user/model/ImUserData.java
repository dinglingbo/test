package com.chedao.websocket.webserver.user.model;

import java.io.Serializable;
import java.util.Map;


public class ImUserData implements Serializable {
	private static final long serialVersionUID = 1L;

	public String code;
	public String msg;
	public Map data;
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Map getData() {
		return data;
	}
	public void setData(Map data) {
		this.data = data;
	}
 
	 
	 
}
