package com.huasheng.usersWechat;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.activation.MimetypesFileTypeMap;
import javax.net.ssl.HttpsURLConnection;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;

import com.wechat.Tool.WechatCommonTool;

import commonj.sdo.DataObject;

@Bizlet("")
public class WeChatImageTextMessAge {
	
	//static String ipHttp="http://127.0.0.1:8080/default";
	static String ipHttp="http://qxy60.hszb.harsons.cn/dms";
	/*static String envType = Env.getContributionConfig("sys", "url", "api", "serverType");
	static String apiurl = Env.getContributionConfig("sys", "url", "api", envType);
	static String ipHttp = apiurl+"/dms";*/
	/**
     * (一)新增临时素材的接口
     * @param fileType     媒体文件类型，分别有图片（image）、语音（voice）、视频（video）和缩略图（thumb）
     * @param filePath     上传文件的流
     * @param fileName     上传到微信的文件名称
     * @return
     * @throws Exception
     * 	图片（image）: 2M，支持PNG\JPEG\JPG\GIF格式

		语音（voice）：2M，播放长度不超过60s，支持AMR\MP3格式

		视频（video）：10MB，支持MP4格式

		缩略图（thumb）：64KB，支持JPG格式
		
		返回参数:
			例子：{"created_at":1544434063,"media_id":"7tLiBA-OECGYuzywQKHfKR2wZHq9BpOJ_SFye2rpBrQpammg26pR3okK5vU33jKs","type":"image"}
			
		type	媒体文件类型，分别有图片（image）、语音（voice）、视频（video）和缩略图（thumb，主要用于视频与音乐格式的缩略图）
		media_id	媒体文件上传后，获取标识
		created_at	媒体文件上传时间戳
		
     */
    public static JSONObject UploadMeida(String fileType,InputStream fileInputStream,String fileName) throws Exception{
        //返回结果
        String result=null;
        /*File file=new File(filePath);
        if(!file.exists()||!file.isFile()){
            throw new IOException("文件不存在");
        }*/
        String AccessToken=ReceiveToken.getAccessToken();
        String urlString="https://api.weixin.qq.com/cgi-bin/media/upload?access_token="+AccessToken+"&type="+fileType;
        URL url=new URL(urlString);
        HttpsURLConnection conn=(HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");//以POST方式提交表单
        conn.setDoInput(true);
        conn.setDoOutput(true);
        conn.setUseCaches(false);//POST方式不能使用缓存
        //设置请求头信息
        conn.setRequestProperty("Connection", "Keep-Alive");
        conn.setRequestProperty("Charset", "UTF-8");
        //设置边界
        String BOUNDARY="----------"+System.currentTimeMillis();
        conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);
        //请求正文信息
        //第一部分
        StringBuilder sb=new StringBuilder();
        sb.append("--");//必须多两条道
        sb.append(BOUNDARY);
        sb.append("\r\n");
        sb.append("Content-Disposition: form-data;name=\"media\"; filename=\"" + fileName +"\"\r\n");
        sb.append("Content-Type:application/octet-stream\r\n\r\n");
        System.out.println("sb:"+sb);

        //获得输出流
        OutputStream out=new DataOutputStream(conn.getOutputStream());
        //输出表头
        out.write(sb.toString().getBytes("UTF-8"));
        //文件正文部分
        //把文件以流的方式 推送道URL中
        DataInputStream din=new DataInputStream(fileInputStream);
        int bytes=0;
        byte[] buffer=new byte[1024];
        while((bytes=din.read(buffer))!=-1){
            out.write(buffer,0,bytes);
        }
        din.close();
        //结尾部分
        byte[] foot=("\r\n--" + BOUNDARY + "--\r\n").getBytes("UTF-8");//定义数据最后分割线
        out.write(foot);
        out.flush();
        out.close();
        if(HttpsURLConnection.HTTP_OK==conn.getResponseCode()){

            StringBuffer strbuffer=null;
            BufferedReader reader=null;
            try {
                strbuffer=new StringBuffer();
                reader=new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String lineString=null;
                while((lineString=reader.readLine())!=null){
                    strbuffer.append(lineString);

                }
                if(result==null){
                    result=strbuffer.toString();
                    System.out.println("result:"+result);
                }
            } catch (IOException e) {
                System.out.println("发送POST请求出现异常！"+e);
                e.printStackTrace();
            }finally{
                if(reader!=null){
                    reader.close();
                }
            }

        }
        JSONObject jsonObject=JSONObject.parseObject(result);
        return jsonObject;
    }
    
