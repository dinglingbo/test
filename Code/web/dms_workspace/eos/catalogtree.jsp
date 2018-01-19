<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
	String bizCatalog = ResourcesMessageUtil.getI18nResourceMessage("permission_common.busi_catalog");
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
	function addCatalog(oTree){
		var curNode = oTree.getSelectNode();
		if(curNode==null){
			return;
		}
		if(!curNode.isRootNode()&&null!=curNode.getProperty('formChName')){
			var ss = curNode.getProperty('formChName');
			window['returnValue'] = curNode;
			window.close();
		}else{
			return;
		}
	}
	function back(){
		returnValue();
		window.close();
	}

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
	
	function getParam(){
    	return "<treeType>3</treeType>";
    }
    
    function getPermType(){
    	return "<permType>3</permType>";
    }
    
    function getPermType2(){
    	var curCatalogUUID = $name("bizviewobj/catalogUUID").value;
//    	alert(curCatalogUUID);
    	return "<permType>3</permType><curCatalogUUID>"+curCatalogUUID+"</curCatalogUUID>";
    }

	function nodeRefresh(node){
		node.reloadChild();
	}

	function refresh(node){
	   //if(node.getProperty("isLeaf")=="1") node.setLeaf(); 
	}
	
	/** 兼容性方法 **/
	function dealScroll(){
		if (window.isFF){
			var treediv =$id("treediv");
			//if(!treediv){
				treediv.style.height=document.body.clientHeight-40;
			//}
		}
	}
	
	function returnValue(node){
		window['returnValue']=  node;
		window.close();
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
<form name="form1" action="com.bps.workspace.handler.catalogtree.flow" method="post" >
<h:hidden name="bizviewobj/catalogUUID" property="curCatalogUUID"/>
	<tr>
		<td valign="top" style="border-left:1px solid #7ACBFF; border-right:1px solid #7ACBFF;">
			<div id="treediv" style="width: 100%;height: 95%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
			<nobr>
			<r:rtree expandLevel="2" id="catalogtree">
			  <r:treeRoot action="com.primeton.bps.web.composer.common.catalogtree.getTopTreeNode.biz" childEntities="cataloglist" display="<%=bizCatalog %>" initParamFunc="getParam" onDblclickFunc="nodeRefresh">
			  </r:treeRoot>			  
			  <r:treeNode action="com.bps.workspace.handler.BFSTree.getTreeRoot.biz" childEntities="catalogsubs,bfspackages" nodeType="cataloglist" showField="catalogName" submitXpath="querySub" initParamFunc="getPermType2" onRefreshFunc="refresh" onDblclickFunc="nodeRefresh">
			  </r:treeNode>
			  <r:treeNode action="com.bps.workspace.handler.BFSTree.getTreeSubByBFS.biz" childEntities="catalogsubs,bfspackages" nodeType="catalogsubs" showField="catalogName" submitXpath="querySub" initParamFunc="getPermType2" onRefreshFunc="refresh" onDblclickFunc="nodeRefresh">
			  </r:treeNode>
			  
			  <r:treeNode action="com.bps.workspace.handler.BFSTree.getFormTemplateList.biz" childEntities="bfstemplates" nodeType="bfspackages" onClickFunc="showResourceIndex" showField="packChName" submitXpath="pack" initParamFunc="getPermType" onRefreshFunc="refresh" onDblclickFunc="nodeRefresh" icon="/images/bfs/bfs_pkg_ico.gif">
			  </r:treeNode>
			  
			  <r:treeNode nodeType="bfstemplates" showField="formChName"  initParamFunc="getPermType" onRefreshFunc="refresh" onDblclickFunc="returnValue" icon="/images/bfs/bfs_form_ico.gif">
			  </r:treeNode>
			  
			</r:rtree>
			</nobr>
			</div>
		</td>
		
	</tr>
	<tr align="center" style="height:10%">
		<td>
			<input type ="button" class="button" value="<b:message key="catalogtree_jsp.ok"/>" id="ok" onclick="addCatalog($id('catalogtree'))" style="width:65" />
			<input type ="button" class="button" value="<b:message key="catalogtree_jsp.back"/>" id="cancel" onclick="back()" style="width:65;float:none" />
		</td>
	</tr>

</table>
</form>
</body>
</html>