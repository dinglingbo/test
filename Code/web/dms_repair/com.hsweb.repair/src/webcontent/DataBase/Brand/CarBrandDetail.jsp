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
<title>新增品牌</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Brand/CarBrandDetail.js?v=1.0.2"></script>
<style type="text/css">

table {
	table-layout: fixed;
	font-size: 12px;
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
	<fieldset style="width: 92.5%; height: 55%; border: solid 1px #aaa; position: relative; margin: 5px 5px;">
		<div id="dataform1"  class="form">
			<input name="id" class="nui-hidden" />
			<table style="table-layout: fixed;" class="nui-form-table">
				<tr style="display: block; margin: 10px 0">
					<td class="form_label" width="100px"><span
						style="color: #FF0000; margin-left: 20px;">品牌英文名：</span></td>
					<td colspan="1"><input class="nui-textbox"
						name="carBrandEn"id="carBrandEn" width="230px" /></td>
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
<!-- 	<div style="text-align: center;"> -->
<!-- 		<a class="nui-button" onclick="onOk" style="margin-right: 20px;">保存</a> -->
<!-- 		<a class="nui-button" onclick="onCancel">取消</a> -->
<!-- 	</div> -->
</body>
</html>