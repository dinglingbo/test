<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<script src="<%=request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/common/nui/locale/<%=I18nUtil.getLocale(request)%>.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/web/control/js/nui-ext.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/web/control/js/selectResource.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/web/control/js/showProcStartAndWorkItemForm.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/web/control/js/fetchMessageList.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/web/control/js/appointActivityOrStepParticipant.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/web/control/js/graph4BPS.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/web/control/js/processGraph.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/web/control/js/bpsPager.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/web/control/locale/i18n_<%=I18nUtil.getLocale(request)%>.js" type="text/javascript"></script>
 
 <!-- default nui style for integration coframe -->
 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/bps/web/control/css/common_nui.css">
<script>
	var contextPath = "<%=request.getContextPath()%>";
</script>