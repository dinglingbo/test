<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-23 15:07:01
  - Description:
-->
<head>
<title>新增、修改班组成员</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
	<script
	src="<%= request.getContextPath() %>/repair/js/DataBase/Team/addEditTeamMember.js"  type="text/javascript"></script>

</head>
<body>
	<fieldset
		style="width: 95%; height: 106px; border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;"">
		<div id="dataform1" style="padding-top: 5px;">
			<!-- 隐藏区域 -->
			<input class="nui-hidden" name="rpbclass." id="types.mpLookupCodess" />
			<input class="nui-hidden" name="rpbclass." id="types.lookupTypeId" />

			<span style="width: 80px; height: 38px; display: inline-block;">维修工种：</span>
			<input class="nui-textbox" name="types.lookupTypeCode" width="240px" />


			<span style="width: 80px; height: 38px; display: inline-block;">班组名称：</span>
			<input class="nui-textbox" name="types.lookupTypeName" width="240px" />


			<span style="width: 80px; height: 38px; display: inline-block;">班组长名称：</span>
			<input class="nui-textbox" name="types.lookupTypeRemark"
				width="240px" />
		</div>

	</fieldset>

	</div>
	<div class="nui-toolbar" style="padding: 0px;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align: center;" colspan="4"><a
					class="nui-button" iconCls="icon-save" onclick="onOk()"
					id="save_btn" plain="true">保存（s）</a> <span
					style="display: inline-block; width: 25px;"> </span> <a
					class="nui-button" iconCls="icon-cancel" onclick="onCancel"
					iconCls="icon-cancel" plain="true">取消（c）</a></td>
			</tr>
		</table>
	</div>
	

</body>
</html>