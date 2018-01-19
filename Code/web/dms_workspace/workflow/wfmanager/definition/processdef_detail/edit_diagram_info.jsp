<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.primeton.workflow.manager.def.presentation.ProcessDefinitionXmlWrap,java.util.Map,java.util.Set,java.util.Iterator"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/json2xml.js" language="javascript"></script>
<html>
<head>

	<title></title>
	
	<%
		ProcessDefinitionXmlWrap pdxw = 
		 				(ProcessDefinitionXmlWrap)request.getAttribute("pxmlWrapObj") ;
		String proDefID = String.valueOf(pdxw.getProcessDefID());
		String processStr = pdxw.getProcessHead() ; 
		Map activies = pdxw.getActivities() ;
		
	%>
	
	<script>
		var cacheMgr = new SpecCacheMgr () ;
		cacheMgr.create("processDefID","<%=proDefID%>") ;
		cacheMgr.create("processHead","<%=processStr%>") ;
	</script>
	   <% 
		  String key = "";
		  String value = "" ;
		  String actKeys = "";
		  
		  Set keys = activies.keySet() ;
		  Iterator iterator = keys.iterator() ;
		  for(key = "" ;iterator.hasNext();){
		      key = (String)iterator.next() ;
		      actKeys = actKeys+key+",";
		      value = (String)activies.get(key) ;
		%>
	<script>
			cacheMgr.create("<%=key%>","<%=value%>") ;
			//alert(cacheMgr.get("<%=key%>"));
	</script>		
		<% 
			}
		    actKeys=actKeys.substring(0, actKeys.lastIndexOf(","));
		%>
    <script>
        cacheMgr.create("activityKeys","<%=actKeys%>") ;//将所有的活动ID保存到activityKeys中，这样在提交修改时，可查到所有活动的id，并找到相应的data
        //alert(cacheMgr.get("activityKeys"));
	</script>
	<script type="text/javascript">
		
		function callback(activity){
			//invoke submit func
			if(!activity) return ;
			var actId = activity.activityId ;
			var xmlData = json2xml(activity,'',true) ;
			//alert(xmlData);
			xmlData = '<activity>'+xmlData+'</activity>' ;
			
			cacheMgr.set(actId,xmlData) ;
			
			//hs = new HideSubmit ("com.primeton.workflow.manager.def.processdef.saveActivity.biz") ;
			//hs.addParam("xmlData",xmlConversion(xmlData)); 
			//hs.addParam("activityId",activity.activityId);
			//submit
			//hs.submit();
			//show submit entire process link div
			parent.document.getElementById('zoomDiv').style.paddingLeft="10px";
			parent.document.getElementById('sbmitEproDiv').style.display="inline" ;
		}
		
		function openacteditwindow(obj,type) {
			processId = obj.getAttribute("processDefId") ;
			actId = obj.id ;
			var width = 600;
			var height = 400 ;
			var title = "" ;
			if(!type || type=="") return ;
			var page ;
			if(type == "start") {
					page = "edit_startact_info.jsp"  ;
					height = 320 ;
					title = "<b:message key="edit_diagram_info_jsp.title1"/>" ;//编辑启动活动信息 title1
				}
			else if (type == "manual") {
				page = "edit_manualact_info.jsp" ;
				title = "<b:message key="edit_diagram_info_jsp.title2"/>" ;//编辑人工活动信息 title2
				}
			else if (type == "route") {
					page = "edit_routeact_info.jsp" ;
					height=322;
					title = "<b:message key="edit_diagram_info_jsp.title3"/>" ;//编辑路由活动信息 title3
				}
			else if (type == "subflow") {
					page = "edit_subflow_info.jsp" ;
					height=380;
					width = 650;
					title = "<b:message key="edit_diagram_info_jsp.title4"/>" ;//编辑子流程信息 title4
				}
			else if (type == "toolapp") {
				page = "edit_autoact_info.jsp" ;
				height = 420;
				width=600;
				title = "<b:message key="edit_diagram_info_jsp.title5"/>" ;//编辑自动活动信息 title5
				}
			else if (type == "finish") {
					page = "edit_finishact_info.jsp" ;
					height = 322;
					width=600;
					title = "<b:message key="edit_diagram_info_jsp.title6"/>" ;//编辑结束活动信息 title6
				}
			
			var argument ;
			//去掉编辑这个功能
			//showModalCenter('<%=request.getContextPath() %>/workflow/wfmanager/definition/processdef_detail/'+page+'?processId='+processId+"&actId="+actId,argument,callback,width,height,title);
		}
	</script>
</head>
<body style="background:#FFFFFF;margin-top:10px;margin-left:0px;margin-buttom:0px;overflow: auto;">
		<wf:processGraph processID='<%=request.getParameter("id")%>'  zoomQuotiety='<%=request.getParameter("zoom")%>'>
			<wf:activityGraph activityType="start" onclick="openacteditwindow(this,'start')" />
			<wf:activityGraph activityType="manual" onclick="openacteditwindow(this,'manual')" />
			<wf:activityGraph activityType="route" onclick="openacteditwindow(this,'route')" />
			<wf:activityGraph activityType="subflow" onclick="openacteditwindow(this,'subflow')" />
			<wf:activityGraph activityType="toolapp" onclick="openacteditwindow(this,'toolapp')" />
			<wf:activityGraph activityType="finish" onclick="openacteditwindow(this,'finish')" />
		</wf:processGraph>
	 
</body>
</html>