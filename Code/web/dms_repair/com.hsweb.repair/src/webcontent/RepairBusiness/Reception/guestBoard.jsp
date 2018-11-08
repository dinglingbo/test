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
.select-row{
   background:#8c8c8c;
}
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
			  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff">客户休息区看板</td>
			  <td style="width: 33%;text-align: center;font-size: 16px;font-weight: bold;color: #fff" id="clock">2018年7月3日20:57:53</td>
			  <td style="width: 33%;text-align: right;font-size: 16px;font-weight: bold;color: #fff">
			  	  <a class="nui-button" id="full" onclick="fullScreen()" > <span class="fa fa-arrows-alt fa-lg"></span></a>
				  <a class="nui-button" id="exit" onclick="exitScreen()" ><span class="fa fa-compress fa-lg"></span></a>
			  </td>
			
			</tr>
		</table>
	</div>
	<div class="nui-fit" style="background-color: #000">
	    <div id="guestBoardGrid" class="nui-datagrid" dataField="data" showLoading="false" enableHotTrack="false"  showPager="false" style="height:100%;width:100%;">
	        <div property="columns">
	            <div field="carNo" width="100" headerAlign="center" align="center">车牌号</div>
	            <div field="recordDate" dateFormat="yyyy-MM-dd H:mm" width="100" headerAlign="center" align="center">接车时间</div>
	            <div field="planFinishDate" width="100" dateFormat="MM-dd H:mm" headerAlign="center" align="center">预计完工时间</div>
	            <div field= "status" width="100" headerAlign="center" align="center">服务进程</div>
	            <div field= "mtAdvisor" width="100" headerAlign="center" align="center">服务顾问</div>
		        <div field= "status" width="100" headerAlign="center" align="center">服务顾问电话</div>
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
			"0" : "在报价",
			"1" : "施工中",
			"2" : "已完工"
		};
		var count = 1;
		var dataLength = 0;
		var full = null;
		var exit = null;

		$(document).ready(function(v) {
		
			full = nui.get("full");	
			exit = nui.get("exit");
			exit.setVisible(false);
			guestBoardGrid = nui.get("guestBoardGrid");
			guestBoardGrid.setUrl(gridUrl);

			guestBoardGrid.on("drawcell", function (e) {
				if (e.field == "status") {
					e.cellHtml = statusHash[e.value];
				}
				if(e.field == "carNo"){
				var carNo = e.row.carNo;
				carNo = replacePos(carNo,3,"*"); 
				carNo = replacePos(carNo,4,"*"); 
				e.cellHtml = carNo;
				}
			});

			load();
		});

		function load(){
			guestBoardGrid.load({
				token:token
			});
	
		}
		
		function replacePos(strObj,pos,replacetext){
			var str = strObj.substr(0, pos-1);	
			str += replacetext;	
			str += strObj.substring(pos,strObj.length);	
			return str;	
		}
		
				//全屏
        function fullScreen(){
            var el = document.documentElement;
            var rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullscreen;      
                if(typeof rfs != "undefined" && rfs) {
                    rfs.call(el);
                };
                full.setVisible(false);
                exit.setVisible(true);
              return;
        }
		
        //退出全屏
        function exitScreen(){
            if (document.exitFullscreen) {  
                document.exitFullscreen();  
            }  
            else if (document.mozCancelFullScreen) {  
                document.mozCancelFullScreen();  
            }  
            else if (document.webkitCancelFullScreen) {  
                document.webkitCancelFullScreen();  
            }  
            else if (document.msExitFullscreen) {  
                document.msExitFullscreen();  
            } 
            if(typeof cfs != "undefined" && cfs) {
                cfs.call(el);
            }
               	full.setVisible(true);
                exit.setVisible(false);
        }
		

/*  	function rolling(){
 			dataLength = guestBoardGrid.getData().length;
 			if(dataLength>25){
	 			var row = guestBoardGrid.getRow(count-1);
	 			var row1 = guestBoardGrid.getRow(count);
				guestBoardGrid.addRowCls(row1, "select-row");
				guestBoardGrid.removeRowCls(row, "select-row");
				guestBoardGrid.scrollIntoView(count);
				count++;
				if(count==dataLength){
					load();
					count=1;
				}
 			}else{
					load();
				}
		} */
		function rolling(){
 			dataLength = guestBoardGrid.getData().length;
	 			var row = guestBoardGrid.getRow(count-1);
	 			var row1 = guestBoardGrid.getRow(count);
				guestBoardGrid.addRowCls(row1, "select-row");
				guestBoardGrid.removeRowCls(row, "select-row");
				guestBoardGrid.scrollIntoView(count);
				count++;
				if(count==dataLength){
					load();
					count=1;
				}
 			}
		
		
 	setInterval(rolling,2000);
    </script>
</body>
</html>