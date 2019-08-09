package com.wechat.Tool;

import java.util.HashMap;
import java.util.Map;

import com.eos.engine.component.ILogicComponent;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;

import commonj.sdo.DataObject;

public class BusinessDict {
	
	@Bizlet("")
	public static Map<String,String> objectTransformationMap(DataObject obj[]){
		Map<String,String> map=new HashMap<String,String>();
		for(int a=0;a<obj.length;a++){
			map.put(obj[a].getString("dictName"), obj[a].getString("dictContent"));
		}
		return map;
	}
	
	
	
	
	public static Map<String,String> businessDictData(String dictName){
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceBackstage.weChatInquire";
		// 逻辑流名称
		String operationNameAdd = "queryBusinessDict";
		
		ILogicComponent logicComponentAdd = LogicComponentFactory.create(addDate);
		
		int sizeAdd = 1;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = dictName;
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
		
		Map<String,String> map = (HashMap<String, String>) resultAdd[0];
		return map;
	}
	
}
