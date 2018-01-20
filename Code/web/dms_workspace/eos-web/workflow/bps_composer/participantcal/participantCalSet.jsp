<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String defaultCal = ResourcesMessageUtil.getI18nResourceMessage("participant_cal_set_jsp.default_cal");
%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-08-13 17:18:04
  - Description:
-->
<head>
<title>Title</title>
<% 
	java.util.Map pTypeMap = com.primeton.bps.web.composer.participantcal.ParticipantTypesDictHelper.getParticipantTypes();
	String partiName = null;
	String calepartiVOPartiName = request.getParameter("calepartiVO/partiName");
	if (calepartiVOPartiName != null) {
		partiName = URLDecoder.decode(calepartiVOPartiName, "UTF-8");
	}
%>
</head>
<body>
<h:form name="viewlist1" action="com.primeton.bps.web.composer.participantcal.participantCalMgr.flow" method="post">
  <h:hidden property="calepartiVO/particaleUUID"/>
  <h:hidden property="calepartiVO/caleType" value="0"/>
  <h:hidden property="calepartiVO/partiID"/>
  <h:hidden property="calepartiVO/partiType"/>
  <%
  	if (partiName != null) {
  %>
  <input type="hidden" name="calepartiVO/partiName" value="<%=partiName%>">
  <%
  	} else {
  %>
  <h:hidden property="calepartiVO/partiName"/>
  <%
  	}
  %> 
  <h:hiddendata property="page" />
  <h:hiddendata property="queryCalepartiInfo" />
<l:present property="ret/code">
	<l:notEqual property="ret/code" targetValue="1">
		<div id="ResponseMessage" class="response_message" onclick="hiddenResponseMessage(this)">&nbsp;&nbsp;<b:write property="ret/name"/>&nbsp;&nbsp;</div>
	</l:notEqual>
</l:present>  
	<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="participant_cal_set_jsp.pant_cal_cfg"/></h3></td>
  	</tr>
  	<tr> 
    	<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
			      <tr>
        <td class="form_label" width="20%">
          <b:message key="participant_cal_set_jsp.pant_id"/>
        </td>
        <td>
          <b:write property="calepartiVO/partiID"/>
        </td>
      </tr>
      <tr>
        <td class="form_label">
          <b:message key="participant_list_jsp.pant_type"/>
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
          com.primeton.workflow.bizresource.manager.model.WFBizCalepartiVO vo = (com.primeton.workflow.bizresource.manager.model.WFBizCalepartiVO)request.getAttribute("calepartiVO");
          out.println(pTypeMap.get(vo.getPartiType()));
          %>
        </td>
      </tr>
      <tr>
        <td class="form_label">
          <b:message key="participant_list_jsp.pant_name"/>
        </td>
        <td>
          <%
            if (partiName != null) {
          %>
          		<%=partiName%>
          <%  
            } else {
          %>
          		<b:write property="calepartiVO/partiName"/>
          <%
          	}
          %>
        </td>
      </tr>
      <tr>
        <td class="form_label">
          <b:message key="participant_cal_set_jsp.cal"/>
        </td>
        <td>
          <h:select property="calepartiVO/calendarUUID" onchange="change()">
            <h:option label="<%=defaultCal%>" value=""/>
            <l:iterate id="id1" property="bizviewobjs">
            <h:option iterateId="id1" labelField="calendarName" valueField="calendarUUID"/>
            </l:iterate>
		  </h:select>
        </td>
      </tr>
      <tr>
          <td colspan="4">
            <input id="btnOK" name="btnOK" type="submit" value='<b:message key="permission_common.btn_ok"/>' class="button">
          </td>
        </tr>
    </table>
    </td>
    </tr>
   </table>
</h:form>

</body>
</html>
<script>
    function change() {
      var frm = $name("viewlist1");
      if ( frm.elements["calepartiVO/calendarUUID"].value == "")
         frm.elements["calepartiVO/caleType"].value = "0";
      else 
         frm.elements["calepartiVO/caleType"].value = "1";
    }
</script>