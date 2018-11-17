<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-17 11:44:25
  - Description:
-->
<head>
<title>跟踪明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    
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
	
	<input id="visitMode" style="display :none;" name="visitMode" class="nui-combobox textboxWidth" dataField="data" valueField="customid" textField="name">
    <div id="gridTabs" class="nui-tabs" name="gridTabs"
           activeIndex="0" 
           style="width:100%; height:100%;" 
           plain="true" 
           onactivechanged="">

        <div title="保养提醒" id="grid1Tab" name="grid1Tab" url="" >
	         <div id="grid1" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
		                <div field="guestName" name="guestName" width="55" headerAlign="center" header="客户姓名"></div>
		                <div field="mobile" name="mobile" width="100" headerAlign="center" header="客户手机"></div>
	                  	<div field="visitMan" name="visitMan" width="70" headerAlign="center" header="提醒人"></div>
		                <div field="visitMode" name="visitMode" width="60" headerAlign="center" header="提醒方式"></div>
	                    <div field="visitDate" name="visitDate" width="110" headerAlign="center" header="提醒日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="visitContent" name="visitContent" width="200" headerAlign="center" header="提醒内容"></div>
	                    
	            </div>
	        </div>

        </div> 
        <div title="商业险提醒" id="grid2Tab" name="grid2Tab" >
            
            <div id="grid2" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
		                <div field="guestName" name="guestName" width="55" headerAlign="center" header="客户姓名"></div>
		                <div field="mobile" name="mobile" width="100" headerAlign="center" header="客户手机"></div>
	                  	<div field="visitMan" name="visitMan" width="70" headerAlign="center" header="提醒人"></div>
		                <div field="visitMode" name="visitMode" width="60" headerAlign="center" header="提醒方式"></div>
	                    <div field="visitDate" name="visitDate" width="110" headerAlign="center" header="提醒日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="visitContent" name="visitContent" width="200" headerAlign="center" header="提醒内容"></div>
	                    
	            </div>
	        </div>

        </div>
        <div title="交强险提醒" name="grid3Tab" id="grid3Tab" url="" >
          
           <div id="grid3" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
		                <div field="guestName" name="guestName" width="55" headerAlign="center" header="客户姓名"></div>
		                <div field="mobile" name="mobile" width="100" headerAlign="center" header="客户手机"></div>
	                  	<div field="visitMan" name="visitMan" width="70" headerAlign="center" header="提醒人"></div>
		                <div field="visitMode" name="visitMode" width="60" headerAlign="center" header="提醒方式"></div>
	                    <div field="visitDate" name="visitDate" width="110" headerAlign="center" header="提醒日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="visitContent" name="visitContent" width="200" headerAlign="center" header="提醒内容"></div>
	                    
	            </div>
	        </div>

        </div>
        <div title="年检提醒" name="grid4Tab" id="grid4Tab" url="" >
          
            <div id="grid4" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
		                <div field="guestName" name="guestName" width="55" headerAlign="center" header="客户姓名"></div>
		                <div field="mobile" name="mobile" width="100" headerAlign="center" header="客户手机"></div>
	                  	<div field="visitMan" name="visitMan" width="70" headerAlign="center" header="提醒人"></div>
		                <div field="visitMode" name="visitMode" width="60" headerAlign="center" header="提醒方式"></div>
	                    <div field="visitDate" name="visitDate" width="110" headerAlign="center" header="提醒日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="visitContent" name="visitContent" width="200" headerAlign="center" header="提醒内容"></div>
	                    
	            </div>
	        </div>
	        
        </div>
        
        <div title="客户生日提醒" name="grid5Tab" id= "grid5Tab" url="" >
          
            <div id="grid5" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
		                <div field="guestName" name="guestName" width="55" headerAlign="center" header="客户姓名"></div>
		                <div field="mobile" name="mobile" width="100" headerAlign="center" header="客户手机"></div>
	                  	<div field="visitMan" name="visitMan" width="70" headerAlign="center" header="提醒人"></div>
		                <div field="visitMode" name="visitMode" width="60" headerAlign="center" header="提醒方式"></div>
	                    <div field="visitDate" name="visitDate" width="110" headerAlign="center" header="提醒日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="visitContent" name="visitContent" width="200" headerAlign="center" header="提醒内容"></div>
	                    
	            </div>
	        </div>

        </div>
        
        <div title="驾照年审提醒" name="grid6Tab" id="grid6Tab" url="" >
          
            <div id="grid6" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="true" pageSize="20"
	            totalField="page.count" sizeList=[10,20,50,100] dataField="list" onrowdblclick="" allowCellSelect="true"allowCellWrap = true url="">
	            <div property="columns">
	            		<div type="indexcolumn" width="30">序号</div>
	                	<div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌"></div>
		                <div field="guestName" name="guestName" width="55" headerAlign="center" header="客户姓名"></div>
		                <div field="mobile" name="mobile" width="100" headerAlign="center" header="客户手机"></div>
	                  	<div field="visitMan" name="visitMan" width="70" headerAlign="center" header="提醒人"></div>
		                <div field="visitMode" name="visitMode" width="60" headerAlign="center" header="提醒方式"></div>
	                    <div field="visitDate" name="visitDate" width="110" headerAlign="center" header="提醒日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	                    <div field="visitContent" name="visitContent" width="200" headerAlign="center" header="提醒内容"></div>
	                    
	            </div>
	        </div>

        </div>
            
    </div>
