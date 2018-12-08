package wxPay;



import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.imageio.ImageIO;
import javax.imageio.stream.FileImageInputStream;
import javax.imageio.stream.ImageInputStream;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import sun.misc.BASE64Encoder;

import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;


public class HttpClientUtil {

//	public static void main(String[] args){
//
//		String str = imgURLToBase64("https://photo.harsonserver.com/20180821112548834.jpg");
//		System.out.println(str);
//	}


	final static HostnameVerifier DO_NOT_VERIFY = new HostnameVerifier() {

		public boolean verify(String hostname, SSLSession session) {
			return true;
		}
	};


	private static void trustAllHosts() {

		// Create a trust manager that does not validate certificate chains
		TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {

			public java.security.cert.X509Certificate[] getAcceptedIssuers() {
				return new java.security.cert.X509Certificate[] {};
			}

			public void checkClientTrusted(X509Certificate[] chain, String authType)  {

			}

			public void checkServerTrusted(X509Certificate[] chain, String authType) {

			}
		} };

		// Install the all-trusting trust manager
		try {
			SSLContext sc = SSLContext.getInstance("TLS");
			sc.init(null, trustAllCerts, new java.security.SecureRandom());
			HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	//读取图片  网络路径，返回Base64

	@Bizlet("")
	public static String imgURLToBase64(String imgURL){

		InputStream inputStream = null;
		ByteArrayOutputStream out = null;
		HttpURLConnection conn = null;
		String content = "";
		ImageInputStream imgInputStram = null;
		try {
			URL url = new URL(null,imgURL,new sun.net.www.protocol.https.Handler());
			trustAllHosts();
			HttpsURLConnection.setDefaultHostnameVerifier(DO_NOT_VERIFY);

			HttpsURLConnection httpsConnection = (HttpsURLConnection) url.openConnection();
			if(url.getProtocol().toLowerCase().equals("https")){
				httpsConnection.setHostnameVerifier(DO_NOT_VERIFY);
				conn = httpsConnection;

			}else{
				conn = (HttpURLConnection)url.openConnection();

			}
			conn.connect();
			//inputStream = url.openStream();
			inputStream = conn.getInputStream();
			//imgInputStram = ImageIO.createImageInputStream(inputStream);
			//图片保存到本地
			BufferedImage image = ImageIO.read(inputStream);
//			String path = "E://test.jpg";
//			File file = new File(path);
//			ImageIO.write(image,"jpg",file);
//			
//			FileInputStream fileInputStream = new FileInputStream(file);
//			byte[] data = new byte[fileInputStream.available()];
//			fileInputStream.read(data);
//			fileInputStream.close();
//			String test = new BASE64Encoder().encode(data);
//			System.out.println("data:image/jpg;base64,"+test);

			//BufferedImage imageBuf = ImageIO.read(inputStream);
			out = new ByteArrayOutputStream();
			ImageIO.write(image, "jpg", out);
			int length = out.toByteArray().length;
			//byte[] buf = new byte[1024];//缓存数组
			byte[] buf = new byte[length];//缓存数组
			buf = out.toByteArray();
			//读取输入流中的数据放入缓存
			
//			while( inputStream.read(buf) != -1 ){
//				out.write(buf);
//			}
//			out.flush();
//			byte[] resultByte = out.toByteArray();

			content = new BASE64Encoder().encode(buf);
			//去除回车和换行
			content.trim().replaceAll("\n", "").replaceAll("\r", "");

		} catch (MalformedURLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}finally{
			if( inputStream != null){
				try {
					inputStream.close();
				} catch (IOException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			}
			if(out != null){
				try {
					out.close();
				} catch (IOException e) {
					// TODO 自动生成的 catch 块
					e.printStackTrace();
				}
			}
		}
		return content;
	}



	/**
	 * 绕过SSL验证
	 * 	
	 * @return
	 * @throws NoSuchAlgorithmException 
	 * @throws KeyManagementException 
	 */
	public static SSLContext createIgnoreVerifySSL() throws NoSuchAlgorithmException, KeyManagementException {
		SSLContext sc = SSLContext.getInstance("SSLv3");

		// 实现一个X509TrustManager接口，用于绕过验证，不用修改里面的方法
		X509TrustManager trustManager = new X509TrustManager() {
			@Override
			public void checkClientTrusted(
					java.security.cert.X509Certificate[] paramArrayOfX509Certificate,
					String paramString) throws CertificateException {
			}

			@Override
			public void checkServerTrusted(
					java.security.cert.X509Certificate[] paramArrayOfX509Certificate,
					String paramString) throws CertificateException {
			}

			@Override
			public java.security.cert.X509Certificate[] getAcceptedIssuers() {
				return null;
			}
		};

		sc.init(null, new TrustManager[] { trustManager }, null);
		return sc;
	}

	public static String doPostNotSSL(String url,Map<String,String> map,String encoding) throws KeyManagementException, NoSuchAlgorithmException, ClientProtocolException, IOException{
		String body = "";
		//采用绕过验证的方式处理HTTPS请求
		SSLContext sslcontext = createIgnoreVerifySSL();
		// 设置协议http和https对应的处理socket链接工厂的对象
		Registry<ConnectionSocketFactory> socketFactoryRegistry = RegistryBuilder.<ConnectionSocketFactory>create()
				.register("http", PlainConnectionSocketFactory.INSTANCE)
				.register("https", new SSLConnectionSocketFactory(sslcontext))
				.build();
		PoolingHttpClientConnectionManager connManager = new PoolingHttpClientConnectionManager(socketFactoryRegistry);
		HttpClients.custom().setConnectionManager(connManager);
		//创建自定义的httpclient对象
		CloseableHttpClient client = HttpClients.custom().setConnectionManager(connManager).build();
		//创建POST方式请求对象
		HttpPost post = new HttpPost(url);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		//装填参数
		if(map != null){
			for(Entry<String,String> entry : map.entrySet()){
				nvps.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));

			}
		}
		//设置参数到请求对象中
		post.setEntity(new UrlEncodedFormEntity(nvps,encoding));
		System.out.println("请求地址:" + url);
		System.out.println("请求参数：" + nvps.toString());
		//设置header信息
		post.setHeader("Content-type","application/octet-stream");
		//执行请求操作，拿到结果(同步阻塞)
		CloseableHttpResponse response = client.execute(post);
		HttpEntity entity = response.getEntity();
		if(entity != null){
			body = EntityUtils.toString(entity,encoding);
		}
		EntityUtils.consume(entity);
		response.close();
		return body;
	}

	//发送get请求，返回服务器json
	@Bizlet("")
	public static JSONObject doGet(String url){
		//指定get	请求
		HttpGet httpGet = new HttpGet(url);
		//创建httpClient
		HttpClient httpClient = new DefaultHttpClient();
		//发送请求
		HttpResponse response;
		JSONObject json = null;
		try {
			response = httpClient.execute(httpGet);
			//验证请求是否成功
			if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
				//拿到请求响应信息
				String str = EntityUtils.toString(response.getEntity(),"utf-8");
				json = JSONObject.parseObject(str);
			}

		} catch (ClientProtocolException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}

		return json;
	}

	@Bizlet("")
	public static String doPost(String url,String jsonData){
		HttpPost post = new HttpPost(url);
		HttpClient client = new DefaultHttpClient();
		HttpResponse response;
		//JSONObject json = null;
		//封装post请求数据
		String result = null;
		try {
			StringEntity entity = new StringEntity(jsonData);
			post.setEntity(entity);
			response = client.execute(post);
			if(response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
				//得到响应信息
				result = EntityUtils.toString(response.getEntity(),"UTF-8");
				//json = JSONObject.parseObject(str);

			}
		} catch (UnsupportedEncodingException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		} catch (IOException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}

		return result;
	}
}
