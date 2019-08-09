package com.huasheng.usersWechat;

import java.util.Map;

import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;
import com.wechat.Tool.WechatCommonTool;

@Bizlet("")
public class WeChatIPUrl {
	public static String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential";
	
	public static String AppID = "wxd10b49dcb45e5591";
	public static String Secret = "8f21ab04f3b9bc252d8dce64a6d055e4";
	@Bizlet("")
	public static String queryWeChatIp(){
		String Accesstoken = null;
		url=url+"&appid="+AppID+"&secret="+Secret;
		String JAccesstoken = WechatCommonTool.transferLinkInterface(url);
		System.out.println(url);
		JSONObject json = JSONObject.parseObject(JAccesstoken);
		System.out.println(json.toJSONString());
		if (json != null) {
			try {
				Accesstoken = json.getString("access_token");
			} catch (JSONException e) {
				Accesstoken = null;
				System.out.println("系统异常，获取access_token失败");
			}
		}
		return json.toJSONString();
	}
	
}