    /**
     * (二)新增临时素材的接口
     * @param fileType     媒体文件类型，分别有图片（image）、语音（voice）、视频（video）和缩略图（thumb）
     * @param filePath     上传文件的路径
     * @return
     * @throws Exception
     * 	图片（image）: 2M，支持PNG\JPEG\JPG\GIF格式

		语音（voice）：2M，播放长度不超过60s，支持AMR\MP3格式

		视频（video）：10MB，支持MP4格式

		缩略图（thumb）：64KB，支持JPG格式
		
     */
    public static JSONObject UploadMeida(String fileType,String filePath) throws Exception{
        //返回结果
        String result=null;
        File file=new File(filePath);
        String AccessToken=ReceiveToken.getAccessToken();
        String urlString="https://api.weixin.qq.com/cgi-bin/media/upload?access_token="+AccessToken+"&type="+fileType;
        URL url=new URL(urlString);
        HttpsURLConnection conn=(HttpsURLConnection) url.openConnection();
        conn.setRequestMethod("POST");//以POST方式提交表单
        conn.setDoInput(true);
        conn.setDoOutput(true);
        conn.setUseCaches(false);//POST方式不能使用缓存
        //设置请求头信息
        conn.setRequestProperty("Connection", "Keep-Alive");
        conn.setRequestProperty("Charset", "UTF-8");
        //设置边界
        String BOUNDARY="----------"+System.currentTimeMillis();
        conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);
        //请求正文信息
        //第一部分
        StringBuilder sb=new StringBuilder();
        sb.append("--");//必须多两条道
        sb.append(BOUNDARY);
        sb.append("\r\n");
        sb.append("Content-Disposition: form-data;name=\"media\"; filename=\"" + file.getName()+"\"\r\n");
        sb.append("Content-Type:application/octet-stream\r\n\r\n");
        System.out.println("sb:"+sb);
        
        URL urlpath =new URL(filePath);
        
