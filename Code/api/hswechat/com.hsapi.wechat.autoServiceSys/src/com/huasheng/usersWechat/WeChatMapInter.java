package com.huasheng.usersWechat;

import java.util.HashMap;
import java.util.Map;

import com.eos.system.annotation.Bizlet;
import com.huasheng.userSSDK.CreateSigntrue;
import com.huasheng.userSSDK.JsapiTicketUtil;

public class WeChatMapInter {
	
	
	@Bizlet("")
	public Map getMapParamData(String url){
		// 必填，企业号的唯一标识，此处填写企业号corpid
	    String appId="wxd10b49dcb45e5591";
	    
	    String jsapi_ticket = JsapiTicketUtil.getJSApiTicket();
	    
	    System.out.println("===jsapi_ticket==="+jsapi_ticket);
	    
	    
	    CreateSigntrue  getSi= new CreateSigntrue();
	    System.out.println("url1:"+url);
	    
	    String arr1[]=getSi.signTrue(url,appId,jsapi_ticket);
	    
	    // 必填，生成签名的时间戳
	    String timestamp =arr1[0];
	    // 必填，生成签名的随机串
	    String nonceStr =arr1[1];
	    // 必填，签名
	    String qianm1 =arr1[2];
		
		System.out.println("签名的时间戳: "+timestamp);
		System.out.println("签名的随机串: "+nonceStr);
		System.out.println("签名: "+qianm1);
		Map map =new HashMap();
		map.put("timestamp", timestamp);
		map.put("nonceStr", nonceStr);
		map.put("qianm1", qianm1);
		
		return map;
	}
	
	//纬度:23.138712,经度:113.3672
	public static double getDistance(double latitude1,double longitude1,double latitude2,double longitude2) {
	    //Location是一个类，包含经度和纬度两个属性
	    //参数location1表示地址1，location2表示地址2.
	       double radLat1 = Math.toRadians (latitude1);
	       double radLat2 = Math.toRadians (latitude2);
	       double a = radLat1 - radLat2;
	       double b = Math.toRadians (longitude1) - Math.toRadians (longitude2);
	       double s = 2 * Math. asin(Math .sqrt(
	                Math.pow (Math. sin(a / 2), 2) + Math.cos (radLat1) * Math.cos (radLat2) * Math.pow (Math. sin(b / 2), 2))) ;
	       s = s * 6378137.0 ;// 取WGS84标准参考椭球中的地球长半径(单位:m)
	       s = Math. round(s * 10000) / 10000 ;
	       return s ;
	}
	
}
