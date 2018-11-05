<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/commonRepair.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-03 20:45:07
  - Description:
--> 
<head>   
<title>维修车间看板</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<style type="text/css">

.mini-grid-border{
   background: #000;
}
 .mini-panel-border{
  border: 0px;
 }
 .mini-grid-headerCell{
      background: #000;
    border-color: #000;
 }
 .mini-grid-viewport{
  background: #000;
 }
 .mini-grid-table{
  background: #000;
 }

 body .mini-grid-headerCell-nowrap{
      color: white;
    font-size: 18px;
 }

 html body .mini-grid-row-selected {
    background: #262626;  
}
 html body .mini-grid-row-hover{
  background :#8c8c8c;
}
.mini-grid-newRow {
    background: #201f35;
} 
.mini-grid-cell {
    border-color: #000; 
}
.mini-grid-cell-inner{ 
    color: white;
}
</style>
</head>
<body >

<div class="nui-fit" style="background-color: #000">
	<div style="height: 40px;background-color: #fa8c16">
		<table style="width: 100%;line-height: 2;">
			<tr>
			  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff">维修车间看板</td>
			  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff" id="clock">2018年7月3日20:57:53</td>
			  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff"></td>
			
			</tr>
		</table>
	</div>
	<div class="nui-fit" style="background-color: #000">
	    <div id="workShopBoardGrid" class="nui-datagrid" dataField="list" showPager="false" style="height:100%;width:100%;">
	        <div property="columns">
	            <div field="carNo" width="100" headerAlign="center" align="center">车牌号</div>
	            <div field="enterDate" width="100" headerAlign="center" dateFormat="yyyy-MM-dd H:mm" align="center">接车时间</div>
	            <div field="planFinishDate" width="100" headerAlign="center" dateFormat="yyyy-MM-dd H:mm" align="center">预计完工时间</div>
	            <div field="mtAdvisor" width="100" headerAlign="center" align="center">服务顾问</div>
	            <div field="sureMtMan" width="100" headerAlign="center" align="center">施工员</div>
	            <div field="" width="100" headerAlign="center" align="center">维修项目</div>
	            <div field="status" width="100" headerAlign="center" align="center">施工状态</div>
	
	        </div>
	    </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();      
		setInterval("showtime('clock');",1000);
		var baseUrl = apiPath + repairApi + "/";
		var workShopBoardGrid = null;
		var gridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
		var statusHash = {
			"0" : "在报价",
			"1" : "施工中",
			"2" : "已完工"
		};

		$(document).ready(function(v) {
			workShopBoardGrid = nui.get("workShopBoardGrid");
			workShopBoardGrid.setUrl(gridUrl);
			workShopBoardGrid.on("drawcell", function (e) {
				if (e.field == "status") {
					e.cellHtml = statusHash[e.value];
				}
			});

			load();


		});

		function load(){
			var params = {};
			params.isSettle = 0;
			params.isDisabled = 0;
			params.isCount = -1;

			workShopBoardGrid.load({
				token:token,
				params: params
			});
	if (this.name!='FullWnd'){                            
          window.open(location.href,'FullWnd','fullscreen,scrollbars=no');      
        this.parent.opener=null;    
        this.parent.close();    
      } 
		}
		
		

		setInterval(load,50000);

    </script>
</body>
</html>