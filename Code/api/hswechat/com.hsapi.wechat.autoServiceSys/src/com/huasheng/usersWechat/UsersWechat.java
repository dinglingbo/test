package com.huasheng.usersWechat;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;
import com.wechat.Tool.WechatCommonTool;

import commonj.sdo.DataObject;

@Bizlet("")
public class UsersWechat {
	
	//获取用户列表
	public List<String> getUserOpidList(String appid ,String secret){
		String url="https://api.weixin.qq.com/cgi-bin/user/get?access_token="+ReceiveToken.getAccessToken(appid,secret)+"&next_openid="+"";
		String JAccesstoken = WechatCommonTool.transferLinkInterface(url);
		JSONObject json = JSONObject.parseObject(JAccesstoken);
		
		JSONObject openidLists =json.getJSONObject("data");
		int total = json.getIntValue("total");
		int count = json.getIntValue("count");
		String nextOpenid = json.getString("next_openid");
		List<String> mapListJson = (List)openidLists.get("openid");
		int lenths=total/10000;//需要再一次调用的次数
		lenths-=1;//删除第一次
		if(total%10000>0) lenths+=1;
		for(int a=0;a<lenths;a++){
			Map map = getUserNext(appid,secret,nextOpenid);
			List<String> list = (List<String>) map.get("userOpidList");
			for(int b=0;b<list.size()-1;b++){
				mapListJson.add(list.get(b));
			}
			nextOpenid=(String) map.get("nextOpenid");
		}
		
		return mapListJson;
	}
	
	public Map getUserNext(String appid ,String secret,String nextOpenid){
		String urls="https://api.weixin.qq.com/cgi-bin/user/get?access_token="+ReceiveToken.getAccessToken(appid,secret)+"&next_openid="+nextOpenid;
		String userData = WechatCommonTool.transferLinkInterface(urls);
		JSONObject userJson = JSONObject.parseObject(userData);
		JSONObject openidLists =userJson.getJSONObject("data");
		List<String> mapListJson = (List)openidLists.get("openid");
		Map map=new HashMap();
		map.put("userOpidList", mapListJson);
		map.put("nextOpenid", openidLists.getString("next_openid"));
		return map;
	}
	
	//获取用户信息列表
	@Bizlet("")
	public List<Object> getUserInforList(String appid ,String secret){
		List<Object> userObjectList = new ArrayList<Object>();
		
		List<String> opidList = getUserOpidList(appid,secret);
		JSONObject json = new JSONObject();
		List<JSONObject> opidObjectList = new ArrayList<JSONObject>();
		boolean bool=false;
		for(int a=0;a<opidList.size();a++){
			JSONObject obj=new JSONObject();
			obj.put("openid", opidList.get(a));
			obj.put("lang", "zh_CN");
			opidObjectList.add(obj);
			if( a != 0 && a%100 == 0 ){
				bool=true;
				json.put("user_list", opidObjectList);
				String userInfo=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/user/info/batchget",ReceiveToken.getAccessToken(appid,secret),json.toJSONString());
				opidObjectList = new ArrayList<JSONObject>();
				JSONObject userJsonss = JSONObject.parseObject(userInfo);
				List<Object> list = userJsonss.getJSONArray("user_info_list");
				for(int b=0;b<list.size();b++){
					userObjectList.add(list.get(b));
				}
			}
		}
		
		if( opidList.size()%100 != 0 ){
			json.put("user_list", opidObjectList);
			String userInfo=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/user/info/batchget",ReceiveToken.getAccessToken(appid,secret),json.toJSONString());
			JSONObject jsonss = JSONObject.parseObject(userInfo);
			if(bool){
				List<Object> list = jsonss.getJSONArray("user_info_list");
				for(int b=0;b<list.size();b++){
					userObjectList.add(list.get(b));
				}
			}else{
				userObjectList = jsonss.getJSONArray("user_info_list");
			}
			
		}
		
		return userObjectList;
	}
	
	//获取关注公众号的用户信息
	@Bizlet("")
	public DataObject getUser(String opid,DataObject obj){
		String urls="https://api.weixin.qq.com/cgi-bin/user/info?access_token="+ReceiveToken.getAccessToken()+"&openid="+opid+"&lang=zh_CN";
		String userData = WechatCommonTool.transferLinkInterface(urls);
		JSONObject userJson = JSONObject.parseObject(userData);
		obj.setString("userOpid",opid);
		obj.setString("userHeadPortrait",userJson.getString("headimgurl") );
		obj.setString("userNickname",userJson.getString("nickname") );
		obj.setString("userGender",userJson.getString("sex") );
		obj.setString("userProvince",userJson.getString("province") );
		obj.setString("userCity",userJson.getString("city") );
		obj.setLong("userAttentionTime",userJson.getLong("subscribe_time") );
		//obj.setInt("userGroupId",userJson.getInteger("groupid") );
		obj.setString("userSource",userJson.getString("subscribe_scene") );
		obj.setString("userSubscribe",userJson.getString("subscribe") );
		return obj;
	}
	
	//获取临时关注公众号的用户信息
	@Bizlet("")
	public DataObject getNowUser(String opid,String token,DataObject obj){
		String urls="https://api.weixin.qq.com/sns/userinfo?access_token="+token+"&openid="+opid+"&lang=zh_CN";
		String userData = WechatCommonTool.transferLinkInterface(urls);
		JSONObject userJson = JSONObject.parseObject(userData);
		obj.setString("userOpid",opid);
		obj.setString("userHeadPortrait",userJson.getString("headimgurl") );
		obj.setString("userNickname",userJson.getString("nickname") );
		obj.setString("userGender",userJson.getString("sex") );
		obj.setString("userProvince",userJson.getString("province") );
		obj.setString("userCity",userJson.getString("city") );
		obj.setString("userSubscribe","0");
		return obj;
	}
	
}
