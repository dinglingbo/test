<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>

<head>
<title>系统参数</title>
<script src="<%=webPath + contextPath%>/config/js/sellCarParamMgr.js?v=1.0.0"></script>
</head>
<body>
	<div class="nui-fit">
		<div id="mainTabs" class="nui-tabs" name="mainTabs"
			activeIndex="0" 
			style="width:100%; height:100%;" 
			plain="false" >
			<div title="购车用途" id="buyCarUser" name="buyCarUser" url="">
			</div>
			<div title="信息来源" id="infoSourceTab" name="infoSourceTab" url="" >
			</div>
			<div title="意向级别" id="purposeTypeTab" name="purposeTypeTab" url="" >
			</div>
			<div title="来访方式" id="visitorsTab" name="visitorsTab" url="">
			</div>
			 
			<div title="关注重点" name="focusTab" id="focusTab" url="" >
			</div>  
		</div>	
	</div>
</body>
</html>
	