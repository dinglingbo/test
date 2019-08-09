package com.huasheng.userSSDK;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

import com.alibaba.fastjson.JSONObject;
import com.eos.foundation.eoscommon.BusinessDictUtil;
import com.huasheng.usersWechat.ReceiveToken;
 
/***
 * @author V型知识库  www.vxzsk.com
 *
 */
public class JsapiTicketUtil {
	/*public static String corpId=BusinessDictUtil.getDictName("WEIXIN_CONNECTION","corpId");
	public static String secret=BusinessDictUtil.getDictName("WEIXIN_CONNECTION","check");*/
	public static String corpId="wxd10b49dcb45e5591";
	public static String secret ="8f21ab04f3b9bc252d8dce64a6d055e4";
    /***
     * 模拟get请求
     * @param url
     * @param charset
     * @param timeout
     * @return
     */
     public static String sendGet(String url, String charset, int timeout)
      {
        String result = "";
        try
        {
          URL u = new URL(url);
          try
          {
            URLConnection conn = u.openConnection();
            conn.connect();
            conn.setConnectTimeout(timeout);
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), charset));
            String line="";
            while ((line = in.readLine()) != null)
            {
             
              result = result + line;
            }
            in.close();
          } catch (IOException e) {
            return result;
          }
        }
        catch (MalformedURLException e)
        {
          return result;
        }
       
        return result;
      }
     /***
      * 获取acess_token 
      * 来源www.vxzsk.com
      * @return
      */
     public static String getAccessToken(){
            String url ="https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid="+corpId+"&secret="+secret+"";
            String backData=sendGet(url, "utf-8", 10000);
            String accessToken = (String) JSONObject.parseObject(backData).get("access_token");  
            return accessToken;
    	 
     }
     
     /***
      * 获取jsapiTicket
      * 来源 www.vxzsk.com
      * @return
      */
    public static String getJSApiTicket(){ 
   	 System.out.println("这是签名的corpId：--------"+corpId);
   	 System.out.println("这是签名的：secret：-----"+secret);
        //获取token
        //String access_token= JsapiTicketUtil.getAccessToken();
    	String access_token = ReceiveToken.getAccessToken();
    	System.out.println("调用微信jsapiaccess_token："+access_token);
        String urlStr = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+access_token+"&type=jsapi";  
        //String backData=sendGet(urlStr, "utf-8", 10000);
        //String ticket = (String) JSONObject.parseObject(backData).get("ticket");  
        JSONObject result = WeixinUtil.PostMessage(access_token, "POST", urlStr, "");
        String ticket =result.getString("ticket");
        return  ticket;  
           
    }  
     
    public static void main(String[] args) {
        String jsapiTicket = JsapiTicketUtil.getJSApiTicket();
        System.out.println("调用微信jsapi的凭证票为："+jsapiTicket);
 
    }
 
}