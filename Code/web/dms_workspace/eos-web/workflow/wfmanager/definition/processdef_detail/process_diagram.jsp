<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>

<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String unpublished = ResourcesMessageUtil.getI18nResourceMessage("process_diagram_jsp.unpublished");
String published = ResourcesMessageUtil.getI18nResourceMessage("process_diagram_jsp.published");
 %>
<html>
<head>
	<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/json2xml.js" language="javascript"></script>
	<title></title>
	<script>
		var cacheMgr = new SpecCacheMgr () ;
		
		function openConfirmWindow2 (frm,act,path,msg,callback,title){
			if (frm == null)
				return false ;
			path= path == null ? "..":path;
			msg = msg == null ? "" :msg ;
			showModalCenter(path+"/workflow/wfmanager/common/confirm.jsp",msg,function(returnValue){
				if (act == null || act == "") {
						if(callback != null) 
							 callback() ;
						return false ;				
					}
					
				if (returnValue == "true") {
					document.forms[frm].action=act;
					submitForm(frm);
					//如果点击过树 则刷新树
					parent.left.refreshParentNode();
				} else {
					return false ;
				}
			},'300','250',title);
		}
		
		function pubProcess () {
   			  openConfirmWindow2('processDiagram','com.primeton.workflow.manager.def.publishProcess.flow?act=pub','<%=request.getContextPath()%>','<b:message key="process_diagram_jsp.confirm_publish"/>',null,'<b:message key="process_diagram_jsp.publish_process"/>');//确认要发布该流程吗?/发布流程
   		}
   		
   		
   		function cancelPubProcess() {
   			  openConfirmWindow2('processDiagram','com.primeton.workflow.manager.def.publishProcess.flow?act=depub','<%=request.getContextPath()%>','<b:message key="process_diagram_jsp.confirm_unpublish"/>',null,'<b:message key="process_diagram_jsp.cancel_publish_process"/>');//确认要取消发布该流程吗?/取消发布流程
   		}
   		
   		function deleteProcess (delAll) {
				openWindow('<%=request.getContextPath()%>/workflow/wfmanager/definition/processdef_list/removeProConfirm2.jsp?id='+obj('proId').value+'&name='+obj('proName').value+'&pkgId='+obj('pkgId').value,'<%=request.getContextPath()%>','300','200','<b:message key="process_diagram_jsp.delete_process"/>');//删除流程
   		}
   		
   		function reloadDiagram (zoom){
   			var fm = $id('fdiagram') ;
   			fm.src='com.primeton.workflow.manager.def.showProcessGraph.flow?_eosFlowAction=action0&id=<b:write property="id"/>&zoom='+zoom ;
   		}
   		
   		function editProcessInfo () {   			
   			showModalCenter('<%=request.getContextPath()%>/workflow/wfmanager/definition/processdef_detail/edit_process_info.jsp?processId=<b:write property="id"/>',null,function (returnValue){
   				if(!returnValue)  return false;
   				var xmlData = json2xml(returnValue,'',true) ;
				xmlData = "<processHeader>"+xmlData+"</processHeader>"; 
				cacheMgr.set("processHead",xmlData) ;			
   				//hs = new HideSubmit ("com.primeton.workflow.manager.def.processdef.saveProcessHead.biz");
   				//hs.addParam("xmlData",xmlConversion(xmlData)); 
   				//hs.submit();
   				//show submit entire process link div
				$id('zoomDiv').style.paddingLeft="10px";				
				$id('sbmitEproDiv').style.display="inline" ;
   			},'670','346','<b:message key="process_diagram_jsp.edit_process_info"/>') ;//编辑流程信息
	   		return false;
   		}
   		
   		function submitEProcess() {
   			hs = new HideSubmit ("com.primeton.workflow.manager.def.processdef.saveProcessDefine.biz");
   			hs.addParam("prodefID",cacheMgr.get("processDefID")); 
   			hs.addParam("proHead",cacheMgr.get("processHead")); 
   			var actkeys=cacheMgr.get("activityKeys").split(",");
   			//alert(actkeys.length);
   			for(var i=0;i<actkeys.length;i++){
   			    //alert(actkeys[i]);
   			    hs.addParam("actID["+i+"]",actkeys[i]); 
   			    hs.addParam("actValue["+i+"]",cacheMgr.get(actkeys[i])); 
   			}
   			
   			hs.submit();
   			
   			var response = hs.getValue("/root/data/validateResponse") ;
   			if(!(response== null || response == "")) {
   				msg = "<b:message key="process_diagram_jsp.save_pro_def_fail"/>"+response ;
   			 	openConfirmWindow('',null,'<%=request.getContextPath()%>',msg,null,'<b:message key="process_diagram_jsp.prompt"/>');//保存流程定义失败!\n/提示
   			} else {
   				$id('zoomDiv').style.paddingLeft="10px";
   				$id('sbmitEproDiv').style.display="none" ;
				alert("<b:message key="process_diagram_jsp.modify_pro_def_success"/>");//修改流程定义成功!
   			}
   			
   		}
   		
   		function  refreshGraph(){
   			//$id('sbmitEproDiv').style.display="none" ;
			location.reload(true) ;
		}
	</script>
