<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
//组织机构
String org = ResourcesMessageUtil.getI18nResourceMessage("participant_tree_jsp.org");
%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-07-21 15:52:29
  - Description:
-->
<head>
<title><b:message key="participant_tree_jsp.part_tree"/></title><!-- 参与者树 -->
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
		<td class="tree_head"><h2><b:message key="participant_tree_jsp.part_cal_cfg"/></h2></td><!-- 参与者日历设置 -->
	</tr>
	<tr>
		<td valign="top" style="border-left:1px solid #7ACBFF; border-right:1px solid #7ACBFF;">
		<div id="treediv" style="width: 100%;height: 100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
		<nobr>
			<r:rtree hasRoot="true" id="orgTree1">
					<r:treeRoot display="<%=org%>" 
					            action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectParticipants.biz" 
					            childEntities="participants" 
					            icon="/workflow/wfcomponent/web/images/participant/process_eos.gif" 
					            onClickFunc="queryParticipantCal"  
					            onDblclickFunc="nodeRefresh"/>
					<r:treeNode action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectChilds.biz" 
					            showField="name" 
					            onRefreshFunc="refreshNode" 
					            initParamFunc="selparam" 
					            nodeType="participants" 
					            childEntities="participants" 
					            icon="/workflow/wfcomponent/web/images/participant/role_view.gif,/workflow/wfcomponent/web/images/participant/role_view.gif" 
					            onClickFunc="setCal" 
					            onDblclickFunc="nodeRefresh"/>
			</r:rtree>
	     </nobr>
	     </div>
	     </td>
	</tr>
</table>
</body>
</html>
<script>
   function refreshNode(node) {
		var type = node.getProperty('typeCode') ;
		setNodeIcon(node,type);

	}
   function selparam(node) {
		var id = node.getProperty('id') ;
		var type = node.getProperty('typeCode') ;
		return "<type>"+type+"</type><id>"+id+"</id>";
	}
   function nodeRefresh(node){
		node.reloadChild();
	}
   function queryParticipantCal(node){
			try{
			parent.frames["right"].window.location.href="com.primeton.bps.web.composer.participantcal.participantCalMgr.flow";
			}catch(e){
			 alert("query error!");            
			}
		
	}
	function setCal(node){
		var id=node.getProperty("id");
		var name=node.getProperty("name");
		var typeCode=node.getProperty("typeCode");
		if (id == "10000") {
		   parent.frames["right"].window.location.href="com.primeton.bps.web.composer.participantcal.participantCalFrame.flow?_eosFlowAction=desc";
		} else {
		   try{
		       var strUrl = "com.primeton.bps.web.composer.participantcal.participantCalMgr.flow?_eosFlowAction=set"
			              +"&calepartiVO/partiID=" + id + "&calepartiVO/partiName=" + name + "&calepartiVO/partiType=" + typeCode + "&viewFlag=0";
		       parent.frames["right"].window.location.href=encodeURI(encodeURI(strUrl));
		   }catch(e){
			 alert("query error!");            
		   }
		}
	}
	
	/** 兼容性方法 **/
	function dealScroll(){
		var treediv =$id("treediv");
		if (window.isFF){
			treediv.style.height=document.body.clientHeight-113;
		}
		else {
			treediv.style.height=document.body.clientHeight-42;
		}
	}
	
	window.onload = function(){
		dealScroll();
	}
	
	window.onresize = function(){
		dealScroll();
	}
</script>