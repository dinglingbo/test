<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-10 17:37:06
  - Description:
-->
<head>
<title>添加好友</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/common/nui/jquery/jQuery-2.2.0.min.js?v=1.0.1"></script>
	<%@include file="/common/sysVarCommon.jsp" %>
<link href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/layui.css?v=1.0.11" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/layui.js?v=1.0.1"></script>
    <style type="text/css">
    	.yuan{width:80px;height:80px;border-radius:80px}
    </style>
</head>
<body>
<div >
<form class="layui-form" action="">
  <div class="layui-tab-item layui-show" style="margin-top: 20px;margin-left: 20px;height:80px">
	<input type="text" name="friend" id="groud" required  lay-verify="required" placeholder="请输入群昵称"  class="layui-input" style="width:340px;display: inline-block;margin-top:20px;margin-left: 10px;">
  </div>
</form>
</div>     
<script>
var baseUrl = apiPath + repairApi + "/";
var groupTemp = {};
function setData(group){
  
  
}

</script>
</body>
</html>