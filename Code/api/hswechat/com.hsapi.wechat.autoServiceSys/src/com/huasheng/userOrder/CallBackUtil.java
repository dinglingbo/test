package com.huasheng.userOrder;



import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eos.engine.component.ILogicComponent;
import com.primeton.ext.engine.component.LogicComponentFactory;

public class CallBackUtil {

	/**
	 * InputStream流转换成String字符串 
	 * @param inStream InputStream流 
	 * @param encoding 编码格式 
	 * @return String字符串 
	 */
	public static String inputStream2String(InputStream inStream, String encoding) {
		String result = null;
		ByteArrayOutputStream outStream = null;
		try {
			if(inStream != null) {
				outStream = new ByteArrayOutputStream();
				byte[] tempBytes = new byte[1024];
				int count = 0;
				while((count = inStream.read(tempBytes)) != -1) {
					outStream.write(tempBytes, 0, count);
				}
				tempBytes = null;
				outStream.flush();
				result = new String(outStream.toByteArray(), encoding);
				outStream.close();
			}
		} catch(Exception e) {
			result = null;
		}
		return result;
	}

	/**
	 * 
	 * @throws Throwable 
	 * @Description 微信支付成功后回调次接口
	 */
	//回调路径是自己在之前已经填写过的
	public static boolean callBack(HttpServletRequest request, HttpServletResponse response){
		//System.out.println("微信支付成功,微信发送的callback信息,请注意修改订单信息");
		InputStream is = null;
		try {
			is = request.getInputStream(); //获取请求的流信息(这里是微信发的xml格式所有只能使用流来读)
			String xml = inputStream2String(is, "UTF-8");
			String ordersSn="";
			Object[] result = null;
			String userId="";
			Map < String, String > notifyMap = WXPayUtil.xmlToMap(xml); //将微信发的xml转map
			if(notifyMap.get("return_code").equals("SUCCESS")) {
				if(notifyMap.get("result_code").equals("SUCCESS")) {
					ordersSn = notifyMap.get("out_trade_no"); //商户订单号 
					String amountpaid = notifyMap.get("total_fee"); //实际支付的订单金额:单位 分
					String attach=notifyMap.get("attach");//自定义参数，返回订单的orderId
					String openid = notifyMap.get("openid");
					BigDecimal amountPay = (new BigDecimal(amountpaid).divide(new BigDecimal("100"))).setScale(2); //将分转换成元-实际支付金额:元										
					System.out.println("微信商户订单号："+ordersSn);
					System.out.println("实际支付的订单金额:单位 分："+amountpaid);
					System.out.println("实际支付金额:元："+amountPay);
					System.out.println(notifyMap);
					System.out.println("orderId："+attach);
					userId=attach;
					// 支付成功后面的逻辑构件名称并且发送微信支付成功的模板
					String componentName = "com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder";
					// 逻辑流名称
					String operationName = "updateUserOrderInfo";
					ILogicComponent logicComponent = LogicComponentFactory
							.create(componentName);
					int size = 4;
					// 逻辑流的输入参数
					Object[] params = new Object[size];
					params[0] =attach;
					params[1] =ordersSn;
					params[2] =amountPay;
					params[3] =openid;
					try {
						result = logicComponent.invoke(operationName, params);
					} catch (Throwable e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
					}
					
					String errCode=(String) result[0];
					String errMsg=(String) result[1];
					
					// 微信统一下单的数据保存在日志表
			    	Object[] resultOperationLog = null;
					String componentNameOperationLog = "com.hsapi.wechat.autoServiceBackstage.weChatStoreOrder";
					// 日志表的逻辑名称
					String operationNameOperationLog = "addWechatOperationLog";
					ILogicComponent logicComponentOperationLog = LogicComponentFactory
							.create(componentNameOperationLog);
					int sizeLog = 3;
					// 逻辑流的输入参数
					Object[] paramsLog = new Object[sizeLog];
					paramsLog[0] =openid;
					if(errCode.equals("S")){
						paramsLog[1] ="统一下单的数据-支付成功";
						paramsLog[2] ="订单id："+attach+"---"+"订单号:"+ordersSn+"---"+"openid:"+openid+"---"+"总价:"+amountPay+"-----订单支付成功";
					}else if(errCode.equals("E")){
						paramsLog[1] ="统一下单的数据-支付成功，执行失败";
						paramsLog[2] ="订单id："+attach+"---"+"订单号:"+ordersSn+"---"+"openid:"+openid+"---"+"总价:"+amountPay+"-----订单支付成功，但逻辑流执行失败，"+errMsg;
					}
					
					try {
						resultOperationLog = logicComponentOperationLog.invoke(operationNameOperationLog, paramsLog);
					} catch (Throwable e) {
						// TODO 自动生成的 catch 块
						e.printStackTrace();
					}
					
				}else{
					System.out.println("兄弟你取消了哦");
				}
			}
			//告诉微信服务器收到信息了，不要在调用回调action了========这里很重要回复微信服务器信息用流发送一个xml即可
			response.getWriter().write("<xml><return_code><![CDATA[SUCCESS]]></return_code></xml>");
			is.close();
			return true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}



