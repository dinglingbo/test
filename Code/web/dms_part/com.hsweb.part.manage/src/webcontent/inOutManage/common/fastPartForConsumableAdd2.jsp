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
    <script src="<%=webPath + contextPath%>/manage/js/inOutManage/common/fastPartForConsumableAdd2.js?v=1.1.28"></script>
    <style type="text/css">

   	#returnRemark.mini-textbox{
   		width: 310px;
   	}
   	#returnRemark.mini-textbox-border{
   		width:303px;
   	}
   	table{
   		margin-left:15px;
   	}
   	td{
   		padding-top:3px;
   	}
	.mini-listbox-view{
		height:105px !important;
	}
	#return1{
		border-top:black solid 1px;
	}

    </style>
</head>
<body>
<div class="nui-fit">
	<div style="margin-bottom:8px;" class="nui-form" id="form" style="width:100%; height:100%;">
		
		<table>
			<tr>
				<td style="padding-left: 13px;">配件编码:<input enabled="false" class="nui-textbox" id="partCode" name="partCode" type="text"></td>
				<td >配件名称:<input enabled="false" class="nui-textbox" id="partName" name="partName" type="text"></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td>配件品牌:<input enabled="false" class="nui-textbox" id="partBrandId" name="partBrandId" type="text"></td> -->
<!-- 				<td>适用车型:<input enabled="false" class="nui-textbox" id="applyCarModel" name="applyCarModel" type="text"></td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td style="padding-left: 26px;">数量:<input enabled="false" class="nui-textbox" id="stockQty" name="stockQty" type="text"></td> -->
<!-- 	<!-- 			<td><input class="nui-textbox" id="" name="" type="text"></td> --> 
<!-- 			</tr> -->
			<tr id="return"><td id="return1">请输入数量及归库人:</td></tr>
			<tr id="return">
				<td style="padding-left: 23px;">归库人:
					<input  name="returnMan"
                            id="mtAdvisorId"
                            class="nui-combobox"
                            textField="empName"
                            valueField="empName"
                            emptyText="请选择..."
                            url=""
                             required="true"
                            allowInput="true"
                            valueFromSelect="false"
                            popupHeight="90%"
                          />
				</td>
				<td>归库数量:<input enabled="false"  required="true" vtype="int" class="nui-textbox" id="outQty" name="outQty" type="text"></td>
			</tr>
			<tr id="return">
				<td style="" >归库原因ID:<input  class="nui-combobox" id="returnReasonId" name="returnReasonId" type="text"  popupHeight="85%"></td>
			</tr id="return">
			<tr id="return">
				<td style="padding-left: 13px;" colspan="2">归库原因:<input required="true"  class="nui-textarea" id="returnRemark" name="returnRemark" type="text" ></td>
			</tr id="return">
			<tr  id="return"align="center">
				<td  colspan="2">
				<a class="nui-button" iconCls="" plain="false" onclick="onOk()">归库</a>
				</td>
			</tr>
			
		</table>
	</div>
	</div>
</body>
</html>