<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_catalog/common/common_catalog.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-09 17:02:21
  - Description:
-->
<head>
<title>SortOrder</title>
<script>
	var currentSel=null;
	function setButton(obj){
		if(obj.length==0) return;
　　　　	currentSel=obj;
　　}
　　
	function moveUpSort(direction){
　　	if(currentSel==null) {
			showMessage($id("ResponseMessage"),"<b:message key="catalog_sort_jsp.select_catalog"/>");//请先选择一个目录
			return ;
		}
　　　　	
		if(direction){//up
			if(currentSel.selectedIndex>0){
				for(var i=0; i<currentSel.length; i++){
					if(currentSel[i].selected){
						var oOption=currentSel.options[i];
	　　　　　　var oPrevOption=currentSel.options[i---1];
	　　　　　　	currentSel.insertBefore(oOption,oPrevOption);
						hiddenResponseMessage($id('ResponseMessage'));
	　　　　　}
				}　　　　　　　　
			}else{
				showMessage($id("ResponseMessage"),"<b:message key="catalog_sort_jsp.already_first"/>");//已经是排在第一个了
				return ;
			}
		}else{//down
			for(var i=currentSel.length-1;i>=0;i--){
				if(currentSel[i].selected){
					if(i==currentSel.length-1) {
						showMessage($id("ResponseMessage"),"<b:message key="catalog_sort_jsp.already_last"/>");//已经是排在最后一个了
						return ;
					}
　　　　　　var oOption=currentSel.options[i];
　　　　　　	var oNextOption=currentSel.options[i+1];
　　　　　　	currentSel.insertBefore(oNextOption,oOption);
					hiddenResponseMessage($id('ResponseMessage'));
				}
			}
		}
	}

	function saveCatalogSort(){
		if($id("sortList").length==0){
			showMessage($id("ResponseMessage"),"<b:message key="catalog_sort_jsp.not_save_content"/>");//没有需要保存内容
			return;
		}
		$id("btnsave").disabled="disabled";
		var sortXML = buildSortStr();
		//alert(sortXML);
		//调用业务流
        var myAjax = new Ajax("com.primeton.bps.web.bizcatalog.bizcatalogmgr.updateSort.biz");
		myAjax.submitXML(sortXML); 
		//myAjax.submit();
		var isSuc = myAjax.getValue("root/data/RtnMsg/code");
		//alert(isSuc);
		if(isSuc==1){
			showMessage($id("ResponseMessage"),"<b:message key="catalog_sort_jsp.save_succeed"/>");//保存成功
			$id("btnsave").disabled="";
			//刷新树菜单
			refreshTree();
		}else{
			//提示错误
			showMessage($id("ResponseMessage"),"<b:message key="catalog_sort_jsp.save_failed"/>");//保存失败
		}
	}
	
	function buildSortStr(){
		var retStr = "";
		for(var i=0; i<$id("sortList").length; i++){
			var oOption=$id("sortList").options[i];
			retStr +="<WFBizCatalogInfo><catalogUuid>"+oOption.value+"</catalogUuid><orderId>"+(i+1)+"</orderId></WFBizCatalogInfo>"
　　　　	}
		return retStr;
	}
	
	function refreshTree(){
		var curNode = getSelectNode();
		curNode.reloadChild();
		curNode.selected();
		//curNode.cell.click();
	}
	
	function go2View(){
		window.location.href = "com.primeton.bps.web.bizcatalog.CatalogMgr.flow?_eosFlowAction=view&WFBizCatalogInfo/catalogUuid=<%=request.getParameter("querySub/catalogUuid")%>";
	}
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr> 
    <td class="workarea_title" valign="middle"><h3><b:message key="catalog_sort_jsp.reoder_sub_catalog"/></h3></td><!-- 调整子业务目录顺序 -->
  </tr>
  <tr> 
    <td width="100%">
		<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
		<tr>
			<td style="padding-top:10px;height:100%;">
				<div style="width:300px;height:100%;float:left;">
					<b:message key="catalog_sort_jsp.sub_catalog_list"/><!-- 子目录列表 -->
					<h:select id="sortList" size="20" style="width:300px" onclick="setButton(this)" 
						onchange="hiddenResponseMessage($id('ResponseMessage'))">
						<h:options labelField="catalogName" valueField="catalogUuid" property="cataloglist" />
					</h:select>
				</div>
				<div style="margin-top:15px;" align="left">
					<input type ="button"  id="btnUp" onclick="moveUpSort(true)" value=""
						style="width:25;height:25;background:url(<%=request.getContextPath()%>/workflow/bps_catalog/images/up.gif) no-repeat center center;"/> 
					<br/>
					<input type ="button"  id="btnDowm" onclick="moveUpSort(false)" value=""
						style="width:25;height:25;background:url(<%=request.getContextPath()%>/workflow/bps_catalog/images/down.gif) no-repeat center center;" />
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" name="btnsave" id="btnsave" value="<b:message key="catalog_sort_jsp.save"/>" class="button" onclick="saveCatalogSort()"/><!-- 保存 -->
				<input type="button" name="btnreset" id="btnreset" value="<b:message key="catalog_sort_jsp.reset"/>" class="button" onclick="location.reload()"/><!-- 重置 -->
				<input type="button" name="btnreturn" id="btnreturn" value="<b:message key="catalog_sort_jsp.back"/>" class="button" onclick="go2View();"/><!-- 返回 -->
			</td>
		</tr>
		</table>
	</td>
  </tr>
</table>
</body>
</html>

