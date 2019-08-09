package com.huasheng.usersWechat;

import org.apache.log4j.Logger;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import weixin.popular.bean.xmlmessage.XMLMessage;
import weixin.popular.bean.xmlmessage.XMLTextMessage;
import weixin.popular.support.ExpireKey;
import weixin.popular.support.expirekey.DefaultExpireKey;
import weixin.popular.util.SignatureUtil;

import javax.servlet.ServletInputStream;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 消息接收控制层
 * @author YaoShiHang
 * @Date 15:15 2017-10-16
 */
public class incidentWechat{

    private final String TOKEN="xxxxxxxxxx";                      //Wx 开发者设置的 token
    private Logger loger = Logger.getLogger(getClass());
    //重复通知过滤
    private static ExpireKey expireKey = new DefaultExpireKey();


    //微信推送事件 url
    public void getTicket(HttpServletRequest request, HttpServletResponse response)throws Exception {
    	System.out.println("11");
        ServletInputStream inputStream = request.getInputStream();
        ServletOutputStream outputStream = response.getOutputStream(); 
        String signature = request.getParameter("signature");
        String timestamp = request.getParameter("timestamp");
        String nonce = request.getParameter("nonce");
        String echostr = request.getParameter("echostr");
        
        //首次请求申请验证,返回echostr
        if(echostr!=null){
            outputStreamWrite(outputStream,echostr);
            return;
        }

        //验证请求签名
        if(!signature.equals(SignatureUtil.generateEventMessageSignature(TOKEN,timestamp,nonce))){
            System.out.println("The request signature is invalid");
            return;
        }

        boolean isreturn= false;
        loger.info("1.收到微信服务器消息");
        Map<String, String> wxdata=parseXml(request);
        if(wxdata.get("MsgType")!=null){
            if("event".equals(wxdata.get("MsgType"))){
                loger.info("2.1解析消息内容为：事件推送");
                if( "subscribe".equals(wxdata.get("Event"))){
                    loger.info("2.2用户第一次关注 返回true哦");
                    isreturn=true;
                }
            }
        }

        if(isreturn == true){
            //转换XML
            String key = wxdata.get("FromUserName")+ "__"
                    + wxdata.get("ToUserName")+ "__"
                    + wxdata.get("MsgId") + "__"
                    + wxdata.get("CreateTime");
            loger.info("3.0 进入回复 转换对象："+key);

            if(expireKey.exists(key)){
                //重复通知不作处理
                loger.info("3.1  重复通知了");
                return;
            }else{
                loger.info("3.1  第一次通知");
                expireKey.add(key);
            }

            loger.info("3.2  回复你好");
            //创建回复
            XMLMessage xmlTextMessage = new XMLTextMessage(
                    wxdata.get("FromUserName"),
                    wxdata.get("ToUserName"),
                    "感谢你的关注，请牢记您的服务码：100001");
            //回复
            //xmlTextMessage.outputStreamWrite(outputStream);
            return;
        }
        loger.info("3.2  回复空");
        outputStreamWrite(outputStream,"");
    }

    /**
     * 数据流输出
     * @param outputStream
     * @param text
     * @return
     */
    private boolean outputStreamWrite(OutputStream outputStream, String text){
        try {
            outputStream.write(text.getBytes("utf-8"));
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return false;
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return false;
        }
        return true;
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

        // 遍历所有子节点
        for (Element e : elementList)
            map.put(e.getName(), e.getText());

        // 释放资源
        inputStream.close();
        inputStream = null;
        return map;
    }

    /**
     * 回复微信服务器"文本消息"
     * @param response
     * @param returnvaleue
     */
    public void output(HttpServletResponse response, String returnvaleue) {
        try {
            PrintWriter pw = response.getWriter();
            pw.write(returnvaleue);
            loger.info("****************return valeue***************="+returnvaleue);
            pw.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
