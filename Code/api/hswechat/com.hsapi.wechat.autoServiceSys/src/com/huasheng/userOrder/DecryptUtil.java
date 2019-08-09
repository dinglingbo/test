package com.huasheng.userOrder;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
public class DecryptUtil {
	/**
	 * 方法名称:TripleDES_CBC_Decrypt 
	 * 功能描述:
	 * 经过封装的三重DES / CBC解密算法
	 * @param sourceBuf
	 *            需要解密内容的字节数组
	 * @param deskey
	 *            KEY 由24位字节数组通过SecretKeySpec类转换而成。
	 * @param ivParam
	 *            IV偏转向量，由6位字节数组通过IvParameterSpec类转换而成。
	 * @return 解密后的字节数组
	 * @throws Exception
	 */
	public static byte[] TripleDES_CBC_Decrypt(byte[] sourceBuf,
			SecretKeySpec deskey, IvParameterSpec ivParam) throws Exception {

		byte[] cipherByte;
		// 获得Cipher实例，使用CBC模式。
		Cipher decrypt = Cipher.getInstance("TripleDES/CBC/PKCS5Padding");
		// 初始化加密实例，定义为解密功能，并传入密钥，偏转向量
		decrypt.init(Cipher.DECRYPT_MODE, deskey, ivParam);

		cipherByte = decrypt.doFinal(sourceBuf, 0, sourceBuf.length);
		// 返回解密后的字节数组
		return cipherByte;
	}
	/**
	 * 方法名称:encrypt 
	 * 功能描述: 
	 * 解密方法 
	 * @param xmlStr
	 *            需要解密的消息字符串
	 * @return 解密后的字符串
	 * @throws Exception
	 */
	public static String decrypt(String xmlStr) throws Exception {
		// base64解码
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] encBuf = null;
		try {
			encBuf = decoder.decodeBuffer(xmlStr);
		} catch (IOException e) {
			e.printStackTrace();
		}

		// 取密钥和偏转向量
		byte[] key = new byte[8];
		byte[] iv = new byte[8];
		getKeyIV(EncryptUtil.key, key, iv);

		SecretKeySpec deskey = new SecretKeySpec(key, "DES");
		IvParameterSpec ivParam = new IvParameterSpec(iv);

		// 使用DES算法解密
		byte[] temp = null;
		try {
			temp = DecryptUtil.DES_CBC_Decrypt(encBuf, deskey, ivParam);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 进行解密后的md5Hash校验
		byte[] md5Hash = null;
		try {
			md5Hash = EncryptUtil.MD5Hash(temp, 16, temp.length - 16);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 进行解密校检
		for (int i = 0; i < md5Hash.length; i++) {
			if (md5Hash[i] != temp[i]) {
				// System.out.println(md5Hash[i] + "MD5校验错误。" + temp[i]);
				throw new Exception("MD5校验错误。");
			}
		}

		// 返回解密后的数组，其中前16位MD5Hash码要除去。
		return new String(temp, 16, temp.length - 16, "utf-8");
	}
	/**
	 * 方法名称:getKeyIV 
	 * 功能描述:
	 * @param encryptKey
	 * @param key
	 * @param iv
	 */
	public static void getKeyIV(String encryptKey, byte[] key, byte[] iv) {
		// 密钥Base64解密
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] buf = null;
		try {
			buf = decoder.decodeBuffer(encryptKey);
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 前8位为key
		int i;
		for (i = 0; i < key.length; i++) {
			key[i] = buf[i];
		}
		// 后8位为iv向量
		for (i = 0; i < iv.length; i++) {
			iv[i] = buf[i + 8];
		}
	}
	/**
	 * 方法名称:DES_CBC_Decrypt 
	 * 功能描述:
	 * 经过封装的DES/CBC解密算法。
	 * @param sourceBuf
	 *            需要解密内容的字节数组
	 * @param deskey
	 *            KEY 由8位字节数组通过SecretKeySpec类转换而成。
	 * @param ivParam
	 *            IV偏转向量，由6位字节数组通过IvParameterSpec类转换而成。
	 * @return 解密后的字节数组
	 * @throws Exception
	 */
	public static byte[] DES_CBC_Decrypt(byte[] sourceBuf,
			SecretKeySpec deskey, IvParameterSpec ivParam) throws Exception {

		byte[] cipherByte;
		// 获得Cipher实例，使用CBC模式。
		Cipher decrypt = Cipher.getInstance("DES/CBC/PKCS5Padding");
		// 初始化加密实例，定义为解密功能，并传入密钥，偏转向量
		decrypt.init(Cipher.DECRYPT_MODE, deskey, ivParam);

		cipherByte = decrypt.doFinal(sourceBuf, 0, sourceBuf.length);
		// 返回解密后的字节数组
		return cipherByte;
	}
	public static void main(String[] args) throws Exception {
		System.out.println("Jt0LM0WyheJ FSOI1HjGIGx5u1f/M3tadaMb4foVTnM=".length());
		System.out.println(decrypt("Jt0LM0WyheJ+FSOI1HjGIGx5u1f/M3tadaMb4foVTnM="));
	}
}
