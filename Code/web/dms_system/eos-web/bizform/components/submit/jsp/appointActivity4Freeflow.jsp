<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/bps/wfclient/common/common.jsp"%>
<html>
<head>
	<title><%=I18nUtil.getMessage(request, "bps.bizform.AppointActivity4Freeflow") %></title>
</head>
<body style="width: 97%; height: 95%"> 
	<div id="datagrid1" dataField="defActivities" class="nui-datagrid bpsDatagrid" showPager="false"  style="width: 100%; height: 90%"
		url="org.gocom.bps.web.bizform.components.submit.submitComponents.queryStepActivities.biz.ext" onload="selectActivity"  allowAlternating="true"
		 allowCellSelect="true" allowCellEdit="true">
		<div property="columns">
		  	<div type="checkcolumn" width="40px"></div>
		    <div field="processDefId" visible="false"><%=I18nUtil.getMessage(request, "bps.bizform.ProcessDefID") %></div>
		    <div field="id" headerAlign="center" align="center" width="120px"><%=I18nUtil.getMessage(request, "bps.bizform.ActionID") %></div>
		    <div field="name" headerAlign="center" align="center" width="140px"><%=I18nUtil.getMessage(request, "bps.bizform.ActivitydefName") %></div>
		</div>
	</div>

    <table style="width:100%;">
		<tr>
			<td style="text-align:center;" colspan="4">
			<a class="nui-button redBtn" onclick="saveData"><%=I18nUtil.getMessage(request, "bps.bizform.Save") %></a>
			<span style="display:inline-block;width:25px;"></span>
			<a class="nui-button redBtn" onclick="onCancel"><%=I18nUtil.getMessage(request, "bps.bizform.Cancel") %></a>
		    </td>
		</tr>
    </table>

	<script type="text/javascript">
    	nui.parse();
    	
    	var workItemID;
    	var returnData = {};
		var datagrid = nui.get("datagrid1");
		

		function setData(data) {
			returnData = nui.clone(data);
			datagrid.load({workItemID:returnData.workItemID});
		}
		
		function onCancel() {
			returnData = datagrid.getSelected();
			CloseWindow("cancel");
		}
		
		function saveData() {
			returnData = datagrid.getSelected();
			CloseWindow("ok");
		}
		
		function getData() {
			return returnData;
		}
		
		function selectActivity(e){
			var row = datagrid.findRow(function(r){
				return r.id == returnData.selectActivities;
			});
			if(row){
				datagrid.select(row, false);
			}
		}
		
		//关闭窗口
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if (window.confirm("<%=I18nUtil.getMessage(request, "bps.bizform.IsSavaDateModified") %>")) {
					saveData();
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				return window.close();
		}
    </script>
</body>
</html>