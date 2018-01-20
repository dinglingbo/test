<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-27 09:58:22
  - Description:
-->
<head>
<title><b:message key="catalog_bizvar_list_jsp.biz_var_mgr"/></title><!-- 目录级业务变量管理 -->
</head>
<body>
  <h:form name="viewlist1" action="com.primeton.bps.web.composer.bizresouce.CatalogBizVarMgr.flow" method="post">
    <input type="hidden" name="_eosFlowAction" value="init" >
    <h:hiddendata property="queryViewObject" />
    <h:hidden property="permType"/>
    <h:hidden property="page/begin"/>
    <h:hidden property="page/length"/>
    <h:hidden property="page/count"/>
    <h:hidden property="page/isCount"/>
    <input type="hidden" name="resUUID"/>
    <input type="hidden" name="catalogUUID"/>
    <input type="hidden" name="resName"/>
<l:present property="ret/code">
	<l:notEqual property="ret/code" targetValue="1">
		<div id="ResponseMessage" class="response_message" onclick="hiddenResponseMessage(this)">&nbsp;&nbsp;<b:write property="ret/name"/>&nbsp;&nbsp;</div>
	</l:notEqual>
</l:present>
<div id="AlertMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>    
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
  	<td class="workarea_title" valign="middle"><h3><b:message key="catalog_bizvar_list_jsp.biz_var_list"/></h3></td><!-- 业务变量列表 -->
  </tr>
  <tr> 
   	<td width="100%" >
   	<table class="EOS_TABLE" width="100%" >
	   	<thead class="EOS_TABLE_HEAD">
        <tr>
          <th width="5%" style="white-space:nowrap">
            <h:checkbox name="chkall" onclick="list_selectAll()" /><b:message key="permission_common.select_all"/><!-- 全选 -->
          </th>
          <th width="5%" style="white-space:nowrap"><!-- 状态 -->
            <b:message key="permission_common.status"/>
          </th>
          <th style="white-space:nowrap"><!-- 业务变量名称 -->
            <b:message key="catalog_bizvar_list_jsp.biz_var_name"/>
          </th>
          <th style="white-space:nowrap"><!-- XPATH -->
            <b:message key="catalog_bizvar_list_jsp.biz_var_xpath"/>
          </th>
          <th style="white-space:nowrap"><!-- 说明 -->
            <b:message key="catalog_bizvar_list_jsp.biz_var_desc"/>
          </th>
        </tr>
        </thead>
        <w:checkGroup id="group1">
          <l:iterate property="bizviewobjs" id="id1">
            <tr class="<l:output evenOutput='EOS_table_row' />">
              <td align="center">
                <w:rowCheckbox>
                	<h:param name='selViewObject/busivarUUID' iterateId='id1' property='busivarUUID' indexed='true' />
                	<h:param name='selViewObject/busivarName' iterateId='id1' property='busivarName' indexed='true' />
                </w:rowCheckbox>
              </td>
              <td>
                <l:equal iterateId="id1" property="mdfState" targetValue="9"><img src="<%=request.getContextPath()%>/workflow/bps_composer/common/images/new.gif" alt='<b:message key="permission_common.img_new"/>'/></l:equal><!-- 新增 -->
              	<l:equal iterateId="id1" property="mdfState" targetValue="0"><img src="<%=request.getContextPath()%>/workflow/bps_composer/common/images/submission.gif" alt='<b:message key="permission_common.img_submit"/>'/></l:equal><!-- 一致 -->
              	<l:equal iterateId="id1" property="mdfState" targetValue="1"><img src="<%=request.getContextPath()%>/workflow/bps_composer/common/images/modify.gif" alt='<b:message key="permission_common.img_modify"/>'/></l:equal><!-- 修改 -->
              </td>
              <td>
              <l:equal property="permType" targetValue="Y">
	            <a href="javascript:selClickNode('<b:write iterateId="id1" property="busivarUUID"/>','selViewObject/busivarUUID');modiRecord()"><b:write iterateId="id1" property="busivarName"/></a>
	          </l:equal>
	          <l:notEqual property="permType" targetValue="Y">
	          	<b:write iterateId="id1" property="busivarName"/>
              </l:notEqual>
              </td>
              <td>
                <b:write iterateId="id1" property="busivarImpl"/>
              </td>
              <td title="<b:write iterateId="id1" property="mark"/>">
                <b:write iterateId="id1" property="mark" maxLength="15"/>
              </td>
            </tr>
          </l:iterate>
        </w:checkGroup>
        <tr>
          <td colspan="6" class="command_sort_area">
          <div id="listleft" style="white-space:nowrap">
          <l:equal property="permType" targetValue="Y">
            <input id="btnAdd" name="btnAdd" type="button" value='<b:message key="permission_common.btn_add"/>' onclick="addRecord();" class="button"><!-- 新增 -->
            <l:greaterThan property="page/count" targetValue="0" compareType="number">
              <input id="btnEdit" name="btnEdit" type="button" value='<b:message key="permission_common.btn_edit"/>' onclick="modiRecord();" class="button"><!-- 修改 -->
              <input id="btnDel" name="btnDel" type="button" value='<b:message key="permission_common.btn_del"/>' onclick="delRecord();" class="button"><!-- 删除 -->
              <input id="btnViewRef" name="btnViewRef" type="button" value='<b:message key="permission_common.btn_view_ref"/>' onclick="showReference();" class="button"><!-- 查看引用 -->
              <input id="btnMove" name="btnMove" type="button" value='<b:message key="permission_common.btn_move_to"/>' onclick="moveRecord();" class="button"><!-- 移动到 -->
              <input id="btnCopy" name="btnCopy" type="button" value='<b:message key="permission_common.btn_copy_to"/>' onclick="copyRecord();" class="button"><!-- 复制到 -->
              <input id="btnSubmit" name="btnSubmit" type="button" value='<b:message key="permission_common.btn_submit"/>' onclick="putinRecord();" class="button"><!-- 提交 -->
              <input id="btnExt" name="btnExt" type="button" value='<b:message key="permission_common.btn_extract"/>' onclick="pickupRecord();" class="button"><!-- 提取 -->
            </l:greaterThan>
           </l:equal>
           </div>
           <div id="listright" style="white-space:nowrap">
              <l:equal property="page/isCount" targetValue="true"><!-- 共 -->
                <b:message key="permission_common.page_info1"/>
                <b:write property="page/count"/><!-- 条记录 第 -->
                <b:message key="permission_common.page_info2"/>
                <b:write property="page/currentPage"/><!-- 页/ -->
                <b:message key="permission_common.page_info3"/>
                <b:write property="page/totalPage"/><!-- 页 -->
                <b:message key="permission_common.page_info4"/>
              </l:equal>
              <l:equal property="page/isCount" targetValue="false"><!-- 第 -->
                <b:message key="permission_common.page_info5"/>
                <b:write property="page/currentPage"/><!-- 页 -->
                <b:message key="permission_common.page_info6"/>
              </l:equal>
              <input id="btnFirst" name="btnFirst" type="button" onclick="firstPage('page', 'pageQuery', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_first"/>'  <l:equal property="page/first" targetValue="true">disabled</l:equal> ><!-- 首页 -->
              <input id="btnPrev" name="btnPrev" type="button" onclick="prevPage('page', 'pageQuery', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_prev"/>' <l:equal property="page/first" targetValue="true">disabled</l:equal> ><!-- 上页 -->
              <input id="btnNext" name="btnNext" type="button" onclick="nextPage('page', 'pageQuery', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_next"/>' <l:equal property="page/last" targetValue="true">disabled</l:equal> ><!-- 下页 -->
              <l:equal property="page/isCount" targetValue="true">
                <input id="btnLast" name="btnLast" type="button" onclick="lastPage('page', 'pageQuery', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_last"/>' <l:equal property="page/last" targetValue="true">disabled</l:equal> ><!-- 尾页 -->
              </l:equal>
         </div>
          </td>
        </tr>
      </table>
	</td>
	</tr>
