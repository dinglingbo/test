var grid = null;
var newRow = null;
var invoiceTypeEl = null;
var form = null;
var baseUrl = apiPath + repairApi + "/";
var advancedMorePartWin = null;
var moreGrid = null;
var oldValue = null;
var oldRow = null;
var servieTypeList = [];
var servieTypeHash = {};
$(document).ready(function () {
	grid = nui.get("grid");
	advancedMorePartWin = nui.get("advancedMorePartWin");
	moreGrid = nui.get("moreGrid");
	form = new nui.Form("#form");
	/*if(nui.get("main").value){
		grid.setUrl(baseUrl+"com.hsapi.repair.repairService.query.searchTicketDetail.biz.ext");
    	grid.load({mainId : nui.get("main").value,token : token});
    	nui.ajax({
            url: baseUrl+"com.hsapi.repair.repairService.query.selectInvoiceMain.biz.ext",
            type : "post",
            data : {
            	rid : nui.get("main").value
            },
            success: function (text) {
            	if(text.errCode == "S"){
            		var list = nui.decode(text.list);
            		document.getElementById("rate").value = list[0].rate;
            		form.setData(list[0]);
            		nui.get("invoiceType").setText(list[0].invoiceType);
            		nui.get("invoiceType").setValue(list[0].invoiceType);
            		
            	}
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
                showMsg("网络出错！", "W");
            }
    	});
	}else{
		newRow = {serviceCode : nui.get("serviceCode").value};
		grid.addRow(newRow , 0);
	}*/
	grid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		if(field == "action"){ 
			e.cellHtml ='<a class="optbtn" href="javascript:addRow()">增加</a> '+ '<a class="optbtn" href="javascript:remove()">删除</a> ';
		}
		if(field == "rate"){
			if(value){
				e.cellHtml = value + "%";
			}
		}
		if(field == "invoiceType"){
			if(value){
				e.cellHtml = servieTypeHash[value].name;
			}
			
		}
	});
	
	invoiceTypeEl = nui.get("invoiceType");
	/*initServiceType("invoiceType",function(data) {
        servieTypeList = nui.get("invoiceType").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });*/
	var dicDefs = {"invoiceType":"DDT20130703000008"};
	initDicts(dicDefs,function(data){
		servieTypeList = nui.get("invoiceType").getData();
        servieTypeList.forEach(function(v) {
        servieTypeHash[v.id] = v;
        });
	});
	
	advancedMorePartWin.on("load",function(e){
		
		var data = advancedMorePartWin.getData();
		if(data.length == 0){
			showMsg("该源单号暂没数据","W");
		}else if(data.length == 1){
			var row = advancedMorePartWin.getRow(0);
			advancedMorePartWin.hide();
			var newRow = {};
		}
	});
	grid.on("cellendedit",function(e){
		var field = e.field;
		if(field == "invoiceAmt"){
			/*document.getElementById("rateMoney").innerHTML = 0;
			document.getElementById("money").innerHTML = 0;*/
			var data = grid.getData();
			for(var i = 0 , l = data.length ; i < l ; i ++){
				var row = grid.getRow(i);
				if(data[i].invoiceAmt && data[i].rate){
					var rateAmt = data[i].rate * data[i].invoiceAmt / 100;
					var newRow = {rateAmt : rateAmt};
					grid.updateRow(row,newRow);
					/*document.getElementById("rateMoney").innerHTML = parseFloat(document.getElementById("rateMoney").innerHTML)+parseFloat(rateAmt);
					document.getElementById("money").innerHTML = parseFloat(document.getElementById("money").innerHTML)+parseFloat(row.invoiceAmt);*/
				}
			}
		}
	});
	moreGrid.on("rowdblclick",function(e){
		addSelect();
	});
});



function setInitData(params){
	if(params.main){
		nui.get("main").setValue(params.main);
		nui.get("serviceCode").setValue(params.serviceCode);
		grid.setUrl(baseUrl+"com.hsapi.repair.repairService.query.searchTicketDetail.biz.ext");
    	grid.load({mainId : params.main,token : token});
    	nui.ajax({
            url: baseUrl+"com.hsapi.repair.repairService.query.selectInvoiceMain.biz.ext",
            type : "post",
            data : {
            	rid : params.main
            },
            success: function (text) {
            	if(text.errCode == "S"){
            		var list = nui.decode(text.list);
            		document.getElementById("rate").value = list[0].rate;
            		form.setData(list[0]);
            		nui.get("invoiceType").setText(list[0].invoiceType);
            		nui.get("invoiceType").setValue(list[0].invoiceType);
            		
            	}
            },
            error: function (jqXHR, textStatus, errorThrown) {
                console.log(jqXHR.responseText);
                showMsg("网络出错！", "W");
            }
    	});
	}else{
		form.setData([]);
		grid.setData([]);
		newRow = {serviceCode : nui.get("serviceCode").value};
		grid.addRow(newRow , 0);
	}
}

function addRow(){//新增
	var row = grid.getSelected();
	var index = grid.indexOf(row);
	newRow = {
			rate:document.getElementById("rate").value,
			serviceCode :  nui.get("serviceCode").value
			};
	grid.addRow(newRow,index+1);
}

function remove(){//删除
	var data = grid.getData();
	if(data.length == 1){
		 showMsg("不能删除此行","W");
	}else{
		var row = grid.getSelected();
		grid.removeRow(row,false);
	}
}

