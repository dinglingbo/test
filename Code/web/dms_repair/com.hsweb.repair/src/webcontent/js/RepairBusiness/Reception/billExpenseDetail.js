var packageGrid = null;
var itemGrid = null;
var partGrid = null;
var sellForm = null;
var receiveGrid = null;
var payGrid = null;
var fserviceId = 0;
var plist = [];
var rlist = [];
var mtAmtEl = null;
var amountEl = null;
var onetInAmt = 0;
var netInAmt = 0;
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var expenseUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext';
$(document).ready(function(v) {
	receiveGrid = nui.get("receiveGrid");
	payGrid = nui.get("payGrid");

	receiveGrid.setUrl(expenseUrl);
	payGrid.setUrl(expenseUrl);

	var params = {isMain:0};
	svrInComeExpenses(params,function(data) {
		var list = data.list||{};
		for(var i = 0; i<list.length; i++){
			var obj = list[i];
			if(obj.itemTypeId==1){
				rlist.push(obj);
			}else if(obj.itemTypeId==-1){
				plist.push(obj);
			}
		}
    });

	receiveGrid.on("drawcell",function(e)
    {
		var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        if(e.field == "optBtn")
        {
			var s = '<a class="optbtn" href="javascript:addReceiveRow(\'' + uid + '\')">新增</a>'
				  + ' <a class="optbtn" href="javascript:deleteReceiveRow(\'' + uid + '\')">删除</a>';
			
			e.cellHtml = s;
        }
	});
	payGrid.on("drawcell",function(e)
    {
		var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        if(e.field == "optBtn")
        {
			var s = '<a class="optbtn" href="javascript:addPayRow(\'' + uid + '\')">新增</a>'
				  + ' <a class="optbtn" href="javascript:deletePayRow(\'' + uid + '\')">删除</a>';
			
			e.cellHtml = s;
        }
	});
	
	receiveGrid.on("cellcommitedit",function(e){
		var editor = e.editor;
		var record = e.record;
		
		editor.validate();
		if (editor.isValid() == false) {
			showMsg("请输入数字!","W");
			e.cancel = true;
		}else{
			var value = e.value;
			if(value<0){
				showMsg("金额不能小于0!","W");
				e.cancel = true;
			}

			if (e.field == "amt") {
				var amt = e.value;
				var newRow = {
					amt : amt
				};
				receiveGrid.updateRow(e.row, newRow);
			}
		}
	});

	payGrid.on("cellcommitedit",function(e){
		var editor = e.editor;
		var record = e.record;
		
		editor.validate();
		if (editor.isValid() == false) {
			showMsg("请输入数字!","W");
			e.cancel = true;
		}else{
			var value = e.value;
			if(value<0){
				showMsg("金额不能小于0!","W");
				e.cancel = true;
			}
		}
	});
	
	nui.get("onOk").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
});
function onbillRTypeChange(e){
    var se = e.selected;
    var billTypeCode = se.code;
    var row = receiveGrid.getSelected();
    var newRow = {typeCode: billTypeCode};
    receiveGrid.updateRow(row, newRow);

}
function onbillPTypeChange(e){
    var se = e.selected;
    var billTypeCode = se.code;
    var row = payGrid.getSelected();
    var newRow = {typeCode: billTypeCode};
    payGrid.updateRow(row, newRow);

}
function setData(params){
	var serviceId = params.serviceId||0;
	fserviceId = serviceId;
	
	receiveGrid.load({
		serviceId: fserviceId,
		dc: 1,
		token: token
	},function(rs){
		var result = rs.result||{};
		var errCode = result.errCode||"";
		if(errCode=='S'){
			var data = result.data||[];
			if(data && data.length>0){
			}else{
				var row = {};
				receiveGrid.addRow(row);
			}
		}
	});

	payGrid.load({
		serviceId: fserviceId,
		dc: -1,
		token: token
	},function(rs){
		var result = rs.result||{};
		var errCode = result.errCode||"";
		if(errCode=='S'){
			var data = result.data||[];
			if(data && data.length>0){
			}else{
				var row = {};
				payGrid.addRow(row);
			}
		}
	});

	// var row = {};
	// receiveGrid.addRow(row);
	// payGrid.addRow(row);

}
function addReceiveRow(row_uid){
	var row = {};
	receiveGrid.addRow(row);
}
function deleteReceiveRow(row_uid){
    var data = receiveGrid.getData();
    var row = receiveGrid.getRowByUID(row_uid);
    var id = row.id;
    if(data && data.length==1){
		row = data[0];
		receiveGrid.removeRow(row);
		
		var newRow = {};
		receiveGrid.addRow(newRow);
    }else{
		receiveGrid.removeRow(row);
	}
}
function addPayRow(row_uid){
	var row = {};
	payGrid.addRow(row);
}
function deletePayRow(row_uid){
    var data = payGrid.getData();
    var row = payGrid.getRowByUID(row_uid);
    var id = row.id;
    if(data && data.length==1){
		row = data[0];
		payGrid.removeRow(row);

		var newRow = {};
		payGrid.addRow(newRow);
    }else{
		payGrid.removeRow(row);
	}
}
var resultData = {};
//关闭窗口
function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}
function adjustData(data){
	var rlist = [];
	for(var i=0; i<data.length; i++){
		var obj = data[i];
		if(obj.typeId && obj.amt){
			rlist.push(obj);
		}
	}

	return rlist;
}
function onOk(){
	var rs = checkGrid();
	if(rs.rmsg || rs.pmsg){
		if(rs.rmsg){
			showMsg(rs.rmsg,"W");
			return;
		}
		if(rs.pmsg){
			showMsg(rs.pmsg,"W");
			return;
		}
	}
	
	var receiveData = receiveGrid.getData();
	var payData = payGrid.getData();

	receiveData = adjustData(receiveData);
	payData = adjustData(payData);

	var json = {
		serviceId:fserviceId,
		receiveData:receiveData,
		payData:payData
	}

	nui.mask({
        el : document.body,
	    cls : 'mini-mask-loading',
	    html : '保存中...'
    });
	nui.ajax({
		url : baseUrl + "com.hsapi.repair.repairService.settlement.saveExpense.biz.ext" ,
		type : "post",
		data : json,
        cache : false,
        contentType : 'text/json',
		success : function(data) {
			nui.unmask(document.body);
			if(data.errCode=="S"){
				showMsg("保存成功","S");
			}else{
				nui.alert(data.errMsg,"提示");
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});	
}
function checkGrid(){
	var rrows = receiveGrid.findRows(function(row){
		var amt = row.amt||0;
		var typeId = row.typeId;
		if(amt > 0 && typeId == null){
			return true;
		}
	});

	var rs = {};
	rs.rmsg = "";
	rs.pmsg = "";
	if(rrows && rrows.length>0){
		rs.rmsg = "请选择收入项目!";
		return rs;
	}
	
	var prows = payGrid.findRows(function(row){
		var amt = row.amt||0;
		var typeId = row.typeId;
		if(amt > 0 && typeId == null){
			return true;
		}
	});

	if(prows && prows.length>0){
		rs.pmsg = "请选择费用科目!";
		return rs;
	}

	return rs;
}