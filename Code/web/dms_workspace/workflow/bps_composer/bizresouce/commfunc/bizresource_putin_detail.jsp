<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String procRefRes = ResourcesMessageUtil.getI18nResourceMessage("bizresource_refs_jsp.proc_ref_res");
String ruleRefRes = ResourcesMessageUtil.getI18nResourceMessage("bizresource_refs_jsp.rule_ref_res");
%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-08-07 16:03:28
  - Description:
-->
<head>
<title><b:message key="bizresource_putin_detail_jsp.res_detail"/></title><!-- 资源明细信息 -->
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="bizresource_putin_detail_jsp.biz_res_desc"/></h3></td><!-- 业务资源描述 -->
  	</tr>
  	<tr> 
    	<td width="100%">
			&nbsp;<b:write property="resDesc" />
		</td>
	</tr>	
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="bizresource_putin_detail_jsp.biz_res_ref"/></h3></td><!-- 业务资源相关引用 -->
  	</tr>
  	<tr>
  		<td>
  			<div style="border:1px solid #dddddd;width:100%;height:180;overflow: auto;overflow-x: auto;overflow-y: auto;float: left;" >
  			<table>
  				<tr>
		  			<td>
						<l:equal property="count" targetValue="0" compareType="number"><b:message key="bizresource_refs_jsp.no_ref_res"/></l:equal><!-- 此业务资源没有被引用 -->
						<l:notEqual property="count" targetValue="0" compareType="number"><b:message key="bizresource_refs_jsp.has_ref_res"/></l:notEqual><!-- 业务资源被引用情况如下 -->
		    		</td>
				</tr>
				<l:in property="count" targetValue="1,3">
				<tr height="100"><td>
				<div id="orgTreediv1" style="width:100%;height:100%;overflow: auto;overflow-x: auto;overflow-y: auto;float: left;" >
				<nobr>
				<w:tree hasCheckBox="false" hasRoot="true" id="flowtree" height="100%">
				  <w:treeRoot display="<%=procRefRes%>"/><!-- 引用了此业务资源的流程 -->
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
				<w:tree hasCheckBox="false" hasRoot="true" id="ruletree" height="100%">
				  <w:treeRoot display="<%=procRefRes%>"/><!-- 引用了此业务资源的规则 -->
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