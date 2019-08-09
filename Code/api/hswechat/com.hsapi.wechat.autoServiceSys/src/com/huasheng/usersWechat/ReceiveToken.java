package com.huasheng.usersWechat;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;
import com.wechat.Tool.WechatCommonTool;

@Bizlet("")
public class ReceiveToken {
	/**
     * 向指定URL发送GET方法的请求
     * 
     * @param url
     *            获取access_token的请求链接
     * @param AppID
     *            第三方用户唯一凭证,开发者ID(AppID)
     * @return Secret 
     * 			第三方用户唯一凭证密钥，即appsecret 开发者密码(AppSecret)
     * 
     * 
     * 
     */
	
	public static String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential";
	
	public static String AppID = "wxd10b49dcb45e5591";
	public static String Secret = "8f21ab04f3b9bc252d8dce64a6d055e4";
	
	@Bizlet("")
	public static String getAccessToken(String appid ,String secret){
		String Accesstoken = null;
		url=url+"&appid="+appid+"&secret="+secret;
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
		return Accesstoken;
	}
	
	public static String getAccessToken(){
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
		return Accesstoken;
	}
	
	
	
	
}
