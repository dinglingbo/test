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
<title>配件物流看板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
      <style type="text/css">
            .mini-grid-cell{
      		    font-size: 18px;
      }
      
            .mini-grid-headerCell-inner {
    word-break: break-all;
    padding-top: 15px;
    padding-bottom: 15px;
    overflow: hidden;
}
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
    font-size: 30px;
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
	<div style="height: 60px;background-color: #fa8c16">
		<table style="width: 100%;line-height: 2;">
			<tr>
			  <td style="width: 33%;text-align: center;font-size: 26px;font-weight: bold;color: #fff">配件物流看板</td>
			  <td style="width: 33%;text-align: center;font-size: 26px;font-weight: bold;color: #fff" id="clock">2018年7月3日20:57:53</td>
			  <td style="width: 33%;text-align: right;font-size: 26px;font-weight: bold;color: #fff">
			  	  <a class="nui-button" id="full" onclick="fullScreen()" > <span class="fa fa-arrows-alt fa-lg"></span></a>
				  <a class="nui-button" id="exit" onclick="exitScreen()" ><span class="fa fa-compress fa-lg"></span></a>
			  </td>
			
			</tr>
		</table>
	</div>
	<div class="nui-fit" style="background-color: #000">
	    <div id="partLogisticsGrid" class="nui-datagrid" dataField="data" showLoading="false" enableHotTrack="false" 
	   	  allowRowSelect="false" showPager="false" style="height:100%;width:100%;">
	        <div property="columns">
	            <div field="carNo" width="60" headerAlign="center" align="center">车牌号</div>
	            <div field="partName" width="80" headerAlign="center" align="center">配件名称</div>
	            <div field="partCode" width="80" headerAlign="center" align="center">配件编码</div>
	            <div field="guestName" width="130" headerAlign="center" align="center">供应商</div>
	            <div field="planArriveDate" width="100"  headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" align="center">预计到货时间</div>
	            <div field= "qty" width="40" headerAlign="center" align="center">数量</div>
	            <div field= "status" width="40" headerAlign="center" align="center">状态</div>
	        </div>
	        
	    </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();      
		setInterval("showtime('clock');",1000);
		var baseUrl = apiPath + repairApi + "/";
		var partLogisticsGrid = null;
		var data =  [
			{
				carNo: '粤Z23W34',
				partName: '变速箱转速传感器',
				partCode: '095927321B',
				guestName: '广州市鸿泽运汽车贸易有限公司',
				planArriveDate: '12月04日 12:50',
				qty: '3',
				status: '待收货'
			},
			{
				carNo: '粤PQ3212',
				partName: '水箱温度传感器卡环',
				partCode: '06J121142',
				guestName: '广州市鸿泽运汽车贸易有限公司',
				planArriveDate: '12月05日 12:50',
				qty: '1',
				status: '分拣中'
			},
			{
				carNo: '粤PQ3212',
				partName: '漆面水晶镀膜套装',
				partCode: 'YH-223021',
				guestName: '广州鸿辉汽车用品有限公司',
				planArriveDate: '12月05日 12:50',
				qty: '3',
				status: '分拣中'
			},
			{
				carNo: '粤D7894X',
				partName: 'ABS泵支架',
				partCode: '1154652',
				guestName: '广州鸿辉汽车用品有限公司',
				planArriveDate: '12月06日 13:40',
				qty: '3',
				status: '分拣中'
			},
			{
				carNo: '粤D7894X',
				partName: '机油滤清器',
				partCode: 'A2701800109',
				guestName: '广州长荣行汽车配件有限公司',
				planArriveDate: '12月05日 14:50',
				qty: '3',
				status: '分拣中'
			},
			{
				carNo: '桂D21111',
				partName: '火花塞',
				partCode: '0242235776',
				guestName: '广州长荣行汽车配件有限公司',
				planArriveDate: '12月06日 12:50',
				qty: '3',
				status: '已出库'
			},
			{
				carNo: '粤YHT939',
				partName: '制动蹄片',
				partCode: '0986AB3987',
				guestName: '长沙恒信奥迪汽车销售服务有限公司',
				planArriveDate: '12月04日 13:30',
				qty: '3',
				status: '已出库'
			},
			{
				carNo: '粤YHT939',
				partName: '	轮胎',
				partCode: '409778',
				guestName: '长沙恒信奥迪汽车销售服务有限公司',
				planArriveDate: '12月02日  9:42',
				qty: '3',
				status: '分拣中'
			}
		];
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
		
/* 			full = nui.get("full");	
			exit = nui.get("exit");
			exit.setVisible(false); */
			partLogisticsGrid = nui.get("partLogisticsGrid");
			partLogisticsGrid.setData(data);
			guestBoardGrid.setUrl(gridUrl);

			guestBoardGrid.on("drawcell", function (e) {
				if (e.field == "status") {
					e.cellHtml = statusHash[e.value];
				}
				if (e.field == "recordDate") {
				var str =e.cellHtml.split(" "); 
				var qian = str[0].split("-");
				var time = qian[1]+"月"+qian[2]+"日"+" "+str[1];
					e.cellHtml = time;
				}
				if (e.field == "planArriveDate") {
					if(e.cellHtml!=""&&e.cellHtml!=null){
						var str =e.cellHtml.split(" "); 
						var qian = str[0].split("-");
						var time = qian[1]+"月"+qian[2]+"日"+" "+str[1];
						e.cellHtml = time;
					}
				}
				if(e.field == "carNo"){
				var carNo = e.row.carNo;
				carNo = replacePos(carNo,3,"*"); 
				carNo = replacePos(carNo,4,"*"); 
				e.cellHtml = carNo;
				}
			});
			$(function(){
				$(window).keydown(function (event) {
					if (event.keyCode == 27) {
						               	full.setVisible(true);
                exit.setVisible(false);
					}
				});
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
/*                 full.setVisible(false);
                exit.setVisible(true); */
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
/*                	full.setVisible(true);
                exit.setVisible(false); */
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