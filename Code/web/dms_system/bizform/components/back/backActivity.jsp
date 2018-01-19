<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/bizform/bizformCommon.jsp" %>
<html>
<head>
	<title><%=I18nUtil.getMessage(request, "bps.bizform.backActivity") %></title>
</head>
<body>
	
	<div class="nui-fit" style="padding: 5px;">
		<div id="form1" class="nui-form" style="width:100%;">
			<input class="nui-hidden" name="workItemID"/>
			<table style="width:100%;table-layout:fixed;">
				<tr>
					<td></td>
					<td style="text-align:right;" class="form-label"><%=I18nUtil.getMessage(request, "bps.bizform.backWayStrategy") %>:</td>
					<td style="padding-top:4px;text-align:center;width:150px;"><input id="strategyCombox" class="nui-combobox" textField="text" readonly="readonly" data="backStrategy" onvaluechanged="isSelectActivity" width="100%"/></td>
					<td></td>
				</tr>
				<!-- 
				<tr>
					<td class="form-label"><%=I18nUtil.getMessage(request, "bps.bizform.back.backReason") %></td>
					<td><textarea class="nui-textarea" name="backReason" required="true" width="100%" ></textarea></td>
				</tr>
				 -->
			</table>
		</div>
		
		<div id="gridContainer" style="width:100%;display: none;">
			<div id="datagrid1" dataField="activities" class="nui-datagrid bpsDatagrid" showPager="false"  style="margin-top: 10px; width: 100%;"
				url="com.primeton.bps.web.bizform.components.back.backComponents.queryPreviousActivities.biz.ext" allowAlternating="true"
				 allowCellSelect="true" allowCellEdit="true">
				<div property="columns">
				  	<div type="checkcolumn" width="40px"><%=I18nUtil.getMessage(request, "bps.bizform.back.operator") %></div>
				  	<div field="id" headerAlign="center" align="center" visible="false" width="120px"><%=I18nUtil.getMessage(request, "bps.bizform.back.activityDefID") %></div>
				    <div field="name" headerAlign="center" align="center" width="120px"><%=I18nUtil.getMessage(request, "bps.bizform.back.activityDefName") %></div>
				    <div field="type" headerAlign="center" align="center" width="140px"><%=I18nUtil.getMessage(request, "bps.bizform.back.activityType") %></div>
				</div>
			</div>
		</div>
	</div>

    <table style="width:100%;margin-top: 10px;margin-bottom: 10px;">
		<tr>
			<td style="text-align:center;" colspan="4">
			<a class="nui-button redBtn" onclick="saveData"><%=I18nUtil.getMessage(request, "bps.bizform.ok") %></a>
			<span style="display:inline-block;width:25px;"></span>
			<a class="nui-button redBtn" onclick="onCancel"><%=I18nUtil.getMessage(request, "bps.bizform.cancel") %></a>
		    </td>
		</tr>
    </table>

	<script type="text/javascript">
    	var backStrategy = [
    		{id: "one_step", text: "<%=I18nUtil.getMessage(request, "bps.bizform.back.single") %>"},
    		{id: "simple", text: "<%=I18nUtil.getMessage(request, "bps.bizform.back.simple") %>"},
    		{id: "simple_appoint", text: "<%=I18nUtil.getMessage(request, "bps.bizform.back.simpleAppoint") %>"},
    		{id: "recent_manual", text: "<%=I18nUtil.getMessage(request, "bps.bizform.back.recentManual") %>"}];
    		
    	nui.parse();

    	var showSelectorArr = [backStrategy[1].id];//需要选择数据的列表
    	
    	var grid = nui.get("datagrid1");
    	var gridWrapper = $("#gridContainer");
    	var combo = nui.get("strategyCombox");
    	var form = new nui.Form("#form1");
    	var initData = null;
    	
    	var selectData = {};
    	
    	function setData(data){
	    	gridWrapper.hide();
	    	
	    	//修改回退方式的样式
    		var fields = form.getFields();                
            for(var i=0,len=fields.length;i<len;i++) {
            	var field = fields[i];
            	if(field["id"]=="strategyCombox"){
	                if (field.setReadOnly) field.setReadOnly(true);
	                if (field.setIsValid) field.setIsValid(true);//去除错误提示
	                if (field.addCls) field.addCls("asLabel");//增加asLabel外观
            	}
            }
            document.getElementById("strategyCombox").style.border="solid 1px #a5acb5";
            document.getElementById("strategyCombox").style.background="white";
            document.getElementById("strategyCombox").style.background="#FFFFE6";
    		
    		data = nui.clone(data);
    		if(data){
		    	grid.load({workItemID: data.workItemID});
		    	combo.setValue(data.backWay);
		    	if(data.backWay=="simple"){ //简单回退
		    		gridWrapper.show();
		    	}
		    	initData = data;
    		}
    	}

		function getData(){
			return selectData;
		}
		
		function saveData(e){
			//校验
			form.validate();
			if(!form.isValid()) return;
			
			var formData = form.getData();
			var backReason = "";
			
			if(formData){
				backReason = formData["backReason"];
			}
			
			if(needSelectData()){
				var sel = grid.getSelected();
				if(!sel){
					nui.alert("<%=I18nUtil.getMessage(request, "bps.bizform.back.recentManual.tip") %>");
					return ;
				}else{
					selectData = {
						strategy:combo.getValue(),
						destActDefID:sel.id, 
						backReason: backReason
					};
					CloseWindow("ok");
				}
			}else{
				var destActivityID = "";
				var strategy = combo.getValue() || backStrategy[1].id;
				if(strategy==[backStrategy[2].id] && initData){//简单指定
					destActivityID = initData["destActivityID"] || "";
					strategy = backStrategy[1].id;//simple
				}
				selectData = {
					strategy:strategy,
					destActDefID:destActivityID,
					backReason: backReason
				};
				CloseWindow("ok");
			}
		}
		
		function isSelectActivity(e){
			gridWrapper.hide();
			//判断是否显示
			if(needSelectData()){
				gridWrapper.show();
			}
		}
		
		function needSelectData(){
			var val = combo.getValue();
			for(var i=0;i<showSelectorArr.length;i++){
				if(val == showSelectorArr[i]){
					return true;
				}
			}
			return false;
		}
		
		function onCancel(){
			CloseWindow("cancel");
		}
		
		//关闭窗口
		function CloseWindow(action) {
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				return window.close();
		}
    </script>
</body>
</html>