<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String busi_catalog = ResourcesMessageUtil.getI18nResourceMessage("permission_common.busi_catalog");
%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-08-05 16:10:26
  - Description:
-->
<head>
<title><b:message key="biz_process_move_copy_jsp.title"/></title>
<%
	String processDefCHName = request.getParameter("processDefCHName");
	if (processDefCHName != null) {
		processDefCHName = URLDecoder.decode(processDefCHName,"UTF-8");
		request.setAttribute("processDefCHName", processDefCHName);
	}
 %>
</head>
<body>
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td><span id="showSelNodeText"><b:message key="biz_process_move_copy_jsp.select_target_catalog"/></span></td>
	</tr>
  	<tr> 
    	<td id="treeTD" width="100%" height="265px" style="width:300px;border:1px solid #75B5C3;">
    		<div id="orgTreediv1" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
			<nobr>
				<r:rtree expandLevel="1" id="catalogFlowTree">
				  <r:treeRoot action="com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.getTopTreeNode.biz" 
				              childEntities="cataloglist" 
				              display="<%=busi_catalog%>" 
				              initParamFunc="getParam" 
				              onClickFunc="" 
				              onDblclickFunc="nodeRefresh"/>
				  <r:treeNode action="com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.getTreeRootAndProcessDefNode.biz" 
				              childEntities="catalogsubs" 
				              nodeType="cataloglist" 
				              submitXpath="querySub" 
				              showField="catalogName" 
				              onClickFunc="clickNode" 
				              onDblclickFunc="" 
				              onRefreshFunc="" 
				              initParamFunc="getParam" 
				              preload="true"/>					              
				  <r:treeNode action="com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.getTreeSubAndProcessDefNode.biz" 
				              childEntities="catalogsubs" 
				              nodeType="catalogsubs" 
				              submitXpath="querySub" 
				              showField="catalogName" 
				              onClickFunc="clickNode" 
				              onDblclickFunc="" 
				              onRefreshFunc="" 
				              initParamFunc="getParam" 
				              preload="true"/>
				</r:rtree>
	         <nobr>
	         </div>
	     </td>
	 </tr>
   <l:equal property="operate" targetValue="1" compareType="number">
   <tr>
   	<td>
     <table class="EOS_table" width="100%">
		<tr>
			<td width="50%"><b:message key="biz_process_move_copy_jsp.target_dis_name"/></td>
			<td><h:text property="processDefCHName" /></td>
		</tr>
		<tr>
			<td ><b:message key="biz_process_move_copy_jsp.target_def_name"/></td>
			<td><h:text property="processDefName" /></td>
		</tr>
	</table>
	</td>
	</tr>
  </l:equal>	
	<tr>
		<td align="center">
			<h:hidden property="tempProcessDefID"/>
			<h:hidden property="modifyState"/>
			<input type="hidden" value="" id="directFlag"/>
			<input type="hidden" value="" id="selCatalogID"/>
			<input id="btnOK" name="btnOK" type="button" value='<b:message key="permission_common.btn_ok"/>' onclick="save()" class="button">
			<input id="btnCancel" name="btnCancel" type="button" value='<b:message key="permission_common.btn_cancel"/>' onclick="cancel()" class="button">
		</td>
	</tr>
