<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>应收账款管理</title>
<%@include file="/common/sysCommon.jsp"%>
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />

</head>
<body>
	<form id="form1" method="post">
	
		<fieldset style="border: solid 1px #aaa; padding: 3px;">
			<legend>业务单据信息</legend>
			<div style="padding: 5px;">
				<input class="nui-hidden"name="id">
				<table>
					<tr>
						<td class="title" style="width:width2M ">入库日期 从：</td>
						<td><input class="nui-datepicker"name="guestFullName" style="width:width2M "/></td>
						<td class="title" style="width:width2M ">至：</td>
						<td><input class="nui-datepicker"name="guestFullName" style="width:width2M "/></td>
					</tr>

					<tr>
						<td class="title">供应商编码：</td>
						<td><input class="nui-textbox"  name="serviceCode"/></td>
						<td class="title">供应商拼音码：</td>
						<td ><input class="nui-textbox"  name="rpAmt"
							/></td>
					</tr>
					<tr>
						<td class="title">供应商名称：</td>
						<td colspan="3"><input class="nui-textbox width7_5"   name="recorder"/></td>
						
					</tr>
					<tr>
						<td class="title">商品编码：</td>
						<td><input class="nui-textbox"   name="rpAmtYes"/></td>
						<td class="title">商品拼音码：</td>
						<td><input class="nui-textbox"   name="rpAmtYes"/></td>
					</tr>
					<tr>
						<td class="title">配件名称：</td>
						<td colspan="3"><input class="nui-textbox width7_5"   name="recorder"/></td>
						
					</tr>
					<tr>
						<td class="title">配件类型：</td>
						<td colspan="3"><input class="nui-combobox width7_5"name="recorder"/></td>
						
					</tr>
					<tr>
						<td class="title">适应车款：</td>
						<td><input class="nui-combobox"name="recorder"/></td>
						<td class="title">品牌：</td>
						<td><input class="nui-combobox"name="recorder"/></td>
					</tr>
				</table>
			</div>
		</fieldset>
	
		<div style="text-align:center;padding:10px;">
	        <a class="nui-button" onclick="onOk" style="width:60px;">确定(O)</a>
	        <a class="nui-button" onclick="onCancel" style="width:60px;">取消(C)</a>
        </div>
	</form>
</body>
</html>