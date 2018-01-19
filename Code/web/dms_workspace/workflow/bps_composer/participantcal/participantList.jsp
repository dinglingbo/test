<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String select = ResourcesMessageUtil.getI18nResourceMessage("participant_list_jsp.select");
%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-08-13 16:46:24
  - Description:
-->
<head>
<title>Title</title>
<% 
	java.util.Map pTypeMap = com.primeton.bps.web.composer.participantcal.ParticipantTypesDictHelper.getParticipantTypes();
%>
</head>
<body>
  <form  name="form1" action="com.primeton.bps.web.composer.participantcal.participantCalMgr.flow" target="_self" method="post">
    <input type="hidden" name="_eosFlowAction" value="query" >
	<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="participant_list_jsp.pant_cal_query"/></h3></td>
  	</tr>
  	<tr> 
    	<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">    
        <tr>
          <td class="form_label" width="15%">
            <b:message key="participant_list_jsp.pant_name"/>
          </td>
          <td width="20%">
            <h:text property="queryCalepartiInfo/partiName"/>
          </td>
          <td class="form_label" width="15%">
            <b:message key="participant_list_jsp.pant_type"/>
          </td>
          <td width="20%">
            <h:select property="queryCalepartiInfo/partiType">
            <h:option label="<%=select%>" value=""/>
            <l:iterate property="participantTypeList" id="id1">
            <h:option iterateId="id1" labelField="displayName" valueField="code"/>
			</l:iterate>
		  </h:select>
          </td>
          <td class="form_label" width="15%">
            <b:message key="participant_list_jsp.cal_name"/>
          </td>
          <td width="20%">
            <h:text property="queryCalepartiInfo/calendarName"/>
          </td>
        </tr>
        <tr>
          <td colspan="6" align="center">
            <b:message key="participant_list_jsp.every_page_display"/>
            <h:text size="2" property="page/length" value="10" onblur="checkInput(this)" validateAttr="minValue=1;maxValue=100;type=integer;allowNull=false" />
            <input type="hidden" name="page/begin" value="0">
            <input type="hidden" name="page/isCount" value="true">
            <input id="btnQuery" name="btnQuery" type="button" value='<b:message key="permission_common.btn_query"/>' class="button" onclick="doQuery()">
            <input id="btnClean" name="btnClean" type="button" value='<b:message key="permission_common.btn_clean"/>' class="button" onclick="cleanQuery()">
          </td>
        </tr>
      </table>
      </td>
      </tr>
  </table>
  </form>
  
<l:present property="ret/code">
	<l:notEqual property="ret/code" targetValue="1">
		<div id="ResponseMessage" class="response_message" onclick="hiddenResponseMessage(this)">&nbsp;&nbsp;<b:write property="ret/name"/>&nbsp;&nbsp;</div>
	</l:notEqual>
