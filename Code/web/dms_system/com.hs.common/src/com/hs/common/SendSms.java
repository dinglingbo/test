/**
 * 
 */
package com.hs.common;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;

import com.eos.system.annotation.Bizlet;

/**
 * @author Guine
 * @date 2018-05-22 10:59:55
 * 
 */
@Bizlet("")
public class SendSms {
	private static String USER_NAME = "admin";
	private static String PASSWORD = "123456@123456";

	public static void main(String[] args) {
		//report();  连不上
		//send("13288637205", "测试一下");
	}
	
	@Bizlet("")
	public static void setAccount(String userName, String passWord) {
		USER_NAME = userName;
		PASSWORD = passWord;
	}
	
	@Bizlet("")
	public static String send(String phones, String message) {
		HttpClient client = new HttpClient();
		PostMethod method = null;
		try {
			//http://yzh.tushi106.com:6062/webservices/sms?wsdl
			//http://yzh.tushi106.com:6062/public/sms.action
			method = new PostMethod(
					"http://yzh.tushi106.com:6062/public/sms.action");//http://m.tushi106.com:9000/public/sms.action
			String submitXml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><messages><account>"
					+ USER_NAME
					+ "</account><password>"
					+ PASSWORD
					+ "</password><message><phones>"
					+ phones
					+ "</phones><content>"
					+ message
					+ "</content><subcode></subcode><sendtime></sendtime></message></messages>";
			method.setRequestEntity(new StringRequestEntity(submitXml,
					"text/xml", "UTF-8"));
			client.executeMethod(method);
			String result = new String(method.getResponseBody(), "UTF-8");
			System.out.println(result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}finally{
			method.releaseConnection();
		}
	}

	@Bizlet("")
	public static void report() {
		HttpClient client = new HttpClient();
		PostMethod method = null;
		//http://yzh.tushi106.com:6062/webservices/sms?wsdl
		try {
			method = new PostMethod(
					"http://sms.jdcjsr.com/UpdateStatusSMS.aspx");
			String submitXml = "<reports><type>1</type><report><enterprise_id>1</enterprise_id><mobile>15081186864</mobile><seq>1/1</seq>		 <msg_id>d068e8c4-7337-4121-8fdb</msg_id><result>0</result><netway_code>DELIVRD</netway_code></report></reports>";
			method.setRequestEntity(new StringRequestEntity(submitXml,
					"text/xml", "UTF-8"));
			client.executeMethod(method);
			String result = new String(method.getResponseBody(), "UTF-8");
			System.out.println(result);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			method.releaseConnection();
		}
	}
}
