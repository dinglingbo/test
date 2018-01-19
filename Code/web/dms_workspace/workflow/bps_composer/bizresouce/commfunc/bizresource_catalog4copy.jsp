<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String bizCatalog = ResourcesMessageUtil.getI18nResourceMessage("permission_common.busi_catalog");
%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-08-05 16:10:26
  - Description:
-->
<head>
<title><b:message key="bizresource_catalog4copy_jsp.biz_res_copy"/></title><!-- 业务资源复制到 -->
<script>
	var ret = new Array(2);
	function init(){
        //取得主页面传过来的参数
        var args = window["dialogArguments"];

        $id('curCatalogID').value = args[0];
        var ids = args[1];
        var names = args[2];
        $id("resType").value = args[3];
        var idStr = "";
        var nameStr = "";
        for(i=0;i<ids.length;i++){
        	idStr += ids[i]+";";
        	nameStr += names[i]+";";
        }
        $id("resIDs").value = idStr;
        $id("resNames").value = nameStr;
        if($id("selCatalogName").value!=""){
        	$id("showSelNodeText").innerHTML="已选目录:<font color='red'>"+$id("selCatalogName").value+"</font>";
        }
    }

	function next(){
		hiddenResponseMessage($id("ResponseMessage"));
		// 定义窗口关闭时的返回值
		var curCatalogID = $id('curCatalogID').value;
		var selCatalogID = $id('selCatalogID').value;
		var resType = $id("resType").value;
		if(selCatalogID==""||curCatalogID==""){
			showMessage($id("ResponseMessage"),'<b:message key="bizresource_catalog4copy_jsp.copy_tip1"/>');//请选择一个可用的业务目录
			return ;
		}
		if(curCatalogID==selCatalogID){
			showMessage($id("ResponseMessage"),'<b:message key="bizresource_catalog4copy_jsp.copy_tip2"/>');//不能把业务资源复制到当前目录
			return ;
		}
		if(resType=="03"||resType=="04"){
			if(selCatalogID=="0"){
				showMessage($id("ResponseMessage"),'<b:message key="bizresource_catalog4copy_jsp.copy_tip3"/>');//资源不能复制到全局业务目录下
				return;
			}
		}
		if($id('directFlag').value!="Y"&&selCatalogID!="0"){
			showMessage($id("ResponseMessage"),'<b:message key="bizresource_catalog4copy_jsp.copy_tip4"/>');//不能把业务资源移动到没有操作权限的目录下
			return;
		}
		var frm = $name("viewlist1");
      	frm.submit();
	}
	
	function cancel(){
		ret[0]="N";
		// 定义窗口关闭时的返回值
        window['returnValue'] = ret;
        window.close();
	}
	
	function clickNode(node){
		hiddenResponseMessage($id("ResponseMessage"));
		$id('directFlag').value=node.getProperty("directFlag");
		if(node.getProperty("catalogUUID")!="1"){
		    $id('selCatalogID').value=node.getProperty("catalogUUID");
		}else{
		    $id('selCatalogID').value="";
		}
		$id("showSelNodeText").innerHTML='<b:message key="permission_common.selected"/><font color="red">'+node.getProperty("catalogName")+"</font>";//已选目录
		$id("selCatalogName").value=node.getProperty("catalogName");
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
</script>
</head>
<body onload='init();'>
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<form name="viewlist1" action="com.primeton.bps.web.composer.bizresouce.BizResCommOpertion.flow" method="post">
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td><span id="showSelNodeText"><b:message key="permission_common.please_select"/></span></td><!-- 请选择目标业务目录 -->
	</tr>
  	<tr> 
    	<td width="100%" height="265px" style="width:300px;border:1px solid #75B5C3;">
    		<div id="orgTreediv1" style="width:100%;height:100%;overflow:auto;overflow-x:auto;overflow-y: auto;float: left;">
			<nobr>
			<r:rtree id="catalogtree">
			  <r:treeRoot action="com.primeton.bps.web.composer.common.catalogtree.getTopTreeNode.biz" childEntities="cataloglist" display="<%=bizCatalog%>" initParamFunc="getParam" onDblclickFunc="nodeRefresh">
			  </r:treeRoot>
			  <r:treeNode action="com.primeton.bps.web.composer.common.catalogtree.getTreeRoot.biz" childEntities="catalogsubs" nodeType="cataloglist" onClickFunc="clickNode" showField="catalogName" submitXpath="querySub" initParamFunc="getPermType" onRefreshFunc="refresh" onDblclickFunc="nodeRefresh">
			  </r:treeNode>
			  <r:treeNode action="com.primeton.bps.web.composer.common.catalogtree.getTreeSub.biz" childEntities="catalogsubs" nodeType="catalogsubs" onClickFunc="clickNode" showField="catalogName" submitXpath="querySub" initParamFunc="getPermType" onRefreshFunc="refresh" onDblclickFunc="nodeRefresh">
			  </r:treeNode>
			</r:rtree>
			</nobr>
			</div>
		</td>
	</tr>
	<tr>
		<td align="center">
			<input type="hidden" value="<b:write property="directFlag"/>" id="directFlag"/>
			<input type="hidden" value="copy_next" name="_eosFlowAction"/>
			<input type="hidden" value="" id="curCatalogID" name="curCatalogID"/>
			<input type="hidden" value="<b:write property="catalogName"/>" id="selCatalogName" name="selCatalogName"/>
			<input type="hidden" value="<b:write property="catalogUUID"/>" id="selCatalogID" name="selCatalogID"/>
			<input type="hidden" value="" id="resIDs" name="resIDs"/>
			<input type="hidden" value="" id="resNames" name="resNames"/>
			<input type="hidden" value="" id="resType" name="resType"/>
			<input id="btnNext" name="btnNext" type="button" class="button" value='<b:message key="permission_common.btn_next_step"/>' onclick="next()"><!-- 下一步 -->
			<input id="btnCancel" name="btnCancel" type="button" class="button" value='<b:message key="permission_common.btn_cancel"/>' onclick="cancel()"><!-- 取消 -->
		</td>
	</tr>
</table>
</form>
</body>
</html>