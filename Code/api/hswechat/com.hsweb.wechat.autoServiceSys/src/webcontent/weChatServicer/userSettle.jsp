<%@include file="/common/sysCommon.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	
        //获取openid
	    String code =request.getParameter("code");
		System.out.println("code:"+code);
		String appid="wxd10b49dcb45e5591";
		String secret="8f21ab04f3b9bc252d8dce64a6d055e4";
		String getOpenid="";
	    System.out.println(code);
	    if (code != null){
	        //获取openid和access_token的连接
	        StringBuffer result = new StringBuffer(); //用来接受返回值
			URLConnection connection = null; //创建的http连接
			URL httpUrl = null; //HTTP URL类 用这个类来创建连接
			BufferedReader bufferedReader = null; //接受连接受的参数
	        String getOpenIdUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=APPID&secret=APPSECRET&code=CODE&grant_type=authorization_code";
	       	String requestUrl = getOpenIdUrl.replace("CODE", code);
	       	requestUrl = requestUrl.replace("APPID", appid);
	        requestUrl = requestUrl.replace("APPSECRET", secret);
	        httpUrl=new URL(requestUrl);
			connection = httpUrl.openConnection();
			connection.connect();
			 bufferedReader = new BufferedReader(new InputStreamReader(connection.getInputStream(),"UTF-8"));
		        String line;
		        while ((line = bufferedReader.readLine()) != null) {
		            result.append(line);
		        }
	        System.out.println(result);
	        JSONObject jsStr = JSONObject.parseObject(result.toString());
	        String openid = jsStr.getString("openid");
	          getOpenid=openid;
		}
		String id=request.getParameter("id");
    	System.out.println("openid:"+getOpenid);
    	System.out.println("id:"+id);
    	
 %>
<html>
<!-- 
  - Author(s): 11017555
  - Date: 2018-10-08 10:25:05
  - Description:
-->
<head>
<title>车道车服</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>


	<script type="text/javascript">
    	nui.parse();
    	$(function(){
    		var openid="<%=getOpenid %>";
    		var id="<%=id %>";
    		//window.location.href="http://18u3m92012.imwork.net/couponUse?couponArrayString="+couponArrayString+"&openid="+openid;
    		window.location.href="http://tomato.harsonserver.com/app/test-chedaoWeixin/settleMaitain?id="+id+"&openid="+openid;
    	});
    </script>
</body>
</html>