</table>
</body>
</html>
<script>
   var ret = new Array(2);
   function getParam(){
    	return "<treeType>1</treeType>";
   }
   
   function nodeRefresh(node){
		node.reloadChild();
   }
	
   function refresh(node){
	   if(node.getProperty("isLeaf")=="1") node.setLeaf();
   }
   
   function clickNode(node){
   	   hiddenResponseMessage($id("ResponseMessage"));
   	   $id('directFlag').value=node.getProperty("directFlag");
       $id('selCatalogID').value=node.getProperty("catalogUUID");
       $id("showSelNodeText").innerHTML="<b:message key='biz_process_move_copy_jsp.selected_catalog'/><font color='red'>"+node.getProperty("catalogName")+"</font>";
   }
   
   function save(){
   		hiddenResponseMessage($id("ResponseMessage"));
        if($id('selCatalogID').value =="" || $id('selCatalogID').value == null || $id('selCatalogID').value == "undefined") {
           showMessage($id("ResponseMessage"),'<b:message key='biz_process_move_copy_jsp.select_catalog_tip'/>');
           return false;
        }
        if($id('selCatalogID').value =="99999")
           $id('selCatalogID').value ="";
        if($id('selCatalogID').value =="1") {
           showMessage($id("ResponseMessage"),'<b:message key="biz_process_move_copy_jsp.domain_no_proc"/>');
           return false;
        }
        <l:equal property="operate" targetValue="2" compareType="number">
        var srcCatalogUUID = '<b:write property="catalogUUID" />';
        if($id('selCatalogID').value ==srcCatalogUUID) {
           showMessage($id("ResponseMessage"),'<b:message key="biz_process_move_copy_jsp.cannot_move"/>');
           return false;
        }
        </l:equal>
        if($id('directFlag').value!="Y"&&$id('selCatalogID').value!=""){
			showMessage($id("ResponseMessage"),'<b:message key="biz_process_move_copy_jsp.cannot_move_no_perssion"/>');
			return;
		}
        <l:equal property="operate" targetValue="1" compareType="number">
        	saveCopyProcess();
		</l:equal>
        <l:equal property="operate" targetValue="2" compareType="number">
        	saveMoveProcess();
        </l:equal>
	}
	
	function f_check_defname(str){
        var reg = /^[a-zA-Z_]{1}([a-zA-Z0-9_]|[.]){0,254}([a-zA-Z0-9_])$/;
        var reg2 = /^[a-zA-Z_]{1}([a-zA-Z0-9_]){0,1}$/;
        if(str.length<2){
        	if(!reg2.test(str)){
	            showMessage($id("ResponseMessage"),'<b:message key="biz_process_add_jsp.check_define2"/>');
	            $name("processDefName").focus(); 
	            return false;
	        } 
        }else{
	        if(!reg.test(str)){
	            showMessage($id("ResponseMessage"),'<b:message key="biz_process_add_jsp.check_define2"/>');
	            $name("processDefName").focus(); 
	            return false;
	        } 
        }
        return true;
    }
	
	function checkCopyProcessInput(){
		//不为空判断
		if($name("processDefCHName").value==""){
			showMessage($id("ResponseMessage"),'<b:message key="biz_process_move_copy_jsp.display_name_not_null"/>');
			$name("processDefCHName").focus(); 
			return false;
		}	
		if($name("processDefName").value==""){
			showMessage($id("ResponseMessage"),'<b:message key="biz_process_move_copy_jsp.define_name_not_null"/>');
			$name("processDefName").focus(); 
			return false;
		}
		return f_check_defname($name("processDefName").value);
	}

	function saveCopyProcess() {
		if(!checkCopyProcessInput()){
			return;
		}
        var catalogUUID = $id('selCatalogID').value;
        var tempProcessDefID = $name("tempProcessDefID").value;
        var processDefName = $name('processDefName').value;
        var processDefCHName = $name('processDefCHName').value;
        
        var myAjax = new Ajax("com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.copyProcess.biz");
        myAjax.addParam("srcProcessDefID", tempProcessDefID);
        myAjax.addParam("targetDefName", processDefName);
        myAjax.addParam("targetCHName", processDefCHName);
        myAjax.addParam("catalogUUID", catalogUUID);
        myAjax.submit();
        var retFlag = myAjax.getValue("root/data/ret/code");
        if (retFlag==1){
            ret[0]="Y";
            ret[1]=catalogUUID;
	        window['returnValue'] = ret;
	        window.close();
        }else{
            showMessage($id("ResponseMessage"),myAjax.getValue("root/data/ret/name"));
			return;
        }
     }
	
     function saveMoveProcess() {
        var catalogUUID = $id('selCatalogID').value;
        var tempProcessDefID = $name("tempProcessDefID").value;
        var modifyState = $name("modifyState").value;
        
        var myAjax = new Ajax("com.primeton.bps.web.composer.bizflowmgr.bizprocessmgr.moveProcess.biz");
        myAjax.addParam("wfbizprocess/processDefID", tempProcessDefID);
        myAjax.addParam("wfbizprocess/catalogUUID", catalogUUID);
        myAjax.addParam("wfbizprocess/modifyState", modifyState);
        myAjax.submit();
        var retFlag = myAjax.getValue("root/data/ret/code");
        if (retFlag==1){
            ret[0]="Y";
            ret[1]=catalogUUID;
	        window['returnValue'] = ret;
	        window.close();
        }else{
            showMessage($id("ResponseMessage"),myAjax.getValue("root/data/ret/name"));
			return;
        }
     }
	
   function cancel(){
		ret[0]="N";
		// 定义窗口关闭时的返回值
        window['returnValue'] = ret;
        window.close();
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
	
	window.onload = function(){
		dealScroll();
	}
	
	window.onresize = function(){
		dealScroll();
	}
	
	<l:equal property="operate" targetValue="1" compareType="number">
		$name('processDefName').value = '<b:write property="processDefName" />'+'_copy';
		$name('processDefCHName').value = '<b:write property="processDefCHName" />'+'<b:message key='biz_process_move_copy_jsp.str_copy'/>';//_副本
		$id('treeTD').height = '210px';
    </l:equal>
</script>