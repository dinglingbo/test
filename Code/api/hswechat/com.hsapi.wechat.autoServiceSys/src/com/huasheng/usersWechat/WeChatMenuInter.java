package com.huasheng.usersWechat;

import com.alibaba.fastjson.JSONObject;
import com.wechat.Tool.WechatCommonTool;

/**
 * 微信菜单接口调用
 * @author lidongsheng
 *
 */
public class WeChatMenuInter {
	
	//创建菜单接口
	public static void creatorMenu() {
		JSONObject jsonArray[]=new JSONObject[1];
		JSONObject jsonObj=new JSONObject();
		jsonObj.put("type", "view");
		jsonObj.put("name", "车道车服");
		jsonObj.put("url", "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxd10b49dcb45e5591&redirect_uri=http%3a%2f%2fppwq72ty36.51http.tech%2fdefault%2fautoServiceeSys%2fweChatServicer%2fuserLogin.jsp&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect");
		jsonArray[0] = jsonObj;
		
		JSONObject jsons=new JSONObject();
		jsons.put("button", jsonObj);
		
		System.out.println(jsons.toJSONString());
		String json=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/menu/create",ReceiveToken.getAccessToken(),jsons.toJSONString());
		
		JSONObject resData=JSONObject.parseObject(json);
		System.out.println(resData);
	}
	
	public static void main(String[] args) {
		creatorMenu();
	}
	
}
