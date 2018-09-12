var grid = null;
var newRow = null;
var invoiceTypeEl = null;
var form = null;
var baseUrl = apiPath + repairApi + "/";
var advancedMorePartWin = null;
var moreGrid = null;
var oldValue = null;
var oldRow = null;
$(document).ready(function () {
	grid = nui.get("grid");
	advancedMorePartWin = nui.get("advancedMorePartWin");
	moreGrid = nui.get("moreGrid");
	form = new nui.Form("#form");
	newRow = {name : ""};
	grid.addRow(newRow , 0);
	var date = new Date();
	document.getElementById("right").value = format(date, "yyyy-MM-dd HH:ss:mm");
	grid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		if(field == "action"){
			e.cellHtml = '<a class="optbtn" href="javascript:addRow()">新增</a>&nbsp;&nbsp;&nbsp;<a class="optbtn" href="javascript:remove()">删除</a>';
		}
		if(field == "rate"){
			if(value){
				e.cellHtml = value + "%";
			}
		}
	});
	
	/*invoiceTypeEl = nui.get("invoiceType");
	initServiceType("invoiceType",function(data) {
        servieTypeList = nui.get("invoiceType").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });*/
	
	/*advancedMorePartWin.on("load",function(e){
		var data = advancedMorePartWin.getData();
		if(data.length == 0){
			showMsg("该源单号暂没数据","W");
		}else if(data.length == 1){
			var row = advancedMorePartWin.getRow(0);
			advancedMorePartWin.hide();
			var newRow = {};
		}
	});*/
	grid.on("cellendedit",function(e){
		var field = e.field;
		if(field == "invoiceAmt"){
			document.getElementById("rateMoney").innerHTML = 0;
			document.getElementById("money").innerHTML = 0;
			var data = grid.getData();
			for(var i = 0 , l = data.length ; i < l ; i ++){
				var row = grid.getRow(i);
				if(data[i].invoiceAmt && data[i].rate){
					var rateAmt = data[i].rate * data[i].invoiceAmt / 100;
					var newRow = {rateAmt : rateAmt};
					grid.updateRow(row,newRow);
					document.getElementById("rateMoney").innerHTML = parseFloat(document.getElementById("rateMoney").innerHTML)+parseFloat(rateAmt);
					document.getElementById("money").innerHTML = parseFloat(document.getElementById("money").innerHTML)+parseFloat(row.invoiceAmt);
				}
			}
		}
	});
});

function addRow(){//新增
	var row = grid.getSelected();
	var index = grid.indexOf(row);
	newRow = {
			name : "",
			rate:document.getElementById("rate").value
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
	nui.ajax({
        url: baseUrl+"com.hsapi.repair.repairService.insurance.saveInvoice.biz.ext",
        type: "post",
        cache: false,
        data: {
        	 i: grid.getChanges("added"),
             d: grid.getChanges("removed"),
             u: grid.getChanges("modified"),
             data : data,
             main : nui.get("mainId").value,
             token : token
        },
        success: function(text) {
        	nui.get("mainId").setValue(text.mainId);
        	grid.setUrl(baseUrl+"com.hsapi.repair.repairService.query.searchTicketDetail.biz.ext");
        	grid.load({mainId : text.mainId,token : token});
        	nui.get("state").setValue("1");
        }
    });
}
function checkValue(){//实时监听税率输出的值
	if (document.getElementById("rate").value < 0 || document.getElementById("rate").value > 100){
		document.getElementById("rate").value = "";
		showMsg("请输入0-100以内的数字","W");
	}else{
		if(/\D/.test(document.getElementById("rate").value)){
			showMsg('只能输入数字',"W");
			document.getElementById("rate").value = "";;
		}
	}
	var data = grid.getData();
	document.getElementById("rateMoney").innerHTML = 0;
	for(var i = 0, l = data.length ; i < l ; i++){
		var row = grid.getRow(i);
		var newRow = {rate : document.getElementById("rate").value};
		grid.updateRow(row,newRow);
		if(document.getElementById("rate").value && row.invoiceAmt){
			var rateAmt = parseFloat(document.getElementById("rate").value) * row.invoiceAmt / 100;
			var newRow = {rateAmt : rateAmt};
			grid.updateRow(row,newRow);
			document.getElementById("rateMoney").innerHTML = parseFloat(document.getElementById("rateMoney").innerHTML)+parseFloat(rateAmt);
		}
	}
}

function onCellEditEnter(e) {
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
				serviceCode : row.serviceCode,
				carNo : row.carNo,
				guestId : row.guestId,
				guestName : row.guestFullName
		};
		row = grid.getSelected();
		grid.updateRow(row,newRow);
		advancedMorePartWin.hide();
	}else{
		showMsg("请选择一条数据","W");
	}
}

function onClose(){
	advancedMorePartWin.hide();
	var newRow = {serviceCode: oldValue};
	grid.updateRow(oldRow, newRow);
	grid.beginEditCell(oldRow, "serviceCode");
}