</table>
  </h:form>
  <script>
    function addRecord() {
     	hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      var frm = $name("viewlist1");
      frm.elements["_eosFlowAction"].value = "addRecord";
      frm.submit();
    }

    function modiRecord() {
    	hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      if (g.getSelectLength() != 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectOne);
        return;
      }
      var frm = $name("viewlist1");
      frm.elements["_eosFlowAction"].value = "modiRecord";
      frm.submit();
    }
    
    function delRecord() {
    	hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      if (g.getSelectLength() < 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectMore);
        return;
      }
      var names = g.getSelectParams("selViewObject/busivarName");
      var nameStr = "";
      for(i=0;i<names.length;i++){
        	nameStr += names[i]+";";
      }
      var argument = new Array(2);
      //"确定要删除["+nameStr+"]("+i+"个)业务变量吗?"
	  argument[0]='<b:message key="catalog_bizvar_list_jsp.confirm_del_tip1"/>'+nameStr+']('+i+'<b:message key="catalog_bizvar_list_jsp.confirm_del_tip3"/>';
	  showModalCenter("<%=request.getContextPath()%>/workflow/bps_composer/common/ConfirmWin.jsp",argument,callBack4Del,'300','125','<b:message key="permission_common.confirm_dialog"/>');//确认框
    }
    
    function callBack4Del(value){
    	if(value==""){
			return;
		}
        if(value[0]=="Y"){
            var frm = $name("viewlist1");
      		frm.elements["_eosFlowAction"].value = "delRecord";
      		frm.submit();
        }
    }
    
    function showReference() {
     hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      if (g.getSelectLength() != 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectOne);
        return;
      }
	  var params = g.getSelectParams("selViewObject/busivarUUID");
      var strUrl = "com.primeton.bps.web.composer.bizresouce.CatalogBizVarMgr.flow?_eosFlowAction=showReference&resUUID="+params[0];
      showModalCenter(strUrl,"","",300,350,'<b:message key="global_bizopt_list_jsp.ref"/>');//引用
    }
    
    function moveRecord() {
    	hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      if (g.getSelectLength() < 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectMore);
        return;
      }
      var ids = g.getSelectParams("selViewObject/busivarUUID");
      var idStr = "";
      var names = g.getSelectParams("selViewObject/busivarName");
      var nameStr = "";
      for(i=0;i<ids.length;i++){
        	idStr += ids[i]+";";
        	nameStr += names[i]+";";
      }
      var strUrl = "com.primeton.bps.web.composer.bizresouce.BizResCommOpertion.flow?_eosFlowAction=move";
      var argument = new Array(4);
      argument[0] = $name("queryViewObject/catalogUUID").value;;
      argument[1] = "03";
      argument[2] = idStr;
      argument[3] = nameStr;
      showModalCenter(strUrl,argument,refreshList,300,350,'<b:message key="permission_common.btn_move_to"/>');//移动到
    }

    function copyRecord() {
	    hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      if (g.getSelectLength() < 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectMore);
        return;
      }
      var argument = new Array(4);
      argument[0] = $name("queryViewObject/catalogUUID").value;
      argument[1] = g.getSelectParams("selViewObject/busivarUUID");
      argument[2] = g.getSelectParams("selViewObject/busivarName");
      argument[3] = "03";
      var strUrl = "com.primeton.bps.web.composer.bizresouce.BizResCommOpertion.flow?_eosFlowAction=copy";
      showModalCenter(strUrl,argument,refreshList,300,350,'<b:message key="permission_common.btn_copy_to"/>');//复制到
      
      
    }
    
    function putinRecord() {
    	hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      if (g.getSelectLength() < 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectMore);
        return;
      }
      var idStr="",nameStr="";
      var ids = g.getSelectParams("selViewObject/busivarUUID");
      var names = g.getSelectParams("selViewObject/busivarName");
      for(i=0;i<ids.length;i++){
        	idStr += ids[i]+";";
        	nameStr += names[i]+";";
      }
      var strUrl = "com.primeton.bps.web.composer.bizresouce.BizResCommOpertion.flow?_eosFlowAction=putin&resType=03&idStr="+idStr+"&nameStr="+nameStr;
      showModalCenter(encodeURI(encodeURI(strUrl)),"",refreshList,500,350,'<b:message key="permission_common.btn_submit"/>');//提交
    }
    
    function pickupRecord() {
    	hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      if (g.getSelectLength() < 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectMore);
        return;
      }
      var idStr="",nameStr="";
      var ids = g.getSelectParams("selViewObject/busivarUUID");
      var names = g.getSelectParams("selViewObject/busivarName");
      for(i=0;i<ids.length;i++){
        	idStr += ids[i]+";";
        	nameStr += names[i]+";";
      }
      //判断是否可以提取
      var myAjax = new Ajax("com.primeton.bps.web.composer.bizresource.bizrescommoperation.canPickupResource.biz");
      myAjax.addParam('resIDs',idStr);
	  myAjax.addParam('resNames',nameStr);
	  myAjax.addParam('unitType','03');

	  myAjax.submit ();
	  var isSuc =myAjax.getValue("root/data/RtnMsg/code");
	  if(isSuc!=1){
	  	showMessage($id("AlertMessage"),Alert_Message_CannotPickUp);
	  	return ;
	  }
      var strUrl = "com.primeton.bps.web.composer.bizresouce.BizResCommOpertion.flow?_eosFlowAction=pickup&resType=03&idStr="+idStr+"&nameStr="+nameStr;
      showModalCenter(encodeURI(encodeURI(strUrl)),"",refreshList,500,350,'<b:message key="permission_common.btn_extract"/>');//提取
    }
    
    function refreshList(value){
    	if(value==""){
    		return;
    	}
    	if(value[0]=='Y'){
			var frm = $name("viewlist1");
	      	frm.elements["_eosFlowAction"].value = "pageQuery";
	      	frm.submit();
      	}
    }    
  </script>
</body>
</html>