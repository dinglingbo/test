/**
 * 
 */
package com.hs.settle;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.URLConnection;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import com.alibaba.fastjson.JSON;
import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IContextAttributable;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.system.annotation.Bizlet;
import com.google.gson.Gson;
import com.harsons.hscp.common.util.AESCoderUtils;
import com.harsons.hscp.common.util.SignUtils;
import com.harsons.hscp.common.util.StringUtils;
import com.hs.common.Env;
import com.hs.common.HttpUtils;
import com.hs.common.Utils;

/**
 * @author Administrator
 * @date 2018-12-04 19:30:41
 *
 */
@Bizlet("")
public class SettleOrder {

	@SuppressWarnings("unchecked")
	@Bizlet("")
	public static Map<String, Object> getToken(String apiid, String loginId, String password){
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SETTLEAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SETTLEAPI", envType);
		String url = apiurl + "hscp/auth/token";
		String param = "grant_type=password&app_id=" + apiid + "&login_id="+loginId+"&password="+password;

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
			conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数
			out.print(param);

			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应 new InputStreamReader(connection.getInputStream(), "UTF-8")
			in = new BufferedReader(
					new InputStreamReader(conn.getInputStream(), "UTF-8"));
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

		Gson gson = new Gson();
        Map<String, Object> map = new HashMap<String, Object>();
        map = gson.fromJson(result, map.getClass());
        Object code = map.get("code");
        if(code.equals(0)||code.equals(0.0)) {
        	Object obj = map.get("data");
            Map p = Utils.obj2Map(obj);
            String access_token = (String) p.get("access_token");
            
        	IMUODataContext muo = DataContextManager.current().getMUODataContext();
        	Map<String, Object> attrMap = muo.getUserObject().getAttributes();
        	attrMap.put("settAccessToken", access_token);
        	
        	//将结算中心access_token设置到muo
        	muo.getUserObject().setAttributes(attrMap);
        	
        	//System.out.println("access_token的值为:"+access_token);
        	
        }
        
		return map;
	}
	
	@Bizlet("")
	public static Map testQueryAccountsOrder(String url, String access_token, String apikey) {
		url = url + "hscp/pay/accounts";
		String result = "";
		try {
            URL urll = new URL(url);    //把字符串转换为URL请求地址
            HttpURLConnection connection = (HttpURLConnection) urll.openConnection();// 打开连接
            //addRequestProperty添加相同的key不会覆盖，如果相同，内容会以{name1,name2}
            //connection.addRequestProperty("from", "sfzh");  //来源哪个系统
            //setRequestProperty添加相同的key会覆盖value信息
            //setRequestProperty方法，如果key存在，则覆盖；不存在，直接添加。
            //addRequestProperty方法，不管key存在不存在，直接添加。
            //connection.setRequestProperty("user", "user");  //访问申请用户
            //InetAddress address = InetAddress.getLocalHost();
            //String ip = address.getHostAddress();//获得本机IP
            //connection.setRequestProperty("ip", ip);  //请求来源IP
            //connection.setRequestProperty("encry", "00000");
            //connection.setRequestProperty("设置请求头key", "请求头value");
            connection.setRequestProperty("Authorization", "Bearer " + access_token);
            connection.setRequestProperty("Api-Version", "1.0");
            connection.setRequestProperty("Call-Source", "PC");
            connection.connect();// 连接会话
            // 获取输入流
            BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
            String line;
            StringBuilder sb = new StringBuilder();
            while ((line = br.readLine()) != null) {// 循环读取流
                sb.append(line);
                result += line;
            }
            br.close();// 关闭流
            connection.disconnect();// 断开连接
            System.out.println(sb.toString());
            
            Gson gson = new Gson();
            Map<String, Object> map = new HashMap<String, Object>();
            map = gson.fromJson(result, map.getClass());
            
            return map;
            
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("失败!");
        }

		return null;
	}
	
	@Bizlet("")
	public static Map createOrder(String access_token, String apikey, String businessNo,
			String businessType, String companyId, String customerId, String customerName,
			String invoiceType, String payMethod, String receiptAmount, String receiptNo,
			String receiptSummary) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SETTLEAPI", "serverType");
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SETTLEAPI", envType);
		String url = apiurl + "hscp/pay/orders";
		Map<String, String> map = new HashMap<String, String>();
		map.put("businessNo", businessNo);
		map.put("businessType", businessType);
		map.put("companyId", companyId);
		map.put("customerId", customerId);
		map.put("customerName", customerName);
		map.put("invoiceType", invoiceType);
		map.put("payMethod", payMethod);
		map.put("receiptAmount", receiptAmount);
		map.put("receiptNo", receiptNo);
		map.put("receiptSummary", receiptSummary);
		
		JSONObject json = JSONObject.fromObject(map);
		
		String sortData = StringUtils.sortJoin(map, "&");
		
