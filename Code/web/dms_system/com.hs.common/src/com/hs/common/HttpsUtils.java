package com.hs.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import com.alibaba.fastjson.JSONObject;
import com.eos.system.annotation.Bizlet;

public class HttpsUtils {
	/**
	 * 以POST方式发送JSON数据请求
	 * 
	 * @param urlParam
	 *            (Https)
	 * @param json
	 * @return
	 */
	@Bizlet("BMW Parts")
	public synchronized static String bmwPartsPost(Map<String, String> params,
			Map<String, String> header) {
		String url = "https://www.dwp.bmw-brilliance.cn/sap(bD1lbiZjPTEwMA==)/bc/bsp/bmw/gis_tp_par_dev/spp05_stock_check.htm";

		/*
		 * params.put("onInputProcessing", "atp_all"); params.put("contentClip",
		 * ""); params.put("req_date", "06.07.2018"); params.put("material",
		 * "01402982693");
		 * 
		 * Integer x=(int)Math.random()*10; Integer y=(int)Math.random()*10;
		 * params.put("x", x.toString()); params.put("y", y.toString());
		 */

		String result = HttpsUtils.sendHttpsPost(url, params, header);
		Map map = Utils.str2Map(result);
		try {
			map = (Map) map.get("headers");
			result = map.get("location").toString();
			if (result != null && result.indexOf("resultCode") < 0) {
				url = "https://www.dwp.bmw-brilliance.cn/sap(bD1lbiZjPTEwMA==)/bc/bsp/bmw/gis_tp_par_dev/SPP05_Stock_RESULT.htm?sap-params=bGZfbWF0ZXJpYWw9MDAwMDAwMDAxNDAyOTgyNjkzJnJlcV9kYXRlPTA2LjA3LjIwMTgmcmVxX3J1bGU9JmVycl9kYXRlPSZyZXN1bHRfZGlzcGxheT1YJmxmX3ZpZXdfYWx0cGFydHM9";
				result = HttpsUtils.sendHttpsPost(url, null, header);
				/*
				 * System.out.println(); System.out.println(result);
				 */
				if (result != null && result.indexOf("resultCode") < 0) {
					int start = result.indexOf("<form ");
					int end = result.lastIndexOf("</form>");
					result = result.substring(start, end);
					/*
					 * System.out.println(); System.out.println(result);
					 */
					return result;
				}
			}
			return null;
		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}

	/**
	 * 以POST方式发送JSON数据请求
	 * 
	 * @param urlParam
	 *            (Https)
	 * @param json
	 * @return
	 */
	@Bizlet("Https Post")
	public static String sendHttpsPost(String urlParam,
			Map<String, String> params, Map<String, String> header) {

		StringBuffer resultBuffer = null;
		HttpsURLConnection con = null;
		OutputStreamWriter osw = null;
		BufferedReader br = null;
		// 发送请求
		try {
			HttpsURLConnection
					.setDefaultHostnameVerifier(new HttpsUtils().new NullHostNameVerifier());
			SSLContext sc = SSLContext.getInstance("TLS");
			sc.init(null, trustAllCerts, new SecureRandom());
			HttpsURLConnection
					.setDefaultSSLSocketFactory(sc.getSocketFactory());

			

			URL url = new URL(urlParam);
			con = (HttpsURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setInstanceFollowRedirects(false);//Redirects
			con.setRequestProperty("connection", "Keep-Alive"); 
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(true);

			con.setRequestProperty("Content-Type",
					"application/json;charset=UTF-8");
			con.setRequestProperty("accept", "application/json,text/plain,*/*");
			

			// BMW Params
			if (header != null) {
				for (Map.Entry<String, String> e : header.entrySet()) {
					con.setRequestProperty(e.getKey(), e.getValue());
				}
				/*
				 * con.setRequestProperty("Authorization",
				 * "Basic MzgyNTZwYXI6MXFhejJ3c3g=");
				 * con.setRequestProperty("Cookie",
				 * "sap-usercontext=sap-language=ZH&sap-client=100");
				 */}

			con.setConnectTimeout(10000);// 连接超时 单位毫秒
			con.setReadTimeout(10000);// 读取超时 单位毫秒
			if (params != null) {
				String json = JSONObject.toJSONString(params);
				osw = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
				osw.write(json);
				osw.flush();
			} else {
				params = new HashMap();
			}

			params.clear();
			// 读取返回内容
			if (con.getResponseCode() == 302) {
				Map headers = con.getHeaderFields();
		        Set<String> keys = headers.keySet();
		        for( String key : keys ){
		            String val = con.getHeaderField(key);
		            System.out.println(key+"    "+val);
		        }
				params.put("headers",
						JSONObject.toJSONString(con.getHeaderFields()));
			}
			if (con.getResponseCode() == 200) {
				resultBuffer = new StringBuffer();
				br = new BufferedReader(new InputStreamReader(
						con.getInputStream(), "UTF-8"));
				
				String temp;
				while ((temp = br.readLine()) != null) {
					resultBuffer.append(temp);
				}				
			}
			params.put("result", resultBuffer.toString());
			return JSONObject.toJSONString(params);
		} catch (Exception e) {
			e.printStackTrace();
			return "{\"resultCode\":\"999\", \"resultMsg\":\"" + e.getMessage()
					+ "\"}";
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

	/**
	 * 内部调用测试
	 * 
	 * @param urlParam
	 * @param json
	 * @return
	 */
	public static String sendPostByJsonInnerTest(String urlParam, String json) {
		StringBuffer resultBuffer = null;
		HttpURLConnection con = null;
		OutputStreamWriter osw = null;
		BufferedReader br = null;
		// 发送请求
		try {
			HttpsURLConnection
					.setDefaultHostnameVerifier(new HttpsUtils().new NullHostNameVerifier());
			SSLContext sc = SSLContext.getInstance("TLS");
			sc.init(null, trustAllCerts, new SecureRandom());
			HttpsURLConnection
					.setDefaultSSLSocketFactory(sc.getSocketFactory());

			URL url = new URL(urlParam);
			con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setDoInput(true);
			con.setUseCaches(true);
			con.setRequestProperty("Content-Type",
					"application/json;charset=UTF-8");
			con.setRequestProperty("accept", "application/json,text/plain,*/*");

			// 内部调用测试
			/*
			 * String timestamp = D.getTimestamp(); String userkey =
			 * "HSU1708MAP0956"; con.setRequestProperty("timestamp", timestamp);
			 * con.setRequestProperty("userkey", userkey);
			 * con.setRequestProperty("sign", MD5.getTestCrypt(timestamp,
			 * true));
			 */

			con.setConnectTimeout(10000);// 连接超时 单位毫秒
			con.setReadTimeout(10000);// 读取超时 单位毫秒
			if (json != null && json.length() > 0) {
				osw = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
				osw.write(json);
				osw.flush();
			}
			con.connect();  

			// 读取返回内容
			if (con.getResponseCode() == 200) {
				resultBuffer = new StringBuffer();
				br = new BufferedReader(new InputStreamReader(
						con.getInputStream(), "UTF-8"));
				String temp;
				while ((temp = br.readLine()) != null) {
					resultBuffer.append(temp);
				}
			}
			return resultBuffer.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return "{\"resultCode\":\"999\", \"resultMsg\":\"" + e.getMessage()
					+ "\"}";
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

	static TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
		@Override
		public void checkClientTrusted(X509Certificate[] chain, String authType)
				throws CertificateException {
			// TODO Auto-generated method stub
		}

		@Override
		public void checkServerTrusted(X509Certificate[] chain, String authType)
				throws CertificateException {
			// TODO Auto-generated method stub
		}

		@Override
		public X509Certificate[] getAcceptedIssuers() {
			// TODO Auto-generated method stub
			return null;
		}
	} };

	public class NullHostNameVerifier implements HostnameVerifier {
		/*
		 * (non-Javadoc)
		 * 
		 * @see javax.net.ssl.HostnameVerifier#verify(java.lang.String,
		 * javax.net.ssl.SSLSession)
		 */
		@Override
		public boolean verify(String arg0, SSLSession arg1) {
			// TODO Auto-generated method stub
			return true;
		}
	}

	public static void main(String[] args) throws IOException,
			KeyManagementException, NoSuchAlgorithmException {
		/*
		 * Map<String, String> createMap = new HashMap<String, String>();
		 * createMap.put("businessNo", "00000120170728001"); createMap
		 * .put("content",
		 * "{\"accInfo\":{\"reportDate\":\"2017-07-19 09:25:49\",\"reportNo\":\"JEFF072801\"},\"claimAttachments\":[{\"attachmentCategoryName\":\"车损照片\",\"attachmentId\":94491,\"attachmentName\":\"add.jpg\",\"attachmentUrl\":\"33020/5981d87f-5b5a-434f-85b1-0fc3a88457a4.jpg\"},{\"attachmentCategoryName\":\"其他1\",\"attachmentId\":94492,\"attachmentName\":\"white01.jpg\",\"attachmentUrl\":\"33020/9e3a7b7a-6242-4908-bec8-1ed260c621c8.jpg\"},{\"attachmentCategoryName\":\"测试\",\"attachmentId\":94493,\"attachmentName\":\"white02.jpg\",\"attachmentUrl\":\"33020/ed0ee794-8baf-4a91-b484-20f70a5f078b.jpg\"}],\"claimInfo\":{\"claimVersion\":\"E01\",\"repairOrderNo\":\"00000120170728001\",\"sourceType\":\"2\"},\"contact\":{\"senderName\":\"JEFF072801\",\"senderTelNo\":\"87654321\",\"vehicleOwnerName\":\"JEFF072801\",\"vehicleOwnerTelNo\":\"12345678\"},\"discountRate\":{\"electricianMachinistRate\":100,\"laborFeeManageRate\":100,\"manageRate\":100,\"managementFee\":0,\"multiPaintDiscountRate\":100,\"paintRate\":110,\"partType\":\"4S店价\",\"partTypeCode\":\"01\",\"sheetMetalRate\":90},\"feeTotal\":{\"deductionTotalLaborFee\":0,\"depreciation\":0,\"entireSalvage\":0,\"estimateAmount\":1453.14,\"laborFee\":1350,\"lossTotal\":1453.14,\"manageFee\":0.00,\"materialFee\":0,\"partFee\":103.14,\"rescueFee\":0,\"totalSalvage\":0},\"insuranceCompany\":{\"insuranceCompanyGroupCode\":\"30130\",\"insuranceCompanyGroupName\":\"0725保险公司\",\"insuranceCompanyName\":\"机构\"},\"lossItem\":{\"changeItems\":[{\"depreciation\":0,\"itemId\":140789,\"itemName\":\"散热器检修警示标签\",\"manualFlag\":\"0\",\"partFeeAfterDiscount\":103.14,\"partNo\":\"25328 0L000\",\"partQuantity\":1,\"recycleFlag\":\"0\",\"salvage\":0,\"unitPriceAfterDiscount\":103.14}],\"materialItems\":[],\"repairItems\":[{\"itemId\":140789,\"itemName\":\"散热器检修警示标签\",\"laborFeeAfterDiscount\":1350,\"laborFeeManageRate\":100,\"laborHour\":15,\"laborHourFee\":90,\"laborType\":\"B\",\"manualFlag\":\"0\",\"operationType\":\"04\",\"outerLaborFee\":0,\"outerRepairFlag\":\"0\",\"paintDiscountFlag\":\"0\",\"partNo\":\"25328 0L000\"}]},\"repairFacility\":{\"appraiserCode\":\"jeff@xl\",\"appraiserName\":\"jeffxl\",\"qualificationLevel\":\"01\",\"repairFacilityCode\":\"30124\",\"repairFacilityName\":\"test修理厂\",\"repairFacilityType\":\"01\"},\"vehicleInfo\":{\"baseInfo\":{\"brandModel\":\"XINHAO\",\"currentValue\":11,\"engineNo\":\"FADOINGJIHAO\",\"licenseFirstRegisterDate\":\"2017-07-27\",\"lossVehicleType\":\"标的车\",\"lossVehicleTypeCode\":\"01\",\"plateColor\":\"黑色\",\"plateColorCode\":\"02\",\"plateNo\":\"JEFF072801\",\"plateType\":\"小型汽车号牌\",\"plateTypeCode\":\"02\",\"purchasePrice\":12,\"usingType\":\"家庭自用\",\"usingTypeCode\":\"01\",\"vehicleBodyColor\":\"车身颜色\",\"vehicleCategory\":\"9座以下客车\",\"vehicleCategoryCode\":\"01\",\"vin\":\"11111111111111111\"},\"lossInfo\":{\"fuelRemain\":23,\"itemsInCar\":\"车内物品\",\"mileage\":12,\"subCollisionPoints\":\"1R\"},\"vehicleModel\":{\"country\":\"010\",\"vehicleManufMakeName\":\"北京现代\",\"vehicleSubModelName\":\"I30 2009款 1.6L 手动 豪享版\"}},\"workflow\":{\"estimateEndTime\":\"2017-07-28 09:31:24\",\"estimateStartTime\":\"2017-07-28 09:29:41\",\"workFlowNodeCode\":\"04\",\"workFlowNodeName\":\"定核损结束\"}}"
		 * ); createMap.put("partyId",
		 * "5322ef2908f4f1eb4895792e5e9e54a43a936c6a"); String
		 * httpOrgCreateTestRtn = HttpsUtils.sendPostByJson(
		 * "https://192.168.1.100:1722/claimInfoNotification",
		 * JSONObject.toJSONString(createMap)); System.out.println("result:" +
		 * httpOrgCreateTestRtn);
		 */

		// "https://www.dwp.bmw-brilliance.cn/sap(bD1lbiZjPTEwMA==)/bc/bsp/bmw/gis_tp_par_dev/spp05_stock_check.htm

		Map<String, String> createMap = new HashMap<String, String>();
		createMap.put("Authorization", "Basic MzgyNTZwYXI6MXFhejJ3c3g=");
		createMap.put("Cookie",
				"sap-usercontext=sap-language=ZH&sap-client=100");

		Map<String, String> header = new HashMap<String, String>();
		header.put("onInputProcessing", "atp_all");
		header.put("contentClip", "");
		header.put("req_date", "09.07.2018");
		header.put("material", "11001263381");
		Integer x = (int) Math.random() * 10;
		Integer y = (int) Math.random() * 10;
		header.put("x", x.toString());
		header.put("y", y.toString());
		String xx = bmwPartsPost(header, createMap);
		Utils.bmpPartsInfoProcess(xx);

	}

	
}
