package cn.harsons.hscp.common.util;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class Base64Utils {

    public static String encode(String text) {
        if (text == null || text.isEmpty())
            return text;

        byte[] bytes = text.getBytes(StandardCharsets.UTF_8);

        byte[] retbytes = Base64.getEncoder().encode(bytes);

        return new String(retbytes, StandardCharsets.UTF_8);
    }

    public static String decode(String text) {
        if (text == null || text.isEmpty())
            return text;

        byte[] bytes = Base64.getDecoder().decode(text);

        return new String(bytes, StandardCharsets.UTF_8);
    }

    public static String urlEncode(String text) {
        if (text == null || text.isEmpty())
            return text;

        byte[] bytes = text.getBytes(StandardCharsets.UTF_8);

        byte[] retbytes = Base64.getUrlEncoder().encode(bytes);

        return new String(retbytes, StandardCharsets.UTF_8);
    }

    public static String urlDecode(String text) {
        if (text == null || text.isEmpty())
            return text;

        byte[] bytes = Base64.getUrlDecoder().decode(text);

        return new String(bytes, StandardCharsets.UTF_8);
    }
}
