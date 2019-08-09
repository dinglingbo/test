<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%@page import="java.io.*"%>
<%@page import="com.eos.web.taglib.util.*" %>
<%
    String activitionMean= request.getParameter("activitionMean");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-05-15 17:00:53
  - Description:
-->
<head>
<title>活动</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>



	<script type="text/javascript">
		nui.parse();
		var pathapi=apiPath+wechatApi;
		var pathweb=webPath+wechatDomain;
    	$(function(){
    		var json=nui.encode({dictName:"<%=activitionMean %>"});
    		nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryWeChatMenuDic.biz.ext?token="+token,
				type: 'POST',
				data: json,
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					if( text.dictDataArray.length > 0 ){
						var dictData = text.dictDataArray[0];
						window.location.href=dictData.dictUrl;
					}else{
						showMsg("此编码没有对应的菜单","W");
					}
					
				}
			});
    	});
    </script>
</body>
</html>