<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=I18nUtil.getMessage(request, "bps.bizform.ApprovalMsgList") %></title>
<%@include file="/bizform/bizformCommon.jsp" %>
</head>
<body>
		<div id="datagrid1" showPager="true" class="nui-datagrid" style="width:100%;height:100%;"
		 dataField="data.items" totalField="data.total"
		url="org.gocom.bps.web.bizform.components.approval.approvalManager.queryApprovalMsgByProcessInstID.biz.ext">
		    <div property="columns">
		    	<!-- 
		        <div field="messageID" width="10%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.approval.messageID") %></div>   
		         --> 
		        <div field="producer" width="10%" headerAlign="center" renderer="renderProducer"><%=I18nUtil.getMessage(request, "bps.bizform.approval.producer") %></div>
		        <div field="content" width="40%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.approval.content") %></div>
		        <div width="15%" headerAlign="center" renderer="renderActivityDefID"><%=I18nUtil.getMessage(request, "bps.bizform.approval.activityDefID") %></div>
		        <div field="correlationID" width="10%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.approval.workItemID") %></div>
		        <div field="createTime" width="15%" headerAlign="center"><%=I18nUtil.getMessage(request, "bps.bizform.approval.createTime") %></div>
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
// 	    var pager = nui.get("pager");
        var workItemMap = {};
        $(function(){
        	nui.ajax({
        		url:"org.gocom.bps.web.bizform.bizformcomponent.getWorkItemsByProcInstId.biz.ext",
        		data: {procInstId: bps.components.core.getPageContext().processInstID,
        			page: {
        				begin: 0,
        				length: 1<<20
        			}},
        		type: "POST",
        		cache: false,
        		success: function(ret){
        			if(ret.exception){
        				nui.alert("<%=I18nUtil.getMessage(request, "bps.bizform.ajaxErrorMsg") %>");
        				return;
        			}
        			var data = nui.decode(ret)["data"];
        			if(data && data["items"]){
        				data = data["items"];
        				for(var i=0;i<data.length;i++){
        					workItemMap[data[i].workItemID] = data[i];
        				}
        			}
        			//数据加载完成之后再加载表单数据
        			grid.load({processInstID:bps.components.core.getPageContext().processInstID});
        		},
        		fail: function(err){
        			nui.alert("<%=I18nUtil.getMessage(request, "bps.bizform.ajaxErrorMsg") %>");
        		}
        	});
        });
        
        function renderActivityDefID(e){
        	var record = e.record;
        	return workItemMap[record.correlationID]["activityDefID"];
        }
        
        function renderProducer(e){
        	var record = e.record;
        	return workItemMap[record.correlationID]["partiName"];
        }
        
        
    </script>
</body>
</html>
