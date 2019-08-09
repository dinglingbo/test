<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): lidongsheng
  - Date: 2019-03-23 04:54:21
  - Description:
-->
<head>
<title>模板详细信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <style type="text/css">
    	body .mini-textbox-disabled .mini-textbox-border{
    		border: 0px !important;
    		background: #f2f5f7 !important;
    	}
    	.mini-textarea .mini-textbox-input{
    		line-height: 2.2 !important;
    	}
    </style>
</head>
<body>
	<div class="form" id="templateInfoForm" name="templateInfoForm" style="height:85%;left:0;right:0;margin: 0 auto;display: flex;padding: 10px;padding-right: 25px;">
		<table style="width:100%;margin-left: 30px;border-collapse: separate;border-spacing: 0px 20px;" class="nui-form-table">
			<tr>
				<td class="nui-form-label" colspan="1" style="width: 70%;" >
					<label>模板示例:</label>
				</td>
				<td colspan="1" style="width: 30%;">
					<label>模板内容:</label>
				</td>
			</tr>
			<tr>
				<td class="nui-form-label" colspan="1" >
					<input class="nui-textarea" name="example" id="example" required="true" style="width:350px;height:260px;" />
				</td>
				<td colspan="1">
					<input class="nui-textarea" name="content" id="content" required="true" style="width:350px;height:260px;" />
				</td>
			</tr>
		</table>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	
    	//页面间传输json数据
		function setFormData(data) {
			var infos = nui.clone(data);
			var templateInfoForm=infos.templateData;
			var form = new nui.Form("#templateInfoForm"); //将普通form转为nui的form
			form.setData(templateInfoForm);
			nui.get("content").disable(false);
			nui.get("example").disable(false);
		}
    </script>
</body>
</html>