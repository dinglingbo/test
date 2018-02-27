<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 14:21:19
  - Description:
-->
<head>
<title>品牌</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script
	src="<%= request.getContextPath() %>/repair/js/DataBase/Brand/CarBrandDetail.js"  type="text/javascript"></script>

</head>
<body style="margin: 0; padding: 0; overflow: hidden">
	<fieldset style="width: 92.5%; height: 55%; border: solid 1px #aaa; position: relative; margin: 5px 5px;">
		<div id="dataform1"  class="form">
			<input name="id" class="nui-hidden" />
			<table style="table-layout: fixed;" class="nui-form-table">
				<tr style="display: block; margin: 10px 0">
					<td class="form_label" width="100px"><span
						style="color: #FF0000; margin-left: 20px;">品牌英文名：</span></td>
					<td colspan="1"><input class="nui-textbox"
						name="carBrandEn" width="230px" /></td>
				</tr>
				<tr style="display: block; margin: 10px 0">
					<td class="form_label" width="100px"><span
						style="color: #FF0000; margin-left: 20px;">品牌中文名：</span></td>
					<td colspan="1"><input class="nui-textbox"
						name="carBrandZh" width="230px" /></td>
				</tr>
			</table>
		</div>
	</fieldset>
	<div style="text-align: right; padding: 10px;">
		<a class="nui-button" onclick="onOk" style="margin-right: 20px;">保存（S）</a>
		<a class="nui-button" onclick="onCancel">取消（C）</a>
	</div>


	
</body>
</html>