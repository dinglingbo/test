<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>采购平台</title>
<%-- <script src="<%=webPath + contextPath%>/manage/js/inOutManage/stockQuery/partStoreStockQuery.js?v=2.2.20"></script> --%>
<style type="text/css">
.title {
	width: 90px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	/*border-right: 0;*/
	
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>
    <div id="mainTabs" class="nui-tabs" name="mainTabs"
           activeIndex="0" 
           style="width:100%; height:100%;" 
           plain="false" 
           onactivechanged="ontopTabChanged">
          
          <div title="配件查询" id="partInfoTab" name="partInfoTab" url="" >
             	 
          </div>
          
          <div title="采购车" name="purchaseAdvanceTab" url="" >
 			
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
				if(name == "partInfoTab"){
					mainTabs.loadTab(webPath + contextPath + "/purchasePart/pchsPlatform/partQuery.jsp", tab);
				}else if(name == "purchaseAdvanceTab"){
					mainTabs.loadTab(webPath + contextPath + "/purchasePart/pchsPlatform/containOrderCart.jsp", tab);		
				}
			}
			
		}
    </script>
</body>
</html>
