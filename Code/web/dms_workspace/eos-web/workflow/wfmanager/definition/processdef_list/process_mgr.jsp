<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<%@page import="com.primeton.workflow.governor.ProductInstallManager"%>
<html>
<%
	String product=com.eos.system.ServerContext.getInstance().getProductFamily();
 %>
<head>
	<title></title>
	<script>
		/*资源库提取版本*/
		function uploadMultiProcesses () {
   			showModalCenter('<%=request.getContextPath()%>/workflow/wfmanager/definition/deployprocess/deploy_multiprocesses.jsp',null,function (returnValue){
   			 	 if (!returnValue) 
   			 		return false;
   			 	if (returnValue == 'failed')
   			 		return false ;
   			 	pNode = parent.left.tree.cur_node ;
				parent.left.refreshTree(pNode);
   			 	history.go(0) ;
   			 },'700','420','<b:message key="process_list_jsp.extractVersion"/>');//从资源库提取版本
   		}
   		/*独立BPS环境中，上传Ecd*/
   		function uploadEcdProcesses(){
   			document.forms['packageForm'].action='com.primeton.workflow.manager.def.deployContribution.flow?_eosFlowAction=chooseFile' ;
   			submitForm('packageForm');
   		}
   		
   		/*部署Ecd，刷新左边构件包*/
   		function refreshLeftTree(flag){
   			if(flag||flag=="true"){
				parent.left.location="<%=request.getContextPath()%>/workflow/wfmanager/main/left.jsp";
			}
   		}
   		
   		
	</script>
</head>
<body onload='refreshLeftTree(<b:write property="flag"/>)' style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
	<form name="packageForm" method="post" action="com.primeton.workflow.manager.def.getAllProcessDef.flow">
   <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="process_mgr_jsp.deployedComponentPackage"/></h3></td><!-- 已部署的构件包 -->
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
			   <td width="100%" height="100%" valign="top">
					 
					<table border="0" class="EOS_table" width="100%">
				<tr class="EOS_table_head">
				  <th width="43%"><b:message key="edit_autoact_info_jsp.name"/></th><!-- 名称 -->
				  <th width="25%"><b:message key="deploy_result_list_jsp.processNumber"/></th><!-- 流程数量 -->
				</tr>
					<l:iterate id="view" property="packages" scope="request">
						<tr class="EOS_table_row">
							  <td><a href='com.primeton.workflow.manager.def.getAllProcessDef.flow?pkgId=<b:write iterateId="view" property="packageID"/>' target="middle">
							  		<b:write iterateId="view" property="packageName"/>
							  	  </a>
							  </td>
							  <td><b:write iterateId="view" property="processCount"/></td>
						</tr>
					</l:iterate>		 
			  </table>
			  <br>
				    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                        	<% if(product!=null&&product.equals("Primeton EOS")){  %>
								<input type="button" name="pub2" value="<b:message key="process_list_jsp.extractVersion"/>" class="button" onclick="uploadMultiProcesses()"><!-- 从资源库提取版本 -->
                        	<%} else { %>
                        	<input type="button" name="pub2" value="<b:message key="process_mgr_jsp.deployBizProcess"/>" class="button" onclick="uploadEcdProcesses()"><!-- 部署业务流程 -->                        	 
                        	<%} %>
                        </td>
                      </tr>
                    </table></td>
			</tr>
		</table>
</td></tr>
</table> 
</form>
</body>
</html>