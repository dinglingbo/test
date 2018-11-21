<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 09:24:30
  - Description:
-->
<head>
<title>根据配件生命周期精准营销</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/sysCommon.jsp"%>
   
  <style type="text/css">
    body {
        margin: 0; 
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%; 
        overflow: hidden;
        font-family: "微软雅黑";
    }
</style>  
</head>
<body>
	<div class="nui-fit">
	 	<div id="gridTabs" class="nui-tabs" name="gridTabs"
           activeIndex="0" 
           style="width:100%; height:100%;" 
           plain="true" 
           onactivechanged="">
           <div title="客户分析" id="grid1Tab" name="grid1Tab" url="" >

           </div>
           <div title="车辆分析" id="grid2Tab" name="grid2Tab" url="" >
           </div>
           <div title="商机列表" id="grid3Tab" name="grid3Tab" url="" >
           </div>
       	</div>
	</div>
	<script type="text/javascript">
		var gridTabs=null;
    	nui.parse();
    	$(document).ready(function(){
    		gridTabs=nui.get('gridTabs');
	    	gridTabs.on("activechanged",function(e){
			showTabInfo();
		});
	});
	function showTabInfo(){
		var tab =gridTabs.getActiveTab();
		var name=tab.name;
		var url = tab.url;
		if(!url){
			if(name == 'grid1Tab'){
				gridTabs.loadTab(webPath + contextPath + "/manage/exactMarketing/customerAnalysis.jsp", tab);
			}
			if(name == 'grid2Tab'){
				gridTabs.loadTab(webPath + contextPath +"/manage/exactMarketing/carAnalysis.jsp",tab);
			}
			if(name == 'grid3Tab'){
				gridTabs.loadTab(webPath + contextPath + "/manage/exactMarketing/businessList.jsp", tab);
			}
		}
	}
    </script>
</body>
</html>