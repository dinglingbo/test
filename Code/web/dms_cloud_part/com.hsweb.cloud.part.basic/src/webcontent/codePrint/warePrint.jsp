<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): Administrator
  - Date: 2019-03-21 14:37:32
  - Description:
-->
<head>
<title>仓位打印页面</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
    <style>
		body {margin-left: 0px;margin-top: 0px;margin-right: 0px;margin-bottom: 0px;overflow: hidden;}
	</style>
</head>
<body>
	
     <iframe id="ifr" src="" onload="" width="100%" height="100%" frameborder="0" scrolling="auto"></iframe>


	<script type="text/javascript">
    	nui.parse();
    	var baseUrl = apiPath + cloudPartApi + "/";
    	var pathUrl=  baseUrl +"com.hsapi.cloud.part.baseDataCrud.cang.printPath.biz.ext";
		$(document).ready(function(v) {			
			setSrc();
		});
		
		function setSrc(){
			$.ajaxSettings.async = false;
			$.post(pathUrl+"?agency_id="+currAgencyId+"&token="+token,{},function(text){
		   		var data=text.data;
		   		var path= data.ware;
		   		$('#ifr').attr("src",path);
    		});
		
		}
    </script>
</body>
</html>