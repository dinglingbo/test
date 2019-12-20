<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-12-20 09:24:16
  - Description:
-->
<head>
<title>项目复制</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    	<%@include file="/common/sysCommon.jsp"%>
   <script src="<%= request.getContextPath() %>/dataProcessing/js/itemCopy.js?v=1.0.2"></script>
       <style type="text/css">
    	.titel{
    		width: 20px;
    		height: 35px;
    	}
	
		a.btn {
		    background: #28bef0;
		    text-decoration: none;
		    display: inline-block;
		    height: 38px;
		    line-height: 38px;
		    padding: 0 22px;
		    border-radius: 5px;
		    color: #fff;
		    font-size: 15px;
		}
    </style>
    <div class="nui-fit" style="width: 100%;height: 100%;">
		<table style="width:100%;">
		       <tr>
	              <td style="width:70px;" align="right">原门店：</td>
	              <td colspan="1" style="width:50%"><input class="nui-textbox" style="width:80%;"  align="left" name="yorgid"  id="yorgid" /></td>
	           <tr>
	           <tr>
	              <td style="width:70px;" align="right">现门店：</td>
	              <td colspan="1" style="width:50%"><input class="nui-textbox" style="width:80%;"  align="left" name="xorgid"  id="xorgid" /></td>
	               <td align="left" ><a href="#" class="btn" itemid="0" onclick="itemCopy()">确认复制</a></td>
	           <tr>
	     </table>
	</div>
</head>
<body>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>