        //获得输出流
        OutputStream out=new DataOutputStream(conn.getOutputStream());
        //输出表头
        out.write(sb.toString().getBytes("UTF-8"));
        //文件正文部分
        //把文件以流的方式 推送道URL中
        DataInputStream din=new DataInputStream(urlpath.openStream());
        int bytes=0;
        byte[] buffer=new byte[1024];
        while((bytes=din.read(buffer))!=-1){
            out.write(buffer,0,bytes);
        }
        din.close();
        //结尾部分
        byte[] foot=("\r\n--" + BOUNDARY + "--\r\n").getBytes("UTF-8");//定义数据最后分割线
        out.write(foot);
        out.flush();
        out.close();
        if(HttpsURLConnection.HTTP_OK==conn.getResponseCode()){

            StringBuffer strbuffer=null;
            BufferedReader reader=null;
            try {
                strbuffer=new StringBuffer();
                reader=new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String lineString=null;
                while((lineString=reader.readLine())!=null){
                    strbuffer.append(lineString);

                }
                if(result==null){
                    result=strbuffer.toString();
                    System.out.println("result:"+result);
                }
            } catch (IOException e) {
                System.out.println("发送POST请求出现异常！"+e);
                e.printStackTrace();
            }finally{
                if(reader!=null){
                    reader.close();
                }
            }

        }
        JSONObject jsonObject=JSONObject.parseObject(result);
        return jsonObject;
    }
    
    /**
     * 单图文上传
     * @param thumbMediaId
     * @param author
     * @param title
     * @param contentSourceUrl
     * @param digest
     * @param contentHtml
     * @param needOpenComment
     * @param onlyFansCanComment
     * @return
     */
    @Bizlet("")
    public Map<String,String> ImageTextContentUpload(String thumbMediaId,String author,String title,String contentSourceUrl,String digest,String contentHtml,int needOpenComment,int onlyFansCanComment){
		GraphicMessage graphicArray[]=new GraphicMessage[1];
		
		GraphicMessage graphic=new GraphicMessage(thumbMediaId,title,contentHtml);
		graphic.setAuthor(author);
		if( contentSourceUrl != null && !contentSourceUrl.equals("")){
			graphic.setContent_source_url(contentSourceUrl);
		}
		graphic.setDigest(digest);
		graphic.setShow_cover_pic(0);
		graphic.setNeed_open_comment(needOpenComment);
		graphic.setOnly_fans_can_comment(onlyFansCanComment);
		graphicArray[0]=graphic;
		
		JSONObject articles=new JSONObject();
		articles.put("articles", graphicArray);
		System.out.println(articles.toJSONString());
		String json=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/media/uploadnews",ReceiveToken.getAccessToken(),articles.toJSONString());
		
		JSONObject resData=JSONObject.parseObject(json);
		Map<String,String> resMap=new HashMap<String,String>();
		
		resMap.put("media_id", resData.getString("media_id") );
		resMap.put( "type", resData.getString("type") );
		//正确例子: {"type":"news","media_id":"2E-2WloC32HXC7YFYbXNvAcCEo8PpkiZttI8wUOG5Jfg5yKR5dKqcmGaXZunUBZd","created_at":1544498697}
		return resMap;
	}
    
    /**
     * 多图文上传
     * @param obj
     * @return
     */
    @Bizlet("")
    public Map<String,String> ImageTextContentUploadMany(DataObject obj[]){
    	GraphicMessage graphicArray[]=new GraphicMessage[obj.length];
    	for(int a=0;a<obj.length;a++){
        	GraphicMessage graphic=new GraphicMessage(obj[a].getString("mediaId"),obj[a].getString("imageTextTitle"),obj[a].getString("container"));
        	graphic.setAuthor(obj[a].getString("imageTextAuthor"));
        	String contentSourceUrl=obj[a].getString("imageTextSource");
        	if( contentSourceUrl != null && !contentSourceUrl.equals("")){
        		graphic.setContent_source_url(contentSourceUrl);
    		}
        	graphic.setShow_cover_pic(0);
        	graphic.setNeed_open_comment(obj[a].getInt("isOpenComment"));
        	graphic.setOnly_fans_can_comment(obj[a].getInt("isCanComment"));
        	graphicArray[a]=graphic;
    	}
    	
    	JSONObject articles=new JSONObject();
    	articles.put("articles", graphicArray);
    	System.out.println(articles.toJSONString());
    	String json=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/media/uploadnews",ReceiveToken.getAccessToken(),articles.toJSONString());
		
		JSONObject resData=JSONObject.parseObject(json);
		Map<String,String> resMap=new HashMap<String,String>();
		
		resMap.put("media_id", resData.getString("media_id") );
		resMap.put( "type", resData.getString("type") );
    	//{"type":"news","media_id":"hMxxTDDgguJMGeCVdbRumgFQc-Mi5gMMLPj1z0XVUb7I8Wvd2s_1T4AmGX_iWwED","created_at":1544585802}
		return resMap;
		
	}
    
    
    /**
     * 推送图文消息-预览
     * @param towxname   用户微信号
     * @param openId	用户opid
     * @param mediaId	消息模板id
     * @param messAgeType	消息类型 1.图文，2.图片，3.文本
     * 
     * 返回参数：
     * 		errcode	错误码
     *		errmsg	错误信息
     *		msg_id	消息ID
     * 
     */
    @Bizlet("")
    public Map<String,Object> sendImageTextContentMessagePush(String towxname,String openId,String mediaId,int messAgeType){
  		JSONObject json=new JSONObject();
  		if( towxname == null || towxname.equals("") ){
  			json.put("touser", openId);//用户微信openid
  		}else{
  			json.put("towxname", towxname);//用户微信号
  		}
  		
  		JSONObject obj=new JSONObject();
  		obj.put("media_id", mediaId);
  		json.put("mpnews", obj);
  		
  		switch (messAgeType) {
		case 1:
			json.put("msgtype", "mpnews");
			break;
		case 2:
			json.put("msgtype", "image");
			break;
		case 3:
			json.put("msgtype", "text");
			break;
		}
  		System.out.println(json.toJSONString());
  		String resjson=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/message/mass/preview",ReceiveToken.getAccessToken(),json.toJSONString());
  		
  		JSONObject resData=JSONObject.parseObject(resjson);
  		Map<String,Object> resMap=new HashMap<String,Object>();
		resMap.put("errcode", resData.getInteger("errcode") );
		resMap.put("errmsg", resData.getString("errmsg") );
		resMap.put("msg_id", resData.getIntValue("msg_id") );
  		//{"errcode":0,"errmsg":"preview success","msg_id":34182}
		return resMap;
     }
    
    //图文推送用户
    @Bizlet("")
    public void pushImageTextContentMessage(DataObject openIdList[],DataObject imageTextMain[],DataObject imageTextDetil[] ){
    	String array[]=new String[openIdList.length];
		for(int a=0;a<openIdList.length;a++){
			array[a]=openIdList[a].getString("userOpid");
		}
		String resjson="";
    	if( imageTextMain[0].getString("imageTextType").equals("1") ){//文本消息
    		JSONObject json=new JSONObject();
			json.put("touser", array);//用户的openID
			JSONObject obj=new JSONObject();
			obj.put( "content", imageTextDetil[0].getString("imageTextDescribe") );
			json.put("text", obj);
			json.put("msgtype", "text");
			System.out.println(json);
			resjson=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/message/mass/send",ReceiveToken.getAccessToken(),json.toJSONString());
			System.out.println(resjson);
    	}else if( imageTextMain[0].getString("imageTextType").equals("2") ){//图片消息
    		try {
				JSONObject jsonObject=UploadMeida("image",ipHttp+imageTextDetil[0].getString("fodderPath"));//上传图片
				System.out.println(jsonObject);
				JSONObject json=new JSONObject();
				json.put("touser", array);//用户的openID
				JSONObject obj=new JSONObject();
				obj.put( "media_id", jsonObject.getString("media_id") );
				json.put("image", obj);
				json.put("msgtype", "image");
				System.out.println(json);
				resjson=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/message/mass/send",ReceiveToken.getAccessToken(),json.toJSONString());
				System.out.println(resjson);
			} catch (Exception e) {
				e.printStackTrace();
			}
    	}else if( imageTextMain[0].getString("imageTextType").equals("3") ){//单图文消息
    		try {
    			System.out.println(ipHttp);
    			JSONObject jsonObject=UploadMeida("image",ipHttp+imageTextDetil[0].getString("fodderPath"));//上传图片
				System.out.println(jsonObject);
				Map<String,String> map=ImageTextContentUpload( jsonObject.getString("media_id") ,imageTextDetil[0].getString("imageTextAuthor"),imageTextDetil[0].getString("imageTextTitle"),imageTextDetil[0].getString("imageTextSource"),imageTextDetil[0].getString("imageTextDescribe"),imageTextDetil[0].getString("imageTextContent"),imageTextDetil[0].getInt("isOpenComment"),imageTextDetil[0].getInt("isCanComment"));
				JSONObject json=new JSONObject();
				json.put("touser", array);//用户的openID
				JSONObject obj=new JSONObject();
				obj.put("media_id", map.get("media_id"));
				json.put("mpnews", obj);
				json.put("msgtype", "mpnews");
				json.put("send_ignore_reprint",0);
				System.out.println(json);
				resjson=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/message/mass/send",ReceiveToken.getAccessToken(),json.toJSONString());
				System.out.println(resjson);
				//{"errcode":0,"errmsg":"send job submission success","msg_id":3147483649,"msg_data_id":2247483686}
			} catch (Exception e) {
				e.printStackTrace();
			}
    		
    	}else if( imageTextMain[0].getString("imageTextType").equals("4") ){//多图文消息
    		GraphicMessage graphicArray[]=new GraphicMessage[imageTextDetil.length];
    		for(int a=0;a<imageTextDetil.length;a++){
				try {
					JSONObject jsonObject = UploadMeida("image",ipHttp+imageTextDetil[a].getString("fodderPath"));
					System.out.println(jsonObject);
					GraphicMessage graphic=new GraphicMessage(jsonObject.getString("media_id"),imageTextDetil[a].getString("imageTextTitle"),imageTextDetil[a].getString("imageTextContent"));
	            	graphic.setAuthor(imageTextDetil[a].getString("imageTextAuthor"));
	            	String contentSourceUrl=imageTextDetil[a].getString("imageTextSource");
	            	if( contentSourceUrl != null && !contentSourceUrl.equals("")){
	            		graphic.setContent_source_url(contentSourceUrl);
	        		}
	            	graphic.setShow_cover_pic(0);
	            	graphic.setNeed_open_comment(imageTextDetil[a].getInt("isOpenComment"));
	            	graphic.setOnly_fans_can_comment(imageTextDetil[a].getInt("isCanComment"));
	            	graphicArray[a]=graphic;
				} catch (Exception e) {
					e.printStackTrace();
				}
    		}
        	JSONObject articles=new JSONObject();
        	articles.put("articles", graphicArray);
        	System.out.println(articles.toJSONString());
        	String json=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/media/uploadnews",ReceiveToken.getAccessToken(),articles.toJSONString());
    		JSONObject resData=JSONObject.parseObject(json);
    		
    		JSONObject jsonPush=new JSONObject();
    		jsonPush.put("touser", array);//用户的openID
			JSONObject obj=new JSONObject();
			obj.put("media_id", resData.getString("media_id"));
			jsonPush.put("mpnews", obj);
			jsonPush.put("msgtype", "mpnews");
			jsonPush.put("send_ignore_reprint",0);
			System.out.println(jsonPush);
			resjson=WechatCommonTool.transferJsonInterface("https://api.weixin.qq.com/cgi-bin/message/mass/send",ReceiveToken.getAccessToken(),jsonPush.toJSONString());
			System.out.println(resjson);
    	}
    	JSONObject resDatas=JSONObject.parseObject(resjson);
    	JSONObject paramPush=new JSONObject();
    	paramPush.put("msg_id",resDatas.getString("msg_id"));
    	//验证是否发送成功
		String ressData=WechatCommonTool.transferJsonInterface( "https://api.weixin.qq.com/cgi-bin/message/mass/get",ReceiveToken.getAccessToken(),paramPush.toJSONString() );
		System.err.println(ressData);
    }
    
    
}
