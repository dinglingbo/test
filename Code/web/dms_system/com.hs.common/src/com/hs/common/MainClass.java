package com.hs.common;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.eos.data.datacontext.UserObject;

public class MainClass {
	public static String post(){
		String param = "http://127.0.0.1:8081/default/com.vplus.login.auth.setUserOrgInfo.biz.ext";
		Map p = new HashMap();
		p.put("loginName", "000ysg");
		p.put("posiId", null);
		p.put("roleName", null);
		String userOrgInfo = HttpUtils.sendPost(param, p);
		return userOrgInfo;
	}
public static void main(String[]args){
	/**
	* java对象转换成json对象，并获取json对象属性
	*/
	String test=post();
	Map p=Utils.str2Map(test);
	JSONObject jsonStu=JSONObject.fromObject(p.get("userObject"));

	System.out.println(jsonStu.toString());

	/**
	* json对象转换成java对象，并获取java对象属性
	*/
	UserObject stu = (UserObject) JSONObject.toBean(jsonStu, UserObject.class);
	System.out.println(stu.getUserId());
}
}
