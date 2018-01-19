<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String participant = ResourcesMessageUtil.getI18nResourceMessage("select_participant_jsp.participant");
 %>

<script>   
	var ret = new Array(2);
	var selNode = null;

	function selOneParti(node){
		hiddenResponseMessage($id("AlertMessage"));
		selNode = node;
	}
	
	function selOnePartiAndClose(node){
		hiddenResponseMessage($id("AlertMessage"));
		selNode = node;
		selectAndClose();
	}
	
	function selectAndClose(){
		if(selNode!=null){
			var id = selNode.getProperty('id') ;
			var type = selNode.getProperty('typeCode') ;
			var name = selNode.getProperty('name') ;
			var partiArray = new Array(3);
			partiArray[0]=id;
			partiArray[1]=type;
			partiArray[2]=name;
			
			ret[0]="Y";
			ret[1]=partiArray;
			// 定义窗口关闭时的返回值
	        window['returnValue'] = ret;
	        window.close();
		}else{
			showMessage($id("AlertMessage"),"<b:message key="select_participant_jsp.select_one_participant"/>");//请先选择一个参与者		
		}
	}
	
	function cancel(){
		ret[0]="N";
		// 定义窗口关闭时的返回值
        window['returnValue'] = ret;
        window.close();
	}
			
	function initParam () {
		return "";
	}
	function initParam2(node) {
		var id = node.getProperty('id') ;
		var type = node.getProperty('typeCode') ;
		return "<type>"+type+"</type><id>"+id+"</id>";
	}
	
	function refreshNode(node) {
		var type = node.getProperty('typeCode') ;
		//node.setLeaf();
		setNodeIcon(node,type);

	}
</script>
<body>
<div id="AlertMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td><b:message key="select_participant_jsp.select_participant"/></td><!-- 请选择参与者 -->
	</tr>
	<tr>
		<td width="100%" valign="top" height="285px" style="width:300px;border:1px solid #75B5C3;">
			<div id="orgTreediv" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
			<nobr> 
			<r:rtree hasRoot="true" id="tree">
			<r:treeRoot display="<%=participant%>"
				action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectParticipants.biz"
				initParamFunc="initParam" childEntities="participants" /><!-- 参与者 -->
			<r:treeNode onDblclickFunc="selectItem"
				action="com.primeton.bps.web.bizcatalog.bizcatalogpermission.selectChilds.biz"
				onRefreshFunc="refreshNode" showField="name"
				initParamFunc="initParam2" nodeType="participants"
				childEntities="participants"
				onDblclickFunc="selOnePartiAndClose"
				onClickFunc="selOneParti"
				icon="/workflow/wfcomponent/web/images/participant/role_view.gif,/workflow/wfcomponent/web/images/participant/role_view.gif" />
			</r:rtree>
			</nobr>
			</div>
		</td>
	</tr>
	<tr>
		<td align="center">
			<input type="button" id="okBtn"  class="button" name="close" value="<b:message key="select_participant_jsp.ok"/>" onclick="selectAndClose()"><!-- 确定 -->
			<input type="button" id="cancelBtn"  class="button" name="close" value="<b:message key="select_participant_jsp.cancel"/>"	onclick="cancel()"></td><!-- 取消 -->
	</tr>
</table>
</body>
