<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
		parent.left.refreshNode();
   		//function comfirmDeploy(){
   			//pNode = parent.left.tree.cur_node;
			//parent.left.refreshTree(pNode);
			//window.close();
   		//}
	</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
	<form name="packageForm" method="post" action="com.primeton.workflow.manager.def.getAllProcessDef.flow">
   <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="deploy_result_list_jsp.workarea_title"/></h3></td><!-- 已部署的业务目录 -->
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
					<l:iterate id="catalog" property="catalogs" scope="request">
						<tr class="EOS_table_row">
							  <td>
							  	<a href='com.primeton.workflow.manager.def.getProcessByCatalogID.flow?catalogUUID=<b:write iterateId="catalog" property="catalog/catalogUUID"/>' target="middle">
							  		<b:write iterateId="catalog" property="catalog/catalogName"/>
							  	</a>
							  </td>
							  <td><b:write iterateId="catalog" property="processCount"/></td>
						</tr>
					</l:iterate>		 
			  	</table>
			  	<br>
			  		<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td align="center">
							<!--<input type="button" name="ok" value="  确定  " class="button" onclick="comfirmDeploy();">-->
                        </td>
                      </tr>
                    </table>
				</td>
			</tr>
		</table>
</td></tr>
</table> 
</form>
</body>
</html>