</head>
<body style="background:#FFFFFF;margin-top:10px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow: auto;">
   <form name="processDiagram" method="post">
   <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="process_diagram_jsp.process_details"/>&nbsp;&nbsp;|&nbsp;&nbsp;<%=request.getParameter("pkgName")%>&nbsp;>&nbsp;<%=request.getParameter("pname")%>&nbsp;>&nbsp;V<%=request.getParameter("version")%>&nbsp;(<%=request.getParameter("state") == null ? "" : (request.getParameter("state").equals("1") ? unpublished : published) %>)</h3></td><%-- 流程详细信息/未发布/已发布 --%>
	</tr>
	<tr>
		<td valign="top">
			<table cellpadding="0" width="100%" cellspacing="0" border="0" style="margin-left:5px; margin-top:5px">
				<tr>
					<td>
						<div>
							<div style="display:inline;margin-left:5px">
								<b:message key="process_diagram_jsp.biz_process_diagram"/>
								<!-- 
								<input name="btEdit" type="button" class="button" value="编辑流程信息" onClick="editProcessInfo()">
								 -->
							</div><%-- 业务流程图: --%>
							<div style="display:inline;padding-left:15px">
								<input id="btDelete" name="btDelete" type="button" class="button" value="<b:message key="process_diagram_jsp.delete_process"/>" onClick="deleteProcess()"><%-- 删除流程 --%>
							</div>
							
							<div style="display:inline;padding-left:20px">
							 	<%
							  		String state = request.getParameter("state") ;
							  		if(state != null)
							  		if(state.equals("3")) {
							  	%>
							  		<input id="btCancel" name="btCancel" type="button" class="button" value="<b:message key="process_diagram_jsp.cancel_process_publish"/>" onClick="cancelPubProcess()"><%-- 取消流程发布 --%>
							  	<%  } else { %>
							  		<input id="btPub" name="btPub" type="button" class="button" value="<b:message key="process_diagram_jsp.publish_process"/>" onClick="pubProcess()"><%-- 发布流程 --%>
							  	<%  } %>
							 </div>
							
							<div style="display:inline;padding-left:260px">
								<input id="freshBtn" name="fresh" type="button" class="button" value="<b:message key="process_diagram_jsp.refresh"/>" onClick="refreshGraph()" alt="<b:message key="process_diagram_jsp.reset_data"/>"><%-- 刷新/可用于重置数据 --%>
							</div>
							
							<div id="zoomDiv" style="display:inline;padding-left:10px">
								  <label><b:message key="process_diagram_jsp.scaling"/> </label><%-- 缩放比例: --%>
								  <select name="zoom" onchange="reloadDiagram(this.options[this.selectedIndex].value)">
								  		  <option value="1.0" selected><b:message key="process_diagram_jsp.auto"/></option><%-- 自动 --%>
								          <option value="0.4">40%</option>
								          <option value="0.55">55%</option>
								          <option value="0.7">70%</option>
								          <option value="0.85">85%</option>
								          <option value="1.0">100%</option>
								          <option value="1.5">150%</option>
								          <option value="2.0">200%</option> 										
								  </select>
							 </div>
							 <div id="sbmitEproDiv" style="display:none;padding-left:5px">
							 	<a href="javascript:submitEProcess()"><font color="red"><b:message key="process_diagram_jsp.submit_save"/></font></a><%-- *提交保存所有修改 --%>
							 </div>
						</div>
					</td>
				</tr>
				
			</table>
		</td>
		
	</tr>
 	<tr>
		<td width="100%" align="center" valign="middle">
			<table cellpadding="0" width="100%" cellspacing="0" border="0" style=" padding-bottom:10px">
				<tr><td>
		<iframe id="fdiagram" name="fdiagram" align="middle" src='com.primeton.workflow.manager.def.showProcessGraph.flow?_eosFlowAction=action0&id=<b:write property="id"/>&zoom=1.0' scrolling="yes" frameBorder="1" style="size:auto; height:385px; border: 1px; red" width="98%"></iframe></td></tr>
			</table>
		</td>
	</tr>
	
	
   </table> 
   <h:hidden name="pkgId" property="pkgId" />
   <h:hidden name="proId" property="id" />
   <h:hidden name="proName" property="pname" />
   </form>
</body>
</html>