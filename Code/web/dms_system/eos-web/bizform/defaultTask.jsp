<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">	
<%@include file="/bizform/bizformCommon.jsp" %>
<html>
<head>
<title><%=I18nUtil.getMessage(request, "bps.bizform.DefaultTask") %></title>
</head>
<body>
<div class="nui-fit" style="padding: 5px;">
	<table style="width:100%;hegith:100%;">
	<tr>
		<td>
			<div class="nui-form" id="form1" >
			<fieldset> 
			<legend><span>【<%=I18nUtil.getMessage(request, "bps.bizform.WorkItemDetail") %>】</span></legend>
			<table class="nui-form-table" width="100%">	
			<tr>
				<td class="nui-form-label" style="white-space:nowrap"><label for="processInstID$text"><%=I18nUtil.getMessage(request, "bps.bizform.ProcessInstID") %>:</label></td>
				<td><input id="processInstID"  name="processInstID" class="nui-textbox asLabel" readOnly="true"/></td>
				<td class="nui-form-label" style="white-space:nowrap"><label for="processInstName$text"><%=I18nUtil.getMessage(request, "bps.bizform.ProcessInstName") %>:</label></td>
				<td><input id="processInstName"  name="processInstName" class="nui-textbox asLabel" readOnly="true"/></td>
			</tr>		
			<tr>
				<td class="nui-form-label" style="white-space:nowrap"><label for="activityInstID$text"><%=I18nUtil.getMessage(request, "bps.bizform.ActivityInstID") %>:</label></td>
				<td><input id="activityInstID"  name="activityInstID" class="nui-textbox asLabel" readOnly="true"/></td>
				<td class="nui-form-label" style="white-space:nowrap"><label for="activityInstName$text"><%=I18nUtil.getMessage(request, "bps.bizform.ActivityInstName") %>:</label></td>
				<td><input id="activityInstName"  name="activityInstName" class="nui-textbox asLabel" readOnly="true"/></td>
			</tr>			
			<tr>
				<td class="nui-form-label" style="white-space:nowrap"><label for="workItemID$text"><%=I18nUtil.getMessage(request, "bps.bizform.WorkItemID") %>:</label></td>
				<td><input id="workItemID"  name="workItemID" class="nui-textbox asLabel" readOnly="true"/></td>
				<td class="nui-form-label" style="white-space:nowrap"><label for="workItemName$text"><%=I18nUtil.getMessage(request, "bps.bizform.WorkItemName") %>:</label></td>
				<td><input id="workItemName"  name="workItemName" class="nui-textbox asLabel" readOnly="true"/></td>
			</tr>
			<tr>
				<td class="nui-form-label" style="white-space:nowrap"><label for="priority$text"><%=I18nUtil.getMessage(request, "bps.bizform.Priority") %>:</label></td>
				<td><input id="priority"  name="priority" class="nui-textbox asLabel" readOnly="true"/></td>
				<td class="nui-form-label" style="white-space:nowrap"><label for="currentState$text"><%=I18nUtil.getMessage(request, "bps.bizform.CurrentState") %>:</label></td>
				<td><input id="currentState"  name="currentState" class="nui-combobox asLabel" dictTypeId="WFDICT_WorkItemState" readOnly="true"/></td>
			</tr>
			<tr>
				<td class="nui-form-label" style="white-space:nowrap"><label for="limitNumDesc$text"><%=I18nUtil.getMessage(request, "bps.bizform.LimitNumDesc") %>:</label></td>
				<td><input id="limitNumDesc"  name="limitNumDesc" class="nui-textbox asLabel" readOnly="true"/></td>
				<td class="nui-form-label" style="white-space:nowrap"><label for="remindTime$text"><%=I18nUtil.getMessage(request, "bps.bizform.RemindTime") %>:</label></td>
				<td><input id="remindTime"  name="remindTime" class="nui-datepicker asLabel" format="yyyy-MM-dd HH:mm" readOnly="true" width="160"/></td>
			</tr>
			<tr>
				<td class="nui-form-label" style="white-space:nowrap"><label for="isTimeOut$text"><%=I18nUtil.getMessage(request, "bps.bizform.TimeOutFlag") %>:</label></td>
				<td><input id="isTimeOut"  name="isTimeOut" class="nui-combobox asLabel" dictTypeId="WFDICT_YN" readOnly="true"/></td>
				<td class="nui-form-label" style="white-space:nowrap"><label for="timeOutNumDesc$text"><%=I18nUtil.getMessage(request, "bps.bizform.TimeOutNumber") %>:</label></td>
				<td><input id="timeOutNumDesc"  name="timeOutNumDesc" class="nui-textbox asLabel" readOnly="true"/></td>
			</tr>	
			<tr>
				<td class="nui-form-label" style="white-space:nowrap"><label for="partiName$text"><%=I18nUtil.getMessage(request, "bps.bizform.PartiName") %>:</label></td>
				<td><input id="partiName"  name="partiName" class="nui-textbox asLabel" readOnly="true"/></td>
				<td class="nui-form-label" style="white-space:nowrap"><label for="createTime$text"><%=I18nUtil.getMessage(request, "bps.bizform.CreateTime") %>:</label></td>
				<td><input id="createTime"  name="createTime" class="nui-datepicker asLabel" format="yyyy-MM-dd HH:mm" readOnly="true" width="160"/></td>
			</tr>		
			<tr>
				<td class="nui-form-label" style="white-space:nowrap"><label for="startTime$text"><%=I18nUtil.getMessage(request, "bps.bizform.StartTime") %>:</label></td>
				<td><input id="startTime"  name="startTime" class="nui-datepicker asLabel" format="yyyy-MM-dd HH:mm" readOnly="true" width="160"/></td>
				<td class="nui-form-label" style="white-space:nowrap"><label for="endTime$text"><%=I18nUtil.getMessage(request, "bps.bizform.EndTime") %>:</label></td>
				<td><input id="endTime"  name="endTime" class="nui-datepicker asLabel" format="yyyy-MM-dd HH:mm" readOnly="true" width="160"/></td>
			</tr>
			</table>
			</fieldset> 
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset> 
			<legend><span>【<%=I18nUtil.getMessage(request, "bps.bizform.WorkItemOerationTab") %>】</span></legend>
			<div id="messageFetch" class="nui-bps-fetchmessagelist">
			</div>
			</fieldset>
		</td>
	</tr>
	</table>
