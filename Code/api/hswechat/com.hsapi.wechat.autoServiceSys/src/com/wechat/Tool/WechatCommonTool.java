package com.wechat.Tool;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.Map;

import javax.activation.MimetypesFileTypeMap;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

/**
 * 
 * 接口调用工具
 * @author lidongsheng
 * 
 */
public class WechatCommonTool {
	
	//链接调用接口
	public static String transferLinkInterface(String url) {
        String result = "";
        BufferedReader in = null;
        try {
            String urlNameString = url;
            URL realUrl = new URL(urlNameString);
            // 打开和URL之间的连接
            URLConnection connection = realUrl.openConnection();
            // 设置通用的请求属性
            connection.setRequestProperty("accept", "*/*");
            connection.setRequestProperty("connection", "Keep-Alive");
            connection.setRequestProperty("user-agent",
                    "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
            // 建立实际的连接
            connection.connect();
            // 获取响应头字段
            Map<String, List<String>> map = connection.getHeaderFields();
            // 定义 BufferedReader输入流来读取URL的响应
            in = new BufferedReader(new InputStreamReader(
                    connection.getInputStream(),"UTF-8"));
            String line;
            while ((line = in.readLine()) != null) {
                result += line;
            }
        } catch (Exception e) {
            System.out.println("发送GET 请求出现异常");
            e.printStackTrace();
        }
        // 使用finally块来关闭输入流
        finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return result;
    }
	
	//公共的提交json的接口调用
	public static String transferJsonInterface(String uploadurl, String access_token,String data){
    	org.apache.commons.httpclient.HttpClient client = new org.apache.commons.httpclient.HttpClient();
    	String posturl = String.format("%s?access_token=%s", uploadurl,access_token);
    	System.out.println(posturl);
    	PostMethod post = new PostMethod(posturl);
    	post.setRequestHeader("User-Agent","Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:30.0) Gecko/20100101 Firefox/30.0");
    	post.setRequestHeader("Host", "file.api.weixin.qq.com");
    	post.setRequestHeader("Connection", "Keep-Alive");
    	post.setRequestHeader("Cache-Control", "no-cache");
    	post.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
    	String result = null;
    	try{
    		post.setRequestBody(data);
	    	int status = client.executeMethod(post);
	    	if (status == HttpStatus.SC_OK){
	    		String responseContent = post.getResponseBodyAsString();
	    		System.out.println(responseContent);
	    		result=responseContent;
	    	}
    	}catch (Exception e){
    		e.printStackTrace();
    	}finally{
    		return result;
    	}
    }
	
	//文件上传
	public static String formUpload(String urlStr, File file) {
        String res = "";
        HttpURLConnection conn = null;
        String BOUNDARY = "---------------------------123821742118716"; // boundary就是request头和上传文件内容的分隔符
        try {
            URL url = new URL(urlStr);
            conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(30000);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Connection", "Keep-Alive");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.1; zh-CN; rv:1.9.2.6)");
            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);
            OutputStream out = new DataOutputStream(conn.getOutputStream());

            // file
            String inputName = "";
            String filename = file.getName();
            String contentType = new MimetypesFileTypeMap().getContentType(file);
            if (filename.endsWith(".png")) {
                contentType = "image/png";
            }else if (filename.endsWith(".jpg")) {
                contentType = "image/jpeg";
            }
            if (contentType == null || contentType.equals("")) {
                contentType = "application/octet-stream";
            }

            StringBuffer strBuf = new StringBuffer();
            strBuf.append("\r\n").append("--").append(BOUNDARY).append("\r\n");
            strBuf.append(
                    "Content-Disposition: form-data; name=\"" + inputName + "\"; filename=\"" + filename + "\"\r\n");
            strBuf.append("Content-Type:" + contentType + "\r\n\r\n");
            out.write(strBuf.toString().getBytes());
            DataInputStream in = new DataInputStream(new FileInputStream(file));
            int bytes = 0;
            byte[] bufferOut = new byte[1024];
            while ((bytes = in.read(bufferOut)) != -1) {
                out.write(bufferOut, 0, bytes);
            }
            in.close();
            byte[] endData = ("\r\n--" + BOUNDARY + "--\r\n").getBytes();
            out.write(endData);
            out.flush();
            out.close();

            // 读取返回数据
            StringBuffer strBuf2 = new StringBuffer();
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = null;
            while ((line = reader.readLine()) != null) {
                strBuf2.append(line).append("\n");
            }
            res = strBuf2.toString();
            reader.close();
            reader = null;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.disconnect();
                conn = null;
            }
        }
        return res;
    }
}
