package com.hs.common; 
  
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.springframework.util.StreamUtils;


  
/** 
 * 重写HttpServletRequestWrapper方法 
 * @author Oliver 
 * @version 20161214 
 */  
public class MyHttpServletRequestWrapper extends HttpServletRequestWrapper {  
    private byte[] requestBody = null;  
  
    public MyHttpServletRequestWrapper (HttpServletRequest request) {  
  
        super(request);  
  
        //缓存请求body  
        try {  
        	//requestBody = StreamUtils.copyToByteArray(request.getInputStream(), Charset.forName("utf-8"));
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
        final ByteArrayInputStream bais = new ByteArrayInputStream(requestBody);  
        return new ServletInputStream() {  
            @Override  
            public int read() throws IOException {  
                return bais.read();  
            }  
        };  
    }  
  
    /** 
     * 重写 getReader() 
     */  
    @Override  
    public BufferedReader getReader() throws IOException {  
        return new BufferedReader(new InputStreamReader(getInputStream()));  
    }  
}  