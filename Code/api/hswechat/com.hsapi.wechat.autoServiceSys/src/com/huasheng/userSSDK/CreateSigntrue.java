package com.huasheng.userSSDK;

import java.io.UnsupportedEncodingException;
import java.security.DigestException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;
import java.util.UUID;

import com.eos.system.annotation.Bizlet;
@Bizlet("")
public class CreateSigntrue {
	
	/**
	 * 生成签名
	 * @param url
	 * @param jsapi_ticket
	 * @return
	 */
	public String[] signTrue( String url,String appId,String jsapi_ticket){
		String signature = "";
		//生成时间戳
		String timestamp =Long.toString(System.currentTimeMillis() / 1000L);
		//生成随机字符串
		String nonceStr =UUID.randomUUID().toString();
		//创建数组，将需传到前台的数据储存在数组中：时间戳，随机字符串，签名
		String [] arr=new String[3];
		arr[0] =timestamp;
		arr[1] =nonceStr;
		
		System.out.println("timestamp=="+timestamp);
		System.out.println("nonceStr=="+nonceStr);
		
		String data ="jsapi_ticket=" + jsapi_ticket + 
			      "&noncestr=" + nonceStr + 
			      "&timestamp=" + timestamp + 
			      "&url=" + url;
		//String data=string1+"&url="+url;
		try {
			//调加密方法获取签名
			signature = shaEncrypt(data);
			//存入数组
			arr[2] =signature;
			
			System.out.println("signature=="+signature);

		} catch (DigestException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}	
		return arr;	
		
	}
	
	//shaEncrypt加密
    public   String shaEncrypt(String a) throws DigestException {  
        //获取信息摘要 - 参数字典排序后字符串  
        String decrypt = a;  
        String  signature="";
        try {  
          //指定sha1算法  
          MessageDigest crypt = MessageDigest.getInstance("SHA-1");
  	      crypt.reset();
  	      crypt.update(decrypt.getBytes("UTF-8"));
  	      signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
	    {
	      e.printStackTrace();
	    }
	    catch (UnsupportedEncodingException e)
	    {
	      e.printStackTrace();
	    }
		 
        return   signature;
    }  
    
    public String byteToHex(byte[] hash)
	  {
	    Formatter formatter = new Formatter();
	    for (byte b : hash)
	    {
	      formatter.format("%02x", new Object[] { Byte.valueOf(b) });
	    }
	    String result = formatter.toString();
	    formatter.close();
	    return result;
	  }
}
