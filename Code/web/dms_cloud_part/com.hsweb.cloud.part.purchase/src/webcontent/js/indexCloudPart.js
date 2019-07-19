/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";
var workBoardUrl = baseUrl + "com.hsapi.cloud.part.report.timer.queryTodayBill.biz.ext";
var businessRemindUrl = baseUrl + "com.hsapi.cloud.part.report.report.queryBusinessRemind.biz.ext";
var targetDataRemindUrl = baseUrl + "com.hsapi.cloud.part.report.report.queryDataRemind.biz.ext";

var gridWorkBoard = null;
var gridWaitDo = null;
var targetDataMindForm = null;


$(document).ready(function(v) {

	gridWorkBoard = nui.get("gridWorkBoard");
	gridWaitDo = nui.get("gridWaitDo");
	targetDataMindForm = new nui.Form("#targetDataMindForm");
	gridWorkBoard.setUrl(workBoardUrl);
	gridWorkBoard.load({token:token});

	gridWorkBoard.setData(grid1_data);
	gridWorkBoard.setShowVGridLines(false);
	gridWorkBoard.setShowHGridLines(false);

	gridWaitDo.setData(waitDoData);
	gridWaitDo.setShowVGridLines(false);
	gridWaitDo.setShowHGridLines(false);

	showMain();

	//加载待办
	queryBusinessRemindData(setGridWaitDoData);

	queryTargetDataRemindData(setGridTargetDataData);

	setInitShareUrl();

	gridWaitDo.on("drawcell",function(e){
	    var record = e.record;
	    var column = e.column;
	    var field = e.field;
	    var value = e.value;
	    var row = e.row;
	    //if(column.field == "num"||column.field == "business"){
	        if(value){
	            e.cellStyle = "color:#4d7496";
	        }
	    //}
	});

	//ShowRSS();
	if(currIsOpenApp==1){
		$("#epc").hide();
		$("#purRtn").show();
	}else{
		$("#epc").show();
		$("#purRtn").hide();
	}
});
var grid1_data =[{business:"采购订单",custom:"长荣行",address:"上海浦东",date:"8:40",status:"已受理"},
{business:"采购订单2",custom:"长荣行2",address:"上海浦东2",date:"8:50",status:"已受理2"}];

var waitDoData =[{business1:"未入库采购订单",num1:"0",business2:"待受理采购订单",num2:"0"},
				 {business1:"未出库销售订单",num1:"0",business2:"待受理客户退单",num2:"0"},
				 {business1:"未付款对账单",num1:"0",business2:"",num2:""},
				 {business1:"未收款对账单",num1:"0",business2:"",num2:""},
				 {business1:"本月月结未对账",num1:"0",business2:"",num2:""}];

