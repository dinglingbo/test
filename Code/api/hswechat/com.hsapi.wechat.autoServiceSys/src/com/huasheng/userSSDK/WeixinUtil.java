package com.huasheng.userSSDK;
/**
 * 请求数据通用类*/
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;




import com.alibaba.fastjson.JSON;
/*import net.sf.json.JSONObject;*/
import com.alibaba.fastjson.JSONObject;




public class WeixinUtil {
    /** 
     * 发起https请求并获取结果 
     *  
     * @param requestUrl 请求地址 
     * @param requestMethod 请求方式（GET、POST） 
     * @param outputStr 提交的数据 
     * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值) 
     */  
	public static JSONObject HttpRequest(String request , String RequestMethod , String output ){
		@SuppressWarnings("unused")
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			//建立连接
			URL url = new URL(request);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setUseCaches(false);
			connection.setRequestMethod(RequestMethod);
			if(output!=null){
				OutputStream out = connection.getOutputStream();
				out.write(output.getBytes("UTF-8"));
				out.close();
			}
			//流处理
			InputStream input = connection.getInputStream();
			InputStreamReader inputReader = new InputStreamReader(input,"UTF-8");
			BufferedReader reader = new BufferedReader(inputReader);
			String line;
			while((line=reader.readLine())!=null){
				buffer.append(line);
			}
			//关闭连接、释放资源
			reader.close();
			inputReader.close();
			input.close();
			input = null;
			connection.disconnect();
			/*jsonObject = JSONObject.fromObject(buffer.toString());*/
			jsonObject =  (JSONObject) JSONObject.parse(buffer.toString());
		} catch (Exception e) {
		}
		return jsonObject;
	} 
//	 获取access_token的接口地址（GET）   
	public final static String access_token_url = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=CorpID&corpsecret=SECRET";  
	  
	/** 
	 * 获取access_token 
	 *  
	 * @param CorpID 企业Id 
	 * @param SECRET 管理组的凭证密钥，每个secret代表了对应用、通讯录、接口的不同权限；不同的管理组拥有不同的secret 
	 * @return 
	 */  
	public static AccessToken getAccessToken(String corpID, String secret) {  
	    AccessToken accessToken = null;  
	  
	    String requestUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=CorpID&secret=SECRET".replace("CorpID", corpID).replace("SECRET", secret);  
	    JSONObject jsonObject = HttpRequest(requestUrl, "GET", null);  
	    // 如果请求成功  
	    if (null != jsonObject) {  
	        try {  
	            accessToken = new AccessToken();  
	            accessToken.setToken(jsonObject.getString("access_token"));  
	            accessToken.setExpiresIn(jsonObject.getIntValue("expires_in"));
	            //System.out.println("获取token成功:"+jsonObject.getString("access_token")+"————"+jsonObject.getIntValue("expires_in"));
	        } catch (Exception e) {  
	            accessToken = null;  
	            // 获取token失败  
	            String error = String.format("获取token失败 errcode:{} errmsg:{}", jsonObject.getIntValue("errcode"), jsonObject.getString("errmsg"));  
	            //System.out.println(error);
	        }  
	    }  
	    return accessToken;  
	}
	public static String URLEncoder(String str){
		String result = str ;
		try {
		result = java.net.URLEncoder.encode(result,"UTF-8");	
		} catch (Exception e) {
        e.printStackTrace();
		}
		return result;
	}
	/**
	 * 根据内容类型判断文件扩展名
	 * 
	 * @param contentType 内容类型
	 * @return
	 */
	public static String getFileEndWitsh(String contentType) {
		String fileEndWitsh = "";
		if ("image/jpeg".equals(contentType))
			fileEndWitsh = ".jpg";
		else if ("audio/mpeg".equals(contentType))
			fileEndWitsh = ".mp3";
		else if ("audio/amr".equals(contentType))
			fileEndWitsh = ".amr";
		else if ("video/mp4".equals(contentType))
			fileEndWitsh = ".mp4";
		else if ("video/mpeg4".equals(contentType))
			fileEndWitsh = ".mp4";
		return fileEndWitsh;
	}
	/**
	 * 数据提交与请求通用方法
	 * @param access_token 凭证
	 * @param RequestMt 请求方式
	 * @param RequestURL 请求地址
	 * @param outstr 提交json数据
	 * */
    public static JSONObject PostMessage(String access_token ,String RequestMt , String RequestURL , String outstr){
    	int result = 0;
    	RequestURL = RequestURL.replace("ACCESS_TOKEN", access_token);
    	JSONObject jsonobject = WeixinUtil.HttpRequest(RequestURL, RequestMt, outstr);
    	 if (null != jsonobject) {  
 	        if (0 != jsonobject.getIntValue("errcode")) {  
 	            result = jsonobject.getIntValue("errcode");  
 	            String error = String.format("操作失败 errcode:{} errmsg:{"+jsonobject+"}", jsonobject.getIntValue("errcode"), jsonobject.getString("errmsg"));  
 	            //System.out.println(error); 
 	        }  
 	    }
    	//return outstr+":"+jsonobject.toString();\
    	 return jsonobject;
    }/**
	 * 数据提交与请求通用方法(返回1和0)
	 * @param access_token 凭证
	 * @param RequestMt 请求方式
	 * @param RequestURL 请求地址
	 * @param outstr 提交json数据
	 * */
    public static int PostMessageByBoolean(String access_token ,String RequestMt , String RequestURL , String outstr){
    	int result = 0;
    	RequestURL = RequestURL.replace("ACCESS_TOKEN", access_token);
    	JSONObject jsonobject = WeixinUtil.HttpRequest(RequestURL, RequestMt, outstr);
    	 if (null != jsonobject) {  
 	        if (0 != jsonobject.getIntValue("errcode")) {  
 	           result = jsonobject.getInteger("errcode");
 	        }  
 	    }
    	return result;
    }
//
//    public static String getOpenId(String userID) {
//		String corpId="wx91cb08a2bf9faa27";
//	 	String secret = "hweHmFM007_s-14yVONct7L1U-zVvGNx5v3tl5n22e9wNCXaF0tGiLYub5ygu0gf";
// 		String access_token = WeixinUtil.getAccessToken(corpId, secret).getToken(); 
// 		String PostData = "{\"userid\": \""+userID+"\"}";  
// 		System.out.println(PostData);
//    	JSONObject result=WeixinUtil.PostMessage(access_token, "POST", "https://qyapi.weixin.qq.com/cgi-bin/user/convert_to_openid?access_token=ACCESS_TOKEN ", PostData);
//    	System.out.println(result);
//    	String openid = result.getString("openid");
//    	String errcode=result.getString("errcode");
//    	String errmsg=result.getString("errmsg");
//    	System.out.println(openid);
//    	return openid;
//    	}
//    public static void main(String[] args) {
//    	getOpenId("11017555");
//    }
//   
    
}  
