<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-22 15:47:35
  - Description:
-->
<head>
<title><b:message key="participant_cal_set_jsp.pant_cal_cfg"/></title>
</head>
<frameset cols="200,10,*" frameborder="no" border="0" framespacing="0" name="bizResMain" id="framesetMain">
  <noframes><b:message key="permission_common.noframes"/></noframes>
  <frame src="com.primeton.bps.web.composer.participantcal.participantCalFrame.flow?_eosFlowAction=tree" name="left" id="left" noresize="noresize"  frameborder="0" scrolling="no" marginheight="0" marginwidth="0">
  <frame src="<%=request.getContextPath()%>/workflow/bps_composer/common/arrowPage.jsp" name="middle" id="middle" noresize="noresize" scrolling="no"/>
  <frame src="com.primeton.bps.web.composer.participantcal.participantCalMgr.flow" name="right" id="right" scrolling="auto">
</frameset>
</html>