<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): wujun
  - Date: 2014-12-31 13:45:32
  - Description:
-->
<head>
<title><%=I18nUtil.getMessage(request, "bps.bizform.ApprovalTrajectory") %></title>
<%@include file="/bizform/bizformCommon.jsp" %>   
</head>
<body>
	<!--
		任务ID
		任务名称
		参与者
		优先级
		任务状态
		是否超时
		创建时间
		结束时间
	-->
	<div id="datagrid1" showPager="true" class="nui-datagrid" style="width:100%;height:100%;" dataField="data.items" totalField="data.total" 
	url="org.gocom.bps.web.bizform.bizformcomponent.getWorkItemsByProcInstId.biz.ext">
	    <div property="columns">
	        <div field="activityDefID" width="15%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.ActionID") %></div>    
	        <div field="activityInstID" width="10%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.ActivityInstID") %></div>
	        <div field="activityInstName" width="12%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.ActivityInstName") %></div>
	        <div field="partiName" width="9%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.PartiName") %></div>
	        <div field="createTime" width="17%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.CreateTime") %></div>
	        <div field="endTime" width="17%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.EndTime") %></div>
	        <div field="isTimeOut" width="5%" headerAlign="center" renderer="onTimeoutRenderer"><%=I18nUtil.getMessage(request, "bps.bizform.Timeout") %></div>
	        <div field="currentState" width="15%" headerAlign="center" renderer="onCurrentStateRenderer"><%=I18nUtil.getMessage(request, "bps.bizform.CurrentState") %></div> 
	    </div>
	</div>
	<!-- 
	<div class="pager">
		<div id="pager" class="nui-bpspager" datagridId="datagrid1"></div>
	</div>
	 -->
<script type="text/javascript">
	nui.parse();
    var grid = nui.get("datagrid1");
    grid.load({procInstId:bps.components.core.getPageContext().processInstID});
// 	var pager = nui.get("pager");
// 	pager.setDatagridParams({procInstId : bps.components.core.getPageContext().processInstID});
  //@Review 是/否的值应该用业务字典
    function onCurrentStateRenderer(e) {
    	return nui.getDictText("WFDICT_WorkItemState",e.row.currentState);
    } 
  
    function onTimeoutRenderer(e) {
    	return nui.getDictText("WFDICT_YN",e.row.isTimeOut);
    }
</script>
</body>
</html>
