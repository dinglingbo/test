package com.wechat.Tool;

import java.util.HashMap;
import com.eos.engine.component.ILogicComponent;
import com.primeton.ext.engine.component.LogicComponentFactory;

/**
 * 
 * 微信接口或事件调用逻辑流
 * java调用逻辑流
 * @author lidongsheng
 * 
 */
public class WechatLogicTool {
	
	//查询用户的服务号即标识
	public static HashMap queryWechatUserMarke(String opid){
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceSys.weChatUsers";
		// 逻辑流名称
		String operationNameAdd = "queryWechatUserMarke";
		ILogicComponent logicComponentAdd = LogicComponentFactory
				.create(addDate);
		int sizeAdd = 1;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = opid;
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
		HashMap[] resultMap = (HashMap[]) resultAdd[0];
		System.out.println("服务号："+resultAdd[0]);
		return resultMap[0];
	}
	
	//匹配关键字回复
	public static HashMap queryKeywordReply(String msgText,String toUserName){
		Object[] result=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceSys.weChatUsers";
		// 逻辑流名称
		String operationNameAdd = "queryKeywordMsg";
		ILogicComponent logicComponentAdd = LogicComponentFactory.create(addDate);
		int sizeAdd = 1;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		HashMap tempMap = new HashMap();
		tempMap.put("msgText", msgText);
		tempMap.put("toUserName", toUserName);
		paramsAdd[0] = tempMap;
		try {
			result = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
		System.out.println(result[0].getClass());
		HashMap[] obj = (HashMap[]) result[0];
		System.out.println(obj.toString());
		return obj[0];
	}
	
	//添加关注用户的信息
	public static void addWechatUserInfo(String opid,int serviceNumber){
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceSys.weChatUsers";
		// 逻辑流名称
		String operationNameAdd = "addWechatUser";
		ILogicComponent logicComponentAdd = LogicComponentFactory
				.create(addDate);
		int sizeAdd = 4;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = opid;
		paramsAdd[1] = serviceNumber;
		paramsAdd[2] = null;
		paramsAdd[3] = null;
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
	}
	
	//二维码添加关注用户的信息
	public static void addWechatUserInfo(String opid,int serviceNumber,int storeId){
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceSys.weChatUsers";
		// 逻辑流名称
		String operationNameAdd = "addWechatUser";
		ILogicComponent logicComponentAdd = LogicComponentFactory
				.create(addDate);
		int sizeAdd = 4;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = opid;
		paramsAdd[1] = serviceNumber;
		paramsAdd[2] = storeId;
		paramsAdd[3] = null;
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
	}
	
	//已关注用户二维码切换门店
	public static void updateWechatCodeUserStore(String opid,int storeId){
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceBackstage.weChatUsers";
		// 逻辑流名称
		String operationNameAdd = "addStoreUserWechatCode";
		ILogicComponent logicComponentAdd = LogicComponentFactory
				.create(addDate);
		int sizeAdd = 2;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = opid;
		paramsAdd[1] = storeId;
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
	}
	
	//添加微信用户的取消关注时间，顺便更新微信用户的信息
	public static void addWechatUserNotAttentionTime(String opid,String userNotAttentionTime){
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceSys.weChatUsers";
		// 逻辑流名称
		String operationNameAdd = "addWechatUserNotAttentionTime";
		ILogicComponent logicComponentAdd = LogicComponentFactory
				.create(addDate);
		int sizeAdd = 2;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = opid;
		paramsAdd[1] = Long.valueOf(userNotAttentionTime);
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		String str = "qrscene_123123";
		String strArray[] = str.split("_");
		int storeId = Integer.valueOf(strArray[1]);
		System.out.println(storeId);
	}
}