		String data = AESCoderUtils.encryptBase64(json.toString(), apikey);
		String ts = String.valueOf(System.currentTimeMillis());
		Map<String, String> mapSign = new HashMap<String, String>();
		mapSign.put("encrypted_data", data);
		mapSign.put("timestamp", ts);
		
		String sign = SignUtils.sign(mapSign, apikey);
		
		System.out.println("参数编码data的值为:"+data);
		System.out.println("参数编码sign的值为:"+sign);
		System.out.println("参数编码timestamp的值为:"+ts);
		
		String decodeData = AESCoderUtils.decryptBase64(data, apikey);
		System.out.println("参数编码data解密decodeData的值为:"+decodeData);
		
		String param = "encrypted_data="+data+"&sign=" + sign + "&timestamp="+String.valueOf(System.currentTimeMillis());

		
		String jsonstr1 = "{\r\n" + 
                "            \"encrypted_data\": \""+data+"\",\r\n" +
                "            \"sign\": \""+sign+"\",\r\n" +  
                "            \"timestamp\": "+ts+"\r\n" +  
                "        }";
		
		System.out.println("======jsonstr1...======" + jsonstr1);
		
		
		try {
            URL urll = new URL(url);
            // 将url 以 open方法返回的urlConnection  连接强转为HttpURLConnection连接  (标识一个url所引用的远程对象连接)
            // 此时cnnection只是为一个连接对象,待连接中
            HttpURLConnection connection = (HttpURLConnection) urll.openConnection();
            // 设置连接输出流为true,默认false (post 请求是以流的方式隐式的传递参数)
            connection.setDoOutput(true);
            // 设置连接输入流为true
            connection.setDoInput(true);
            // 设置请求方式为post
            connection.setRequestMethod("POST");
            // post请求缓存设为false
            connection.setUseCaches(false);
            // 设置该HttpURLConnection实例是否自动执行重定向
            connection.setInstanceFollowRedirects(true);
            // 设置请求头里面的各个属性 (以下为设置内容的类型,设置为经过urlEncoded编码过的from参数)
            // application/x-javascript text/xml->xml数据 application/x-javascript->json对象 application/x-www-form-urlencoded->表单数据
            // ;charset=utf-8 必须要，不然妙兜那边会出现乱码【★★★★★】
            //addRequestProperty添加相同的key不会覆盖，如果相同，内容会以{name1,name2}
            //connection.addRequestProperty("from", "sfzh");  //来源哪个系统
            //setRequestProperty添加相同的key会覆盖value信息
            //setRequestProperty方法，如果key存在，则覆盖；不存在，直接添加。
            //addRequestProperty方法，不管key存在不存在，直接添加。
            connection.setRequestProperty("user", "user");  //访问申请用户
            //InetAddress address = InetAddress.getLocalHost();
            //String ip = address.getHostAddress();//获得本机IP
            //connection.setRequestProperty("ip", ip);  //请求来源IP
            //connection.setRequestProperty("encry", "123456");
            connection.setRequestProperty("Content-Type", "application/json");//;charset=utf-8
            connection.setRequestProperty("Authorization", "Bearer " + access_token);
            connection.setRequestProperty("Api-Version", "1.0");
            connection.setRequestProperty("Call-Source", "PC");
            // 建立连接 (请求未开始,直到connection.getInputStream()方法调用时才发起,以上各个参数设置需在此方法之前进行)
            connection.connect();
            // 创建输入输出流,用于往连接里面输出携带的参数,(输出内容为?后面的内容)
            DataOutputStream dataout = new DataOutputStream(connection.getOutputStream());
            // 格式 parm = aaa=111&bbb=222&ccc=333&ddd=444
            //String parm = "username=zhagnsan&password=0000";
            //System.out.println("传递参数：" + parm);
            // 将参数输出到连接
            dataout.writeBytes(jsonstr1);
            // 输出完成后刷新并关闭流
            dataout.flush();
            dataout.close(); // 重要且易忽略步骤 (关闭流,切记!)
            System.out.println(access_token);
            // 连接发起请求,处理服务器响应  (从连接获取到输入流并包装为bufferedReader)
            BufferedReader bf = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
            String line;
            StringBuilder sb = new StringBuilder(); // 用来存储响应数据

            // 循环读取流,若不到结尾处
            while ((line = bf.readLine()) != null) {
                //sb.append(bf.readLine());
                sb.append(line).append(System.getProperty("line.separator"));
            }
            bf.close();    // 重要且易忽略步骤 (关闭流,切记!)
            connection.disconnect(); // 销毁连接
            String str = sb.toString();
            System.out.println(sb.toString());
            
            
            
            Gson gson = new Gson();
            Map<String, String> resultMap = new HashMap<String, String>();
            resultMap = gson.fromJson(str, map.getClass());
            //String result = resultMap.get("encrypted_data");
            //String resultDecodeData = AESCoderUtils.decryptBase64(result, apikey);
            //str = AESCoderUtils.decryptBase64(str, apikey);
    		//System.out.println("返回结果解密decodeData的值为:"+str);
    		
    		return resultMap;
        } catch (Exception e) {
            e.printStackTrace();
        }
		
