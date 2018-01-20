<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String bizCatalogStr = ResourcesMessageUtil.getI18nResourceMessage("catalog_tree_mgr.busi_catalog");
%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-06-25 17:38:21
  - Description:
-->
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
<head>
<title>CatalogTreeMgr</title>

<script>
	/** 树节点操作方法 **/
	function showCatalogDesc (node) {
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=desc";
	}
	
	function showCatalogInfo (node) {
		var uid = node.getProperty("catalogUuid");
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=view&WFBizCatalogInfo/catalogUuid="+uid;
	}
	
	function addTopCatalog(node){
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=insert&puid=1";
	}
	
	function addCatalog(node){
		var uid = node.getProperty("catalogUuid");
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=insert&puid="+uid;
	}

	function sortTopCatalog(node){
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=sort&querySub/catalogUuid=1";
	}
	
	function sortCatalog(node){
		var uid = node.getProperty("catalogUuid");
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=sort&querySub/catalogUuid="+uid;
	}
	
	function mdfCatalog(node){
		var uid = node.getProperty("catalogUuid");
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=modify&WFBizCatalogInfo/catalogUuid="+uid;
	}
	
	function delCatalog(node){
		var argument = new Array(2);
		
		argument[0] = '<b:message key="catalog_tree_mgr.delete_prompt"/>';
		var param1 = 'node.getProperty("catalogName")';
		argument[0] = argument[0].replace('{0}',param1);//argument[0]="确定要删除["+node.getProperty("catalogName")+"]节点吗?"
		argument[1]=node;
		showModalCenter("<%=request.getContextPath()%>/workflow/bps_catalog/ConfirmWin.jsp",argument,callBack,'300','125',"<b:message key="catalog_tree_mgr.confirm_box"/>");//确认框
	}
	
	function callBack(value){
		if(value==""){
			return;
		}
        if(value[0]=="Y"){
        	var curNode = value[1][1].getParent();
        	var uid = value[1][1].getProperty("catalogUuid");
        	delCatalogByUid(uid,curNode);
        }
   	}
	
	
	function getParam(){
    	return "<WFBizCatalogInfo><parentCatalogUuid>1</parentCatalogUuid></WFBizCatalogInfo>";
    }

	function nodeRefresh(node){
		node.reloadChild();
	}

	function refresh(node){
	   if(node.getProperty("isLeaf")=="1") node.setLeaf();
	}
	
	/** 业务相关方法 **/
	function delCatalogByUid(uid,curNode){
		//调用业务流
        var myAjax = new Ajax("com.primeton.bps.web.bizcatalog.bizcatalogmgr.delCatalog.biz");
		myAjax.addParam("WFBizCatalogInfo/catalogUuid",uid);
		myAjax.submit(); 
		var isSuc =myAjax.getValue("root/data/RtnMsg/code")
		//alert(isSuc);
		if(isSuc==1){
			//刷新树菜单
			curNode.reloadChild();
			curNode.selected();
			if(curNode.isRootNode()){
				parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=desc";
			}else{
				parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=view&WFBizCatalogInfo/catalogUuid="+curNode.getProperty("catalogUuid");							
			}
		}else{
			//提示错误
			alert(myAjax.getValue("root/data/RtnMsg/name"));
		}
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
		<td class="tree_head"><h2><b:message key="catalog_tree_mgr.busi_catalog_mgr"/></h2></td><!-- 业务目录管理 -->
	</tr>
	<tr>
		<td valign="top" style="border-left:1px solid #7ACBFF; border-right:1px solid #7ACBFF;">
			<div id="treediv" style="width: 100%;height: 100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
			<nobr>
			<r:rtree id="catalogtree" >
			  <r:treeRoot action="com.primeton.bps.web.bizcatalog.bizcatalogmgr.getCatalog.biz" childEntities="cataloglist" display="<%=bizCatalogStr%>" initParamFunc="getParam" onClickFunc="showCatalogDesc" onDblclickFunc="nodeRefresh"><!-- 业务目录 -->
			    <%-- <r:treeMenu>
			      <r:treeMenuItem display="新建子目录" onClickFunc="addTopCatalog"/>
			      <r:treeMenuItem display="子目录排序" onClickFunc="sortTopCatalog"/>
			    </r:treeMenu>--%>
			  </r:treeRoot>
			  <r:treeNode action="com.primeton.bps.web.bizcatalog.bizcatalogmgr.getSubCatalog.biz" childEntities="cataloglist" nodeType="cataloglist" onClickFunc="showCatalogInfo" showField="catalogName" submitXpath="querySub" onRefreshFunc="refresh" onDblclickFunc="nodeRefresh">
			    <%--<r:treeMenu>
			      <r:treeMenuItem display="新建子目录" onClickFunc="addCatalog"/>
			      <r:treeMenuItem display="修改当前目录" onClickFunc="mdfCatalog"/>
			      <r:treeMenuItem display="删除当前目录" onClickFunc="delCatalog"/>
			      <r:treeMenuItem display="子目录排序" onClickFunc="sortCatalog"/>
			    </r:treeMenu>--%>
			  </r:treeNode>
			</r:rtree>
			</nobr>
			</div>
		</td>
	</tr>
</table>
</body>
</html>
<script>
	$id("catalogtree").afterShowMenu=function(node,menu){
	 	if(!node.isRootNode()){
	 		if(node.getProperty("isLeaf")=="1"){
	        	//menu.removeMenuItem("子目录排序");//删除菜单项
	    	}
	 	}
	}
//	var func = _rtreeNode_selected;
//	_rtreeNode_selected = function(){
//		func.apply(this,arguments);
//		var rtreeView = findRTree( this );
//		alert(rtreeView.cur_node);
//		rtreeView.cur_node.cell.click();
//	}
</script>