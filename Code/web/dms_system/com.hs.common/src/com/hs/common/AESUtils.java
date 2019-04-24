/**
 * 
 */
package com.hs.common;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.eos.system.annotation.Bizlet;

/**
 * @author Administrator
 * @date 2019-04-23 20:07:13
 *
 */
@Bizlet("")
public class AESUtils {
	/**
     * 加密
     * @param content
     * @param password
     * @return
     */
    public static String AESEncode(String content, String password) {
        try {
            KeyGenerator keygen = KeyGenerator.getInstance("AES");
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");

            random.setSeed(password.getBytes());
            keygen.init(256, random);
            SecretKey original_key = keygen.generateKey();
            byte[] raw = original_key.getEncoded();

            SecretKey key = new SecretKeySpec(raw, "AES");
            Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.ENCRYPT_MODE, key);

            byte[] byte_encode = content.getBytes("utf-8");
            byte[] byte_AES = cipher.doFinal(byte_encode);
            String AES_encode = new String(new BASE64Encoder().encode(byte_AES));
            return AES_encode;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        //如果有错就返加nulll
        return null;
    }


    /**
     * 解密
     * @param content
     * @param password
     * @return
     */
    public static String AESDecode(String content, String password) {
        try {
            KeyGenerator keygen = KeyGenerator.getInstance("AES");
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
            random.setSeed(password.getBytes());
            keygen.init(256, random);
            SecretKey original_key = keygen.generateKey();

            byte[] raw = original_key.getEncoded();
            SecretKey key = new SecretKeySpec(raw, "AES");
            Cipher cipher = Cipher.getInstance("AES");

            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] byte_content = new BASE64Decoder().decodeBuffer(content);
            byte[] byte_decode = cipher.doFinal(byte_content);
            String AES_decode = new String(byte_decode, "utf-8");
            return AES_decode;
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        }
        return null;
    }


    //使其支持256位秘钥
    static {
        Field field = null;
        try {
            field = Class.forName("javax.crypto.JceSecurity").getDeclaredField("isRestricted");
            field.setAccessible(true);
            Field modifiersField = Field.class.getDeclaredField("modifiers");
            modifiersField.setAccessible(true);
            modifiersField.setInt(field, field.getModifiers() & ~Modifier.FINAL);
            field.set(null, java.lang.Boolean.FALSE);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //时间转换
    private static String dateFormat(Date date, String pattern) {
        if(date == null) {
            return "";
        }
        SimpleDateFormat format = new SimpleDateFormat(pattern);
        return format.format(date);
    }

    public static void main(String[] args) {
        /**
         *
         *  clientId   263a9ef3-702d-48a1-b50b-abcsb89fedXXX,说明：clientId不是登录返回的那个值，对商户来说一个确定的值，是申请之后睿信给商户的clientId
         *  carrierId  ruixinchangyin-compXX-X-test.m800-api.com
         *  aessecret  3e573c84-7241-4ece-b0d3-40b5faefde48
         */
        //String str = "263a9ef3-702d-48a1-b50b-abcsb89fedXXX"+"_"+"ruixinchangyin-compXX-X-test.m800-api.com"+"_"+ dateFormat(new Date(), "yyyy-MM-dd HH:mm:ss");
        String str = "263a9ef3-702d-48a1-b50b-b89f770c9934" + "_" + "ruixinchangyin-comphs-1-test.m800-api.com"+"_"+ dateFormat(new Date(), "yyyy-MM-dd HH:mm:ss");
    	System.out.println("state:" + str);
        String encryptString = AESEncode(str, "3e573c84-7241-4ece-b0d3-40b5faefde48");
        System.out.println("encryptString:"+encryptString );//encryptString加密之后的字符串
        String decryptString = AESDecode(encryptString, "3e573c84-7241-4ece-b0d3-40b5faefde48");
        System.out.println("decryptString:"+decryptString);//decryptString解密之后的字符串
    }

}
