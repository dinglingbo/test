package com.hsapi.system.config;

import sun.misc.BASE64Encoder;

import com.eos.system.annotation.Bizlet;

public class Base64 {
	public static void main(String[] args) {
		System.out.println("加密后的字符串：");
	}

	/* base 64加密字符串 */
	@Bizlet("")
	public static String jdkBase64(String str) {
		// JDKBase64位加密
		// 被加密的对象格式必须是 “loginName:passWord”, 例：38256par:1QAZ2WSX
		BASE64Encoder encoder = new BASE64Encoder();
		String encode = encoder.encode(str.getBytes());
		return encode;
	}
	@Bizlet("")
	public String lower(String c){
		//将密码转换为小写
		return c.toLowerCase();
	}
	@Bizlet("")
	public String addStr(String a, String b){
		//拼接字符串
		return (a+b);
	}
}
