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
    <script src="<%=webPath + contextPath%>/manage/js/inOutManage/common/fastPartForConsumableAdd.js?v=1.1.0"></script>
    <style type="text/css">

   	#remark.mini-textbox{
   		width: 360px;
   	}
   	#remark.mini-textbox-border{
   		width:303px;
   	}
   	table{
   		margin-left:15px;
   	}
   	td{
   		padding-top:3px;
   	}
	.mini-listbox-view{
		height:145px !important;
	}
	#out1{
		border-top:black solid 1px;
	}
	#qty{
		padding-bottom:5px;
	}

    </style>
</head>
<body>
<div class="nui-fit">
	
	<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
						<a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-cubes fa-lg"></span>&nbsp;领料</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('cancle')"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
	<div style="margin-bottom:8px;" class="nui-form" id="form" style="width:100%; height:100%;">
		
		<table>
			<tr>
				<td>配件编码:<input enabled="false" class="nui-textbox" id="partCode" name="partCode" type="text"></td>
				<td>配件全称:<input enabled="false" class="nui-textbox" id="fullName" name="fullName" type="text"></td>
			</tr>
			<tr>
				<td>配件品牌:<input enabled="false" class="nui-textbox" id="partBrandId" name="partBrandId" type="text"></td>
				<td>适用车型:<input enabled="false" class="nui-textbox" id="applyCarModel" name="applyCarModel" type="text"></td>
			</tr>
			<tr>
				<td id="qty" style="">库存数量:<input enabled="false" class="nui-textbox" id="stockQty" name="stockQty" type="text"></td>
	<!-- 			<td><input class="nui-textbox" id="" name="" type="text"></td> -->
			</tr>
			<tr><td  colspan="2" id="out1">请输入数量及领料人:</td></tr>
			<tr id="out">
				<td style="padding-left: 14px;">领料人:
					<input  name="pickMan"
                            id="mtAdvisorId"
                            class="nui-combobox"
                            textField="empName"
                            valueField="empName"
                            emptyText="请选择..."
                            url=""
                             required="true"
                            allowInput="true"
                            valueFromSelect="false"
                          />
  
				</td>
				<td>出库数量:<input required="true"  vtype="float;range:0.01,100000000" class="nui-textbox" id="outQty" name="outQty" type="text"></td>
			</tr>
			<tr id="out">
				<td style="" colspan="2">出库原因:<input required="false"  class="nui-textarea" id="remark" name="remark" type="text" ></td>
			</tr>
<!-- 			<tr id="out" align="center"> -->
<!-- 				<td colspan="2"> -->
<!-- 				<a class="nui-button" iconCls="" plain="false" onclick="CloseWindow('cancle')">关闭</a> -->
<!-- 				<a class="nui-button" iconCls="" plain="false" onclick="onOk()">出库</a> -->
<!-- 				</td> -->
<!-- 			</tr> -->
			
		</table>
	</div>
	</div>
</body>
</html>