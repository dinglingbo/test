<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="java.io.*"%>
<%@page import="com.eos.web.taglib.util.*" %>
<%
	String activitionMean = request.getParameter("activitionMean");
	
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-05-14 15:38:58
  - Description:
-->
<head>
<title>登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="https://ps.faisys.com/js/comm/fai.min.js?v=300005090947"></script>
</head>
<body>
	<iframe name='hidden_frameOnly' id="hidden_frameOnly" frameborder="0" style="display:none;" ></iframe>
	<form id="showDataForm" method="post" target="hidden_frameOnly" action="http://www.beetobees.com/User/ajaxlogin.html" >
       	<input type="hidden" name="username" value="">
       	<input type="hidden" name="password" value="">
       	<input type="hidden" name="remember" value="">
    </form>
    <iframe id="firssetOne" name="my_ifram myframee" style="display:none;" height="540" width="100%" frameborder="0"        marginwidth="0" marginheight="0" scrolling="no" border="0"        src="http://www.beetobees.com/User/ajaxlogin.html" security="restricted"        sandbox="allow-forms allow-scripts allow-same-origin"></iframe>
    
    <form id="formLast" method="post" >
       	<input type="hidden" name="activitionMean" value="">
    </form>
    
    
	<script type="text/javascript">
		nui.parse();
		var pathapi=apiPath+wechatApi;
		var pathweb=webPath+wechatDomain;
		
		$(function(){
			$("#formLast").attr("action", pathweb+"/autoServiceSys/weChatActivities/activitiesUrl.jsp");
			$("[name='activitionMean']")[0].value = "<%=activitionMean %>";
			queryActivitiesAcct();
    	});
		
		//查询当前用户的活动账户
		function queryActivitiesAcct(){
			nui.ajax({
				url: pathapi+"/com.hsapi.wechat.autoServiceBackstage.weChatUsers.queryStoreActivitiesAcct.biz.ext?token="+token,
				type: 'POST',
				cache: false,
				async: false,
				contentType: 'text/json',
				success: function(text) {
					$("[name='username']")[0].value = text.cacct;
					$("[name='password']")[0].value = text.pwd;
					$("[name='remember']")[0].value = "no";
					saveReport();
				}
			});
		}
		
		function saveReport(){
			$("#showDataForm").submit();
			setInterval(function(){
				$("#formLast").submit();
			},500);
		}
		
		
    	
    </script>
</body>
</html>