function saveData(){//保存
	var data = form.getData();
	var allData = grid.getData();
	/*var updatData = [];
	for(var i = 0;i<allData.length;i++){
		var temp = allData[i];
		if(temp.id && temp.id>0){
			updatData.push(temp);
		}
	}*/
	//data.invoiceType = nui.get("invoiceType").getValue();
	nui.ajax({
        url: baseUrl+"com.hsapi.repair.repairService.insurance.saveInvoice.biz.ext",
        type: "post",
        cache: false,
        data: {
        	 i: grid.getChanges("added"),
             d: grid.getChanges("removed"),
             u: grid.getChanges("modified"),
             data : data,
             main : nui.get("main").value,
             token : token
        },
        success: function(text) {
        	nui.get("main").setValue(text.mainId);
        	showMsg("保存成功！", "S");
        	grid.setUrl(baseUrl+"com.hsapi.repair.repairService.query.searchTicketDetail.biz.ext");
        	grid.load({mainId : text.mainId,token : token});
        }
    });
}
function checkValue(e){//实时监听税率输出的值
	if (e.value < 0 || e.value > 100){
		document.getElementById("rate").value = "";
		showMsg("请输入0-100以内的数字","W");
	}else{
		if(/\D/.test(e.value)){
			showMsg('只能输入数字',"W");
			document.getElementById("rate").value = "";;
		}
	}
	var data = grid.getData();
	//document.getElementById("rateMoney").innerHTML = 0;
	for(var i = 0, l = data.length ; i < l ; i++){
		var row = grid.getRow(i);
		var invoiceAmt = row.invoiceAmt;
		var rateAmt = 0;
		if(invoiceAmt){
			rateAmt = row.invoiceAmt*e.value/100;
			rateAmt=rateAmt.toFixed(2);	
		}
		var newRow = {rate : e.value,
				    rateAmt : rateAmt
				};
		grid.updateRow(row,newRow);
		/*if(document.getElementById("rate").value && row.invoiceAmt){
			var rateAmt = parseFloat(document.getElementById("rate").value) * row.invoiceAmt / 100;
			var newRow = {rateAmt : rateAmt};
			grid.updateRow(row,newRow);
			document.getElementById("rateMoney").innerHTML = parseFloat(document.getElementById("rateMoney").innerHTML)+parseFloat(rateAmt);
		}*/
	}
}

function onCellEditEnter(e) {
	type = null;
	var record = e.record;
	var cell = grid.getCurrentCell();//行，列
	if(cell && cell.length >= 2){
		var column = cell[1];
		if(column.field == "serviceCode"){
			var serviceCode = record.serviceCode || "";
			if(!serviceCode){
				showMsg("请输入源单号","W");
				return;
			}else{
				advancedMorePartWin.show();
				var params = {
						serviceCode : serviceCode
				};
				moreGrid.setUrl(baseUrl+"com.hsapi.repair.repairService.query.querySettleList.biz.ext");
				moreGrid.load({params : params,token : token});
			}
		}
	}
}

var type = null;
function addRepair() {
	type = "add";
	advancedMorePartWin.show();
	//默认查询今天结算的工单
	var params = {};
	params.today = 1;
    params.sOutDate = getNowStartDate();
    params.eOutDate = addDate(getNowEndDate(), 1);
	moreGrid.setUrl(baseUrl+"com.hsapi.repair.repairService.query.querySettleList.biz.ext");
	moreGrid.load({params : params,token : token});
}

//提交单元格编辑数据前激发
function oncellbeginedit(e){
	var editor = e.editor;
	var record = e.record;
	var row = e.row;
	if(e.field == "serviceCode"){
		oldValue = e.value;
		oldRow = e.row;
	}
}

function addSelect(){
	var row = moreGrid.getSelected();
	if(row){
		var newRow = {
				servcieId : row.id,
				serviceCode : row.serviceCode,
				carNo : row.carNo,
				guestId : row.guestId,
				guestName : row.guestName
		};
		row = grid.getSelected();
		if(type == "add"){
			var data = grid.getData();
			if(data.length==1){
				var temp = data[0];
				if(temp.serviceCode==""){
					grid.removeRow(temp);
				}
			}
			grid.addRow(newRow);
		}else{
			grid.updateRow(row,newRow);
		}
		advancedMorePartWin.hide();
	}
}

function onClose(){
	advancedMorePartWin.hide();
	var newRow = {serviceCode: oldValue};
	grid.updateRow(oldRow, newRow);
	grid.beginEditCell(oldRow, "serviceCode");
}

function onDrawSummaryCell(e) { //汇总
	//客户端汇总计算
	if (e.field == "invoiceAmt") {
		e.cellHtml = '<div align="center" >合计：' + e.cellHtml + '</div>';
	}
	if (e.field == "rateAmt") {
		e.cellHtml = '<div align="center" >合计：' + e.cellHtml + '</div>';
	}
}

var typeF = 0;
function quickSearch(type){
    var params ={};
    var querysign = 1;
    var queryname = "本日";
    typeF = type;
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sOutDate = getNowStartDate();
            params.eOutDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sOutDate = getPrevStartDate();
            params.eOutDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sOutDate = getWeekStartDate();
            params.eOutDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sOutDate = getLastWeekStartDate();
            params.eOutDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sOutDate = getMonthStartDate();
            params.eOutDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sOutDate = getLastMonthStartDate();
            params.eOutDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sOutDate = getYearStartDate();
            params.eOutDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sOutDate = getPrevYearStartDate();
            params.eOutDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
       
        default:
            break;
    }
    
    /*beginDateEl.setValue(params.sOutDate);
    endDateEl.setValue(addDate(params.eOutDate,-1));*/
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    //车牌号
    var carNo = nui.get("carNo-search").getValue();
    var guestName = nui.get("name-search").getValue();
    params.carNo = carNo;
    params.guestName = guestName;
    moreGrid.setUrl(baseUrl+"com.hsapi.repair.repairService.query.querySettleList.biz.ext");
	moreGrid.load({params : params,token : token});
}

function doSearch(){
	quickSearch(typeF);
}