// 单据状态
var AuditSignList = [ {
	customid : '0',
	name : '未审'
}, {
	customid : '1',
	name : '已审'
}, {
	customid : '2',
	name : '已过账'
}, {
	customid : '3',
	name : '已取消'
} ];
var AuditSignHash = {
	"0" : "未审",
	"1" : "已审",
	"2" : "已过账",
	"3" : "已取消"
};
var StatusHash = {
	"0" : "草稿",
	"1" : "待发货",
	"2" : "待收货",
	"3" : "部分入库",
	"4" : "全部入库",
	"5" : "已退回",
	"6" : "已关闭"
};
function setGridWaitDoData(data){

	var rows = gridWaitDo.getData();
	var row1 = rows[0];
	var row2 = rows[1];
	var row3 = rows[2];
	var row4 = rows[3];
	var row5 = rows[4];
	if(data && data.length>0){
		var newRow1 = {num1:"0",num2:"0"};//未入库采购订单1  待受理采购订单6
		var newRow2 = {num1:"0",num2:"0"};//未出库销售订单2  待受理客户退单7
		var newRow3 = {num1:"0"};//未付款对账单3 
		var newRow4 = {num1:"0"};//未收款对账单4
		var newRow5 = {num1:"0"};//本月月结未对账5 
		for(var i=0; i<data.length; i++){
			var d = data[i];
			var code = d.code;
			if(code == 1){
				newRow1.num1 = d.remindValue||0;
			}else if(code == 2){
				newRow2.num1 = d.remindValue||0;
			}else if(code == 3){
				newRow3.num1 = d.remindValue||0;
			}else if(code == 4){
				newRow4.num1 = d.remindValue||0;
			}else if(code == 5){
				newRow5.num1 = d.remindValue||0;
			}else if(code == 6){
				newRow1.num2 = d.remindValue||0;
			}else if(code == 7){
				newRow2.num2 = d.remindValue||0;
			}
		}
		gridWaitDo.updateRow(row1, newRow1);
		gridWaitDo.updateRow(row2, newRow2);
		gridWaitDo.updateRow(row3, newRow3);
		gridWaitDo.updateRow(row4, newRow4);
		gridWaitDo.updateRow(row5, newRow5);
	}else{
		var newRow = {num1:"0",num2:"0"}
		gridWaitDo.updateRow(row1, newRow);
		gridWaitDo.updateRow(row2, newRow);
		gridWaitDo.updateRow(row3, newRow);
		gridWaitDo.updateRow(row4, newRow);
		gridWaitDo.updateRow(row5, newRow);
	}

}
function setGridTargetDataData(data){
	//1今日收入 2今日支出  3库存总成本 4库存SKU部类 5客户欠款 6供应商欠款
	$("#todayReceive").text(0);
	$("#todayPay").text(0);
	$("#stockAmt").text(0);
	$("#stockPartItem").text(0);
	$("#clientNeedReceive").text(0);
	$("#supplierNeedPay").text(0);
	
	if(data && data.length>0){
		var todayReceive = 0, todayPay = 0, stockAmt = 0, stockPartItem = 0, clientNeedReceive = 0, supplierNeedPay = 0;
		for(var i=0; i<data.length; i++){
			var d = data[i];
			var code = d.code;
			if(code == 1){
				todayReceive = d.remindValue||0;
			}else if(code == 2){
				todayPay = d.remindValue||0;
			}else if(code == 3){
				stockAmt = d.remindValue||0;
			}else if(code == 4){
				stockPartItem = d.remindValue||0;
			}else if(code == 5){
				clientNeedReceive = d.remindValue||0;
			}else if(code == 6){
				supplierNeedPay = d.remindValue||0;
			}
		}
		$("#todayReceive").text(numToMoneyField(todayReceive));
		$("#todayPay").text(numToMoneyField(todayPay));
		$("#stockAmt").text(numToMoneyField(stockAmt));
		$("#stockPartItem").text(numToMoneyField(stockPartItem));
		$("#clientNeedReceive").text(numToMoneyField(clientNeedReceive));
		$("#supplierNeedPay").text(numToMoneyField(supplierNeedPay));
	}

}
function toAskPartPrice(){
	var item={};
	item.id = "010";
	item.text = "快速报价";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.purchase.quickSearch.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function toPchsOrder(){
	var item={};
	item.id = "1681";
	item.text = "采购入库";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.purchase.purchaseOrderEnter.flow";
	item.iconCls = "fa fa-file-text";
	if(currIsOpenApp==1){
		item.id = "1184";
		item.text = "采购订单";
		item.url = webPath + contextPath + "/com.hsweb.cloud.part.purchase.purchaseOrder.flow";
		item.iconCls = "fa fa-file-text";
	}
	window.parent.activeTab(item);
}
function toSellOrder(){
	var item={};
	item.id = "1682";
	item.text = "销售出库";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.purchase.sellOrderOut.flow";
	item.iconCls = "fa fa-file-text";
	if(currIsOpenApp==1){
		item.id = "1269";
		item.text = "销售订单";
		item.url = webPath + contextPath + "/com.hsweb.cloud.part.purchase.sellOrder.flow";
		item.iconCls = "fa fa-file-text";
	}
	window.parent.activeTab(item);
}
function toEPC(){
	var item={};
	item.id = "1521";
	item.text = "EPC云服务";
	item.url = webPath + contextPath + "/com.hsweb.system.epc.vinLinkMain.flow";
	item.iconCls = "fa fa-car";
	window.parent.activeTab(item);
}
function toPackOut(){
	var item={};
	item.id = "1561";
	item.text = "打包发货";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.purchase.packOut.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function toState(){
	var item={};
	item.id = "1541";
	item.text = "月结对账";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.settlement.billStatement.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function toSettleAccount(){
	var item={};
	item.id = "1282";
	item.text = "应收应付结算";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.settlement.rpAccountSettle.flow";
	item.iconCls = "fa fa-exchange";
	window.parent.activeTab(item);
}
function toCostOut(){
	var item={};
	item.id = "1425";
	item.text = "费用支出单";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.settlement.expensePay.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function toPurRtn(){
	var item={};
	item.id = "1321";
	item.text = "采购退货";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.purchase.purchaseOrderRtn.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function queryBusinessRemindData(callback) {
	nui.ajax({
		url : businessRemindUrl,
		type : "post",
		data : JSON.stringify({token:token}),
		success : function(data) {
			data = data || {};
			if (data.list) {
				callback(data.list);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
function queryTargetDataRemindData(callback) {
	nui.ajax({
		url : targetDataRemindUrl,
		type : "post",
		data : JSON.stringify({token:token}),
		success : function(data) {
			data = data || {};
			if (data.list) {
				callback(data.list);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
function loadWorkBoard(){
	gridWorkBoard.load({token:token});
}
var typeIdHash = {1:"采购订单",2:"销售订单",3:"采购退货",4:"销售退货"};
var enterIdHash = {1:"待发货",2:"待收货",3:"部分入库",4:"全部入库",5:"已退回",6:"已关闭"};
var outIdHash = {1:"待出库",2:"已出库"};
function onDrawCell(e){
	var row = e.row;
	switch (e.field) {
    	case "orderTypeId":
    		if (typeIdHash[e.value]) {
    			e.cellHtml = typeIdHash[e.value] || "";
    		} else {
    			e.cellHtml = "";
    		}
    		break;
        case "billStatusId":
        	if(row.orderTypeId == 1 || row.orderTypeId == 4){
	    		if (enterIdHash[e.value]) {
	    			e.cellHtml = enterIdHash[e.value] || "";
	    		} else {
	    			e.cellHtml = "";
	    		}
        	}else if(row.orderTypeId == 2 || row.orderTypeId == 3){
	    		if (outIdHash[e.value]) {
	    			e.cellHtml = outIdHash[e.value] || "";
	    		} else {
	    			e.cellHtml = "";
	    		}
        	}
            break;
    	default:
    		break;
	}
}
var  echartNum = [373423,345343,322796,306731,296842,285433,250000,230000,213434,203434,183434,163434];
var xdata = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"];

function showMain() {
    var dataurl = null;
    var rot = 0;

    var params = {};
    params.startDate = getQuarterStartDate();
    params.endDate = addDate(getQuarterEndDate(), 1);

    var staffArr,staffAchValue;
	var dataurl = baseUrl + "com.hsapi.cloud.part.report.timer.queryStaffAchievement.biz.ext";
	nui.ajax({
		url : dataurl,
		type: 'post',
        async: false, //同步执行，返回成功后才能进行下面的操作
        data : nui.encode({params:params,token:token}),
        success:function(text){
        	if(text.errCode == 'S') {
        		staffArr = text.staffArr;
        		staffAchValue = text.staffAchValue;
        	}

        },
        error : function(jqXHR, textStatus, errorThrown) {
			Console.log(jqXHR.responseText);
        }
    });

    var itemStyle = {
        normal: {
            color: [
            '#ff7f50','#87cefa','#da70d6','#32cd32'
            ]
        }
    };

    var soption = {
        title: {
            text: '',
            subtext: '',
            x: 'center'
        },
        color: ['#3398DB', '#ff7f50','#da70d6','#32cd32'],
        tooltip: {
            trigger: 'axis',
                    axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                        type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                    }
                }, 
                
             /*   legend: {
                    data: ['数量']
                },*/
                
                grid: {
                    left: '10%', 
                    right: '5%',
                /*      bottom: '3%',
                containLabel: true,*/
                x:35,
                y:20,
                x2:20,
                y2:30
            },
            xAxis: [
            {
                type: 'category',
                axisLabel:{
                        interval:0,//横轴信息全部显示
                        rotate:rot,//-30度角倾斜显示 (省份)
                    },
                    data: staffArr,
                    axisTick: {
                        alignWithLabel: true
                    }
                }
                ],
                yAxis: [
                {
                    type: 'value',
                    scale: 'true',
                    splitLine: {
                        show: false
                    },
                }
                ],
                series: 
                {
                    name: '金额',
                    type: 'bar',
                    data: staffAchValue
                },
                
            };

            var myChart = echarts.init(document.getElementById('Ranking'));

            //使用刚指定的配置项和数据显示图表。
            myChart.setOption(soption,true);
            window.onresize = function(){
                myChart.resize(); 
            };
} 
var shareUrlGridUrl = apiPath + sysApi + "/com.hsapi.system.config.paramSet.queryTenantShareUrl.biz.ext";
function setInitShareUrl(){
	var param = {tenantId:currTenantId};
	nui.ajax({
		url : shareUrlGridUrl,
		type : "post",
		data : JSON.stringify({
			param : param,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			var list = data.list;
			if (list && list.length>0) {
				$(".newul").empty();
				for(var i=0; i<list.length; i++){
					var r = list[i];
					var name = r.name;
					var url = r.shareUrl;//<li><a href="http://www.baidu.com">华胜企业体系</a></li>
					$(".newul").append('<li ><a href='+url+' target="_Blank">'+name+'</a></li>');
				}


			} else {
				
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

var xmlHttp;

function ShowRSS() {
	var target = "http://www.qpcheng.cn/feed/rss.php?mid=21";
	readRSS(target);
}
//-------------------------------------------------------------------------
//创建一个实例化xmlHttp
function createXMLHttpRequest() {
	if (window.ActiveXObject) {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	} else if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	}
}
//-------------------------------------------------------------------------
//判断状态
function handleStateChange() {
	if (xmlHttp.readyState == 4) {
		if (xmlHttp.status == 200) {
		  clearPreviousResults();
		  parseResults();
		}
	}
}
//-------------------------------------------------------------------------
function readRSS(url) {
	createXMLHttpRequest();
	xmlHttp.onreadystatechange = handleStateChange;
	xmlHttp.open("GET", url, true);
	xmlHttp.send(null);
}

//-------------------------------------------------------------------------
//清除以前的RSS
function clearPreviousResults() {
	var ListBody = document.getElementById("results");
	while (ListBody.childNodes.length > 0) {
		ListBody.removeChild(ListBody.childNodes[0]);
	}
}
//-------------------------------------------------------------------------
function parseResults() {
	var results = xmlHttp.responseXML;
	var title = null;
	var content = null;
	var item = null;
	var items = results.getElementsByTagName("item");
	for (var i = 0; i < items.length; i++){
		item = items[i];
		title = item.getElementsByTagName("title")[0].firstChild.nodeValue;
		link = item.getElementsByTagName("link")[0].firstChild.nodeValue;
		content = item.getElementsByTagName("description")[0].firstChild.nodeValue;
		addListRow(title, link, content);
	}
}
//-------------------------------------------------------------------------
function addListRow(title, link, content) {
	var row = document.createElement("ul");
	var titlecell = createMyCellWithTitle(title, link);
	var contentcell = creatMyCellWithContent(content);
	row.appendChild(titlecell);
	row.appendChild(contentcell);
	document.getElementById("newul").appendChild(row);
}
//-------------------------------------------------------------------------
function createCellWithText(text) {
	var cell = document.createElement("li");
	var textNode = document.createTextNode(text);
	cell.appendChild(textNode);
	return cell;
}
//-------------------------------------------------------------------------
function createMyCellWithTitle(title, link) {
	var cell = document.createElement("div");
	var show = '<a target=_blank href=\'' + link + '\'>' + title;
	cell.innerHTML = show;
	return cell
}
//-------------------------------------------------------------------------
function creatMyCellWithContent(content) {
	var cell = document.createElement("div");
	cell.innerHTML = content;
	return cell;
}
//-------------------------------------------------------------------------
function createCellWithContent(content) {
	var cell = document.createElement("h1");
	var textNode = document.createTextNode(content);
	cell.appendChild(textNode);
	return cell;
}
//-------------------------------------------------------------------------
