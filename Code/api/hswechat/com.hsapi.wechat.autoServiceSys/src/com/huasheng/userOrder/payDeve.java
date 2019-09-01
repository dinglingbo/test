package com.huasheng.userOrder;


import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;
import com.huasheng.userOrder.WXPayConstants.SignType;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.BusinessDictUtil;
public class payDeve {
	/**
	 * 
	 * 
	 * @param 
	 * @param timeExpire   订单失效时间
	 * @param timeStart    订单生效时间
	 * @param getOpenid    用户的openid
	 * @param dishesPrice  订单的价格
	 * @param ordersCode   订单的编码
	 * @param attach       附加数据，在查询API和支付通知中原样返回，可作为自定义参数使用。String(127)
	 * @return
	 * @throws Exception
	 */
	@Bizlet("")
	public static Map<String, String> generationQM(String timeExpire,String timeStart,String  getOpenid,String dishesPrice,String ordersCode,String attach) throws Exception {
		MyConfig config = new MyConfig();
		WXPay wxpay = new WXPay(config);
		String nonce_str=WXPayUtil.generateNonceStr();
		System.out.println(nonce_str); 
		System.out.println("这是openid:"+getOpenid);
		//价格处理，将元转换分
		double fee=Double.parseDouble(dishesPrice);
		Integer cmoney=CorrectYuan2Fen(fee);
		String total_fee=cmoney+"";
		System.out.println("这是总价:"+total_fee);
		String getAll="";
		String getAllb="";
		//订单生效时间
		String time_start=timeStart;
		System.out.println("这是订单生效时间:"+time_start);
		//订单失效时间
		String time_expire=timeExpire;
		System.out.println("这是订单失效时间:"+time_expire);
		//测试商户订单号
		String out_trade_no=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		//自定义参数，用于企业号传userid
		//String attach="5201314";
		
		//微信配置信息
		//获取appId,微信支付分配的商户号,通知地址
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceBackstage.weChatInquire";
		// 逻辑流名称
		String operationNameAdd = "queryBusinessDict";
		
		ILogicComponent logicComponentAdd = LogicComponentFactory.create(addDate);
		
		int sizeAdd = 1;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = "APPID,MCH_ID,NOTIFY_URL,REMOTEIP";
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
		
		Map<String,String> map = (HashMap<String,String>) resultAdd[0];
		
		//公众号appid
		String appid = map.get("APPID");
		//微信支付分配的商户号
		String mch_id =  map.get("MCH_ID");
		//通知地址   异步接收微信支付结果通知的回调地址，通知url必须为外网可访问的url，不能携带参数。
		String notify_url =  map.get("NOTIFY_URL");
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("attach", attach);//附加数据
		data.put("appid", appid);
		data.put("mch_id", mch_id);
		data.put("body", "链车云修订单号-"+ordersCode);//商品描述
		data.put("time_start", time_start);
		data.put("time_expire", time_expire);
		data.put("out_trade_no",ordersCode);//商户订单号
		data.put("total_fee",total_fee);
		data.put("spbill_create_ip", map.get("REMOTEIP"));//服务器IP
		data.put("trade_type", "JSAPI");
		data.put("openid",getOpenid); 
		data.put("notify_url", notify_url);
		data.put("nonce_str",nonce_str);
		try {
		    Map<String, String> resp1 = wxpay.unifiedOrder(data);
		    System.out.println("这是统一下单完成后的结果："+resp1);
		    	  
		    getAll=resp1.toString();
		    if(resp1!=null && "SUCCESS".equals(resp1.get("result_code")) && wxpay. isResponseSignatureValid(resp1) &&  "SUCCESS".equals(resp1.get("return_code")) && StringUtils.isNotBlank(resp1.get("prepay_id"))){
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
		    	getAllb=resp1.toString();
				
		    	// 微信统一下单的数据保存在日志表
		    	Object[] result = null;
				String componentName = "com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder";
				// 日志表的逻辑名称
				String operationName = "addWechatOperationLog";
				ILogicComponent logicComponent = LogicComponentFactory
						.create(componentName);
				int size = 3;
				// 逻辑流的输入参数
				Object[] params = new Object[size];
				params[0] =getOpenid;
				params[1] ="统一下单的数据";
				params[2] ="openid:"+getOpenid+"---"+"总价:"+dishesPrice+"---"+"订单号:"+ordersCode+"---"+"---"+"统一下单后的结果："+getAll+"-----生成预付单号的结果："+getAllb;
				try {
					result = logicComponent.invoke(operationName, params);
				} catch (Throwable e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			    return data;
		    }else{
		    	Map<String, String> rest = new HashMap<String, String>();
		    	rest.put("errMesg","此订单已经过了限定时间");
		    	return rest;
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
	
	/**
	 * 
	 * 
	 * @param 
	 * @param timeExpire   订单失效时间
	 * @param timeStart    订单生效时间
	 * @param sellPrice    订单的价格
	 * @param serviceId   订单的编码
	 * @param attach       附加数据，在查询API和支付通知中原样返回，可作为自定义参数使用。String(127)
	 *               bodyDes  链车云修充值中心-功能充值
	 * @return
	 * @throws Exception  
	 */
	@Bizlet("")
	public static Map<String, String> generatePayOrder(String timeExpire, String timeStart, String sellPrice, String serviceId, String attach, String bodyDes, String productId) throws Exception {
		MyConfig config = new MyConfig();
		WXPay wxpay = new WXPay(config);

		//价格处理，将元转换分
		double fee=Double.parseDouble(sellPrice);
		Integer cmoney=CorrectYuan2Fen(fee);
		String total_fee=cmoney+"";
		
		String getAll="";
		String getAllb="";
		
		//订单生效时间
		String time_start=timeStart;
		//订单失效时间
		String time_expire=timeExpire;
		
		//自定义参数，用于企业号传userid
		//String attach="5201314";
		
		//微信配置信息
		//获取appId,微信支付分配的商户号,通知地址
		Object resultAdd[]=null;
		// 逻辑构件名称
		String addDate = "com.hsapi.wechat.autoServiceBackstage.weChatInquire";
		// 逻辑流名称
		String operationNameAdd = "queryBusinessDict";
		
		ILogicComponent logicComponentAdd = LogicComponentFactory.create(addDate);
		
		int sizeAdd = 1;
		// 逻辑流的输入参数
		Object[] paramsAdd = new Object[sizeAdd];
		paramsAdd[0] = "NOTIFY_URL,REMOTEIP";
		try {
			resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
		}catch (Throwable e) {
			e.printStackTrace();
		}
		Map<String,String> map = (HashMap<String,String>) resultAdd[0];
		//通知地址   异步接收微信支付结果通知的回调地址，通知url必须为外网可访问的url，不能携带参数。
		String notify_url =  map.get("NOTIFY_URL");
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("body", "链车云修充值中心-"+bodyDes);//商品描述
		data.put("time_start", time_start);
		data.put("time_expire", time_expire);
		data.put("out_trade_no",serviceId);//商户订单号
		data.put("total_fee",total_fee);
		data.put("spbill_create_ip", map.get("REMOTEIP"));//服务器IP
		data.put("trade_type", "NATIVE");
		data.put("product_id", productId);
		data.put("notify_url", notify_url);
		data.put("attach", attach);//附加数据

		try {
		    Map<String, String> resp1 = wxpay.unifiedOrder(data);
		    System.out.println("这是统一下单完成后的结果："+resp1);
		    	  
		    getAll=resp1.toString();
		    if(resp1!=null && "SUCCESS".equals(resp1.get("result_code")) && wxpay.isResponseSignatureValid(resp1) &&  "SUCCESS".equals(resp1.get("return_code")) && StringUtils.isNotBlank(resp1.get("prepay_id"))){
		    	//生成给前台调起支付请求的签名
		    	data.clear();
		    	data.put("timeStamp",Integer.parseInt(String.valueOf(new Date().getTime()/1000))+"");
		    	data.put("nonceStr",WXPayUtil.generateNonceStr());
		    	data.put("package", "prepay_id="+resp1.get("prepay_id"));
		    	data.put("signType", SignType.MD5.toString());
		    	data.put("codeUrl", resp1.get("code_url"));
		    	String generateSignature = WXPayUtil.generateSignature(data,config.getKey(),SignType.MD5);
		    	data.put("paySign",generateSignature );
		    	System.out.println("这是预付单号id："+resp1.get("prepay_id"));
		    	getAllb=resp1.toString();
				
		    	// 微信统一下单的数据保存在日志表
		    	Object[] result = null;
				String componentName = "com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder";
				// 日志表的逻辑名称
				String operationName = "addWechatOperationLog";
				ILogicComponent logicComponent = LogicComponentFactory
						.create(componentName);
				int size = 3;
				// 逻辑流的输入参数
				Object[] params = new Object[size];
				params[0] ="";
				params[1] ="统一下单的数据";
				params[2] ="总价:"+sellPrice+"---"+"订单号:"+serviceId+"---"+"---"+"统一下单后的结果："+getAll+"-----生成预付单号的结果："+getAllb;
				try {
					result = logicComponent.invoke(operationName, params);
				} catch (Throwable e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			    return data;
		    }else{
		    	Map<String, String> rest = new HashMap<String, String>();
		    	rest.put("errMesg","此订单已经过了限定时间");
		    	return rest;
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		}
		return null;
	}
	
	@Bizlet("")
	public static Map<String, String> getPayOrder(String serviceId) throws Exception {
		MyConfig config = new MyConfig();
		WXPay wxpay = new WXPay(config);
		
		Map<String, String> data = new HashMap<String, String>();
		data.put("out_trade_no",serviceId);//商户订单号

		try {
		    Map<String, String> resp1 = wxpay.orderQuery(data);
		    	  
		    if(resp1!=null && "SUCCESS".equals(resp1.get("result_code")) && wxpay.isResponseSignatureValid(resp1) &&  "SUCCESS".equals(resp1.get("return_code")) && "OK".equals(resp1.get("return_msg"))){
		    	
		    	data.clear();
		    	data.put("timeStamp",Integer.parseInt(String.valueOf(new Date().getTime()/1000))+"");
		    	data.put("isSubscribe",resp1.get("is_subscribe"));
		    	data.put("tradeType",resp1.get("trade_type"));
		    	/*
		    	 *  SUCCESS—支付成功

					REFUND—转入退款
					
					NOTPAY—未支付
					
					CLOSED—已关闭
					
					REVOKED—已撤销（付款码支付）
					
					USERPAYING--用户支付中（付款码支付）
					
					PAYERROR--支付失败(其他原因，如银行返回失败)
					
					支付状态机请见下单API页面
		    	 * */
		    	data.put("tradeState",resp1.get("trade_state"));
		    	data.put("transactionId",resp1.get("transactionId"));
		    	data.put("attach",resp1.get("attach"));
		    	data.put("timeEnd",resp1.get("time_end"));
				
			    return data;
		    }else{
		    	Map<String, String> rest = new HashMap<String, String>();
		    	rest.put("tradeState","CLOSED");
		    	return rest;
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		}
		return null;
	}
	
}
