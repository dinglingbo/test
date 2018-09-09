<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonPart.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-09-08 16:10:16
  - Description:
-->
<head>
<title>领料出库</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/manage/js/inOutManage/common/fastPartForConsumableAdd.js?v=1.1.4"></script>
    <style type="text/css">
    div{
   		margin-bottom:8px; 	
   	}
    </style>
</head>
<body>
	<div class="nui-form" id="form" style="width:100%; height:100%;">
	
		<div align="center" style="width:100%;">			
			领料人:<input id="orderMan" name="orderMan" class="nui-textbox" />
		</div>
		<div  align="center" style="width:100%;">			
			备注:<input id="remark" name="remark" class="nui-textbox" />
		</div>
		<div  align="center" style="width:100%;">			
			出库数量:<input id="orderQty" name="orderQty" class="nui-textbox" />
		</div>
		<div align="center" style="width:100%;">			
			<a class="nui-button" iconCls=""  onclick="onOk" id="out"><span class=""></span>&nbsp;出库</a>
		</div>

	</div>


	
</body>
</html>