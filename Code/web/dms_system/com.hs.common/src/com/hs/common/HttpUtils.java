/**
 * 
 */
package com.hs.common;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;

/**
 * @author chenyy
 * @date 2016-07-06 10:19:35
 * 
 */
@Bizlet("Http工具类")
public class HttpUtils {

	/***
	 * 发送get请求
	 */
	@Bizlet("")
	public static String sendGet(String url, String param) {
		String result = "";
		BufferedReader in = null;
		try {
			String urlNameString = url
					+ ((param == null || (param.trim().length() == 0) ? ""
							: ("?" + param)));
			URL realUrl = new URL(urlNameString);
			// 打开和URL之间的连接
			URLConnection connection = realUrl.openConnection();
			// 设置通用的请求属性
			connection.setRequestProperty("accept", "*/*");
			connection.setRequestProperty("connection", "Keep-Alive");
			connection.setRequestProperty("user-agent",
					"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			// 建立实际的连接
			connection.connect();
			// 获取所有响应头字段
			Map<String, List<String>> map = connection.getHeaderFields();
			// 遍历所有的响应头字段
			for (String key : map.keySet()) {
				System.out.println(key + "--->" + map.get(key));
			}
			// 定义 BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(
					connection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送GET请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输入流
		finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}

	/**
	 * 向指定 URL 发送POST方法的请求
	 * 
	 * @param url
	 *            发送请求的 URL
	 * @param param
	 *            请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
	 * @return 所代表远程资源的响应结果
	 */
	public static String sendPost(String url, String param) {
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(url);
			// 打开和URL之间的连接
			URLConnection conn = realUrl.openConnection();
			// 设置通用的请求属性
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent",
					"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数

			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(
					new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			System.out.println("发送 POST 请求出现异常！" + e);
			e.printStackTrace();
		}
		// 使用finally块来关闭输出流、输入流
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}

	@Bizlet("")
	public static String sendPost(String urlParam, Map<String, Object> params) {
		String aa = JSONObject.toJSONString(params);
		return sendPostByJson(urlParam, aa);
	}

	@Bizlet("")
	public static HashMap<String, Object> sendPost2Map(String urlParam,
			HashMap<String, Object> params) {
		String aa = JSONObject.toJSONString(params);
		aa = sendPostByJson(urlParam, aa);
		try {
			params = JSONObject.parseObject(aa, HashMap.class);
		} catch (Exception e) {
			// TODO: handle exception
			params = new HashMap<String, Object>();
			params.put("result", aa);
			params.put("errCode", "Http_Send_Error");
		}
		return params;
	}

	/**
	 * @Description:使用HttpURLConnection发送post请求
	 * @author:liuyc
	 * @time:2016年5月17日 下午3:26:07
	 */
	@Bizlet("")
	public static String sendPost(String urlParam, Map<String, Object> params,
			String charset) {
		StringBuffer resultBuffer = null;
		StringBuffer sbParams = getParamFromMap(params);
		HttpURLConnection con = null;
		OutputStreamWriter osw = null;
		BufferedReader br = null;
		// 发送请求
		try {
			URL url = new URL(urlParam);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(false);
			con.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			if (sbParams != null && sbParams.length() > 0) {
				osw = new OutputStreamWriter(con.getOutputStream(), charset);
				osw.write(sbParams.substring(0, sbParams.length() - 1));
				osw.flush();
			}
			// 读取返回内容
			resultBuffer = new StringBuffer();
			// int contentLength = Integer.parseInt(con
			// .getHeaderField("Content-Length"));
			br = new BufferedReader(new InputStreamReader(con.getInputStream(),
					charset));
			String temp;
			while ((temp = br.readLine()) != null) {
				resultBuffer.append(temp);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			if (osw != null) {
				try {
					osw.close();
				} catch (IOException e) {
					osw = null;
					throw new RuntimeException(e);
				} finally {
					if (con != null) {
						con.disconnect();
						con = null;
					}
				}
			}
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					br = null;
					throw new RuntimeException(e);
				} finally {
					if (con != null) {
						con.disconnect();
						con = null;
					}
				}
			}
		}

		return resultBuffer.toString();
	}

	/**
	 * @param urlParam
	 * @param json
	 * @return
	 */
	@Bizlet("")
	public static String sendPostByJson(String urlParam, String json) {
		StringBuffer resultBuffer = null;
		HttpURLConnection con = null;
		OutputStreamWriter osw = null;
		BufferedReader br = null;
		// 发送请求
		try {
			URL url = new URL(urlParam);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(true);
			con.setRequestProperty("Content-Type",
					"application/json;charset=UTF-8");
			con.setRequestProperty("accept", "application/json,text/plain,*/*");

			con.setConnectTimeout(30000);// 连接超时 单位毫秒
			con.setReadTimeout(30000);// 读取超时 单位毫秒
			if (json != null && json.length() > 0) {
				osw = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
				osw.write(json);
				osw.flush();
			}

			// 读取返回内容
			if (con.getResponseCode() == 200) {
				resultBuffer = new StringBuffer();
				br = new BufferedReader(new InputStreamReader(
						con.getInputStream(), "UTF-8"));
				String temp;
				while ((temp = br.readLine()) != null) {
					resultBuffer.append(temp);
				}
			} else {
				System.out.println("con.getResponseCode = "
						+ con.getResponseCode());
			}
			return resultBuffer.toString();
		} catch (Exception e) {
			System.out.println("Access Error At:" + urlParam);
			e.printStackTrace();
			return "{\"resultCode\":\"Http_Send_Error\", \"resultMsg\":\""
					+ e.getMessage() + "\"}";
		} finally {
			if (osw != null) {
				try {
					osw.close();
				} catch (IOException e) {
					osw = null;
					throw new RuntimeException(e);
				} finally {
					if (con != null) {
						con.disconnect();
						con = null;
					}
				}
			}
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					br = null;
					throw new RuntimeException(e);
				} finally {
					if (con != null) {
						con.disconnect();
						con = null;
					}
				}
			}
		}
	}

	private static StringBuffer getParamFromMap(Map<String, Object> params) {
		// 构建请求参数
		StringBuffer sbParams = new StringBuffer();
		if (params != null && params.size() > 0) {
			for (Entry<String, Object> e : params.entrySet()) {
				sbParams.append(e.getKey());
				sbParams.append("=");
				sbParams.append(e.getValue());
				sbParams.append("&");
			}
		}
		return sbParams;
	}

	/**
	 * 功能：连接网络服务器，获取网上数据,我是用來獲取網上圖片的 参数：URL地址 返回：btye[]
	 * 
	 */
	@Bizlet("")
	public static byte[] getHttpToByteArray(String urlPath) {

		try {
			URL url = new URL(urlPath);
			HttpURLConnection connection = (HttpURLConnection) url
					.openConnection();
			connection.setRequestMethod("GET");
			connection.setConnectTimeout(8000);
			connection.setReadTimeout(8000);

			if (connection.getResponseCode() == 200) {
				InputStream inputStream = connection.getInputStream();
				byte[] data = readStream(inputStream).toByteArray();
				inputStream.close();
				return data;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 创建人：Guine 时间：2017-08-02 功能：连接网络服务器，获取网上数据 参数：URL地址 返回：string
	 * 
	 * @param urlPath
	 * @param params
	 *            <String, String>
	 * @return
	 */
	@Bizlet("")
	public static String getHttpByGet(String urlPath, Map<String, Object> params) {
		if (urlPath != null && urlPath.indexOf("?") < 0) {
			urlPath += "?";
		}
		urlPath += getParamFromMap(params).toString();
		return getHttpByJsonParam(urlPath, null, "GET");
	}

	/**
	 * @param urlPath
	 * @param params
	 *            <String, String>
	 * @return
	 */
	@Bizlet("")
	public static String getHttpByPost(String urlPath,
			Map<String, String> params) {
		return getHttpByJsonParam(urlPath, params, "POST");
	}

	public static String getHttpByFormParam(String urlPath,
			Map<String, Object> params, String method) {
		String result = null;
		try {
			URL url = new URL(urlPath);
			HttpURLConnection connection = (HttpURLConnection) url
					.openConnection();
			connection.setRequestMethod(method);
			connection.setConnectTimeout(8000);
			connection.setReadTimeout(8000);

			// connection.setRequestProperty("Content-type", "text/html");
			// connection.setRequestProperty("Content-type",
			// "application/json");

			// 数据塔原form提交方式
			connection.setRequestProperty("content-type",
					"application/x-www-form-urlencoded");

			connection.setRequestProperty("cache-control", "no-cache");
			connection.setRequestProperty("Accept-Charset", "utf-8");

			connection.setDoOutput(true);
			/* 设置容许输入 */
			connection.setDoInput(true);
			connection.connect();
			if (params != null && params.size() > 0) {

				OutputStreamWriter outStreamWriter = new OutputStreamWriter(
						connection.getOutputStream(), "UTF-8");
				outStreamWriter.write(getParamFromMap(params).toString());
				outStreamWriter.flush();
				outStreamWriter.close();
			}

			if (connection.getResponseCode() == 200) {
				InputStream inputStream = connection.getInputStream();
				result = new String(readStream(inputStream).toByteArray(),
						"UTF-8");
			}

			System.out.println("length：" + result.length());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("getHttpToString URL：" + urlPath);
		System.out.println("getHttpToString Result：" + result);
		return result;
	}

	private static String getHttpByJsonParam(String urlPath,
			Map<String, String> params, String method) {
		String result = null;
		try {
			URL url = new URL(urlPath);
			HttpURLConnection connection = (HttpURLConnection) url
					.openConnection();
			connection.setRequestMethod(method);
			connection.setConnectTimeout(8000);
			connection.setReadTimeout(8000);

			if (params != null && params.size() > 0) {
				for (Entry<String, String> e : params.entrySet()) {
					connection.setRequestProperty(e.getKey(), e.getValue());
				}
			}

			// connection.setRequestProperty("Content-type", "text/html");
			connection.setRequestProperty("Content-type", "application/json");
			connection.setRequestProperty("Accept-Charset", "utf-8");
			connection.setRequestProperty("contentType", "utf-8");
			if (connection.getResponseCode() == 200) {
				InputStream inputStream = connection.getInputStream();
				result = new String(readStream(inputStream).toByteArray(),
						"UTF-8");
			} else {
				System.out.println("getResponseCode："
						+ connection.getResponseCode());
			}

			System.out.println("length：" + result.length());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("getHttpToString URL：" + urlPath);
		System.out.println("getHttpToString Result：" + result);
		return result;
	}

	private static ByteArrayOutputStream readStream(InputStream inputStream) {
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int len = -1;
			while ((len = inputStream.read(buffer)) != -1) {
				out.write(buffer, 0, len);
			}
			out.close();
			inputStream.close();
			return out;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public static void main2(String args[]) {

		String url = "http://14.23.35.20:88/wbsystem/WBWebService.dll/WBLogin";
		Map<String, String> p = new HashMap<String, String>();
		p.put("LoginName", "000ysg");
		p.put("LoginPassword", "1");
		p.put("wb-ct", "3");
		url = getHttpByJsonParam(url, p, "GET");

		// 成功返回session id，类似：504FE69E8C9146B19624D93EBD2DEEDE
		// 失败返回：null

		// apiAuth Test
		url = "http://tapi.harsonserver.com/login/vlogin.json";
		url = "http://tapi.harsonserver.com/service/login";

		/*
		 * "loginName":"000ysg", "password":"1", "platform":"38",
		 * "clientId":"5907a7aa-e98b-41d0-bb51-cdeba086a995",
		 * "clientSecret":"067edd58-47ca-4922-ac9e-6dc700e18a8b"
		 */
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("loginName", "000ysg");
		params.put("password", "1");
		params.put("platform", "38");
		params.put("clientId", "5907a7aa-e98b-41d0-bb51-cdeba086a995");
		params.put("clientSecret", "067edd58-47ca-4922-ac9e-6dc700e18a8b");
		url = sendPost(url, params);

		/*
		 * Map<String, Object> p = new HashMap<String, Object>(); p =
		 * com.vplus.pub.JsonUtils.json2Map(url); p =
		 * JsonUtils.Json2HashMap(url);
		 */

		/*
		 * Map<String, Object> p2 = new HashMap<String, Object>(); url =
		 * getHttpByPost(url, params); p2=Utils.json2Token(url);
		 */
		System.out.println(url);

	}

	public static void main(String[] args) {
		/*String param = "http://127.0.0.1:8081/default/com.vplus.login.auth.setUserOrgInfo.biz.ext";
		Map p = new HashMap();
		p.put("loginName", "000ysg");
		p.put("posiId", null);
		p.put("roleName", null);
		String userOrgInfo = HttpUtils.sendPost(param, p);
		System.out.println("userOrgInfo 1");
		System.out.println(userOrgInfo);
		System.out.println("userOrgInfo 1");

		p = Utils.str2Map(userOrgInfo);
		Object obj = p.get("userObject");
		//Object obj = p.get("userAttr");
		UserObject u = new UserObject();
		if (obj != null) {
			// userOrgInfo=obj.toString();
			u = JSONObject.parseObject(obj.toString(), UserObject.class);
		}
		//p = JsonUtils.Json2HashMap(JsonUtils.obj2JsonObj(u.getAttributes()));
		String str2 = JSONObject.toJSONString(u.getAttributes());
		//String str2 = JUtils.serialize(u);
		System.out.println("userOrgInfo 2");
		System.out.println(str2);
		System.out.println("userOrgInfo 2");*/
		String as="http://tomato.harsonserver.com/app/todo/to-audit-detail?processinstid=56690&workitemid=231973&activityInstID=9509";
		System.out.println(as);
		try {
			System.out.println(URLEncoder.encode(as, "utf-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
		}		
	}
}