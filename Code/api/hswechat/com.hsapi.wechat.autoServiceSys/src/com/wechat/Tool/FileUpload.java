package com.wechat.Tool;

import java.io.IOException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;
import com.huasheng.usersWechat.WeChatImageTextMessAge;

@Bizlet("")
public class FileUpload {
	
	@Bizlet("")
	public static String onlyFileUpload(String url,String fileName){
		 String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase(); //当前上传图片的格式
		 SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmm");
         String newFileName = df.format(new Date()) + "_" + new Random().nextInt(1000) + "." + fileExt;//当前的时间+顺机数字+文件格式=文件
         
        try {
        	URL urls=new URL(url);
        	//微信-新增临时素材的接口
			JSONObject resjson = WeChatImageTextMessAge.UploadMeida("image",urls.openStream(),newFileName);
			System.out.println(resjson);
			return resjson.getString("media_id");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
        return "";
	}
	
	/*public static void main(String[] args) {
		System.out.println( onlyFileUpload("http://127.0.0.1:8080/default/hsWechatImager/201903/201903072029_630.png","xrds.png") );
	}*/
	
}
