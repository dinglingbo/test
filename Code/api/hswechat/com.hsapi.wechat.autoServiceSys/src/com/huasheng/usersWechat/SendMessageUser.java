package com.huasheng.usersWechat;

import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;
import com.wechat.Tool.WechatCommonTool;

import commonj.sdo.DataObject;

@Bizlet("")
public class SendMessageUser {
	//模板接口链接
	public static String SEND_MESSAGE ="https://api.weixin.qq.com/cgi-bin/message/template/send";
	//发送纯文本链接
	public static String SEND_TEXT_MESSAGE="https://api.weixin.qq.com/cgi-bin/message/custom/send";
	//查询模板列表接口
	public static String QUERY_TEMPLATE_MESSAGE="https://api.weixin.qq.com/cgi-bin/template/get_all_private_template";
	
	@Bizlet("")
	public static Map sendTextMessage(String openid,String templateId,String url,Map map){
		JSONObject json = new JSONObject();
		json.put("touser", openid);
		json.put("template_id", templateId);
		if( url != null && !url.equals("")){
			json.put("url", url);
		}
		
		JSONObject data = new JSONObject();
		
		JSONObject firstData = new JSONObject();
		firstData.put("value", map.get("first"));
		firstData.put("color", "#000000");
		data.put("first", firstData);
		
		JSONObject keyword1Data = new JSONObject();
		keyword1Data.put("value", map.get("keyword1"));
		keyword1Data.put("color", "#000000");
		data.put("keyword1", keyword1Data);
		
		if(map.get("keyword2") != null){
			JSONObject keyword2Data = new JSONObject();
			keyword2Data.put("value", map.get("keyword2"));
			keyword2Data.put("color", "#000000");
			data.put("keyword2", keyword2Data);
		}
		
		if(map.get("keyword3") != null){
			JSONObject keyword3Data = new JSONObject();
			keyword3Data.put("value", map.get("keyword3"));
			keyword3Data.put("color", "#000000");
			data.put("keyword3", keyword3Data);
		}
		
		if(map.get("keyword4") != null){
			JSONObject keyword4Data = new JSONObject();
			keyword4Data.put("value", map.get("keyword4"));
			keyword4Data.put("color", "#000000");
			data.put("keyword4", keyword4Data);
		}
		
		if(map.get("keyword5") != null){
			JSONObject keyword4Data = new JSONObject();
			keyword4Data.put("value", map.get("keyword5"));
			keyword4Data.put("color", "#000000");
			data.put("keyword5", keyword4Data);
		}
		JSONObject remarkData = new JSONObject();
		remarkData.put("value", map.get("remark"));
		remarkData.put("color", "#000000");
		data.put("remark", remarkData);
		
		json.put("data", data);
		
		System.out.println(json.toJSONString());
		String messsageRes=WechatCommonTool.transferJsonInterface(SEND_MESSAGE,ReceiveToken.getAccessToken(),json.toJSONString());
		System.out.println(messsageRes);
		JSONObject resJson=JSONObject.parseObject(messsageRes);
		
		Map resMap=new HashMap();
		if( resJson.getString("errmsg").equals("ok") ){
			resMap.put("errCode", "S");
			resMap.put("errMsg", "消息发送成功");
		}else{
			resMap.put("errCode", "E");
			resMap.put("errMsg", "消息发送失败");
		}
		return resMap;
	}
	
	//模板消息查询
	@Bizlet("")
	public static Map<String,String>[] queryTemplateMessages(){
		String token=ReceiveToken.getAccessToken();
		String messsageRes=WechatCommonTool.transferLinkInterface(QUERY_TEMPLATE_MESSAGE+"?access_token="+token);
		JSONObject resJson=JSONObject.parseObject(messsageRes);
		JSONArray jsonArray=resJson.getJSONArray("template_list");
		
		Map<String,String> resMap[]=new HashMap[jsonArray.size()];
		for(int a=0;a<jsonArray.size();a++){
			JSONObject json=jsonArray.getJSONObject(a);
			Map<String,String> map=new HashMap<String,String>();
			map.put("templateId",json.getString("template_id"));
			map.put("title",json.getString("title"));
			map.put("primaryIndustry",json.getString("primary_industry"));
			map.put("deputyIndustry",json.getString("deputy_industry"));
			map.put("content",json.getString("content"));
			map.put("example",json.getString("example"));
			resMap[a]=map;
		}
		return resMap;
	}
	
	/**
	 * 发送纯文本消息
	 * @param openid   	用户的openid
	 * @param url		用户消息里链接地址
	 * @param content	用户要发送的内容
	 * @return
	 */
	@Bizlet("")
	public static Map<String,String> sendTextMessages(String openid,String url,String content){
		JSONObject json = new JSONObject();
		json.put("touser", openid);
		json.put("msgtype", "text");
		
		JSONObject contentData = new JSONObject();
		if( url != null && !url.equals("")){
			contentData.put("content",content+"\t\n\r<a href=\'" + url + "\'>点击查看详情</a>");
		}else{
			contentData.put("content",content);
		}
		json.put("text", contentData);
		System.out.println(json);
		String messsageRes=WechatCommonTool.transferJsonInterface(SEND_TEXT_MESSAGE,ReceiveToken.getAccessToken(),json.toJSONString());
		System.out.println(messsageRes);
		JSONObject resJson=JSONObject.parseObject(messsageRes);
		
		Map<String,String> resMap=new HashMap<String,String>();
		if( resJson.getString("errmsg").equals("ok") ){
			resMap.put("errCode", "S");
			resMap.put("errMsg", "消息发送成功");
		}else{
			resMap.put("errCode", "E");
			resMap.put("errMsg", "消息发送失败");
		}
		return resMap;
	}
	
	
}
