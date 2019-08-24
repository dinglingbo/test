<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>

<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-08-22 16:43:54
  - Description:
-->
<head>
<title>配件加工</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
  
</head>
<body>

	 <div id="mainTabs" class="nui-tabs" name="mainTabs"
           activeIndex="0" 
           style="width:100%; height:100%;" 
           plain="false" 
           onactivechanged="ontopTabChanged">
          
          <div title="配件组装" id="partAssembly" name="partAssembly" url="" >
             	 
          </div>
          
          <div title="配件拆分" name="partSplit" url="" >
 			
         </div>   

	</div>


	<script type="text/javascript">
    	nui.parse();
    	var mainTabs=null;
    	$(document).ready(function(v) {
    		mainTabs = nui.get("mainTabs");
    	});
    	
    	function ontopTabChanged(e){
			var tab = e.tab;
			var name = tab.name;
			var url = tab.url;
			if(!url){
				if(name == "partAssembly"){
					mainTabs.loadTab(webPath + contextPath + "/purchase/processPart/partAssembly.jsp", tab);
				}else if(name == "partSplit"){
					mainTabs.loadTab(webPath + contextPath + "/purchase/processPart/partSplit.jsp", tab);		
				}
			}
			
		}
    </script>
</body>
</html>