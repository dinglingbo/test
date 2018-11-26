/**
 * @Filename: RSACoderUtils.java
 * @Author锛歝aiqf
 * @Date锛�016-4-12
 */
package cn.harsons.hscp.common.util;

import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;

/**
 * @Class: RSACoderUtils.java
 * @Description: RSA加解密类
 * @Author：caiqf
 * @Date：2016-4-12
 */
public class  RSACoderUtils {
    public static final String KEY_ALGORITHM = "RSA";
    public static final String SIGNATURE_ALGORITHM = "MD5withRSA";
    private static final String PUBLIC_KEY = "RSAPublicKey";
    private static final String PRIVATE_KEY = "RSAPrivateKey";

    public static Map<String, Key> initKey() throws Exception {
        Map<String, Key> keyMap = new HashMap<>(2);
        KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance("RSA");
        keyPairGen.initialize(2048);
        KeyPair keyPair = keyPairGen.generateKeyPair();
        keyMap.put(PUBLIC_KEY, keyPair.getPublic());
        keyMap.put(PRIVATE_KEY, keyPair.getPrivate());
        return keyMap;
    }

    public static String getPrivateKey(Map<String, Object> keyMap)
            throws Exception {
        Key key = (Key) keyMap.get("RSAPrivateKey");
        return Base64.getEncoder().encodeToString(key.getEncoded());
    }

    public static String getPublicKey(Map<String, Object> keyMap)
            throws Exception {
        Key key = (Key) keyMap.get("RSAPublicKey");
        return Base64.getEncoder().encodeToString(key.getEncoded());
    }

    public static byte[] encryptByPrivateKey(byte[] data, String key)
            throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(key);

        PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        Key privateKey = keyFactory.generatePrivate(pkcs8KeySpec);

        Cipher cipher = Cipher.getInstance(keyFactory.getAlgorithm());
        cipher.init(1, privateKey);

        return cipher.doFinal(data);
    }

    public static byte[] decryptByPrivateKey(byte[] data, String key)
            throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(key);

        PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        Key privateKey = keyFactory.generatePrivate(pkcs8KeySpec);

        Cipher cipher = Cipher.getInstance(keyFactory.getAlgorithm());
        cipher.init(2, privateKey);

        return cipher.doFinal(data);
    }

    public static byte[] encryptByPublicKey(byte[] data, String key)
            throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(key);

        X509EncodedKeySpec x509KeySpec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        Key publicKey = keyFactory.generatePublic(x509KeySpec);

        Cipher cipher = Cipher.getInstance(keyFactory.getAlgorithm());
        cipher.init(1, publicKey);

        return cipher.doFinal(data);
    }

    public static byte[] decryptByPublicKey(byte[] data, String key)
            throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(key);

        X509EncodedKeySpec x509KeySpec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        Key publicKey = keyFactory.generatePublic(x509KeySpec);

        Cipher cipher = Cipher.getInstance(keyFactory.getAlgorithm());
        cipher.init(2, publicKey);

        return cipher.doFinal(data);
    }

    public static String sign(byte[] data, String privateKey) throws Exception {

        byte[] keyBytes = Base64.getDecoder().decode(privateKey);
        PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(keyBytes);

        KeyFactory keyFactory = KeyFactory.getInstance("RSA");

        PrivateKey priKey = keyFactory.generatePrivate(pkcs8KeySpec);

        Signature signature = Signature.getInstance("SHA1withRSA");
        signature.initSign(priKey);
        signature.update(data);

        return byte2hex(signature.sign());
    }

    public static boolean verify(byte[] data, String publicKey, String sign)
            throws Exception {
        byte[] keyBytes = Base64.getDecoder().decode(publicKey);

        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);

        KeyFactory keyFactory = KeyFactory.getInstance("RSA");

        PublicKey pubKey = keyFactory.generatePublic(keySpec);
        Signature signature = Signature.getInstance("SHA1withRSA");
        signature.initVerify(pubKey);
        signature.update(data);

        //sign 16进制转换成byte数组
        return signature.verify(hex2byte(sign));
    }

    public static String hexString2binaryString(String hexString) {
        if (hexString == null || hexString.length() % 2 != 0)
            return null;
        String bString = "", tmp;
        for (int i = 0; i < hexString.length(); i++) {
            tmp = "0000"
                    + Integer.toBinaryString(Integer.parseInt(hexString
                    .substring(i, i + 1), 16));
            bString += tmp.substring(tmp.length() - 4);
        }
        return bString;
    }

    private static byte[] hex2byte(String strhex) {
        if (strhex == null)
            return null;

        int l = strhex.length();
        if (l % 2 == 1)
            return null;

        byte[] b = new byte[l / 2];
        
        for (int i = 0; i != l / 2; ++i) {
            b[i] = (byte) Integer.parseInt(strhex.substring(i * 2, i * 2 + 2), 16);
        }
        
        return b;
    }

    private static String byte2hex(byte[] b) {
        String hs = "";
        String stmp = "";
        for (int n = 0; n < b.length; ++n) {
            stmp = Integer.toHexString(b[n] & 0xFF);
            if (stmp.length() == 1)
                hs = hs + "0" + stmp;
            else
                hs = hs + stmp;
        }

        return hs.toUpperCase();
    }

}
