package com.hs.common;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import com.eos.system.annotation.Bizlet;

public class BmwPartsGrab {

	/**
	 * 绕过验证
	 * 
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws KeyManagementException
	 */
	private static SSLContext createIgnoreVerifySSL()
			throws NoSuchAlgorithmException, KeyManagementException {
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

	/**
	 * 模拟请求
	 * 
	 * @param url
	 *            资源地址
	 * @param map
	 *            参数列表
	 * @param encoding
	 *            编码
	 * @return
	 * @throws NoSuchAlgorithmException
	 * @throws KeyManagementException
	 * @throws IOException
	 * @throws ClientProtocolException
	 */
	@Bizlet("BMW Parts")
	public static String send(String url, Map<String, String> map,
			Map<String, String> header, String encoding)
			throws KeyManagementException, NoSuchAlgorithmException,
			ClientProtocolException, IOException {
		String body = "";
		// 采用绕过验证的方式处理https请求
		SSLContext sslcontext = createIgnoreVerifySSL();

		// 设置协议http和https对应的处理socket链接工厂的对象
		Registry<ConnectionSocketFactory> socketFactoryRegistry = RegistryBuilder
				.<ConnectionSocketFactory> create()
				.register("http", PlainConnectionSocketFactory.INSTANCE)
				.register("https", new SSLConnectionSocketFactory(sslcontext))
				.build();
		PoolingHttpClientConnectionManager connManager = new PoolingHttpClientConnectionManager(
				socketFactoryRegistry);
		HttpClients.custom().setConnectionManager(connManager);

		// 创建自定义的httpclient对象
		CloseableHttpClient client = HttpClients.custom()
				.setConnectionManager(connManager).build();
		// CloseableHttpClient client = HttpClients.createDefault();

		// 创建post方式请求对象
		HttpPost httpPost = new HttpPost(url);

		// 装填参数
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		if (map != null) {
			for (Entry<String, String> entry : map.entrySet()) {
				nvps.add(new BasicNameValuePair(entry.getKey(), entry
						.getValue()));
			}
		}
		// 设置参数到请求对象中
		httpPost.setEntity(new UrlEncodedFormEntity(nvps, encoding));

		//System.out.println("请求地址：" + url);
		//System.out.println("请求参数：" + nvps.toString());

		// 设置header信息
		// 指定报文头【Content-type】、【User-Agent】
		httpPost.setHeader("Content-type", "application/x-www-form-urlencoded");
		httpPost.setHeader("User-Agent",
				"Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
		if (header != null) {
			for (Map.Entry<String, String> e : header.entrySet()) {
				httpPost.setHeader(e.getKey(), e.getValue());
			}
		}

		// 执行请求操作，并拿到结果（同步阻塞）
		CloseableHttpResponse response = client.execute(httpPost);
		// 获取结果实体
		HttpEntity entity = response.getEntity();
		// Header[] hd = response.getAllHeaders();
		Header hd = response.getFirstHeader("location");
		if (hd != null) {
			String localtion = hd.getValue();
			if (localtion != null) {
				EntityUtils.consume(entity);
				response.close();
				url = url.replace("spp05_stock_check.htm", localtion);

				return send(url, null, header, "utf-8");
			}
		}

		if (entity != null) {
			// 按指定编码转换结果实体为String类型
			body = EntityUtils.toString(entity, encoding);
		}
		EntityUtils.consume(entity);
		// 释放链接
		response.close();
		
		if (body != null) {
			int start = body.indexOf("<form ");
			int end = body.lastIndexOf("</form>");
			body = body.substring(start, end);
		}
		return body;
	}

	public static void main(String[] args) throws IOException,
			KeyManagementException, NoSuchAlgorithmException {

		Map<String, String> createMap = new HashMap<String, String>();
		createMap.put("Authorization", "Basic MzgyNTZwYXI6MXFhejJ3c3g=");
		createMap.put("Cookie",
				"sap-usercontext=sap-language=ZH&sap-client=100");

		Map<String, String> header = new HashMap<String, String>();
		header.put("onInputProcessing", "atp_all");
		header.put("contentClip", "");
		header.put("req_date", "10.07.2018");
		header.put("material", "31316850441");//11427566327 31316850441 11340029751 11617530703 64319395930
		Integer x = (int) Math.random() * 10;
		Integer y = (int) Math.random() * 10;
		header.put("x", x.toString());
		header.put("y", y.toString());
		String url = "https://www.dwp.bmw-brilliance.cn/sap(bD1lbiZjPTEwMA==)/bc/bsp/bmw/gis_tp_par_dev/spp05_stock_check.htm";
		String xx = send(url, header, createMap, "utf-8");
		Utils.bmpPartsInfoProcess(xx);

	}

}
