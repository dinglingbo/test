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
var srnum = [];
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
	nui.get("rechargeBalaAmt").setValue("￥"+data.rechargeBalaAmt); 
	netInAmt = data.mtAmt;
	onetInAmt  = data.mtAmt;
}
function setData(params){
	var amt = 0;
	var serviceId = params.serviceId||0;
	var data = params.data||{};
	var guestId = params.guestId||0;
	data.guestId = guestId;
	fserviceId = serviceId;
	document.getElementById('carNo').innerHTML = params.carNo;
	document.getElementById('guest').innerHTML = params.guestName;

	
	nui.get('packageSubtotal').setValue("￥"+params.data.packageSubtotal);
	nui.get('itemSubtotal').setValue("￥"+params.data.itemSubtotal);
	nui.get('partSubtotal').setValue("￥"+params.data.partSubtotal);
	nui.get('packagePrefAmt').setValue("￥"+params.data.packagePrefAmt);
	nui.get('itemPrefAmt').setValue("￥"+params.data.itemPrefAmt);
	nui.get('partPrefAmt').setValue("￥"+params.data.partPrefAmt);
	
	var json = {
			serviceId: fserviceId,
			dc: 1,
			token: token
	}
	nui.ajax({
		url : baseUrl
		+ "com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext" ,
		type : "post",
		data : json,
		async: false,
		success : function(rs) {
			var str = "";
			srnum = rs.data;
			if(srnum.length>0){
				for(var i = 0;i<rs.data.length;i++){
					if(rs.data[i].remark==null){
						rs.data[i].remark="无";
					}
					var ss = '<td width="110" height="44" align="right">收入项目</td>'+'<td>'+'<input class="nui-textbox" enabled="false" id ='+i+'stypeCode name ="amount" value='+rs.data[i].typeCode+' style="width: 100px;">'+'</td>   <td width="110" height="44" align="right">收入金额</td>'+'<td>'+'<input class="nui-textbox" enabled="false" value='+rs.data[i].amt+' id ='+i+'sAmt name ="amount"  style="width: 100px;">'+'</td> <td width="110" height="44" align="right">备注</td>'+'<td>'+'<input class="nui-textbox" enabled="false" value='+rs.data[i].remark+' id ='+i+'sremark name ="amount"  style="width: 100px;">'+'</td>';
						ss=ss+'</tr>'+'<tr>';
					str = str+ss;
				}
				str='<tr>'+str+'</tr>';
			}else{
				str='<tr><td align="center" ><spand style="color: #ff7800;">无其他收入</spand></td></tr>';
			}

			document.getElementById('paytype0').innerHTML = str;
			for(var i = 0;i<rs.data.length;i++){
				//nui.get().enable();
				document.getElementById(i+"stypeCode").disabled =true;
				document.getElementById(i+"sAmt").disabled =true;
				document.getElementById(i+"sremark").disabled =true;
			}
			amt = parseFloat(amt);
			for(var i = 0;i<srnum.length;i++){
				amt=amt+parseFloat(srnum[i].amt);
			}
			params.data.mtAmt = parseFloat(params.data.mtAmt)+amt;
			document.getElementById('totalAmt').innerHTML = "￥"+params.data.mtAmt;
			document.getElementById('totalAmt1').innerHTML = params.data.mtAmt;
			document.getElementById('amount').innerHTML = params.data.mtAmt;
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
	var json1 = {
			serviceId: fserviceId,
			dc: -1,
			token: token
	}
	nui.ajax({
		url : baseUrl
		+ "com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext" ,
		type : "post",
		data : json1,
		async: false,
		success : function(rs) {
			var str = "";
			srnum = rs.data;
			if(srnum.length>0){
				for(var i = 0;i<rs.data.length;i++){
					if(rs.data[i].remark==null){
						rs.data[i].remark="无";
					}
					var ss = '<td width="110" height="44" align="right">费用项目</td>'+'<td>'+'<input class="nui-textbox" readonly="readonly" id ='+i+'ztypeCode name ="amount" value='+rs.data[i].typeCode+' style="width: 100px;">'+'</td>   <td width="110" height="44" align="right">支出金额</td>'+'<td>'+'<input class="nui-textbox" readonly="readonly" value='+rs.data[i].amt+' id ='+i+'zAmt name ="amount"  style="width: 100px;">'+'</td> <td width="110" height="44" align="right">备注</td>'+'<td>'+'<input class="nui-textbox" enabled="false" value='+rs.data[i].remark+' id ='+i+'zremark name ="amount"  style="width: 100px;">'+'</td>';
						ss=ss+'</tr>'+'<tr>';
					str = str+ss;
				}
				str='<tr>'+str+'</tr>';
			}else{
				str='<tr><td align="center" ><spand style="color: #ff7800;">无费用支出</spand></td></tr>';
			}
			document.getElementById('paytype1').innerHTML = str;
			for(var i = 0;i<rs.data.length;i++){
				//nui.get().enable();
				document.getElementById(i+"ztypeCode").disabled =true;
				document.getElementById(i+"zAmt").disabled =true;
				document.getElementById(i+"zremark").disabled =true;
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
	/*
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
	});*/

	// var row = {};
	// receiveGrid.addRow(row);
	// payGrid.addRow(row);

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
		memAmt = (memAmt.split("￥"))[1];
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
	document.getElementById('amount').innerHTML = amount.toFixed(2);

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
	mtAmtEl.setValue(netInAmt.toFixed(2));
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

	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	doNoPay(fserviceId,PrefAmt);
}

function pay(){

	
	var deductible = nui.get("deductible").getValue()||0;
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	var payType = nui.get("payType").getValue()||0;
	var amt = $("#amount").text();



	var json = {
		allowanceAmt:PrefAmt,
		cardPayAmt:deductible,
		serviceId:fserviceId,
		payType:payType,
		payAmt:amt
	}
    nui.confirm("结算金额:"+amt+"元,确定结算吗?", "友情提示",function(action){
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

function doNoPay(serviceId,allowanceAmt){
	var json = {
			serviceId:serviceId,
			allowanceAmt:allowanceAmt,
			token:token
	};
	
    nui.confirm("确定将此单加入待结算吗？", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
				nui.ajax({
					url : apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.preReceiveSettle.biz.ext" ,
					type : "post",
					data : json,
					success : function(data) {
						if(data.errCode=="S"){
							nui.unmask(document.body);
							nui.alert("待结算成功","提示");
						}else{
							nui.unmask(document.body);
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