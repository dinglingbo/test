
package cn.harsons.hscp.common.util;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Hex;

/**
 *  AES加解密类
 */
public class AESCoderUtils {
    private static String CIPHER_ALGORITHM = "AES/ECB/PKCS5Padding";
    private static String KEY_ALGORITHM = "AES";

    public static byte[] decrypt(byte[] content, String key) {
        if (content == null || key == null)
            throw new IllegalArgumentException("thie content or key is null");
        try {
            SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), KEY_ALGORITHM);
            Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, skeySpec);
            return cipher.doFinal(content);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    public static byte[] encrypt(String content, String key) {
        if (content == null || key == null)
            throw new IllegalArgumentException("thie content or key is null");
        try {
            SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), KEY_ALGORITHM);
            Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
            byte[] bytes = content.getBytes(StandardCharsets.UTF_8);
            return cipher.doFinal(bytes);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String decryptHex(String context, String key) {
        if (context == null) return null;
        try {
            byte[] bytes = Hex.decodeHex(context);
            byte[] ret = decrypt(bytes, key);
            return new String(ret, StandardCharsets.UTF_8);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String encryptHex(String context, String key) {
        byte[] bytes = encrypt(context, key);
        return Hex.encodeHexString(bytes);
    }

    public static String decryptBase64(String context, String key) {
        if (context == null) return null;
        try {
            byte[] bytes = Base64.getDecoder().decode(context);
            byte[] ret = decrypt(bytes, key);
            return new String(ret, StandardCharsets.UTF_8);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static String encryptBase64(String context, String key) {
        byte[] bytes = encrypt(context, key);
        return Base64.getEncoder().encodeToString(bytes);
    }

    public static void main(String[] args) {
        String jsonstr = "{\n" +
                "\"businessType\":\"ERP\",\n" +
                "\"businessNo\":\"123456\",\n" +
                "\"receiptNo\":\"E000049\",\n" +
                "\"receiptAmount\":0.01,\n" +
                "\"receiptSummary\":\"商品描述...\",\n" +
                "\"customerId\":\"789456\",\n" +
                "\"customerName\":\"测试\",\n" +
                "\"invoiceType\":0,\n" +
                "\"payMethod\":\"alipay\"\n" +
                "}";

        System.out.println("encrypt: " + encryptBase64(jsonstr, "NAropsvXehl0SMLcKCRls0xo9WITiVkb"));

        System.out.println (decryptBase64 ("ZqDoaTvxifG7DTvUCLrl7HDjsBme0bjt++WQ73YCz8BW9rEBLOgDvMEfZ9QU8FvIWaS7jm+qSFL38foNkuVnmrVm60MRyhJX1aOQcGCI++6co/c2s535fpBMrpaG3Uxd+TGojjHCuYBVtkpv83TAf+Te/cOKesj1ga8X1l1znUM/8gWMRf+1VfF2U+W+vGGQXFCWfEjUmu9rgM5Z7BD6tA==","NAropsvXehl0SMLcKCRls0xo9WITiVkb"));

    }
}
