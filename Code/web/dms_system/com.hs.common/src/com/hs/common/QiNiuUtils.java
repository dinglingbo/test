/**
 * 
 */
package com.hs.common;

import java.io.ByteArrayInputStream;
import java.io.IOException;

import sun.misc.BASE64Decoder;

import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.storage.model.FileInfo;
import com.qiniu.storage.model.FileListing;
import com.qiniu.util.Auth;

/** 
 * @author 作者 ding: 
 * @version 创建时间：2019年1月31日 下午3:36:34 
 * 类说明 
 */
/**
 * @author Administrator
 * @date 2019-01-31 15:36:34
 *
 */
@Bizlet("")
public class QiNiuUtils {
	@Bizlet("")
	public static String uploadToken() {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNACCESSKEY", "serverType");
		String accessKey = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNACCESSKEY", envType);

		String secretKey = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNSECRETKEY", envType);

		String bucketName = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNBUCKETNAME", envType);

		Auth auth = Auth.create(accessKey, secretKey);
		String upToken = auth.uploadToken(bucketName);
		System.out.println(upToken);
		
		return upToken;

	}
	
	@Bizlet("本地文件上传")
	public static void uploadLocalFile(String localFilePath, String key) {
		Zone z = Zone.zone2();//Zone.autoZone();
		Configuration c = new Configuration(z);
		UploadManager uploadManager = new UploadManager(c);
		//上传到七牛后保存的文件名  String key = null;
		String upToken = uploadToken();

		try {
		    Response response = uploadManager.put(localFilePath, key, upToken);
		    //解析上传成功的结果
		    DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
		    System.out.println(putRet.key);
		    System.out.println(putRet.hash);
		} catch (QiniuException ex) {
		    Response r = ex.response;
		    System.err.println(r.toString());
		    try {
		        System.err.println(r.bodyString());
		    } catch (QiniuException ex2) {
		        //ignore
		    }
		}
	}
	
	@Bizlet("base64编码上传")
	public static void uploadBase64File(String baseCode, String key) {
		Zone z = Zone.autoZone();
		Configuration c = new Configuration(z);
		UploadManager uploadManager = new UploadManager(c);
		//上传到七牛后保存的文件名  String key = null;
		String upToken = uploadToken();

		try {
			// 解码，然后将字节转换为文件
            byte[] bytes = new BASE64Decoder().decodeBuffer(baseCode);   //将字符串转换为byte数组
            ByteArrayInputStream byteInputStream = new ByteArrayInputStream(bytes);
            
		    Response response = uploadManager.put(byteInputStream, key, upToken, null, null);
		    //解析上传成功的结果
		    DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
		    System.out.println(putRet.key);
		    System.out.println(putRet.hash);
		} catch (QiniuException ex) {
		    Response r = ex.response;
		    System.err.println(r.toString());
		    try {
		        System.err.println(r.bodyString());
		    } catch (QiniuException ex2) {
		        //ignore
		    }
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}
	}
	
	@Bizlet("文件列表")
	public static void listFile(String bucket, String prefix, String marker, int limit, String delimiter) {
		Zone z = Zone.autoZone();
		Configuration c = new Configuration(z);
		
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNACCESSKEY", "serverType");
		String accessKey = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNACCESSKEY", envType);

		String secretKey = Env.getContributionConfig("com.vplus.login",
				"cfg", "QNSECRETKEY", envType);

		Auth auth = Auth.create(accessKey, secretKey);
		
		UploadManager uploadManager = new UploadManager(c);
		//上传到七牛后保存的文件名  String key = null;
		String upToken = uploadToken();
		//实例化一个BucketManager对象
        BucketManager bucketManager = new BucketManager(auth, c);

        try {
            //调用listFiles方法列举指定空间的指定文件
            //参数一：bucket    空间名
            //参数二：prefix    文件名前缀
            //参数三：marker    上一次获取文件列表时返回的 marker
            //参数四：limit     每次迭代的长度限制，最大1000，推荐值 100
            //参数五：delimiter 指定目录分隔符，列出所有公共前缀（模拟列出目录效果）。缺省值为空字符串
            FileListing fileListing = bucketManager.listFiles(bucket, null, null, 1000, null);
            FileInfo[] items = fileListing.items;
            for (FileInfo fileInfo : items) {
                System.out.println(fileInfo.key);
            }
        } catch (QiniuException e) {
            //捕获异常信息
            Response r = e.response;
            System.out.println(r.toString());
        }
	}
	
	/* https://blog.csdn.net/u012043557/article/details/54928686
	 * public class UploadCallBackDemo {
		    //设置好账号的ACCESS_KEY和SECRET_KEY
		    private static final String ACCESS_KEY = "";
		    private static final String SECRET_KEY = "";
		    //要上传的空间
		    private static final String BUCKET_NAME = "myhui";
		
		    //上传到七牛后保存的文件名
		    String key = "image/test/" + UUID.randomUUID() + ".png";
		    //上传文件的路径
		    String FilePath = "D://1.jpg";
		    //密钥配置
		    Auth auth = Auth.create(ACCESS_KEY, SECRET_KEY);
		
		    //第二种方式: 自动识别要上传的空间(bucket)的存储区域是华东、华北、华南。
		    Zone z = Zone.autoZone();
		    Configuration c = new Configuration(z);
		
		    //创建上传对象
		    UploadManager uploadManager = new UploadManager(c);
		
		    //设置callbackUrl以及callbackBody,七牛将文件名和文件大小回调给业务服务器
		    public String getUpToken() {
		        return auth.uploadToken(BUCKET_NAME, null, 3600, new StringMap()
		                .put("callbackUrl", "http://your.domain.com/callback")
		                .put("callbackBody", "filename=$(fname)&filesize=$(fsize)"));
		    }
		
		    public void upload() throws IOException {
		        try {
		            //调用put方法上传
		            Response res = uploadManager.put(FilePath, key, getUpToken());
		            //打印返回的信息
		            System.out.println(res.bodyString());
		        } catch (QiniuException e) {
		            Response r = e.response;
		            //响应的文本信息
		            System.out.println(r.bodyString());
		        }
		    }
		
		    public static void main(String args[]) throws IOException {
		        new UploadCallBackDemo().upload();
		    }
		
		}
	 * */
}
