/*
 * Copyright (c) JForum Team
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, 
 * with or without modification, are permitted provided 
 * that the following conditions are met:
 * 
 * 1) Redistributions of source code must retain the above 
 * copyright notice, this list of conditions and the 
 * following  disclaimer.
 * 2)  Redistributions in binary form must reproduce the 
 * above copyright notice, this list of conditions and 
 * the following disclaimer in the documentation and/or 
 * other materials provided with the distribution.
 * 3) Neither the name of "Rafael Steil" nor 
 * the names of its contributors may be used to endorse 
 * or promote products derived from this software without 
 * specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT 
 * HOLDERS AND CONTRIBUTORS "AS IS" AND ANY 
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, 
 * BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR 
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE 
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
 * OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER 
 * IN CONTRACT, STRICT LIABILITY, OR TORT 
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN 
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF 
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE
 * 
 * This file creation date: Mar 29, 2003 / 1:15:50 AM
 * The JForum Project
 * http://www.jforum.net
 */
package com.hs.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

//import net.jforum.exceptions.ForumException;

/**
 * Encodes a string using MD5 hashing
 * 
 * @author Rafael Steil
 * @version $Id: MD5.java,v 1.7 2006/08/23 02:13:44 rafaelsteil Exp $
 */
public class MD5 {
	/**
	 * Encodes a string
	 * 
	 * @param str
	 *            String to encode
	 * @return Encoded String
	 * @throws NoSuchAlgorithmException
	 */
	public static String crypt(String str) {
		if (str == null || str.length() == 0) {
			throw new IllegalArgumentException(
					"String to encript cannot be null or zero length");
		}

		StringBuffer hexString = new StringBuffer();

		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte[] hash = md.digest();

			for (int i = 0; i < hash.length; i++) {
				if ((0xff & hash[i]) < 0x10) {
					hexString.append("0"
							+ Integer.toHexString((0xFF & hash[i])));
				} else {
					hexString.append(Integer.toHexString(0xFF & hash[i]));
				}
			}
		} catch (NoSuchAlgorithmException e) {
			// throw new ForumException("" + e);
		}

		return hexString.toString();
	}

	public static String getSign(String userCode, String key, String timestamp) {
		return MD5.crypt(userCode + key + timestamp);
	}

	public static Map checkSign(String sign, String userCode, String key,
			String timestamp) {
		Map p = new HashMap();
		if (timestamp == null || sign == null) {
			p.put("msg", "参数非法!");
			p.put("code", "ERROR");
			return p;
		} else {
			try {
				Date d = new Date();
				Long c1 = Long.valueOf(timestamp);
				Long c2 = d.getTime();
				if (c2 - c1 > 10) {
					p.put("msg", "timestamp已过期：" + timestamp);
					p.put("code", "ERROR");
					return p;
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				p.put("msg", "timestamp验证失败：" + timestamp);
				p.put("code", "ERROR");
				return p;
			}
		}

		Boolean flg = sign.equals(MD5.getSign(userCode, key, timestamp));
		if (flg) {
			p.put("msg", "验证成功！");
			p.put("code", "SUCCESS");
		} else {
			p.put("msg", "验证失败！");
			p.put("code", "ERROR");
		}
		return p;

	}

	/**
	 * 生产环境密钥
	 * 
	 * @param timestamp
	 * @param append2b
	 * @return
	 */
	public static String getProdCrypt(String timestamp) {
		String user_key = "HSU1708MAP0956";
		String security_key = "C27MK4BMD7GBE2";
		StringBuffer result = new StringBuffer();

		result.append(MD5.crypt(user_key + timestamp + security_key));
		return result.toString();

	}

	/**
	 * 测试环境密钥
	 * 
	 * @param timestamp
	 * @param append2b
	 * @return
	 */
	public static String getTestCrypt(String timestamp) {
		String user_key = "HSU1708MAP0956";
		String security_key = "MC2BED727KMG4B";
		StringBuffer result = new StringBuffer();

		result.append(MD5.crypt(user_key + timestamp + security_key));
		return result.toString();
	}

	public static void main(String[] args) {
		Date d = new Date();
		Long tsp = d.getTime();
		String tms = tsp.toString();
		tms = "20100526125218";
		System.out.println(tms + " getTestCrypt：" + MD5.getTestCrypt(tms));
		System.out.println(tms + " getTestCrypt Append："
				+ MD5.getTestCrypt(tms));
	}
}
