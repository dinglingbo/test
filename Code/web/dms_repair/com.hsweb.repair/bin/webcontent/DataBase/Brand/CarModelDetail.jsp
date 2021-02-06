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
<title>新增车型</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Brand/CarModelDetail.js?v=1.0.1"></script>
<style type="text/css">

table {
	table-layout: fixed;
	font-size: 12px;
}

.form_label {
	width: 60px;
	text-align: right;
}
</style>
</head>
<body>
        <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
<fieldset style="width: 94.8%; height: 67%; border: solid 1px #aaa; position: relative; margin: 5px 5px;">
	<div id="dataform1" class="form">
		<input name="id" class="nui-hidden"/>
		<input name="carBrandId" class="nui-hidden"/>
		<table style="width:100%;" class="nui-form-table">
			<tr>
				<td class="form_label"><span>品牌：</span></td>
				<td colspan="1">
					<input class="nui-textbox" name="carBrandName" id="carBrandName" width="100%" enabled="false"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">
					<span>厂商：</span>
				</td>
				<td colspan="1">
					<input class="nui-textbox" name="carFactoryName" id="carFactoryName" width="100%"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">
					<span>车系：</span>
				</td>
				<td colspan="1">
					<input class="nui-textbox" name="carSeriesName"  width="100%"/>
				</td>
			</tr>
			<tr>
				<td class="form_label">
					<span>品牌车型：</span>
				</td>
				<td colspan="1">
					<input class="nui-textbox" name="carModel" width="100%"/>
				</td>
			</tr>
		</table>
	</div>
</fieldset>
<!-- <div style="text-align: right; padding: 10px;"> -->
<!-- 	<a class="nui-button" onclick="onOk" style="margin-right: 20px;">保存（S）</a> -->
<!-- 	<a class="nui-button" onclick="onCancel">取消（C）</a> -->
<!-- </div> -->


</body>
</html>