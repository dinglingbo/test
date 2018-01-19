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
  - Date: 2009-08-03 16:47:34
  - Description:
-->
<head>
<title><b:message key="bizresource_refs_jsp.biz_res_ref_rel"/></title><!-- 业务资源引用关系 -->
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle">
			<l:equal property="count" targetValue="0" compareType="number"><h3><b:message key="bizresource_refs_jsp.no_ref_res"/></h3></l:equal><!-- 此业务资源没有被引用。 -->
			<l:notEqual property="count" targetValue="0" compareType="number"><h3><b:message key="bizresource_refs_jsp.has_ref_res"/></h3></l:notEqual><!-- 业务资源被引用情况如下： -->
    	</td>
  	</tr>
  	<tr valign="top"> 
    	<td width="100%" height="273px">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
<l:in property="count" targetValue="1,3">
			<tr><td>
<w:tree hasCheckBox="false" hasRoot="true" id="flowtree">
  <w:treeRoot display="<%=procRefRes%>"/><!-- 引用了此业务资源的流程 -->
  <w:treeNode nodeType="WFBizResourceUnit" showField="name" xpath="flowRefs">
  	<w:treeRelation field="pid" parentField="id" parentNodeType="WFBizResourceUnit"/>
	<w:treeRelation field="pid" parentNodeType="root" value="flow"/>
  </w:treeNode>
</w:tree>
			</td></tr>
</l:in>

<l:in property="count" targetValue="2,3">
			<tr><td>
<w:tree hasCheckBox="false" hasRoot="true" id="ruletree">
  <w:treeRoot display="<%=ruleRefRes%>"/><!-- 引用了此业务资源的规则 -->
  <w:treeNode nodeType="WFBizResourceUnit" showField="name" xpath="ruleRefs">
	<w:treeRelation field="pid" parentField="id" parentNodeType="WFBizResourceUnit"/>
	<w:treeRelation field="pid" parentNodeType="root" value="rule"/>
  </w:treeNode>
</w:tree>
	</td></tr>
</l:in>
	</table>
	</td></tr>
<tr><td align="center">
<input id="btnClose" name="btnClose" type="button" class="button" value='<b:message key="bizresource_refs_jsp.btn_close"/>' onclick="window.close()"><!-- 关闭 -->
</td></tr>
</body>
</html>