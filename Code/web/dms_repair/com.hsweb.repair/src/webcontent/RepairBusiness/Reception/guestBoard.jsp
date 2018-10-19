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
<title>客户休息区看板</title>
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
<body>

<div class="nui-fit" style="background-color: #000">
	<div style="height: 40px;background-color: #fa8c16">
		<table style="width: 100%;line-height: 2;">
			<tr>
			  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff">客户休息区看板</td>
			  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff" id="clock">2018年7月3日20:57:53</td>
			  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff"></td>
			
			</tr>
		</table>
	</div>
	<div class="nui-fit" style="background-color: #000">
	    <div id="guestBoardGrid" class="nui-datagrid" dataField="data" showLoading="false" showPager="false" style="height:100%;width:100%;">
	        <div property="columns">
	            <div field="carNo" width="100" headerAlign="center" align="center">车牌号</div>
	            <div field="recordDate" dateFormat="yyyy-MM-dd H:mm:ss" width="100" headerAlign="center" align="center">接车时间</div>
	            <div field="planFinishDate" width="100" dateFormat="yyyy-MM-dd H:mm:ss" headerAlign="center" align="center">预计完工时间</div>
	            <div field= "status" width="100" headerAlign="center" align="center">施工状态</div>
	        </div>
	    </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();      
		setInterval("showtime('clock');",1000);
		var baseUrl = apiPath + repairApi + "/";
		var guestBoardGrid = null;
		var gridUrl = baseUrl + "com.hsapi.repair.repairService.daydata.queryGuestBoard.biz.ext";
		var statusHash = {
			"0" : "报价",
			"1" : "施工",
			"2" : "完工"
		};

		$(document).ready(function(v) {
			guestBoardGrid = nui.get("guestBoardGrid");
			guestBoardGrid.setUrl(gridUrl);

			guestBoardGrid.on("drawcell", function (e) {
				if (e.field == "status") {
					e.cellHtml = statusHash[e.value];
				}
			});

			load();
		});

		function load(){
			guestBoardGrid.load({
				token:token
			});
		}

		setInterval(load,5000);

    </script>
</body>
</html>