package com.huasheng.userOrder;


import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.eos.system.annotation.Bizlet;
import com.huasheng.userOrder.WXPayConstants.SignType;
import com.eos.foundation.eoscommon.BusinessDictUtil;
public class TestpayDeve {
@Bizlet("")
public static Map<String, String> generationQM(String remoteIp) throws Exception {
	MyConfig config = new MyConfig();
	WXPay wxpay = new WXPay(config);
	String nonce_str=WXPayUtil.generateNonceStr();
	System.out.println(nonce_str); 
	System.out.println("这是IP"+remoteIp); 
	String dishesPrice="1";
	//价格处理，将元转换分
	double fee=Double.parseDouble(dishesPrice);
	Integer cmoney=CorrectYuan2Fen(fee);
	String total_fee=cmoney+"";
	System.out.println("这是总价:"+total_fee);
	//商户订单号
	String out_trade_no=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
	
	//微信配置信息
	String appid=BusinessDictUtil.getDictName("SFY_OMS_WeChat","appid");
	//String secret=BusinessDictUtil.getDictName("SFY_OMS_WeChat","secret");
	String mch_id=BusinessDictUtil.getDictName("SFY_OMS_WeChat","mch_id");
	String notify_url=BusinessDictUtil.getDictName("SFY_OMS_WeChat","notify_url");
	
	Map<String, String> data = new HashMap<String, String>();
	data.put("appid", appid);
	data.put("mch_id", mch_id);
	data.put("body", "索菲亚订餐单号-"+out_trade_no);
	data.put("out_trade_no",out_trade_no);
//	data.put("total_fee",total_fee);
	data.put("total_fee","1");
	data.put("spbill_create_ip", remoteIp);    
	data.put("trade_type", "JSAPI");
	data.put("openid","ocWhT57s-6lkFrbJ0QYQlQ9GnQ60"); 
	data.put("notify_url", notify_url);
	data.put("nonce_str",nonce_str);
	try {
	    Map<String, String> resp1 = wxpay.unifiedOrder(data);
	    System.out.println("这是统一下单完成后的结果："+resp1);
	    if(resp1!=null && "SUCCESS".equals(resp1.get("result_code")) && 
	    		"SUCCESS".equals(resp1.get("return_code")) &&
	    		StringUtils.isNotBlank(resp1.get("prepay_id"))){
	    	//生成给前台调起支付请求的签名
	    	data.clear();
	    	data.put("appId", appid);
	    	data.put("timeStamp",Integer.parseInt(String.valueOf(new Date().getTime()/1000))+"");
	    	data.put("nonceStr",WXPayUtil.generateNonceStr());
	    	data.put("package", "prepay_id="+resp1.get("prepay_id"));
	    	data.put("signType", SignType.MD5.toString());
	    	String generateSignature = WXPayUtil.generateSignature(data,config.getKey(),SignType.MD5);
	    	data.put("paySign",generateSignature );
	    	  System.out.println("这是预付单号id："+resp1.get("prepay_id"));
		    	return data;
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		}
		return null;
	}
	public static Integer CorrectYuan2Fen(Double yuan) {
		//（重点）Double直接转BigDecimal丢失精度，此处需要将Double转换为String
		return new BigDecimal(String.valueOf(yuan)).movePointRight(2).intValue();
	}
	

	
}
