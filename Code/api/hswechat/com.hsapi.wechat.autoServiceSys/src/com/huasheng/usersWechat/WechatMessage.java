package com.huasheng.usersWechat;



import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.qq.weixin.mp.aes.AesException;
import com.qq.weixin.mp.aes.SHA1;
import com.eos.data.datacontext.IMapContextFactory;
import com.eos.data.datacontext.IRequestMap;
import com.eos.data.datacontext.ISessionMap;
import com.eos.system.annotation.Bizlet;

import java.io.PrintWriter;


/**
 * 消息接收控制层
 * @author YaoShiHang
 * @Date 15:15 2017-10-16
 */
@Bizlet("")
public class WechatMessage{


    //微信推送事件 url
    @Bizlet("")
    public  String getTicket(){
    	System.out.println("11");
    	IMapContextFactory contextFactory = com.primeton.ext.common.muo.MUODataContextHelper.getMapContextFactory();
    	ISessionMap sessionMap = contextFactory.getSessionMap();
    	Object sessionRoot = sessionMap.getRootObject();
    	System.out.println(sessionRoot);
    	IRequestMap requestMap = contextFactory.getRequestMap();
    	HttpServletRequest request = (HttpServletRequest)requestMap.getRootObject();
    	System.out.println(request);
    	String signature = request.getParameter("signature");
    	System.out.println("signature:"+signature);
        String timestamp = request.getParameter("timestamp");
        System.out.println("timestamp:"+timestamp);
        String nonce = request.getParameter("nonce");
        System.out.println("nonce:"+nonce);
        String echostr = request.getParameter("echostr");
        System.out.println("echostr:"+echostr);
        String token="somelog";
        String jiami="";
        try {
			jiami=SHA1.getSHA1(token, timestamp, nonce,"");
		} catch (AesException e1) {
			// TODO 自动生成的 catch 块
			e1.printStackTrace();
		}
        System.out.println("加密"+jiami);
        System.out.println("本身"+signature);
        //PrintWriter out=response.getWriter();
        if(jiami.equals(signature)){
        	//out.print(echostr);
        	return echostr;
        }
        return "";
       /* try {
			Map<String, String> wxdata=parseXml(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
         
    	IApplicationMap applicationMap = contextFactory.getApplicationMap();
    	Object applicationRoot = applicationMap.getRootObject();
    	System.out.println(applicationRoot);*/
       
    }

    /**
     * dom4j 解析 xml 转换为 map
     * @param request
     * @return
     * @throws Exception
     */
    public static Map<String, String> parseXml(HttpServletRequest request) throws Exception {
        // 将解析结果存储在HashMap中
        Map<String, String> map = new HashMap<String, String>();
        // 从request中取得输入流
        InputStream inputStream = request.getInputStream();
        // 读取输入流
        SAXReader reader = new SAXReader();
        Document document = reader.read(inputStream);
        // 得到xml根元素
        Element root = document.getRootElement();
        // 得到根元素的所有子节点
        List<Element> elementList = root.elements();
        System.out.println("-----开始----");
        // 遍历所有子节点
        for (Element e : elementList){
        	map.put(e.getName(), e.getText());
        	System.out.println(e.getName());
        	System.out.println(e.getText());
        }
        System.out.println("-----结束----");    

        // 释放资源
        inputStream.close();
        inputStream = null;
        return map;
    }

}