</l:present>
<div id="AlertMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
  <form name="viewlist1" action="com.primeton.bps.web.composer.participantcal.participantCalMgr.flow" method="post">
  	<h:hiddendata property="queryCalepartiInfo" />
    <input type="hidden" name="_eosFlowAction" value="query" >
    <h:hidden property="page/begin"/>
    <h:hidden property="page/length"/>
    <h:hidden property="page/count"/>
    <h:hidden property="page/isCount"/>
	<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="participant_list_jsp.query_result"/></h3></td>
  	</tr>
  	<tr> 
   		<td width="100%" >
   		<table class="EOS_TABLE" width="100%" >
	   	<thead class="EOS_TABLE_HEAD">
        <tr>
          <th width="5%" style="white-space:nowrap">
            <h:checkbox name="chkall" onclick="list_selectAll()" /><b:message key="permission_common.select_all"/>
          </th>
          <th style="white-space:nowrap">
            <b:message key="participant_list_jsp.pant_name"/>
          </th>
          <th style="white-space:nowrap">
            <b:message key="participant_list_jsp.pant_type"/>
          </th>
          <th style="white-space:nowrap">
            <b:message key="participant_list_jsp.cal_name"/>
          </th>
        </tr>
        </thead>
        <w:checkGroup id="group1">
          <l:iterate property="calepartiList" id="id1">
            <tr class="<l:output evenOutput='EOS_table_row' />">
              <td align="center">
                <w:rowCheckbox>
                   <h:param name="calepartiInfo/particaleUUID" property="particaleUUID"  iterateId="id1" />
                   <h:param name="calepartiInfo/partiID" property="partiID"  iterateId="id1" />
                   <h:param name="calepartiInfo/partiName" property="partiName"  iterateId="id1"/>
                   <h:param name="calepartiInfo/partiType" property="partiType"  iterateId="id1"/>
                   <h:param name="calepartiInfo/calendarUUID" property="calendarUUID"  iterateId="id1" />
                   <h:param name="calepartiInfo/caleType" property="caleType"  iterateId="id1" />
                   <h:param name="viewFlag" value="1"/>
                   <h:param name="select_objs/particaleUUID" iterateId="id1" property="particaleUUID" indexed="true" />
                </w:rowCheckbox>
              </td>
              <td>
                <b:write iterateId="id1" property="partiName"/>
              </td>
              <td>
                <%
                Map<String, String> newMap = new HashMap<String, String>();
                for(int i = 0; i < pTypeMap.size(); i++) {
                	if (pTypeMap.containsKey("position")) {
                		newMap.put("position", ResourcesMessageUtil.getI18nResourceMessage("cale_parti_manager_java.position"));
                	}
                	if (pTypeMap.containsKey("person")) {
                		newMap.put("person", ResourcesMessageUtil.getI18nResourceMessage("cale_parti_manager_java.person"));
                	}
                	if (pTypeMap.containsKey("role")) {
                		newMap.put("role", ResourcesMessageUtil.getI18nResourceMessage("cale_parti_manager_java.role"));
                	}
                	if (pTypeMap.containsKey("organization")) {
                		newMap.put("organization", ResourcesMessageUtil.getI18nResourceMessage("cale_parti_manager_java.organization"));
                	}
                	if (pTypeMap.containsKey("org")) {
                		newMap.put("org", ResourcesMessageUtil.getI18nResourceMessage("cale_parti_manager_java.org"));
                	}
                	if (pTypeMap.containsKey("emp")) {
                		newMap.put("emp", ResourcesMessageUtil.getI18nResourceMessage("cale_parti_manager_java.emp"));
                	}
                }
                pTypeMap = newMap;
                com.primeton.workflow.bizresource.manager.model.WFBizCalepartiVO vo = (com.primeton.workflow.bizresource.manager.model.WFBizCalepartiVO)pageContext.getAttribute("id1");
                out.println(pTypeMap.get(vo.getPartiType()));
               	%>
              </td>
              <td>
                <b:write iterateId="id1" property="calendarName"/>
              </td>
            </tr>
          </l:iterate>
        </w:checkGroup>
        <tr>
          <td colspan="4" class="command_sort_area">
          	<div id="listleft">
            <l:greaterThan property="page/count" targetValue="0" compareType="number">
              <input id="btnSet" name="btnSet" type="button" value='<b:message key="permission_common.btn_set"/>' onclick="modiRecord();" class="button">
            </l:greaterThan>
            <l:greaterThan property="page/count" targetValue="0" compareType="number">
              <input id="btnDel" name="btnDel" type="button" value='<b:message key="permission_common.btn_del"/>' onclick="delRecord();" class="button">
            </l:greaterThan>
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
              <input id="btnFirst" name="btnFirst" type="button" onclick="firstPage('page', '', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_first"/>'  <l:equal property="page/first" targetValue="true">disabled</l:equal> >
              <input id="btnPrev" name="btnPrev" type="button" onclick="prevPage('page', '', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_prev"/>' <l:equal property="page/first" targetValue="true">disabled</l:equal> >
              <input id="btnNext" name="btnNext" type="button" onclick="nextPage('page', '', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_next"/>' <l:equal property="page/last" targetValue="true">disabled</l:equal> >
              <l:equal property="page/isCount" targetValue="true">
                <input id="btnLast" name="btnLast" type="button" onclick="lastPage('page', '', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_last"/>' <l:equal property="page/last" targetValue="true">disabled</l:equal> >
              </l:equal>
            </div>
          </td>
        </tr>
      </table>
      </td>
      </tr>
  </table>
  </form>
  <script>
	function doQuery(){
      var frm = $name("form1");
      
	  if(!checkForm($name(frm))) {
		return false;
	  }
	  
      frm.submit();
	}
	
  	function cleanQuery(){
  		$name("queryCalepartiInfo/partiName").value="";
  		$name("queryCalepartiInfo/partiType").value="";
  		$name("queryCalepartiInfo/calendarName").value="";
  	}
  
    function modiRecord() {
      var g = $id("group1");
      if (g.getSelectLength() != 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectOne);
        return;
      }
      var frm = $name("viewlist1");
      frm.elements["_eosFlowAction"].value = "set";
      frm.submit();
    }
    function delRecord() {
      var g = $id("group1");
      if (g.getSelectLength() < 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectMore);
        return;
      }
      var names = g.getSelectParams("calepartiInfo/partiName");
      var nameStr = "";
      for(i=0;i<names.length;i++){
        	nameStr += names[i]+";";
      }
      var argument = new Array(2);
      //"确定要删除["+nameStr+"]("+i+"个)的日历配置吗?"
	  argument[0]='<b:message key="participant_list_jsp.confirm_del_tip1"/>'+nameStr+']('+i+'<b:message key="participant_list_jsp.confirm_del_tip3"/>';
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
  </script>
</body>
</html>