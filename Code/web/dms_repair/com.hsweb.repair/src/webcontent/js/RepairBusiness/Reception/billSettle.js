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
	sellForm = new nui.Form("#sellForm");
	receiveGrid = nui.get("receiveGrid");
	payGrid = nui.get("payGrid");
	mtAmtEl = nui.get("mtAmt");
	amountEl = nui.get("amount");

	receiveGrid.setUrl(expenseUrl);
	payGrid.setUrl(expenseUrl);

	//var rparams = {itemTypeId : 1, isMain: 0};
	//var pparams = {itemTypeId : -1, isMain: 0};
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
	//svrInComeExpenses(pparams,function(data) {
    //    plist = data.list;
    //});

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
				setNetInAmt();
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
function getData(data){
	// 跨页面传递的数据对象，克隆后才可以安全使用
	data = data||{};
	data.amount = data.mtAmt;
	data.payType = "020101";
	var json = {
		guestId:data.guestId,
		token : token
	}
	
	nui.ajax({
		url : baseUrl
		+ "com.hsapi.repair.baseData.query.queryMemberByGuestId.biz.ext" ,
		type : "post",
		data : json,
		async: false,
		success : function(rs) {
			if(rs.member.length==0){
				data.rechargeBalaAmt=0;
			}else{
				data.rechargeBalaAmt = rs.member[0].rechargeBalaAmt;
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

	sellForm.setData(data);
	mtAmtEl.setValue(data.mtAmt||0);
	amountEl.setValue(data.mtAmt||0);
	netInAmt = data.mtAmt;
	onetInAmt  = data.mtAmt;
}
function setData(params){
	var serviceId = params.serviceId||0;
	var data = params.data||{};
	var guestId = params.guestId||0;
	data.guestId = guestId;
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

	getData(data);
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
function onChanged() {
	var deductible = nui.get("deductible").getValue()||0;
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	var memAmt = nui.get("rechargeBalaAmt").getValue()||0;

	if(deductible>memAmt){
		nui.alert("储值抵扣不能大于储值余额","提示");
		nui.get("deductible").setValue(0);
		nui.get("PrefAmt").setValue(0);
		return;
	}
	if(parseFloat(deductible) + parseFloat(PrefAmt) > netInAmt){
		nui.alert("储值抵扣加上优惠金额不能大于应收金额","提示");
		nui.get("deductible").setValue(0);
		nui.get("PrefAmt").setValue(0);
		return;
	}
	
	var amount = parseFloat(netInAmt) - parseFloat(deductible) - parseFloat(PrefAmt);
	nui.get("amount").setValue(amount.toFixed(2));

}
function setNetInAmt(){
	var rAmt = 0;
	receiveGrid.findRows(function(row){
		if(row){
			var amt = row.amt||0;
			rAmt += parseFloat(amt);
		}
	});

	netInAmt = parseFloat(onetInAmt) + parseFloat(rAmt);
	var deductible = nui.get("deductible").getValue()||0;
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	var amount = parseFloat(netInAmt) - parseFloat(deductible) - parseFloat(PrefAmt);
	if(amount<0){
		nui.get("deductible").setValue(0);
		nui.get("PrefAmt").setValue(0);
		amount = netInAmt;
	}
	mtAmtEl.setValue(netInAmt);
	amountEl.setValue(amount.toFixed(2));
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
function noPay(){
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

	var data = sellForm.getData();
	doNoPay(fserviceId,data.PrefAmt,receiveData,payData);
}

function pay(){
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
	
	var data = sellForm.getData();
	var json = {
			allowanceAmt:data.PrefAmt,
			cardPayAmt:data.deductible,
			serviceId:fserviceId,
			payType:data.payType,
			payAmt:data.amount
	}
    nui.confirm("结算金额:"+data.amount+"元,确定结算吗?", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
	    		nui.ajax({
	    			url : baseUrl
	    			+ "com.hsapi.repair.repairService.settlement.receiveSettle.biz.ext" ,
	    			type : "post",
	    			data : json,
			        cache : false,
			        contentType : 'text/json',
	    			success : function(data) {
	    				nui.unmask(document.body);
	    				if(data.errCode=="S"){
	    					nui.alert(data.errMsg,"提示");
	    				}else{
	    					nui.alert(data.errMsg,"提示");
	    				}

	    			},
	    			error : function(jqXHR, textStatus, errorThrown) {
	    				// nui.alert(jqXHR.responseText);
	    				console.log(jqXHR.responseText);
	    			}
	    		});	
	     }else {
				return;
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