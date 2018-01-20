<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String busi_catalog = ResourcesMessageUtil.getI18nResourceMessage("permission_common.busi_catalog");
%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-22 16:05:02
  - Description:
-->
<head>
<title>CatalogTree</title>
<style type="text/css">
<!--
.left_tree {
	background:#EEF3F6;
	display:inline;
	border-top-width: 1px;
	border-right-width: 1px;
	border-bottom-width: 1px;
	border-left-width: 1px;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
	border-top-color: #75B5C3;
	border-right-color: #75B5C3;
	border-bottom-color: #75B5C3;
	border-left-color: #75B5C3;
}
-->
</style>
<script>

	/** 树节点操作方法 **/
	function showCatalogDesc (node) {
		parent.frames["right"].window.location.href = "com.primeton.bps.web.composer.bizresouce.BizResMgr.flow?_eosFlowAction=desc";
	}
	
	function showResourceIndex(node){
		var nodeid=node.getProperty("catalogUUID");
		if(nodeid=="0"){
			//全局业务目录
			parent.frames["right"].window.location.href = "com.primeton.bps.web.composer.bizresouce.BizResMgr.flow?_eosFlowAction=global";
		}else if(nodeid=="1"){
			//领域级业务目录
			parent.frames["right"].window.location.href = "com.primeton.bps.web.composer.bizresouce.BizResMgr.flow?_eosFlowAction=desc2";
		}
	}
	
	function showResourceInfo(node){
		var nodeid=node.getProperty("catalogUUID");
		var permType=node.getProperty("directFlag");
		parent.frames["right"].window.location.href = "com.primeton.bps.web.composer.bizresouce.BizResMgr.flow?_eosFlowAction=catalog&cid="+nodeid+"&permType="+permType;
	}
	
	function getParam(){
    	return "<treeType>3</treeType>";
    }
    
    function getPermType(){
    	return "<permType>3</permType>";
    }

	function nodeRefresh(node){
		node.reloadChild();
	}

	function refresh(node){
	   if(node.getProperty("isLeaf")=="1") node.setLeaf();

	}
	
	/** 兼容性方法 **/
	function dealScroll(){
 		if (document.compatMode == "BackCompat") {
			treeHeight = document.body.clientHeight;
			}
			else {
			treeHeight = document.documentElement.clientHeight;
		} 
		if (isIE7 || isIE8) { 
 			treeHeight -= 30;
 		}
 		else if (isIE9) { 
 			treeHeight -= 35;
 		}
 		else {
 			treeHeight = treeHeight - 100;
 		}
 		
		$id("treediv").style.height = treeHeight;
	}
	
	window.onload = function(){
		dealScroll();
	}
	
	window.onresize = function(){
		dealScroll();
	}
</script>
</head>
<body style="background:#EAF0F1;margin-top:0px;margin-left:0px;margin-right: 0px;margin-buttom:0px;width: 100%;height: 100%;">
<table cellpadding="0" cellspacing="0"  bgcolor="#EEF3F6" style="width: 100%;height: 100%;table-layout:fixed;">
	<tr>
		<td class="tree_head"><h2><b:message key="index_tree_jsp.tree_title"/></h2></td>
	</tr>
	<tr>
		<td valign="top" style="border-left:1px solid #7ACBFF; border-right:1px solid #7ACBFF;">
			<div id="treediv" style="width: 100%;height: 100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
			<nobr>
			<r:rtree expandLevel="2" id="catalogtree">
			  <r:treeRoot action="com.primeton.bps.web.composer.common.catalogtree.getTopTreeNode.biz" childEntities="cataloglist" display="<%=busi_catalog%>" initParamFunc="getParam" onClickFunc="showCatalogDesc" onDblclickFunc="nodeRefresh">
			  </r:treeRoot>
			  <r:treeNode action="com.primeton.bps.web.composer.common.catalogtree.getTreeRoot.biz" childEntities="catalogsubs" nodeType="cataloglist" onClickFunc="showResourceIndex" showField="catalogName" submitXpath="querySub" initParamFunc="getPermType" onRefreshFunc="refresh" onDblclickFunc="nodeRefresh">
			  </r:treeNode>
			  <r:treeNode action="com.primeton.bps.web.composer.common.catalogtree.getTreeSub.biz" childEntities="catalogsubs" nodeType="catalogsubs" onClickFunc="showResourceInfo" showField="catalogName" submitXpath="querySub" initParamFunc="getPermType" onRefreshFunc="refresh" onDblclickFunc="nodeRefresh">
			  </r:treeNode>
			</r:rtree>
			</nobr>
			</div>
		</td>
	</tr>
</table>
</body>
</html>