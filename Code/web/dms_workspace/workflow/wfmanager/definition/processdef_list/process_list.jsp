<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.primeton.workflow.governor.ProductInstallManager"%>
<%
	String product=com.eos.system.ServerContext.getInstance().getProductFamily();
 %>
<html>
<head>
	<title></title>
	<script>
		var contributionName ='<b:write property="pkgId"/>';
		
		function showProcessVersions(name){
		
			obj('processDefName').value = name ;
			document.forms['processesForm'].action="com.primeton.workflow.manager.def.getAllProcessVersions.flow";
			submitForm('processesForm');
		}
		
		function uploadMultiProcesses () {
   			showModalCenter('<%=request.getContextPath()%>/workflow/wfmanager/definition/deployprocess/deploy_multiprocesses.jsp?contrib='+contributionName,null,function (returnValue){
   			 	 if (!returnValue) 
   			 		return false;
   			 	if (returnValue == 'failed')
   			 		return false ;
   			 	pNode = parent.left.tree.cur_node ;
				parent.left.refreshTree(pNode);
   			 	history.go(0) ;
   			 },'700','420','<b:message key="process_list_jsp.extractVersion"/>');//从资源库提取版本
   		}
   		
   		function uploadEcdProcesses(){
   			document.forms['processesForm'].action='com.primeton.workflow.manager.def.deployContribution.flow?_eosFlowAction=chooseFile' ;
   			submitForm('processesForm');
   		}
	</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
 <form name="processesForm" method="post">
   <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="process_list_jsp.processList"/></h3></td><!-- 流程列表 -->
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
				<td width="100%"  height="100%"  valign="top">
					<table border="0" class="EOS_table" width="100%">
				<tr class="EOS_table_head">
				  <th width="18%"><b:message key="process_list_by_catalog_jsp.process_name"/></th><!-- 流程名称 -->
				  <th width="19%"><b:message key="process_list_by_catalog_jsp.process_cn_name"/></th><!-- 流程中文名称 -->
				  <th width="18%"><b:message key="process_list_by_catalog_jsp.pub_version"/></th><!-- 发布版本 -->
				  <th width="19%"><b:message key="process_list_by_catalog_jsp.version_num"/></th><!-- 版本数 -->
				  <th width="19%"><b:message key="process_list_by_catalog_jsp.newest_version"/></th><!-- 最新版本 -->
				  </tr>
				<l:iterate id="view" property="processes">
					<tr class="EOS_table_selectRow">
					    <td><a href='com.primeton.workflow.manager.def.getAllProcessVersions.flow?processDefName=<b:write iterateId="view" property="processDefName"/>'><b:write iterateId="view" property="processDefName"/></a></td>
						<td><b:write iterateId="view" property="processChName"/></td>
						<td><b:write iterateId="view" property="publishedVersion"/></td>
						<td><b:write iterateId="view" property="processCount"/></td>
						<td><b:write iterateId="view" property="lastVersion"/></td>
					</tr>
				</l:iterate>
			  </table>		<br>		
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                    	 <% if(product!=null&&product.equals("Primeton EOS")){  %>
                        	<!-- <input type="button" name="pub2" value="从资源库提取版本" class="button" onclick="uploadMultiProcesses()"> -->
                        	<%}%>
                   		  </td>
                      </tr>
                    </table></td>
			</tr>
		</table>
</td></tr>
</table> 
<input type="hidden" name="processDefName">
</form>
</body>	
</html>