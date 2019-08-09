package com.wechat.Tool;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * 
 * 服务器消息事件接受处理类
 * @author lidongsheng
 * 
 */
public class WechatIncidentTool {
	
	/**
     * 数据流输出
     * @param outputStream
     * @param text
     * @return
     */
	public static boolean outputStreamWrite(OutputStream outputStream, String text){
		try {
			outputStream.write(text.getBytes("utf-8"));
			outputStream.flush();
		} catch (UnsupportedEncodingException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
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
        for (Element e : elementList){
        	 map.put(e.getName(), e.getText());
        	 System.out.println( e.getName()+" -- "+e.getText() );
        }
           

        // 释放资源
        inputStream.close();
        inputStream = null;
        return map;
    }
    
}
