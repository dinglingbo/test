<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): Administrator
- Date: 2018-07-17 12:22:17
- Description:
    --%>
<head>
<title>用户修改</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<%@include file="/common/sysCommon.jsp"%>
        </script>
</head>
<body>
	<!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
	<input name="pageType" class="nui-hidden" />
	<div id="form1" method="post" align="center">
		<input class="nui-hidden" name="bmw.id" />
		<table>
			<tr>
				<td class="td1">宝马用户账号：</td>
				<td><input class="nui-textbox" name="bmw.loginname" /></td>

			</tr>
			<tr>
				<td class="td1">宝马用户密码：</td>
				<td><input class="nui-textbox" id="mobile" name="bmw.password" />
				</td>

			</tr>
			<tr>
				<td class="td1">备注：</td>
				<td><input class="nui-textbox" id="mobile" name="bmw.remarks" />
				</td>

			</tr>
		</table>

		<div class="nui-toolbar" style="padding: 0px;" borderStyle="border:0;">
			<table width="100%">
				<tr>
					<td style="text-align: center;" colspan="4"><a
						class="nui-button" onclick="ok()"> 保存 </a> <span
						style="display: inline-block; width: 25px;"> </span> <a
						class="nui-button" onclick="onCancel()"> 取消 </a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		nui.parse();
		//传储数据更新代码区
		function ok() {
			saveData();
			nui.alert("保存完成", "请刷新页面查看", window.CloseOwnerWindow);
		}
		var form = new nui.Form("#form1");
		function saveData() {
			var data = form.getData(false, true);
			var json = nui.encode(data);
			nui.ajax({
				url : "<%=sysApi %>/com.hsapi.system.config.textbase.updataBase.biz.ext",
				data : json,
				type : 'post',
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					CloseWindow("save");
				},
				error : function() {
					window.CloseOwnerWindow();
				}
			});
		}

		//页面间传输json数据父页面中调用 
		function setFormData(data) {
			//跨页面传递的数据对象，克隆后才可以安全使用,data是选中的数据
			var infos = nui.clone(data);
			//保存list页面传递过来的页面类型
			nui.getbyName("pageType").setValue(infos.pageType);
			if (infos.pageType == "edit") {
				var json = infos.record;
				var form = new nui.Form("#form1");
				form.setData(json);
				form.setChanged(false);
			}
		}
		//取消按键
		function onCancel() {
			window.CloseOwnerWindow();
		}
	</script>
</body>
</html>