</div>
	


	<script type="text/javascript">
    	nui.parse();
    	
    	var visitModeList=null;
    	var visitModeHash={};
    	var guestId=null;
    	var gridTabs=null;
    	var grid1=null;
    	var grid2=null;
    	var grid3=null;
    	var grid4=null;
    	var grid5=null;
    	var grid6=null;
    	var baseUrl=apiPath + repairApi+"/";
    	var gridUrl= baseUrl +"com.hsapi.repair.baseData.query.queryCareRecord.biz.ext";
    	$(document).ready(function(){
    		gridTabs=nui.get('gridTabs');
    		grid1=nui.get('grid1');
    		grid1.setUrl(gridUrl);
    		grid2=nui.get('grid2');
    		grid2.setUrl(gridUrl);
    		grid3=nui.get('grid3');
    		grid3.setUrl(gridUrl);
    		grid4=nui.get('grid4');
    		grid4.setUrl(gridUrl);
    		grid5=nui.get('grid5');
    		grid5.setUrl(gridUrl);
    		grid6=nui.get('grid6');
    		grid6.setUrl(gridUrl);
    		
    		gridTabs.on("activechanged",function(e){
    			showTabInfo();
    		});
    		
    		var dictDefs = {
				"visitMode" : "DDT20130703000021"
			};
			initDicts(dictDefs, function(e) {
				var visitModeList = nui.get("visitMode").getData();
				visitModeList.forEach(function(v) {
					visitModeHash[v.customid] = v;
				});
			});
			
			grid1.on("drawcell",function(e){
				switch (e.field) {
				case "visitMode":
					if (visitModeHash[e.value]) {
						e.cellHtml = visitModeHash[e.value].name || "";
					} 
					break;
				default:
					break;	
				}
			});
			grid2.on("drawcell",function(e){
				switch (e.field) {
				case "visitMode":
					if (visitModeHash[e.value]) {
						e.cellHtml = visitModeHash[e.value].name || "";
					} 
					break;
				default:
					break;	
				}
			});
			grid3.on("drawcell",function(e){
				switch (e.field) {
				case "visitMode":
					if (visitModeHash[e.value]) {
						e.cellHtml = visitModeHash[e.value].name || "";
					} 
					break;
				default:
					break;	
				}
			});
			grid4.on("drawcell",function(e){
				switch (e.field) {
				case "visitMode":
					if (visitModeHash[e.value]) {
						e.cellHtml = visitModeHash[e.value].name || "";
					} 
					break;
				default:
					break;	
				}
			});
			grid5.on("drawcell",function(e){
				switch (e.field) {
				case "visitMode":
					if (visitModeHash[e.value]) {
						e.cellHtml = visitModeHash[e.value].name || "";
					} 
					break;
				default:
					break;	
				}
			});
			grid6.on("drawcell",function(e){
				switch (e.field) {
				case "visitMode":
					if (visitModeHash[e.value]) {
						e.cellHtml = visitModeHash[e.value].name || "";
					} 
					break;
				default:
					break;	
				}
			});
		    document.onkeyup = function(event) {
		        var e = event || window.event;
		        var keyCode = e.keyCode || e.which;// 38向上 40向下
		        
		
		        if ((keyCode == 27)) { // ESC
		            CloseWindow('cancle');
		        }
		
		    }
		});
    	
    	function CloseWindow(action) {
			if (action == "close") {
		
			} else if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				return window.close();
		}
		
		function showTabInfo(){
			var params={};
			params.guestId=guestId;
			var tab =gridTabs.getActiveTab();
			var name = tab.name;
			if(name=='grid1Tab'){
				params.careType=1;
				grid1.load({params :params,token:token});
			}
			if(name=='grid2Tab'){
				params.careType=2;
				grid2.load({params :params,token:token});
			}
			if(name=='grid3Tab'){
				params.careType=3;
				grid3.load({params :params,token:token});
			}
			if(name=='grid4Tab'){
				params.careType=4;
				grid4.load({params :params,token:token});
			}
			if(name=='grid5Tab'){
				params.careType=5;
				grid5.load({params :params,token:token});
			}
			if(name=='grid6Tab'){
				params.careType=6;
				grid6.load({params :params,token:token});
			}
		}
			
		function SetData(params) {
			guestId=params.guestId;
			grid1.load({params :params,token:token});
		}
		
    </script>
</body>
</html>