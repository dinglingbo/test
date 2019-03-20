/**
 * 
 */
package com.hs.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.eos.system.annotation.Bizlet;

/**
 * @author Administrator
 * @date 2019-03-18 12:12:54
 *
 */
@Bizlet("电商注册")
public class SignInDs {
	
	@Bizlet("注册电商")
	public static String signInDs(String companyId,String company,String mobile) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SRMAPI", envType);
		String urlParam =apiurl + "jpWeb/f/api/LaneElectricity/register";
				//apiurl + "srm/router/rest?token="+access_token;
//		String urlParam = "http://srm.hszb.harsons.cn/srm/router/rest?token="+access_token;
		Map main = new HashMap();   
		main.put("companyId", companyId);
		main.put("company", company);  
		main.put("mobile", mobile);  
		
		JSONObject jsonObj = JSONObject.fromObject(main);
		String json = jsonObj.toString();
		
		String msg = sendPostByJson(urlParam, json);
		return msg;	
	}
	
	
	private static String sendPostByJson(String urlParam, String json) {
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

			con.setConnectTimeout(60000);// 连接超时 单位毫秒
			con.setReadTimeout(60000);// 读取超时 单位毫秒
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
	
}