</div>
	
	<script type="text/javascript">
    	nui.parse();
    	
		var form = new nui.Form("#form1");
    	
		/**
		* 页面初始化的时候会被调用
		* e.data : {
			workItemID:1
		}
		*/
		function initData(e){
			nui.ajax({
				url:"org.gocom.bps.web.bizform.bizformcomponent.queryWorkItemDetail.biz.ext",
				type: "POST",
				data:{
					workItemID:e.workItemID
				},
				cache: false,
				success: function(e){
					if(e.exception){
						tfcToast.take("<%=I18nUtil.getMessage(request, "bps.bizform.LoadFail") %>");
						return;
					}
					var data = nui.decode(e)["data"];
					form.setData(data);
					form.setChanged(false);
				},
				error: function(e){
					tfcToast.take("<%=I18nUtil.getMessage(request, "bps.bizform.LoadFail") %>");
				}
			});
		}
		
		function beforeSubmit(e){
			
		}
		
		//@Review 调用父类的close方法 {liuxiang}
		function afterSubmit(e){
			if(e.returnData.exception){
				tfcToast.take("<%=I18nUtil.getMessage(request, "bps.bizform.SubmitFail") %>");
				return;
			}
			//自动弹到第一个tab页
			var tab = bps.components.core.getFormTab();
			if(tab){
				
			}
			tfcToast.take("<%=I18nUtil.getMessage(request, "bps.bizform.SubmitSuccess") %>");
			bps.components.core.closeNuiWindowAlways("ok");
		}
    	
    </script>
</body>
</html>