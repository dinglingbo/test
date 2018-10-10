<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>投诉管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="manage/js/complainDetail.js" type="text/javascript"></script>
    <link href="manage/css/complainDetail.css" rel='stylesheet' type='text/css' />
</head>
<body>
	<div style="width:calc(100% - 20px);height:120px;padding:10px;">
		<div class="nui-panel" title="客户信息" style="width:100%;height:100%;">
			<table class="info-tab">
				<tr>
					<td><span>车牌号:</span></td>
					<td><input class="nui-textbox" allowInput="false"/></td>
					<td><span>联系电话:</span></td>
					<td><input class="nui-textbox" allowInput="false"/></td>
					<td><span>客户名称:</span></td>
					<td><input class="nui-textbox" allowInput="false"/></td>
					<td><span>投诉公司:</span></td>
					<td><input class="nui-combobox" allowInput="false"/></td>
				</tr>
				<tr>
					<td><span>厂牌:</span></td>
					<td><input class="nui-textbox" allowInput="false"/></td>
					<td><span>车型:</span></td>
					<td><input class="nui-textbox" allowInput="false"/></td>
					<td><span>登记人:</span></td>
					<td><input class="nui-textbox" allowInput="false"/></td>
					<td><span>登记时间:</span></td>
					<td><input class="nui-datepicker" allowInput="false"/></td>
				</tr>
				<tr>
					<td><span>投诉形式:</span></td>
					<td><input class="nui-combobox" allowInput="false"/></td>
					<td><span>维修顾问:</span></td>
					<td><input class="nui-textbox" allowInput="false"/></td>
					<td><span>维修工单:</span></td>
					<td><input class="nui-textbox" allowInput="false"/></td>
					<td><span>投诉单号:</span></td>
					<td><input class="nui-textbox" allowInput="false"/></td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit" style="width:calc(100% - 20px);padding:10px;">
		<div class="nui-panel" title="客户投诉的陈述" style="width:100%;height:100%;">
			<div class="nui-panel" title="登记人的填写" style="width:100%;height:100%;">
				<div class="nui-panel" title="投诉类别" style="width:100%;height:70%;">
				<table class="complain-tab">
					<tr>
						<td class="title-tab"><span>服务接车/交车:</span></td>
						<td class="input-tab"><input class="nui-combobox" style="width:100%;" allowInput="false"/></td>
					</tr>
					<tr>
						<td class="title-tab"><span>维修保养/品质:</span></td>
						<td class="input-tab"><input class="nui-combobox" style="width:100%;" allowInput="false"/></td>
					</tr>
					<tr>
						<td class="title-tab"><span>价格合理:</span></td>
						<td class="input-tab"><input class="nui-combobox" style="width:100%;" allowInput="false"/></td>
					</tr>
					<tr>
						<td class="title-tab"><span>维修时间:</span></td>
						<td class="input-tab"><input class="nui-combobox" style="width:100%;" allowInput="false"/></td>
					</tr>
					<tr>
						<td class="title-tab"><span>服务设施:</span></td>
						<td class="input-tab"><input class="nui-combobox" style="width:100%;" allowInput="false"/></td>
					</tr>
					<tr>
						<td class="title-tab"><span>问题单:</span></td>
						<td class="input-tab"><input class="nui-combobox" style="width:100%;" allowInput="false"/></td>
					</tr>
					<tr>
						<td class="title-tab"><span>投诉级别:</span></td>
						<td class="input-tab"><input class="nui-combobox" style="width:100%;" allowInput="false"/></td>
					</tr>
				</table>
				</div>
				<div style="width:100%;height:30%;">
					<div>客户陈述:</div>
					<input class="nui-textarea" style="height:70%;width:100%"/>
				</div>
			</div>
		</div>
	</div>
	
	
</body>
</html>