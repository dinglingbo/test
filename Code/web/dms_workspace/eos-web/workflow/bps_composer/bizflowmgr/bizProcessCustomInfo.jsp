<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String commited = ResourcesMessageUtil.getI18nResourceMessage("biz_process_custom_info_jsp.modify_desc_committed");
String edited = ResourcesMessageUtil.getI18nResourceMessage("biz_process_custom_info_jsp.modify_desc_edited");
String uncommited = ResourcesMessageUtil.getI18nResourceMessage("biz_process_custom_info_jsp.modify_desc_uncommitted");
%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-07-23 11:36:19
  - Description:
-->
<head>
<title><b:message key="permission_common.biz_proc_cfg"/></title>
<%
com.primeton.data.sdo.impl.DataObjectImpl wfbizprocess = (com.primeton.data.sdo.impl.DataObjectImpl)request.getAttribute("wfbizprocess");
String modify = wfbizprocess.getString("modifyState");
String modifyDesc = "";
String mdfState = "1";
if("0".equals(modify)){
	modifyDesc = commited;
}else if("1".equals(modify)){
	modifyDesc = edited;
}else if("9".equals(modify)){
	modifyDesc = uncommited;
	mdfState = "9";
}
 %>
</head>
<body onLoad="initiFrame()">
<div id="AlertMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="biz_process_custom_info_jsp.title"/></h3></td>
  	</tr>
  	<tr> 
    	<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
		<tr>
			<td class="workarea_title" valign="middle" colspan="2"><h3><b:message key="biz_process_custom_info_jsp.basic_info"/></h3></td>
  		</tr>
		<tr>
			<td class="form_label" width="20%"><b:message key="biz_process_custom_info_jsp.proc_display_name"/></td>
			<td><b:write property="wfbizprocess/processDefCHName" /></td>
		</tr>
		<tr>
			<td class="form_label" width="20%"><b:message key="biz_process_custom_info_jsp.proc_define_name"/></td>
			<td><b:write property="wfbizprocess/processDefName" /></td>
		</tr>
		<tr>
			<td class="form_label" width="20%"><b:message key="biz_process_custom_info_jsp.owned_busi_catalog"/></td>
			<td><b:write property="pathName" /></td>
		</tr>
		<tr>
			<td class="form_label" width="20%"><b:message key="biz_process_custom_info_jsp.proc_desc"/></td>
			<td style="word-break:break-all;"><b:write property="wfbizprocess/description" /></td>
		</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
		<tr>
			<td class="workarea_title" valign="middle" colspan="2"><h3><b:message key="biz_process_custom_info_jsp.proc_status"/></h3></td>
  		</tr>	
		<tr>
			<td class="form_label" width="20%"><b:message key="biz_process_custom_info_jsp.current_release"/></td>
			<td>
			<l:notEmpty property="wfbizprocess/instanceVersion">
			<b:write property="wfbizprocess/instanceVersion" />
			</l:notEmpty>
			<l:empty property="wfbizprocess/instanceVersion">
			<b:message key="biz_process_custom_info_jsp.no_release_info"/>
			</l:empty>
			</td>
		</tr>
		<tr>
			<td class="form_label" width="20%"><b:message key="biz_process_custom_info_jsp.edited_version_state"/></td>
			<td>
			<l:notEmpty property="wfbizprocess/instanceVersion">
			  <l:equal property="wfbizprocess/instanceVersion" targetProperty="wfbizprocess/versionSign">
			  <b:message key="biz_process_custom_info_jsp.consistent_version"/>(<%=modifyDesc%>)
			  </l:equal>
			  <l:notEqual property="wfbizprocess/instanceVersion" targetProperty="wfbizprocess/versionSign">
			  <b:message key="biz_process_custom_info_jsp.inconsistent_version"/>
			  <b:message key="biz_process_custom_info_jsp.get_from_str1"/><b:write property="wfbizprocess/versionSign"/><b:message key="biz_process_custom_info_jsp.get_from_str2"/>(<%=modifyDesc%>)
			  </l:notEqual>
			</l:notEmpty>
			<l:empty property="wfbizprocess/instanceVersion">
				<b:message key="biz_process_custom_info_jsp.no_release_info"/>(<%=modifyDesc%>)
			</l:empty>
			</td>
		</tr>
		<tr>
			<td class="form_label" width="20%"><b:message key="biz_process_custom_info_jsp.last_edited"/></td>
			<td><b:write property="wfbizprocess/updateTime" formatPattern="yyyy-MM-dd hh:MM"/></td>
		</tr>			
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
		<tr>
			<td class="workarea_title" valign="middle" colspan="2"><h3><b:message key="biz_process_custom_info_jsp.proc_diagram"/></h3>&nbsp;
			<a href="javascript:displayFlow('flowImgInfo')"><span id="hiddentext"><b:message key="biz_process_custom_info_jsp.display"/></span></a>
			</td>
  		</tr>
  		<tr id="flowImgInfo" style="display:none">
  			<td>
  			<iframe width="100%" height="200px" src="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomMgr.flow?_eosFlowAction=flowpic&processDefID=<b:write property="wfbizprocess/processDefID"/>"></iframe>
  			</td>
  		</tr>
  		<tr>
	      <td>            
	        <input id="btnEdit" name="btnEdit" type="button" value='<b:message key="biz_process_custom_info_jsp.btn_edit"/>' class="button" onclick="edit()"><!-- 修改 -->
	        <input id="btnSubmit" name="btnSubmit" type="button" value='<b:message key="biz_process_custom_info_jsp.btn_submit"/>' onclick="doSubmit()" class="button"><!-- 提交 -->
	        <b:size name="listLength" property="procList" toScope="request" />
		    <l:greaterEqual property="listLength" targetValue="1">
		    <input id="btnExt" name="btnExt" type="button" value='<b:message key="biz_process_custom_info_jsp.btn_extract"/>' onclick="doExtract()" class="button"><!-- 提取 -->
		    </l:greaterEqual>
		    <l:equal property="treeType" targetValue="1">
		    <input id="btnMove" name="btnMove" type="button" value='<b:message key="biz_process_custom_info_jsp.btn_move_to"/>' onclick="doMove()" class="button"><!-- 移动到 -->
	        <input id="btnCopy" name="btnCopy" type="button" value='<b:message key="biz_process_custom_info_jsp.btn_copy_to"/>' onclick="doCopy()" class="button"><!-- 复制到 -->
	        <input id="btnDel" name="btnDel" type="button" value='<b:message key="biz_process_custom_info_jsp.btn_del"/>' onclick="doDelete()" class="button"><!-- 删除 -->
	        </l:equal>
	      </td>
	    </tr>
			</table>
		</td>
	</tr>
  </table>
  <div id="exp"/>
