<%@include file="/common/sysCommon.jsp"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%
	String openid = request.getParameter("openid");

 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-14 12:00:36
  - Description:
-->
<head>
<title>首页</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body>



	<script type="text/javascript">
    	nui.parse();
    	$(function(){
    		var openid="<%=openid %>";
    		var pathapi=apiPath+wechatApi;
    		var pathweb=webPath+wechatDomain;
    		
    		var json=nui.encode({openId:openid});
    		nui.ajax({//http://qxy60.hszb.harsons.cn/wechatApi  http://ppwq72ty36.51http.tech/default
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryUserStoreCarGetOpenid.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					if(text.userData.length > 0 ){
						var userData=text.userData[0];
						//window.location.href="http://18u3m92012.imwork.net/loginHome?userId="+userData.userId+"&userPhone="+userData.userPhone+"&guestId="+userData.guestId+"&openid="+openid;
						window.location.href="http://tomato.harsonserver.com/loginHome?userId="+userData.userId+"&userPhone="+userData.userPhone+"&guestId="+userData.guestId+"&openid="+openid;
					}else{
						var userNo=text.userNo[0];
						http://tomato.harsonserver.com
						//window.location.href="http://18u3m92012.imwork.net/default/mapLocation?openid="+openid+"&userId="+userNo.userId;
						window.location.href="http://tomato.harsonserver.com/default/mapLocation?openid="+openid+"&userId="+userNo.userId;
					}
					
					
				}
			});
    	});
    	
    </script>
</body>
</html>