		return null;
//		PrintWriter out = null;
//		BufferedReader in = null;
//		String result = "";
//		try {
//			URL realUrl = new URL(url);
//			// 打开和URL之间的连接
//			URLConnection conn = realUrl.openConnection();
//			// 设置通用的请求属性
//			conn.setRequestProperty("Content-Type", "application/json");
//			conn.setRequestProperty("Authorization", "Bearer " + access_token);
//			conn.setRequestProperty("Api-Version", "1.0");
//			conn.setRequestProperty("Call-Source", "PC");
//			//conn.setRequestProperty("X-Sign", sign);
//			//conn.setRequestProperty("X-timestamp", String.valueOf(System.currentTimeMillis()));
//			// 发送POST请求必须设置如下两行
//			conn.setDoOutput(true);
//			conn.setDoInput(true);
//			// 获取URLConnection对象对应的输出流
//			out = new PrintWriter(conn.getOutputStream());
//			// 发送请求参数
//			out.print(jsonstr1);
//
//			// flush输出流的缓冲
//			out.flush();
//			// 定义BufferedReader输入流来读取URL的响应
//			in = new BufferedReader(
//					new InputStreamReader(conn.getInputStream()));
//			String line;
//			while ((line = in.readLine()) != null) {
//				result += line;
//			}
//		} catch (Exception e) {
//			System.out.println("发送 POST 请求出现异常！" + e);
//			e.printStackTrace();
//		}
//		// 使用finally块来关闭输出流、输入流
//		finally {
//			try {
//				if (out != null) {
//					out.close();
//				}
//				if (in != null) {
//					in.close();
//				}
//			} catch (IOException ex) {
//				ex.printStackTrace();
//			}
//		}

		/*
		 * {
			  "msg": "成功",
			  "code": 0,
			  "sign": "dQvfldvBcv0DMSy0nrr9RsyRGEY=",
			  "encrypted_data": "j8QHM7e4Y6qnqzY5N5YBV/vx2mRQxUIPZpVNFRMP/i6fcfXasrbPSJwbsH6R+terU9a0ZKepaxJ7XKkzemWhjEb9o6vYpcb/tqYJgo+xLufQduVjYLLKdtq6JKs/7IaSg4LXCs7uOh3igtx4yP17zL5e1fey8VGrn7jNm6PIcs1R5GKJmJ8f84X6iXXtJkujUskHartGq1W4I1b0/c7yG2cUm5eAo6GNnToT+F9uSl90nsgqbRza9qFlB10fvW9G3aaIFN7OrQZtuOMGqeIbTC553un0aQUbMsLbS9Cp/qMgf6w6jzjgDm31qvDP4ncn2et3Ph5iK1Kc2pRceYjYACde7ZWKKxH6eyRO/ImeXYb9oLQLIqeXPFTzs6sl5rLAak2kitbiujLRRZtHj3hd3lbdZYhFh33I1iuCnwQ964K+RCZVPcQ/F8021ZWRg8yschJjyyfJAcmjGXLS2vIJevPj5WhUgF6aBG3hnLrAQgdUXmroBC0DFrxYlQ2NvxYkWjsV4xVHOi6aQbCMp0/qCw==",
			  "timestamp": 1543979549462
			}
		 * */
		
	}

	public static void main(String[] args) {
		String envType = Env.getContributionConfig("com.vplus.login",
				"cfg", "SETTLEAPI", "serverType");
		//envType = "TEST";
		String apiurl = Env.getContributionConfig("com.vplus.login",
				"cfg", "SETTLEAPI", envType);
		//apiurl = "http://14.23.35.18:8080/";
		String apiid = Env.getContributionConfig("com.vplus.login",
				"cfg", "SETTLEAPIID", envType);
		//apiid = "31370874921755649";
		String apikey = Env.getContributionConfig("com.vplus.login",
				"cfg", "SETTLEAPIKEY", envType);
		//apikey = "NAropsvXehl0SMLcKCRls0xo9WITiVkb";
		System.out.println(apiurl);
		/*System.out.println("======获取TOKEN开始======");
		testToken(apiurl, apiid);
		System.out.println("======获取TOKEN结束======");
		
		//System.out.println("======生成订单开始======");
		//testCreateOrder("http://14.23.35.18:8080/", "XlgA1b3NILJtkiL0XVz", apikey);
		//System.out.println("======生成订单结束======");
		
		testQueryAccountsOrder("http://14.23.35.18:8080/", "XlgA1b3NILJtkiL0XVz", apikey);
		*/
		
	}
}
