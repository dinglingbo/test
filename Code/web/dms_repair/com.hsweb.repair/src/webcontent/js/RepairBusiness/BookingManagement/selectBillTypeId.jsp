<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-25 11:01:42
  - Description:
-->
<head>
<title>选择开单类型</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
</head>
<body>
   <div class="nui-fit" style=" width: 100%;  ">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;"></div>
   <div align="center">
    <form name="from1" id="form1" >
    
      <label style="font-size:12px; " >
          <input type="radio" style="vertical-align:middle; margin-top:-2px; margin-bottom:1px;" name="orderType" id="timeraido" value="1" checked="true">综合开单   
      </label><br>
      <label style="font-size:12px;">   
          <input type="radio" style="vertical-align:middle; margin-top:-2px; margin-bottom:1px;" name="orderType" id="timeraido" value="2">洗车开单 
      </label><br>
      <label style="font-size:12px;">   
          <input type="radio" style="vertical-align:middle; margin-top:-2px; margin-bottom:1px;" name="orderType" id="timeraido" value="2">理赔开单 
      </label>
	</form>
	</div>
    <div style="text-align:center;padding:10px;">
	    <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
	    <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>
   </div>

 </div>
	 <script type="text/javascript">
    	nui.parse();
     </script>
</body>
</html>