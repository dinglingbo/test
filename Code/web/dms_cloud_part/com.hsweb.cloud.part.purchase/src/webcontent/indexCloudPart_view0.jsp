<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<html lang="zh-cmn-Hans">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<link rel="stylesheet" href="login/iconmenu/iconmenu.css">
		<script src="common/jquery/jquery.min.js" type="text/javascript"></script>
		<script src="login/highcharts.js" type="text/javascript"></script>
		<style type="text/css">
		      body{
		      font-family: "微软雅黑";
		      font-size: 14px;
		      overflow:auto; 
		      }
		      *{padding: 0px;margin: 0px;}
		      a {
		      text-decoration:none;
		      color:#53647f;
		      }
		      .two_vpanel{
		      width:98%;
		      min-width:1168px;
		      height:272px;
		      margin:0px 0px 0px 10px;
		      }
		      .vpanel{
		      border:1px solid #d9dee9;
		      margin:20px 0px 0px 20px;
		      width:39%;
		      height:248px;
		      float:left;
		      }
		      .vpanel_heading{
		      border-bottom:1px solid #d9dee9;
		      width:100%;
		      height:38px;
		      line-height:38px;
		      }
		      .vpanel_heading span{
		      margin:0 0 0 20px;
		      font-size:18px;
		      font-weight:normal;
		      }
		      .allNumber{
		      position: relative;
		      top: -160px;
		      left: 278px;
		      }
		      .barNumber{
		      position: relative;
		      float:left;
		      top: -103px;
		      margin-left: 65%;
		      }
		      .largefont{
		      font-size: 18px;
		      }
		      .midfont{
		      font-size: 17px;
		      }
		      .smallfont{
		      font-size: 10px;
		      position: relative;
		      top: 14px;
		      left: 6px;
		      }
		      .num{
		      font-size: 20px;
		      position: relative;
		      top: 16px;
		      }
		      .littleList{
		      /* float: left; */
		      width: 13%;
		      margin-right: 1%;
		      }
		      .horizontal-line{
		      border-top: 1px solid #ddd;
		      position: relative;
		      top: -79px;
		      left: 165px;
		      width: 69%;
		      }
		      .vertical-line{
		      border-left: 1px solid #ddd;
		      position: relative;
		      top:-5px;
		      /* float:left; */
		      margin-right: 10px;
		      height: 40px;
		      }
			.quickMenu_list{
				float:left;
				margin:0 auto 20px auto;
				width:100%;	
			}
			.quickMenus{
				min-width: 182px;
				width:29.52%;
				height: 56px;
				border:1px solid #d9dee9;
				margin:0px 6px 0px 9px;
				display:none;
			}
			.qMenus1{
				margin-top:20px;
			}
			.qMenus2{
				margin-top:-6px;
			}
			.quickMenus span{position: relative;top: -47px;left: 72px;width:112px;height:56px;font-size:14px;color:#666666;line-height:56px;}
			.div_img{margin:7px 0px 0px 22px;background-size:40px 40px;width:40px;height:40px;font-size:40px;line-height: 40px;}
		</style>
	</head>
	<body>
	<div class="nui-fit">
		<div class="two_vpanel" style="height:150px;">
			<div class="vpanel" style="width:52%;height:128px;">
				<div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>待办事项</span></div>
				<div class="vpanel_body">
					
				</div>
			</div>
			<div class="vpanel" style="height:128px;">
				<div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>通知公告</span></div>
				<div class="vpanel_body" >
				
				</div>
			</div>
		</div>
		<div class="two_vpanel">
			<div class="vpanel" style="width:52%">
				<div class="vpanel_heading" ><span>数据面板</span></div>
				<div class="vpanel_body">
				
					<div style="position: relative;top: 25px;">
						<div id="donutChart" style="width: 280px; height: 170px;"></div>
						<div id="donutData">
							<div class="allNumber">
								<div style="float: left;width: 19%;margin-left: 4%;">
									<div class="largefont">注册用户数</div>
									<font id="cumulativeUsersArea" class="num" color='#2d95ff'>4</font>
									<span class="smallfont">人</span>
								</div>
								<div style="float: left;width: 19%;margin-left: 6%;">
									<div class="largefont">实时在线人数</div>
									<font id="totalOnlineUsersArea" class="num" color='#2d95ff'>4</font>
									<span class="smallfont">人</span>
								</div>
							</div>
							<div class="horizontal-line"></div>
							<div style="position: relative;left: -160px;top: -56px;width:850px;">
								<span class="littleList">
									<img src="login/images/icon/icon_window.png">
									<span class="smallfont" style="position: relative;top:-1px;left: 2px;">Windows</span>
									<font id="windowsArea" class="midfont" style="position: relative;left: 5px;">1</font>
								</span>
								<span class="vertical-line"></span>
								<span class="littleList">
									<img src="login/images/icon/icon_mac.png">
									<span class="smallfont" style="position: relative;top:-1px;left: 2px;">Mac</span>
									<font id="macArea" class="midfont" style="position: relative;left: 5px;">1</font>
								</span>
								<span class="vertical-line"></span>
								<span class="littleList">
									<img style="position: relative;left: 0px;" src="login/images/icon/icon_android.png">
									<span class="smallfont" style="position: relative;top:-1px;left: 2px;">Android</span>
									<font id="androidArea" class="midfont" style="position: relative;left: 5px;">1</font>
								</span>
								<span class="vertical-line"></span>
								<span class="littleList">
									<img style="position: relative;left: 0px;" src="login/images/icon/icon_ios.png">
									<span class="smallfont" style="position: relative;top:-1px;left: 2px;">iOS</span>
									<font id="iosArea" class="midfont" style="position: relative;left: 5px;">1</font>
								</span>
							</div>
						</div>
					</div>
				
				</div>
			</div>
			
			<div class="vpanel">
				<div class="vpanel_heading" ><span>数据面板</span></div>
				<div class="vpanel_body">
				
					<div id="barChart" style="width: 230px; height: 140px;top: 59px;left:20px;position: relative;"></div>
					<div id="barData">
						<div class="barNumber">
							<div>
								<div class="largefont">今天新增用户数</div>
								<font id="newUsersArea" class="num font" color='#2d95ff'>1</font>
								<span class="smallfont font">人</span>
							</div>
							<div style="position: relative;top: 48px">
								<div class="largefont">本周流失用户数</div>
								<font id="thisWeekLossUsersArea" class="num font" color='#2d95ff'>1</font>
								<span class="smallfont font">人</span>
							</div>
						</div>
					</div>       
				
				</div>
			</div>
		</div>
		<div class="two_vpanel">
			<div class="vpanel" style="width:52%;height:218px;">
			<div class="vpanel_heading"><span>快捷入口</span></div>        
		    <div class="vpanel_body quickMenu_list" id="quickMenu_list">
				<a id="quickMenu0" class="quickMenus qMenus1" href="javascript:;" ></a>
				<a id="quickMenu1" class="quickMenus qMenus1" href="javascript:;" ></a>
				<a id="quickMenu2" class="quickMenus qMenus1" href="javascript:;" ></a>
				<a id="quickMenu3" class="quickMenus qMenus2" href="javascript:;" ></a>
				<a id="quickMenu4" class="quickMenus qMenus2" href="javascript:;" ></a>
				<a id="quickMenu5" class="quickMenus qMenus2" href="javascript:;" ></a>			
		    </div> 
			
			<script type="text/javascript">	      
				function getCookie(name){
					var str=document.cookie.split(";");
					for(var i=0;i<str.length;i++){
						var str2=str[i].split("=");
						if(str2[0].replace(/\s(.*)\s/,"$1")==name){
						return str2[1];
						}
					}
				}
		     	nui.ajax({
		     		url:"com.vplus.sysmgr.portal.queryRoleAccessableMenuTreeOnline.biz.ext",
		             type: 'POST',
		             success: function (text) {
		             	var menus = text.menus;
						var cookies_arr = new Array();
						function Cookies(url,num,name,img){
							this.url=url;
							this.num=num;
							this.name=name;
							if(img!=null)
							this.img=img;
							else
							this.img='login/iocn_temp1.png';
						}
						for (var i=0;i<menus.length;i++){
							if(getCookie(menus[i].menuId)!=null){
								cookies_arr.push(new Cookies(menus[i].menuUrl,getCookie(menus[i].menuId),menus[i].menuName,menus[i].menuIcon));
							}
						}
						cookies_arr.sort(function(a,b){return b.num-a.num;});
						if(cookies_arr.length>0){
							for (var i=0;i<6&&i<cookies_arr.length;i++){
								var tk='<div class="div_img icon iconmenu"></div><span >' + cookies_arr[i].name +'</span>';
								$("#quickMenu"+i).html(tk);
								$("#quickMenu"+i+" .div_img").addClass(cookies_arr[i].img);
								$("#quickMenu"+i).bind("click", {
									name:cookies_arr[i].name,url:cookies_arr[i].url
								},
			                    function(event){
									parent.addTab(
										{title:event.data.name,url:event.data.url,showCloseButton:true}
									);
			                    	if(parent.list){
			                    		var node = null;
					                    for(var i=0;i<parent.list.length;i++){
						                    if(parent.list[i].menuUrl==event.data.url){
						                    	node=parent.list[i];
						                    	break;
						                    }
						                    parent.menuTree.selectNode(node);
					                    }
				                    }
			                    });
								$("#quickMenu"+i).css('display','inline-block');
							}
						}
		             },
		             error: function (jqXHR, textStatus, errorThrown) {
		                 alert(jqXHR.responseText);
		             }
		     	});
			</script>
			
			</div>
			<div class="vpanel" style="height:218px;">
				<div class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>预警信息</span></div>
				<div class="vpanel_body">
				
				</div>
			</div>
		</div>
	</div>	
		<script type="text/javascript">
			var donutChart = null;
			var barChart = null;
			$(function(){
				createChart();//创建饼状图和柱状图
				loadChart();//加载饼状图和柱状图
			});
			function createChart(){
				createDonutChart();//创建饼状图
				createBarChart();//创建柱状图
			}
			function loadChart(){
				$.ajax({
					url: 'com.vplus.report.indexPanel.queryIndexPanel.biz.ext',
					type: "POST",
					contentType: "application/json; charset=utf-8",
					data: {},
					success: function(data)
					{
						if('S' == data.errCode){
							var cumulativeUsers = data.cumulativeUsers;//累积用户
							var fourHoursOnlineUsers = data.fourHoursOnlineUsers;//四小时内在线用户
							var newUsers = data.newUsers;//新增用户
							var thisWeekLossUsers = data.thisWeekLossUsers;//本周流失用户(上周启动过，本周未启动过)
							loadDonutChart(fourHoursOnlineUsers);//加载饼状图
							loadBarChart(newUsers, thisWeekLossUsers);//加载柱状图
							//加载表单数据
							loadFormData(cumulativeUsers, fourHoursOnlineUsers, newUsers, thisWeekLossUsers);
						}
					},
					error: function (jqXHR, textStatus, errorThrown) {
						$('body').append('网络异常<br>');
					}
				});
			}
			function createDonutChart(){
				$('#donutChart').highcharts({
					chart: {
						plotBackgroundColor: null,
						plotBorderWidth: 0,
						plotShadow: false
					}
					,legend: {
						align: 'right',
						verticalAlign: 'top',
						x: -10,
						y: 0,
						layout:'vertical',
						itemStyle: {
							color: '#999999'
						},
						labelFormatter: function () {
							return this.name +' '+this.percentage.toFixed(1) +'%';
						}
					}
					,title: null
					,tooltip: {
						pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
					}
					,series: [{
						type: 'pie',
						name: '用户在线人数占比',
						innerSize: '65%',
						data: [
							{name:'Windows',y:0.0,color:'#2d95ff'},
							{name:'Mac',y:0.0,color:'#434348'},
							{name:'Android',y:0.0,color:'#16c395'},
							{name:'iOS',y:0.0,color:'#f7b55e'}
						]
					}]
					,plotOptions:{
						pie: {
							dataLabels: {
								enabled: false,
								distance: -50,
								style: {
									fontWeight: 'bold',
									color: 'white',
									textShadow: '0px 1px 2px black'
								}
							},
							startAngle: 70,
							endAngle: 430,
							center: ['65%', '50%'],
							showInLegend: true
						}
					}
					,credits: {
						enabled: false
					}
				}, function(c) {
			        donutChart = c;//获取饼图对象
			    });
			}
			function loadDonutChart(fourHoursOnlineUsers){
				var iosNum = 1;
				var androidNum = 1;
				var windowsNum = 1;
				var macNum = 1;
				if(null!=fourHoursOnlineUsers && 0<fourHoursOnlineUsers.length){
					var onlineUser = null;
					var osName = null;
					var num = 0;
					for(var i=0;i<fourHoursOnlineUsers.length;i++){
						onlineUser = fourHoursOnlineUsers[i];
						osName = onlineUser.osName;
						num = onlineUser.num;
						if('IOS' == osName){
							iosNum = num;
						} else if('ANDROID' == osName){
							androidNum = num;
						} else if('WINDOWS' == osName){
							windowsNum = num;
						} else if('MAC' == osName){
							macNum = num;
						}
					}
				}
				donutChart.series[0].setData(
					[
						{name:'Windows', y:windowsNum, color:'#2d95ff'},
						{name:'Mac', y:macNum, color:'#434348'},
						{name:'Android', y:androidNum, color:'#16c395'},
						{name:'iOS', y:iosNum, color:'#f7b55e'}
					]
				);
			}
			function createBarChart(){
				$('#barChart').highcharts({
					chart: {
						type: 'column',
						marginTop:-5
					}
					,title: ' '
					,tooltip: {
						headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
						pointFormat: '<tr><td style="color:{series.color};padding:0"></td><td style="padding:0"><b>{point.y} 人</b></td></tr>',
						footerFormat: '</table>',
						shared: true,
						useHTML: true
					}
					,xAxis: {
						categories: ['新增用户','流失用户'],
						labels: {
							formatter: function () {
								return this.value;
							},
							style: {
								color: '#999999',
								fontFamily:'微软雅黑'
							}
						},
						crosshair: true
					}
					,yAxis: {
						min: 0,
						tickPixelInterval:40,
						title: {
							enabled: false
						},
						labels: {
							formatter: function () {
								return this.value;
							},
							style: {
								color: '#999999',
								fontFamily:'微软雅黑'
							}
						},
						gridLineColor: '#f7f7f7'
					}
					,credits: {
						enabled: false
					}
					,plotOptions: {
						column: {
							pointPadding: 0.2,
							borderWidth: 1,
							pointWidth: 20
						}
					}
					,series: [{
						name: '人数',
						data: [
							{y:0.0, color:'#2d95ff'},
							{y:0.0, color:'#999999'}
						]
					}]
					,legend: {
						enabled:false
					}
				}, function(c) {
					barChart = c;//获取饼图对象
			    });
			}
			function loadBarChart(newUsers, thisWeekLossUsers){//加载柱状图
				barChart.series[0].setData(
					[
						{y:newUsers, color:'#2d95ff'},
						{y:thisWeekLossUsers, color:'#999999'}
					]
				);
			}
			function loadFormData(cumulativeUsers, fourHoursOnlineUsers, newUsers, thisWeekLossUsers){
				var iosNum = 1;
				var androidNum = 1;
				var windowsNum = 1;
				var macNum = 1;
				if(null!=fourHoursOnlineUsers && 0<fourHoursOnlineUsers.length){
					var onlineUser = null;
					var osName = null;
					var num = 0;
					for(var i=0;i<fourHoursOnlineUsers.length;i++){
						onlineUser = fourHoursOnlineUsers[i];
						if(null != onlineUser){
							osName = onlineUser.osName;
							num = onlineUser.num;
							if(0 < num){
								if('IOS' == osName){
									iosNum = num;
								} else if('ANDROID' == osName){
									androidNum = num;
								} else if('WINDOWS' == osName){
									windowsNum = num;
								} else if('MAC' == osName){
									macNum = num;
								}
							}
						}
					}
				}

				$('#iosArea').html(iosNum);//iOS区域
				$('#androidArea').html(androidNum);//android区域
				$('#windowsArea').html(windowsNum);//windows区域
				$('#macArea').html(macNum);//mac区域
				var totalOnlineUsers = iosNum + androidNum + windowsNum + macNum;
				$('#totalOnlineUsersArea').html(totalOnlineUsers);//实时在线人数
				$('#cumulativeUsersArea').html(cumulativeUsers);//累积用户数
				$('#newUsersArea').html(newUsers);//新增用户数
				$('#thisWeekLossUsersArea').html(thisWeekLossUsers);//本周流失用户
			}
		</script>
	</body>
</html>