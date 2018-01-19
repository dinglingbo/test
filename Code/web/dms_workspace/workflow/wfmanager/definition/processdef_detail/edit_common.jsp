<script src="<%=request.getContextPath()%>/workflow/wfcomponent/web/js/workflow.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/xml2json.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/json2xml.js" language="javascript"></script>
<script src="<%=request.getContextPath()%>/workflow/wfmanager/definition/js/json.js" language="javascript"></script>

	<script>
		var CONTEXT_PATH = '<%=request.getContextPath()%>' ;
		var actJson = getProcessOrActivityInfo('<%=request.getParameter("actId")%>') ;
		function getProcessOrActivityInfo(id) {
			var cacheData = new SpecCacheMgr().get(id) ;
			if (!cacheData ||cacheData == null) return ;
			var jsonData = xml2json.parser(cacheData);
			//alert(jsonData.toJSONString())
			return jsonData ;
		}
	</script>