<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-07-22 16:21:40
  - Description:
-->
<head>
<title>Title</title>
</head>
<body>
<l:present property="ret/code">
	<l:notEqual property="ret/code" targetValue="1">
		<div id="ResponseMessage" class="response_message" onclick="hiddenResponseMessage(this)">&nbsp;&nbsp;<b:write property="ret/name"/>&nbsp;&nbsp;</div>
	</l:notEqual>
	<l:equal property="ret/code" targetValue="1">
		<script>
			refreshSelectNode();
		</script>
	</l:equal>
</l:present>
<div id="AlertMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
  <h:form name="viewlist1" action="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomMgr.flow" method="post">
    <h:hidden property="permType"/>
    <h:hidden property="page/begin"/>
    <h:hidden property="page/length"/>
    <h:hidden property="page/count"/>
    <h:hidden property="page/isCount"/>
    <h:hidden property="queryCatalogUUID"/>
    <h:hidden property="treeType"/>
    <input type="hidden" name="_eosFlowAction" value="query"/>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
  	<td class="workarea_title" valign="middle"><h3><b:message key="biz_process_custom_list_jsp.title"/></h3></td>
  </tr>
  <tr> 
   	<td width="100%" >
   	<table class="EOS_TABLE" width="100%" >
	   	<thead class="EOS_TABLE_HEAD">    
        <tr>
        <l:equal property="treeType" targetValue="1">	
          <th align="center">
            <!--  h:checkbox name="chkall" onclick="selectAll()" />全选--><b:message key="biz_process_custom_list_jsp.select"/>
          </th>
        </l:equal>
          <th>
            <b:message key="biz_process_custom_list_jsp.display_name"/>
          </th>
          <th>
            <b:message key="biz_process_custom_list_jsp.define_name"/>
          </th>
          <th>
            <b:message key="biz_process_custom_list_jsp.desc"/>
          </th>
        </tr>
        </thead>
        <w:radioGroup id="group1">
          <l:iterate property="processdefList" id="id1">
            <tr class="<l:output evenOutput='EOS_table_row' />">
            <l:equal property="treeType" targetValue="1">
              <td align="center">
                <w:rowRadio>
                   <h:param name="select_objs/processDefID" iterateId="id1" property="processDefID" indexed="true" />
                   <h:param name="select_objs/processDefName" iterateId="id1" property="processDefName"  />
                   <h:param name="select_objs/catalogUUID" iterateId="id1" property="catalogUUID"  />
                </w:rowRadio>
              </td>
          	</l:equal>
              <td title="<b:write iterateId="id1" property="processDefCHName"/>">
              <l:equal property="permType" targetValue="Y">
              	<a href="javascript:go2ProcessInfo('<b:write iterateId="id1" property="processDefID"/>')"><b:write iterateId="id1" property="processDefCHName" maxLength="15"/></a>
              </l:equal>
              <l:notEqual property="permType" targetValue="Y">
              	<b:write iterateId="id1" property="processDefCHName"/>
              </l:notEqual> 	
              </td>
              <td title="<b:write iterateId="id1" property="processDefName"/>">
                <b:write iterateId="id1" property="processDefName" maxLength="15"/>
              </td>
              <td title="<b:write iterateId="id1" property="description"/>">
                <b:write iterateId="id1" property="description" maxLength="15"/>
              </td>
            </tr>
          </l:iterate>
        </w:radioGroup>
        <tr>
          <td colspan="4" class="command_sort_area">
          <div id="listleft">
          <l:equal property="permType" targetValue="Y">
            <l:equal property="treeType" targetValue="1">
            <input id="btnAdd" name="btnAdd" type="button" value='<b:message key="biz_process_custom_list_jsp.btn_add"/>' onclick="addRecord();" class="button">
            <l:greaterThan property="page/count" targetValue="0" compareType="number">
              <input id="btnDel" name="btnDel" type="button" value='<b:message key="biz_process_custom_list_jsp.btn_del"/>' onclick="delRecord();" class="button">
            </l:greaterThan>
            </l:equal>
          </l:equal>
          </div>
          <div id="listright">
              <l:equal property="page/isCount" targetValue="true">
                <b:message key="permission_common.page_info1"/>
                <b:write property="page/count"/>
                <b:message key="permission_common.page_info2"/>
                <b:write property="page/currentPage"/>
                <b:message key="permission_common.page_info3"/>
                <b:write property="page/totalPage"/>
                <b:message key="permission_common.page_info4"/>
              </l:equal>
              <l:equal property="page/isCount" targetValue="false">
                <b:message key="permission_common.page_info5"/>
                <b:write property="page/currentPage"/>
                <b:message key="permission_common.page_info6"/>
              </l:equal>
              <input id="btnFirst" name="btnFirst" type="button" onclick="firstPage('page', 'pageQuery', null, null, 'viewlist1');" value="<b:message key="permission_common.btn_first"/>"  <l:equal property="page/first" targetValue="true">disabled</l:equal> >
              <input id="btnPrev" name="btnPrev" type="button" onclick="prevPage('page', 'pageQuery', null, null, 'viewlist1');" value="<b:message key="permission_common.btn_prev"/>" <l:equal property="page/first" targetValue="true">disabled</l:equal> >
              <input id="btnNext" name="btnNext" type="button" onclick="nextPage('page', 'pageQuery', null, null, 'viewlist1');" value="<b:message key="permission_common.btn_next"/>" <l:equal property="page/last" targetValue="true">disabled</l:equal> >
              <l:equal property="page/isCount" targetValue="true">
                <input id="btnLast" name="btnNext" type="button" onclick="lastPage('page', 'pageQuery', null, null, 'viewlist1');" value="<b:message key="permission_common.btn_last"/>" <l:equal property="page/last" targetValue="true">disabled</l:equal> >
              </l:equal>
           </div>
          </td>
        </tr>
      </table>
  </h:form>
  <script>
    function addRecord() {
      var g = $id("group1");
      var frm = $name("viewlist1");
      frm.elements["_eosFlowAction"].value = "addRecord";
      frm.submit();
    }
    
    function delRecord() {
      var g = $id("group1");
      if (g.getSelectLength() != 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectOne);
        return;
      }
      var argument = new Array(2);
	  argument[0]='<b:message key="permission_common.process_del_tip"/>';
	  showModalCenter("<%=request.getContextPath()%>/workflow/bps_composer/common/ConfirmWin.jsp",argument,callBack4Del,'300','125','<b:message key="permission_common.confirm_dialog"/>');
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
    
    function selectAll() {
      var g = $name("chkall");
      var rows=$id("group1").getRows();
      if (g.checked) {         
         for (i=0;i<rows.length;i++) {
              rows[i].setSelected();
         }
      } else {
         for (i=0;i<rows.length;i++) {
              rows[i].disSelected();
         }
      }
    }
    
    
    function go2ProcessInfo(processDefID){
    	var selectNode = getSelectNode();
    	_save_select_node_id = processDefID;
    	selectNode.reloadChild(afterClickReload);;
    }
    
    function afterClickReload(pNode){
		var curNode = getCurNodeByPIDFromParent(pNode,_save_select_node_id);
		curNode.selected();
		clickNode(curNode);
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
   </script>
</body>
</html>