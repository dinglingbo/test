<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String busiCatalog = ResourcesMessageUtil.getI18nResourceMessage("permission_common.busi_catalog");
%>

<html>
<!-- 
  - Author(s): bps
  - Date: 2009-07-21 15:52:29
  - Description:
-->
<head>
<title><b:message key="permission_common.busi_catalog_tree"/></title>
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
</head>
<body style="background:#EAF0F1;margin-top:0px;margin-left:0px;margin-right: 0px;margin-buttom:0px;width: 100%;height: 100%;">
<table cellpadding="0" cellspacing="0"  bgcolor="#EEF3F6" style="width: 100%;height: 100%;table-layout:fixed;">
	<tr>
		<td class="tree_head"><h2><b:message key="catalog_process_custom_tree_jsp.busi_proc_cust"/></h2></td>
	</tr>
	<tr>
		<td valign="top" style="border-left:1px solid #7ACBFF; border-right:1px solid #7ACBFF;">
		<div id="treediv" style="width: 100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
		<nobr>
			<r:rtree expandLevel="2" id="catalogFlowTree" >
			  <r:treeRoot action="com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.getTopTreeNode.biz" 
			              childEntities="cataloglist" 
			              display="<%=busiCatalog%>" 
			              initParamFunc="getParam" 
			              onClickFunc="showCatalogDesc" onDblclickFunc="nodeRefresh"/>
			  <r:treeNode action="com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.getTreeRootAndProcessDefNode.biz" 
			              childEntities="catalogsubs,processdefineList" 
			              nodeType="cataloglist" 
			              submitXpath="querySub" 
			              showField="catalogName" 
			              onClickFunc="queryProcessDef" 
			              onDblclickFunc="nodeRefresh" 
			              onRefreshFunc="" 
			              initParamFunc="getParam"/>					              
			  <r:treeNode action="com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.getTreeSubAndProcessDefNode.biz" 
			              childEntities="catalogsubs,processdefineList" 
			              nodeType="catalogsubs" 
			              submitXpath="querySub" 
			              showField="catalogName" 
			              onClickFunc="queryProcessDef" 
			              onDblclickFunc="nodeRefresh" 
			              onRefreshFunc="" 
			              initParamFunc="getParam"/>
			  <r:treeNode action="" 
			              childEntities="processdefineList" 
			              nodeType="processdefineList" 
			              showField="processDefCHName" 
			              onClickFunc="queryProcessDefDetail" 
			              onRefreshFunc="refresh"
			              icon="/workflow/wfmanager/images/processdef.gif"
			              />
			</r:rtree>
	       </nobr>
	       </div>
		</td>
	</tr>
</table>
</body>
</html>
<script>
   function getParam(){
    	return "<treeType>1</treeType>";
   }
   function refresh(node){
   	   var modFlag = node.getProperty("modifyState");
   	   if(modFlag=="1"){
   	   	  node.setIcon("/workflow/bps_composer/common/images/W_modify.gif");
   	   	  node.cell.style.color="red";
   	   }
   	   if(modFlag=="0"){
	  	  node.setIcon("/workflow/bps_composer/common/images/W_submission.gif");
   	   	  //node.setText(node.getText());
   	   }
   	   if(modFlag=="9"){
	 	  node.setIcon("/workflow/bps_composer/common/images/W_new.gif");
	 	  node.cell.style.color="red";
   	   	  //node.setText("<font color='red'>"+node.getText()+"</font>");
   	   }
   	   if(node.getProperty("isLeaf")=="1") node.setLeaf();
	}
   function nodeRefresh(node){
		node.reloadChild();
	}
	
		/** 树节点操作方法 **/
	function showCatalogDesc (node) {
		parent.frames["right"].window.location.href = "com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomFrame.flow?_eosFlowAction=desc";
	}
	
   function queryProcessDef(node){
		var param=node.getProperty("catalogUUID");
		var permType=node.getProperty("directFlag");
		if (param != 1) {
			try{
				if(param=="99999"){
					permType="Y";
				}
				parent.frames["right"].window.location.href="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomMgr.flow?_eosFlowAction=init&page/isCount=true&queryCatalogUUID=" + param + "&treeType=1&permType="+permType;
			}catch(e){
			 	alert("query error!");            
			}
	    } else {
	       parent.frames["right"].window.location.href="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomFrame.flow?_eosFlowAction=desc_noopt";
	    }
		
	}
	
	function queryProcessDefDetail(node){
		var param=node.getProperty("processDefID");
		var param1=node.getProperty("processDefName");
		var param2=node.getProperty("catalogUUID");
		if(param2==null){
			param2 = "-1";
		}
		try{
			parent.frames["right"].window.location.href="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomMgr.flow?_eosFlowAction=expand&wfbizprocess/processDefID=" + param + "&wfbizprocess/processDefName=" + param1 + "&queryCatalogUUID=" + param2 +"&treeType=1";
		}catch(e){
			 alert("query error!");            
		}
	}
	
	/** 兼容性方法 **/
 	function dealScroll(){
 		debugger;
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
 		
		var tree = $id("treediv");
		tree.style.height = treeHeight;
	}
	window.onload = function(){
		dealScroll();
	}
	
	window.onresize = function(){
		dealScroll();
	}
</script>