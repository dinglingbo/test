package com.huasheng.usersWechat;

import java.util.List;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.eos.engine.component.ILogicComponent;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;
import com.wechat.Tool.WechatCommonTool;

/*
 * 门店接口调用
 */
@Bizlet("")
public class StoreManagement {
	
	//从腾讯地图拉取省市区信息
	@Bizlet("")
	public String pullAddressInformation(String appid ,String secret,int accountsId){
		String urls="https://api.weixin.qq.com/wxa/get_district?access_token="+ReceiveToken.getAccessToken(appid,secret);
		String userData = WechatCommonTool.transferLinkInterface(urls);
		JSONObject userJson = JSONObject.parseObject(userData);
		if(userJson.containsKey("errcode")){
			System.out.println(userJson.getString("errmsg"));
			System.out.println(userJson.getString("errcode"));
			return userJson.getString("errmsg");
		}
		boolean bool=false;
		JSONArray array= userJson.getJSONArray("result");
		
		//省份
		JSONArray province=array.getJSONArray(0);
		System.out.println(province.toJSONString());
		//城市
		JSONArray city=array.getJSONArray(1);
		//地区
		JSONArray region=array.getJSONArray(2);
		
		//省份添加
		for(int a=0;a<province.size();a++){
			JSONObject provinceData = province.getJSONObject(a);
			JSONObject location = provinceData.getJSONObject("location");
			List<Integer> cityList = (List)provinceData.get("cidx");
			String cityListString = "";
			for(int b=cityList.get(0);b<=cityList.get(1);b++){
				JSONObject provinceDataCity = city.getJSONObject(b);
				cityListString+=(provinceDataCity.getString("id"));
				if(b != cityList.size()-1){
					cityListString+=",";
				}
			}
			bool=addProvince(provinceData.getString("id"),provinceData.getString("name"),provinceData.getString("fullname"),location.getDouble("lat"),location.getDouble("lng"),cityListString,accountsId);
			if(!bool)return "添加省份逻辑流错误";
		}
		
		//城市添加
		for(int a=0;a<city.size();a++){
			JSONObject cityData = city.getJSONObject(a);
			JSONObject location = cityData.getJSONObject("location");
			List<Integer> regionList = (List)cityData.get("cidx");
			String regionListString = "";
			if(regionList != null){
				for(int b=regionList.get(0);b<=regionList.get(1);b++){
					JSONObject cityDataRegion = region.getJSONObject(b);
					regionListString+=(cityDataRegion.getString("id"));
					if(b != regionList.size()-1){
						regionListString+=",";
					}
				}
			}
			
			bool=addCity(cityData.getString("id"),cityData.getString("name"),cityData.getString("fullname"),location.getDouble("lat"),location.getDouble("lng"),regionListString);
			if(!bool)return "添加城市逻辑流错误";
		}
		
		//地区添加
		for(int a=0;a<region.size();a++){
			JSONObject regionData = region.getJSONObject(a);
			JSONObject location = regionData.getJSONObject("location");
			bool=addRegion(regionData.getString("id"),regionData.getString("fullname"),location.getDouble("lat"),location.getDouble("lng"));
			if(!bool)return "添加地区逻辑流错误";
		}
		
		return "";
	}
	
	//添加微信腾讯地址省份信息到数据库
	public boolean addProvince(String districtid,String name,String fullname,Double lat,Double lng,String cidx,int accountsId){
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.huasheng.storeReservationSystem.weChatStoreAddress";
		// 逻辑流名称
		String operationNameAdd = "addProvince";
		ILogicComponent logicComponentAdd = LogicComponentFactory
				.create(addDate);
		int sizeAdd = 7;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = districtid;
		paramsAdd[1] = name;
		paramsAdd[2] = fullname;
		paramsAdd[3] = lat;
		paramsAdd[4] = lng;
		paramsAdd[5] = cidx;
		paramsAdd[6] = accountsId;
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
		return (Boolean) resultAdd[0];
	}
	
	//添加微信腾讯地址城市信息到数据库
	public boolean addCity(String districtid,String name,String fullname,Double lat,Double lng,String cidx){
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.huasheng.storeReservationSystem.weChatStoreAddress";
		// 逻辑流名称
		String operationNameAdd = "addCity";
		ILogicComponent logicComponentAdd = LogicComponentFactory
				.create(addDate);
		int sizeAdd = 6;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = districtid;
		paramsAdd[1] = name;
		paramsAdd[2] = fullname;
		paramsAdd[3] = lat;
		paramsAdd[4] = lng;
		paramsAdd[5] = cidx;
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
		return (Boolean) resultAdd[0];
	}
	
	//添加微信腾讯地址城市下的地区信息到数据库
	public boolean addRegion(String districtid,String fullname,Double lat,Double lng){
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.huasheng.storeReservationSystem.weChatStoreAddress";
		// 逻辑流名称
		String operationNameAdd = "addRegion";
		ILogicComponent logicComponentAdd = LogicComponentFactory
				.create(addDate);
		int sizeAdd = 4;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = districtid;
		paramsAdd[1] = fullname;
		paramsAdd[2] = lat;
		paramsAdd[3] = lng;
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
		return (Boolean) resultAdd[0];
	}
		
	public void sreachAddress(String appid ,String secret,String address,int districtid){
		JSONObject json = new JSONObject();
		json.put("districtid", districtid);
		json.put("keyword", address);
		System.out.println(json.toJSONString());
		String stroeInfo=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/wxa/search_map_poi",ReceiveToken.getAccessToken(appid,secret),json.toJSONString());
		System.out.println(stroeInfo);
	}
	
	public static void main(String[] args) {
		StoreManagement a = new StoreManagement();
		a.sreachAddress("wxd10b49dcb45e5591","8f21ab04f3b9bc252d8dce64a6d055e4","x",440105);
	}
}
