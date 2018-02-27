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
<title>车系</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Brand/CarSeriesDetail.js"  type="text/javascript"></script>
	
	<style type="text/css">
		.i {
			width:460px
		}
	</style>
</head>
<body style="margin: 0; padding: 0; overflow: hidden">
	<input name="id" class="nui-hidden" />
	<fieldset style="width: 95%; height: 65%; border: solid 1px #aaa; position: relative; margin: 5px 5px;">
		<div id="dataform1"  class="form">
			<table style="table-layout: fixed;" class="nui-form-table">
				<tr style="display: block; margin: 5px 0">
					<td class="form_label f" width="80px"><span
						style="color: #FF0000; margin-left: 10px;">品牌：</span></td>
					<td colspan="1"><input class="nui-textbox i"
						name="carBrandName"  /></td>
				</tr>
				<tr style="display: block; margin: 5px 0">
					<td class="form_label f" width="80px"><span
						style="color: #FF0000; margin-left: 10px;">厂商：</span></td>
					<td colspan="1"><input class="nui-textbox i"
						name="carFactoryName"  /></td>
				</tr>
				<tr style="display: block; margin: 5px 0">
					<td class="form_label f" width="80px"><span
						style="color: #FF0000; margin-left: 10px;">车系名称：</span></td>
					<td colspan="1"><input class="nui-textbox i" name="name"
						 /></td>
				</tr>
				<tr style="display: block; margin: 5px 0">
					<td class="form_label f" width="80px"><span
						style="color: #FF0000; margin-left: 10px;">备注：</span></td>
					<td colspan="1"><input class="nui-textbox i"
						name="remark"  /></td>
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