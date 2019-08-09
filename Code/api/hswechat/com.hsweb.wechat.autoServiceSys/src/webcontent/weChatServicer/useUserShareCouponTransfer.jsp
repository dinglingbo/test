<%@include file="/common/sysCommon.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%	
		String couponCode=request.getParameter("couponCode");
    	System.out.println("couponCode:"+couponCode);
 %>
<html>
<!-- 
  - Author(s): 11017555
  - Date: 2018-10-08 10:25:05
  - Description:
-->
<head>
<title>领取优惠劵</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>


	<script type="text/javascript">
    	nui.parse();
    	$(function(){
    		var couponCode="<%=couponCode %>";
    		window.location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxd10b49dcb45e5591&redirect_uri=https%3a%2f%2fqxy60.hszb.harsons.cn%2fdms%2fautoServiceSys%2fweChatServicer%2fuseUserShareCoupon.jsp%3fcouponCode%3d"+couponCode+"&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
    	});
    </script>
</body>
</html>


