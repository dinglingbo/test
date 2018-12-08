package com.harsons.hscp.common.util;

import java.util.Base64;
import java.util.Map;

import org.apache.commons.codec.digest.HmacAlgorithms;
import org.apache.commons.codec.digest.HmacUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class SignUtils {
    
    public static String sign(String signData, String signKey) {
        byte[] hmacBytes = new HmacUtils(HmacAlgorithms.HMAC_SHA_1, signKey).hmac(signData);
        byte[] base64Bytes = Base64.getEncoder().encode(hmacBytes);
        return new String(base64Bytes);
    }
    
    public static String sign(Map<?, ?> signData, String signKey) {
        if (signKey == null || signKey.isEmpty()) return null;
        // 内容为空，也可以
        String signStr = StringUtils.sortJoin(signData, "&");
        return sign(signStr, signKey);
    }
    
    public static Boolean verify(String signData, String signKey, String sign){
        String retsign = sign(signData, signKey);
        return retsign != null && retsign.equals(sign);
    }
    
    public static Boolean verify(Map<?, ?> signData, String signKey, String sign){
        String retsign = sign(signData, signKey);
        return retsign != null && retsign.equals(sign);
    }
    
    public static void main(String[] args) {
        String key = "NAropsvXehl0SMLcKCRls0xo9WITiVkb";
        
        String jsonstr1 = "{\r\n" + 
                "            \"msg\": \"成功\",\r\n" + 
                "            \"code\": 0,\r\n" + 
                "            \"data\": {\r\n" + 
                "                \"access_token\": \"glqrpmoYp1YsK9FMbkV\",\r\n" + 
                "                \"app_id\": 28378403702864386,\r\n" + 
                "                \"expires_in\": 1440,\r\n" + 
                "                \"refresh_token\": \"nzyfdM8UJrpsXk2QtMx\",\r\n" + 
                "                \"scope\": [\r\n" + 
                "                    \"user\",\r\n" + 
                "                    \"photo\"\r\n" + 
                "                ],\r\n" + 
                "                \"acope\": [\r\n" + 
                "                    {\r\n" + 
                "                      \"c\": 232323,  \r\n" +
                "                      \"a\": 3444 \r\n " +
                "                    },\r\n" + 
                "                    {\r\n" + 
                "                      \"d\": 232323,  \r\n" +
                "                      \"a\": 3444, \r\n " +
                "                      \"c\": 3444 \r\n " +
                "                    }\r\n" + 
                "                ]\r\n" + 
                "            }\r\n" + 
                "        }";
        JSONObject jsonobj1 = JSON.parseObject(jsonstr1);
        System.out.println("sign data: " + StringUtils.sortJoin(jsonobj1, "&"));
        System.out.println("sign: " + sign(jsonobj1, key));
        
        String jsonstr2 = "{\n" +
                "\"encrypted_data\":\"mVrKB1qGofXWMeyqJazXlFN+tzVD2u9o3rUcmWNp7HB4MGhOWh7D7cxZ6P/5DwElIXwL4/im3yrJCcTAIajaFgArMG4ljDfy+B7z/PXHbkykFVyxmPUxeg7yEYPu0I1WV2FJ2NjH12SGdlZwvYGQZKeEsYFIjcsDx/F7tygxt1q66LESZTdUR0ttBzf4b0+O5dAuoY9divNcnPSABUINcASSuFMIac1JJC+oRthUBs9QdvBeiPp6BNXUsRTFViq8I+4QF0VsElpFC66QGtHIhIp5B2drp79w8/O+2ysQHAc=\"\n" +
                "}";
        JSONObject jsonobj2 = JSON.parseObject(jsonstr2);        
        System.out.println("sign data: " + StringUtils.sortJoin(jsonobj2, "&"));
        System.out.println("sign: " + sign(jsonobj2, key));
        
        System.out.println("timestamp: " + String.valueOf(System.currentTimeMillis()));
    }
}
