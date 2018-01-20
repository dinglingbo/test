<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script type="text/javascript" src="<%=request.getContextPath()%>/bps/web/control/js/selectResource.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bps/web/control/js/showProcStartAndWorkItemForm.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bizform/components/js/componentsConfig.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bizform/components/js/componentsCore.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/bizform/components/js/componentsBase.js"></script>
<!-- 提交组件 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/bizform/components/submit/js/componentsSubmit.js"></script>
<!-- 回退组件  -->
<%@include file="/bizform/components/back/backComponents.jsp" %>
<!-- 通知组件  -->
<%@include file="/bizform/components/notification/notificationComponents.jsp" %>
<!-- 审批组件  -->
<%@include file="/bizform/components/approval/approvalComponents.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/bizform/style/common_nui.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/bizform/components/js/locale/i18n_<%=I18nUtil.getLocale(request)%>.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/bps/wfclient/common/js/common.js" type="text/javascript"></script>
<script type="text/javascript">
	var contextPath = "<%=request.getContextPath()%>";
	function closeWindow(action) {
		if (window.CloseOwnerWindow) {
			return window.CloseOwnerWindow(action);
		} else {
			window.close();
		}
	}
</script>
