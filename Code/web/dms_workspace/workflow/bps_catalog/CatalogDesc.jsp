<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-06-25 17:40:17
  - Description:
-->
<head>
<title>CatalogDesc</title>
<script>
	function addSubCatalog(){
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=insert&comefrom=viewPage&puid=1";
	}
	
	function sortChildrenCatalog(){
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=sort&querySub/catalogUuid=1";
	}
	
	function setPermissionBatch(){
		parent.frames["catalogright"].window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=setBatch";
	}
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3><b:message key="Catalog_Desc.Busi_Catalog_Mgr"/></h3></td><!-- 业务目录管理 -->
  </tr>
  <tr>
	<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
	    <tr><td>
			<input type="button" name="btnsave" id="btnsave1" value="<b:message key="Catalog_Desc.Add_Subcatalog"/>" class="button" onclick="addSubCatalog();"><!-- 新增子目录 -->
			<input type="button" name="btnsave" id="btnsave2" value="<b:message key="Catalog_Desc.Sort_Subcatalog"/>" class="button" onclick="sortChildrenCatalog();"><!-- 子目录排序 -->
			<input type="button" name="btnsave" id="btnsave3" value="<b:message key="Catalog_Desc.Set_Batch_Permissions"/>" class="button" onclick="setPermissionBatch();"><!-- 批量权限设置 -->
		</td></tr>
		</table>
	</td>
  </tr>
</html>