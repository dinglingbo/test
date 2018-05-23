package com.hs.common; 
  
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.IOUtils;
import org.springframework.util.StreamUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;


  
/** 
 * 重写HttpServletRequestWrapper方法 
 * @author Oliver 
 * @version 20161214 
 */  
public class MyHttpServletRequestWrapper extends HttpServletRequestWrapper {  
    private byte[] requestBody = null;  
    
 // 传入是JSON格式 转换成JSONObject
    public JSONObject getRequestBody() throws UnsupportedEncodingException {
        return JSON.parseObject((new String(requestBody, "UTF-8")));
    }
 
    public void setRequestBody(JSONObject jsonObject) throws UnsupportedEncodingException {
        this.requestBody = jsonObject.toJSONString().getBytes("UTF-8");
    }
  
    public MyHttpServletRequestWrapper (HttpServletRequest request) {  
  
        super(request);  
  
        //缓存请求body  
        try {  
        	//requestBody = StreamUtils.copyToByteArray(request.getInputStream(), Charset.forName("utf-8"));
        	//requestBody=IOUtils.toByteArray(request.getInputStream());
        	requestBody = StreamUtils.copyToString(request.getInputStream(), Charset.forName("utf-8")).getBytes();
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
  
    /** 
     * 重写 getInputStream() 
     */  
    @Override  
    public ServletInputStream getInputStream() throws IOException {  
        if(requestBody == null){  
            requestBody= new byte[0];  
        }  
        
        return new MyServletInputStream(new ByteArrayInputStream(requestBody));
        
        /*final ByteArrayInputStream bais = new ByteArrayInputStream(requestBody);  
        return new ServletInputStream() {  
            @Override  
            public int read() throws IOException {  
                return bais.read();  
            }  
        };*/  
    }  
  
    /** 
     * 重写 getReader() 
     */  
    @Override  
    public BufferedReader getReader() throws IOException {  
        return new BufferedReader(new InputStreamReader(getInputStream()));  
    } 
    
    
    class MyServletInputStream extends ServletInputStream{
        private InputStream inputStream;

        public MyServletInputStream(InputStream inputStream){
            this.inputStream = inputStream;
        }

        @Override
        public int read() throws IOException {
            return inputStream.read();
        }
    }
}  