</body>
<script>
	var locale ='<b:write property="language" scope="session"/>';
	var hasForm ='<b:write property="hasForm" scope="session"/>';
	function initiFrame(){
		if (isFF) {
			var height = $id('exp').offsetHeight;
			height += 80;
			$id('exp').style.height = height;
		}
	}
	
	function edit() {
		hiddenResponseMessage($id("AlertMessage"));
	    <l:equal property="treeType" targetValue="1">
	 	var editype = "custom";
	 	</l:equal>
	 	<l:equal property="treeType" targetValue="2">
	 	var editype = "config";
	 	</l:equal>
	 	var pageURL = "<%=request.getContextPath()%>/workflow/bps_composer/flex/bizProcessCustomDg.jsp?hasForm="+hasForm+"&locale="+locale+"&processDefID="+ '<b:write property="wfbizprocess/processDefID" />' 
                   +"&catalogUUID=" + '<b:write property="wfbizprocess/catalogUUID" />' 
                   +"&processDefName=" + '<b:write property="wfbizprocess/processDefName" />'
                   +"&processDefCHName=" + '<b:write property="wfbizprocess/processDefCHName" />'
                   +"&description=" + '<b:write property="wfbizprocess/description" />' 
                   +"&author=" + '<b:write property="wfbizprocess/author" />' 
                   + "&editType=" + editype
                   + "&mdfState=<%=mdfState%>";
        var argument = "height ="+(window.screen.availHeight-40)+",width="+(window.screen.availWidth-40)+", top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no";
		window.open(encodeURI(pageURL),"",argument);                       
	 }
     
     function doExtract() {
     	hiddenResponseMessage($id("AlertMessage"));
        var tempProcessDefID = '<b:write property="wfbizprocess/processDefID" />';
        var processDefName = '<b:write property="wfbizprocess/processDefName" />';
        var processDefCHName = '<b:write property="wfbizprocess/processDefCHName" />';
        var pathName = '<b:write property="pathName" />';
        var strUrl = "com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomDeal.flow?tempProcessDefID="+tempProcessDefID+"&processDefName=" + processDefName+  "&processDefCHName="+processDefCHName+"&pathName=" + pathName;
        showModalCenter (encodeURI(encodeURI(strUrl)) ,'',refreshPInfo,600,400,'<b:message key="permission_common.biz_proc_extract"/>');//业务流程提取
      
     }
     
     function doSubmit() {
     	hiddenResponseMessage($id("AlertMessage"));
        var myAjax = new Ajax("com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.validateProcess.biz");
        myAjax.addParam("processDefID", '<b:write property="wfbizprocess/processDefID" />');
	    myAjax.submit();
        
        if(myAjax.getValue("root/data/ret")==null){
        	showMessage($id("AlertMessage"),'<b:message key="biz_process_custom_info_jsp.operation_exception"/>');
        	return false;
        }
        if(myAjax.getValue("root/data/ret") == "-1") {
           showMessage($id("AlertMessage"),'<b:message key="biz_process_custom_info_jsp.proc_validate_error"/>');
           return false;
        }
        var tempProcessDefID = '<b:write property="wfbizprocess/processDefID" />';
        var processDefName = '<b:write property="wfbizprocess/processDefName" />';
        var processDefCHName = '<b:write property="wfbizprocess/processDefCHName" />';
        var operator = '<b:write property="wfbizprocess/operator" />';
        var nowDate = new Date();
        var showDate = dateToString(nowDate, 'yyyy-MM-dd hh:MM');
        var versionDesc = '-------['+operator+']-------\n====='+showDate+'=====';
        var pathName = '<b:write property="pathName" />';
        var strUrl="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomSubmit.flow?_eosFlowAction=submit&tempProcessDefID="+tempProcessDefID+"&processDefName=" + processDefName + "&processDefCHName="+processDefCHName+ "&versionDesc=" + versionDesc + "&pathName=" + pathName;
        //alert(encodeURI(strUrl));
        showModalCenter (encodeURI(encodeURI(strUrl)) ,'',refreshPInfo,600,430,'<b:message key="permission_common.biz_proc_submit"/>');//业务流程提交
     }
     
     function doCopy() {
     	hiddenResponseMessage($id("AlertMessage"));
        var catalogUUID = '<b:write property="wfbizprocess/catalogUUID" />';
        var processDefName = '<b:write property="wfbizprocess/processDefName" />';
        var processDefCHName = '<b:write property="wfbizprocess/processDefCHName" />';
        var tempProcessDefID = '<b:write property="wfbizprocess/processDefID" />';
        var modifyState = '<b:write property="wfbizprocess/modifyState" />';
        var strUrl = "com.primeton.bps.web.composer.bizflowmgr.bizProcessMoveCopy.flow?processDefName="+processDefName+"&processDefCHName="+processDefCHName+"&catalogUUID="+catalogUUID+"&tempProcessDefID="+tempProcessDefID+"&operate=1&modifyState="+modifyState;
        showModalCenter (encodeURI(encodeURI(strUrl)) ,'',refreshPList,300,350,'<b:message key="biz_process_custom_info_jsp.proc_copy"/>');//业务流程复制
     }
     
     function doMove() {
     	hiddenResponseMessage($id("AlertMessage"));
        var catalogUUID = '<b:write property="wfbizprocess/catalogUUID" />';
        var tempProcessDefID = '<b:write property="wfbizprocess/processDefID" />';
        var modifyState = '<b:write property="wfbizprocess/modifyState" />';
        var strUrl = "com.primeton.bps.web.composer.bizflowmgr.bizProcessMoveCopy.flow?catalogUUID="+catalogUUID+"&operate=2&tempProcessDefID="+tempProcessDefID+"&modifyState="+modifyState;
        showModalCenter (strUrl ,'',refreshPList,300,350,'<b:message key="biz_process_custom_info_jsp.proc_move"/>');//业务流程移动
     }
     
     function doDelete(){
	    hiddenResponseMessage($id("AlertMessage"));
      	var argument = new Array(2);
	  	argument[0]='<b:message key="permission_common.process_del_tip"/>';
	  	showModalCenter("<%=request.getContextPath()%>/workflow/bps_composer/common/ConfirmWin.jsp",argument,callBack4Del,'300','125','<b:message key="permission_common.confirm_dialog"/>');
     }
     
     function callBack4Del(value){
		if(value==""){
			return;
		}
    	if(value[0]=="Y"){
	        var myAjax = new Ajax("com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.deleteProcessDefinebiz.biz");
	        myAjax.addParam("select_objs[1]/processDefID", '<b:write property="wfbizprocess/processDefID" />');
	        myAjax.addParam("select_objs[1]/processDefName", '<b:write property="wfbizprocess/processDefName" />');
	        myAjax.addParam("select_objs[1]/catalogUUID", '<b:write property="wfbizprocess/catalogUUID" />');
		    myAjax.submit();
	        if(myAjax.getValue("root/data/RtnMsg/code")==null){
	        	showMessage($id("AlertMessage"),'<b:message key="biz_process_custom_info_jsp.operation_exception"/>');
	        	return false;
	        }
	        if(myAjax.getValue("root/data/RtnMsg/code") == "-1") {
	           showMessage($id("AlertMessage"),myAjax.getValue("root/data/RtnMsg/name"));
	           return false;
	        }
	        var parentNode = getSelectParentNode();
	        parentNode.reloadChild();
	        parentNode.selected();	      
	        clickNode(parentNode);
    	}
  	}
     
     function refreshPList(value){
    	if(value==""){
    		return;
    	}
    	if(value[0]=='Y'){
    		var curNode = getSelectNode();
    		var parentNode = getSelectParentNode();
    		_save_select_node_id = curNode.getProperty("processDefID");
    		_save_select_p_node_id = parentNode.getProperty("catalogUUID");
    		if(value[1]=="<b:write property="wfbizprocess/catalogUUID" />"){
    			parentNode.reloadChild(afterSaveReload);;
    		}else{
				//刷新目标节点
				refreshNodeByCatalogUuid(value[1]);
				Pause(this,1000);//调用暂停函数
				this.NextStep = function() {
			    	//刷新父节点
					var pNode = getTreeNodeByCuid(_save_select_p_node_id);
					pNode.reloadChild(afterSaveReload);
				}
			}
      	}
     }
     
     var _save_select_node = null;
	 var _save_select_node_id = null;
	 var _save_select_p_node_id = null;
	 function refreshPInfo(value){
    	if(value==""){
    		return;
    	}
    	if(value[0]=='Y'){
			if(value[1]!=""){
				alert(value[1]+"<b:message key="permission_common.str_success"/>");
			}
			//刷新树菜单
			var selectNode = getSelectNode();
			var selectParentNode = getSelectParentNode();
			_save_select_node_id = selectNode.getProperty("processDefID");
			selectParentNode.reloadChild(afterSaveReload);
      	}
     }
     
     function afterSaveReload(pNode){
		var curNode = getCurNodeByPIDFromParent(pNode,_save_select_node_id);
		curNode.selected();
		if (isIE) {
			curNode.cell.click();
		} else {		
			clickNode(curNode);
		}
	}
	
	function clickNode(curNode) {
		if (isIE) {
			curNode.cell.click();
		} else {		
			var evt = document.createEvent("MouseEvents");
			evt.initEvent("click", true, true);
			curNode.cell.dispatchEvent(evt); 
		}
	}	
	
	function getCurNodeByPIDFromParent(parentNode,pid){
		var children = parentNode.getChildren();
		var goalNode = "";
		//alert(children.length);
		for(var k=0;k<children.length;k++){
			node = children[k];
			var nodeCuid = node.getProperty("processDefID");
			//alert("nodeCuid=="+nodeCuid+"||curUUID=="+curUUID);
			if(nodeCuid==pid){
				goalNode = node;
				break;
			}
		}
		
		if(goalNode!=""){
			//alert("goal");
			return goalNode;
		}
		//alert("parent");
		return parentNode;
	}
	
	function displayFlow(id){
        var traget=document.getElementById(id);
	    if(traget.style.display=="none"){
	    	$id("hiddentext").innerHTML='<b:message key="biz_process_custom_info_jsp.hide"/>';
	        traget.style.display="";
	    }else{
		    $id("hiddentext").innerHTML='<b:message key="biz_process_custom_info_jsp.display"/>';
	        traget.style.display="none";
	    }
    }
	
	function dealByClose(){
		var selectNode = getSelectNode();
		var selectParentNode = getSelectParentNode();
		_save_select_node_id = selectNode.getProperty("processDefID");
		selectParentNode.reloadChild(afterSaveReload);
	}
</script>
</html>
