<%@include file="/common/sysCommon.jsp" %>

<%
	String skin="skin1";
%>

<link id="css_skin" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/skins/<%=skin %>/css/style.css"/>
<link id="css_icon" rel="stylesheet" type="text/css" href="<%=contextPath%>/coframe/tools/icons/icon.css"/>
<script>
	(function(){
		nui.context='<%=contextPath %>'
	})();
	
	var data={};
	nui.DataTree.prototype.dataField='data';//兼容改造
</script>
