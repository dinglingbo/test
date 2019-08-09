package com.huasheng.userOrder;


import com.eos.data.datacontext.IMapContextFactory;
import com.eos.data.datacontext.IRequestMap;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.huasheng.userOrder.WXPayConfig;
import com.huasheng.userOrder.IWXPayDomain.DomainInfo;
import com.primeton.ext.engine.component.LogicComponentFactory;

import java.io.*;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class MyConfig extends WXPayConfig{
    private byte[] certData;
    public MyConfig() throws Exception {
    	IMapContextFactory contextFactory = com.primeton.ext.common.muo.MUODataContextHelper.getMapContextFactory();
	    IRequestMap requestMap = contextFactory.getRequestMap();
	    HttpServletRequest  request = (HttpServletRequest) requestMap.getRootObject();
	    String rootpath =request.getSession().getServletContext().getRealPath("");
	    System.out.println("request:"+rootpath);
        String certPath = rootpath+"/autoServiceeSys/cert/apiclient_cert.p12";
        File file = new File(certPath);
        InputStream certStream = new FileInputStream(file);
        this.certData = new byte[(int) file.length()];
        certStream.read(this.certData);
        certStream.close();
    }
    @Override
    public String getAppID() {
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
    	paramsAdd[0] = "APPID";
    	try {
    		resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
    	}catch (Throwable e) {
    		e.printStackTrace();
    	}
    	Map<String,String> map = (HashMap<String,String>) resultAdd[0];
        return map.get("APPID");
    }
    @Override
    public String getMchID() {
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
    	paramsAdd[0] = "MCH_ID";
    	try {
    		resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
    	}catch (Throwable e) {
    		e.printStackTrace();
    	}
    	Map<String,String> map = (HashMap<String,String>) resultAdd[0];
        return map.get("MCH_ID");
    }
    @Override
    public String getKey() {
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
    	paramsAdd[0] = "KEY";
    	try {
    		resultAdd = logicComponentAdd.invoke(operationNameAdd, paramsAdd);
    	}catch (Throwable e) {
    		e.printStackTrace();
    	}
    	Map<String,String> map = (HashMap<String,String>) resultAdd[0];
        return map.get("KEY");
    }
    @Override
    public InputStream getCertStream() {
        ByteArrayInputStream certBis = new ByteArrayInputStream(this.certData);
        return certBis;
    }
    @Override
    public int getHttpConnectTimeoutMs() {
        return 8000;
    }
    @Override
    public int getHttpReadTimeoutMs() {
        return 10000;
    }
	@Override
	IWXPayDomain getWXPayDomain() {
		// TODO 自动生成的方法存根
		return new IWXPayDomain() {
			public void report(String domain, long elapsedTimeMillis, Exception ex) {
				// TODO 自动生成的方法存根
			}
			public DomainInfo getDomain(WXPayConfig config) {
				return new DomainInfo(WXPayConstants.DOMAIN_API,true);
			}
		};
	}
    
}