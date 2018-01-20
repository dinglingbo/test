<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String proc_ref_res_info = ResourcesMessageUtil.getI18nResourceMessage("reference_jsp.proc_ref_res_info");
String rules_ref_res_info = ResourcesMessageUtil.getI18nResourceMessage("reference_jsp.rules_ref_res_info");
%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-08-04 13:41:09
  - Description:
-->
<head>
<title><b:message key="reference_jsp.res_reference"/></title>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="320px">
	<tr>
		<td class="workarea_title" valign="middle"><h3>[<b:write property="resouceName"/>]&nbsp;<b:message key="reference_jsp.res_desc"/></h3></td>
  	</tr>
  	<tr height="10%" valign="top"> 
    	<td width="100%">
			&nbsp;<b:write property="resouceDesc" />
		</td>
	</tr>	
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="reference_jsp.res_reference"/></h3></td>
  	</tr>
  	<tr height="90%" valign="top">
  		<td>
  			<div style="border:1px solid #dddddd;width:100%;height:240;overflow: auto;overflow-x: auto;overflow-y: auto;float: left;" >
  			<table>
  				<tr>
		  			<td>
						<l:equal property="count" targetValue="0" compareType="number"><b:message key="reference_jsp.res_not_ref_info"/></l:equal>
						<l:notEqual property="count" targetValue="0" compareType="number"><b:message key="reference_jsp.res_ref_info"/></l:notEqual>
		    		</td>
				</tr>
				<l:in property="count" targetValue="1,3">
				<tr><td>
				<div id="orgTreediv1" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
				<nobr>
				<w:tree hasCheckBox="false" hasRoot="true" id="flowtree">
				  <!-- 引用了此业务资源的流程： -->
				  <w:treeRoot display="<%=proc_ref_res_info%>"/>
				  <w:treeNode nodeType="WFBizResourceUnit" showField="name" xpath="flowRefs">
				  	<w:treeRelation field="pid" parentField="id" parentNodeType="WFBizResourceUnit"/>
					<w:treeRelation field="pid" parentNodeType="root" value="flow"/>
				  </w:treeNode>
				</w:tree>
				</nobr>
				</div>
				</td></tr>
				</l:in>
				<l:in property="count" targetValue="2,3">
				<tr><td>
				<div id="orgTreediv1" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
				<nobr>
				<w:tree hasCheckBox="false" hasRoot="true" id="ruletree">
				  <!-- 引用了此业务资源的规则： -->
				  <w:treeRoot display="<%=rules_ref_res_info%>"/>
				  <w:treeNode nodeType="WFBizResourceUnit" showField="name" xpath="ruleRefs">
					<w:treeRelation field="pid" parentField="id" parentNodeType="WFBizResourceUnit"/>
					<w:treeRelation field="pid" parentNodeType="root" value="rule"/>
				  </w:treeNode>
				</w:tree>
				</nobr>
				</div>
				</td></tr>
				</l:in>
			</table>
			</div>
		</td>
	</tr>
</table>
</body>
</html>