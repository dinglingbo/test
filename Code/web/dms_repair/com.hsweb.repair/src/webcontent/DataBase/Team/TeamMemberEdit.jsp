<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-23 16:09:12
  - Description:
-->
<head>
<title>编辑班组成员</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body>
	<fieldset
		style="width: 95%; height: 110px; border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;"">
		<div id="dataform1" style="padding-top: 5px;">
			<!-- 隐藏区域 -->
			<input class="nui-hidden" name="rpbclass." id="types.mpLookupCodess" />
			<input class="nui-hidden" name="rpbclass." id="types.lookupTypeId" />

			<tr style="display: block; margin-top: 100px;">
				<td class="form_label">类型编码：</td>
				<td colspan="1"><input class="nui-textbox"
					name="types.lookupTypeCode" width="200px" /></td>
			</tr>
			</br>

			<tr style="display: block; margin-top: 100px;">
				<td class="form_label">类型名称：</td>
				<td><input class="nui-textbox" name="types.lookupTypeName"
					width="200px" /></td>
			</tr>
			</br>

			<tr style="display: block; margin-top: 100px;">
				<td class="form_label">备&ensp;&ensp;&ensp;&ensp;注：</td>
				<td><input class="nui-textbox" name="types.lookupTypeRemark"
					width="200px" /></td>
			</tr>
		</div>

	</fieldset>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>