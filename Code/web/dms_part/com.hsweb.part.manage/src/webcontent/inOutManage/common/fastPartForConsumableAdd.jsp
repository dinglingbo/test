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
    <script src="<%=webPath + contextPath%>/manage/js/inOutManage/common/fastPartForConsumableAdd.js?v=1.1.9"></script>
    <style type="text/css">

   	#remark.mini-textbox{
   		width: 306px;
   	}
   	#remark.mini-textbox-border{
   		width:300px;
   	}
   	table{
   		margin-left:15px;
   	}
   	td{
   		padding-top:3px;
   	}

    </style>
</head>
<body>
<div class="nui-fit">
	<div style="margin-bottom:8px;" class="nui-form" id="form" style="width:100%; height:100%;">
		
		<table>
			<tr>
				<td>配件编号:<input enabled="false" class="nui-textbox" id="partCode" name="partCode" type="text"></td>
				<td>配件名称:<input enabled="false" class="nui-textbox" id="partName" name="partName" type="text"></td>
			</tr>
			<tr>
				<td>配件品牌:<input enabled="false" class="nui-textbox" id="partBrandId" name="partBrandId" type="text"></td>
				<td>适用车型:<input enabled="false" class="nui-textbox" id="applyCarModel" name="applyCarModel" type="text"></td>
			</tr>
			<tr>
				<td style="padding-left: 26px;">数量:<input enabled="false" class="nui-textbox" id="stockQty" name="stockQty" type="text"></td>
	<!-- 			<td><input class="nui-textbox" id="" name="" type="text"></td> -->
			</tr>
			<tr><td>请输入数量及领料人:</td></tr>
			<tr>
				<td style="padding-left: 14px;">领料人:
					<input  name="pickMan"
                            id="mtAdvisorId"
                            class="nui-combobox"
                            textField="empName"
                            valueField="empId"
                            emptyText="请选择..."
                            url=""
                             required="true"
                            allowInput="true"
                            valueFromSelect="true"
                            showNullItem="true" nullItemText="请选择..."
                          />
				</td>
				<td>出库数量:<input class="nui-textbox" id="orderQty" name="orderQty" type="text"></td>
			</tr>
			<tr>
				<td style="padding-left: 27px" colspan="2">备注:<input  class="nui-textbox" id="remark" name="remark" type="text" ></td>
			</tr>
			<tr align="center">
				<td style="" colspan="2">
				<a class="nui-button" iconCls="" plain="false" onclick="onOk()">出库</a>
				</td>
			</tr>
		</table>
	</div>
	</div>
</body>
</html>