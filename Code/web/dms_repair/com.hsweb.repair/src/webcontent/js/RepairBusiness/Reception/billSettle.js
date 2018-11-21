var packageGrid = null;
var itemGrid = null;
var partGrid = null;
var sellForm = null;
var receiveGrid = null;
var payGrid = null;
var fserviceId = 0;
var deductible = 0;
var tableNum = 0;
var plist = [];
var rlist = [];
var typeList = {};
var mtAmtEl = null;
var guestData = null;
var amountEl = null;
var onetInAmt = 0;
var netInAmt = 0;
var zongAmt = 0;//总金额
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var expenseUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext';
var srnum = [];
$(document).ready(function(v) {

	$("body").on("input  onvaluechanged","input[name='amount']",function(){
		onChanged();
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
	
	onetInAmt  = data.mtAmt;
}
function setData(params){
	guestData = params;
	zongAmt = params.data.mtAmt;
	var rechargeBalaAmt = 0;
	var jsonq = {
			guestId:params.guestId,
			token : token
		};
	var param = {isMain:0};
	svrInComeExpenses(param,function(data) {
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
					for(var j =0;j<rlist.length;j++){
						if(rs.data[i].typeCode==rlist[j].code){
							rs.data[i].typeCode=rlist[j].name;
						}
					}
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
			var amount = 0;
			if(params.data.ycAmt==null||params.data.ycAmt==""){
				amount = params.data.mtAmt;
			}else{
				params.data.mtAmt = params.data.mtAmt-params.data.ycAmt;
				params.data.mtAmt = params.data.mtAmt.toFixed(2)
			}
			netInAmt = amount;
			params.data.mtAmt = parseFloat(params.data.mtAmt)+amt;
			document.getElementById('totalAmt').innerHTML = "￥"+params.data.mtAmt;
			document.getElementById('totalAmt1').innerHTML = params.data.mtAmt;
			document.getElementById('amount').innerHTML =  params.data.mtAmt;
			document.getElementById('ycAmt').innerHTML = params.data.ycAmt||0;
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
					for(var j =0;j<plist.length;j++){
						if(rs.data[i].typeCode==plist[j].code){
							rs.data[i].typeCode=plist[j].name;
						}
					}
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
	

		
		nui.ajax({
			url : apiPath + repairApi + "/com.hsapi.repair.baseData.query.queryMemberByGuestId.biz.ext" ,
			type : "post",
			data : jsonq,
			success : function(data) {
				if(data.member.length==0){
					rechargeBalaAmt=0;
				}else{	
					rechargeBalaAmt = data.member[0].rechargeBalaAmt;
				}
				nui.get("rechargeBalaAmt").setValue("￥"+rechargeBalaAmt); 
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			}
		});
		addType();

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
	var count = scount();
	 deductible = nui.get("deductible").getValue()||0;
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	var memAmt = nui.get("rechargeBalaAmt").getValue()||0;
		memAmt = (memAmt.split("￥"))[1];
	if(deductible>memAmt){
		nui.alert("储值抵扣不能大于储值余额","提示");
		nui.get("deductible").setValue(0);
		deductible=0;
		nui.get("PrefAmt").setValue(0);

		return;
	}
	if(parseFloat(deductible) + parseFloat(PrefAmt)+ parseFloat(count)  > netInAmt){
		nui.alert("储值抵扣加上优惠金额不能大于应收金额","提示");
		nui.get("deductible").setValue(0);
		deductible=0;
		nui.get("PrefAmt").setValue(0);

		return;
	}
	
	var amount = parseFloat(netInAmt) - parseFloat(deductible) - parseFloat(PrefAmt)-parseFloat(count);
	amount = amount.toFixed(2);
	//document.getElementById('amount').innerHTML = amount.toFixed(2);

}
/*function setNetInAmt(){
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
}*/

//转预结算
function noPay(){
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	doNoPay(fserviceId,PrefAmt);
}

//结算
function pay(){
	var accountTypeList =[];
	var accountDetail = {};
	for(var i = 0;i<tableNum+1;i++){
		var  Sel=document.getElementById("optaccount"+i);
		if(Sel!=null){
			var index=Sel.selectedIndex ;
			var selectValue =  Sel.options[index].value;
			var seletText = Sel.options[index].text;
		}
		for(var j =1;j<typeList.length;j++){
			var dtype = typeList[j].split("p");
			var typeF = dtype[0].substring(0,1);
			if(typeF==i){
				var deductible1 = dtype[1];
				var TypeCode = dtype[0].substring(1,dtype[0].length);
				var list={balaTypeCode:TypeCode,charOffAmt:deductible1,settAccountId:selectValue,settAccountName:seletText};
				accountTypeList.push(list);
			}
		}
	}
		var count = scount();
/*		if(count==0){
			nui.alert("请选择结算账户,并填写结算金额","提示");
			return;
		}*/
		if(count!=zongAmt){
			nui.alert("结算金额和应结金额不一致，请重新确认！","提示");
			return;
		}
	var deductible = nui.get("deductible").getValue()||0;
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	var payType = nui.get("payType").getValue()||0;
	var amt = $("#amount").text();
	var json = {
		accountTypeList : accountTypeList,
		allowanceAmt:PrefAmt,
		cardPayAmt:deductible,
		serviceId:fserviceId,
		payType:payType,
		payAmt:amt
	}
    nui.confirm("确定结算吗?", "友情提示",function(action){
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

var inComeExpensesUrl = frmUrl + "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
function svrInComeExpenses(params, callback) {
    //var params = {itemTypeId : 1, isMain: 0};
    nui.ajax({
        url : inComeExpensesUrl,
        data : {
            params: params,
            token: token
        },
        type : "post",
        async: false,
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function addF(){
	tableNum++;
	var str = '<div class="skbox2" id="div'+tableNum+'" name="'+tableNum+'"><table name="'+tableNum+'" width="98%" border="0" align="center" cellpadding="0" cellspacing="0"><tbody><tr><td width="50%" height="&quot;44&quot;"><select name="optaccount'+tableNum+'" id="optaccount'+tableNum+'" onchange="checkField(this.id)"  style="width: 94%; height: 33px; font-weight: bold; font-size: 15px; color: #578ccd;border:0;"></select></td><td><a class="depj" id="'+tableNum+'" data-balloon="删除收款方式" href="javascript:void(0);" onclick="remove(this.id)" style="margin-left: 15px;"></a></td></tr></tbody></table><table name="ppaytype'+tableNum+'" id="ppaytype'+tableNum+'" width="96%" border="0" cellpadding="0" cellspacing="0"><tbody></tbody></table></div>';
	var dataform = document.getElementById("dataform");
	//dataform.innerHTML = dataform.innerHTML+str;
	 $("#csdiv").before(str);
	addType();
}

function addType(){
	nui.ajax({
		url : apiPath + frmApi + "/com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext?token="+ token,
		type : "post",
		data : "",
		success : function(data) {
			for(var i = tableNum;i<=tableNum;i++){
				$("#optaccount"+i).empty();
				var optaccount = document.getElementById('optaccount'+i);
				$("<option value=''>—请选择结算账户—</option>").appendTo("#optaccount"+i);
				for (var j = 0; j < data.settleAccount.length; j++) {
					$("<option  value="+data.settleAccount[j].id+">"+data.settleAccount[j].name+"</option>").appendTo("#optaccount"+i);
				}
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

function checkField(id){
	 var str = "";
	 var s1=id.split("optaccount");
	 $("#ppaytype"+s1[1]).empty();
	 var myselect=document.getElementById("optaccount"+s1[1]);
	 var index=myselect.selectedIndex;
	 var c  =myselect.options[index].value
   var json = {
   		accountId:c,
   		token:token
   }
	nui.ajax({
		url : apiPath + frmApi + "/com.hsapi.frm.setting.queryAccountSettleType.biz.ext",
		type : "post",
		data : json,
		success : function(data) {
			for(var i = 0;i<data.list.length;i++){
				var ss = '<td width="110" height="44" align="right">'+data.list[i].customName+'</td>'+'<td>'+'<input class="nui-textbox" id ='+s1[1]+data.list[i].customId+' name ="amount" onvaluechanged="onChanged" style="width: 100px;">'+'</td>';
				if(((i+1)%3)==0){
					ss=ss+'</tr>'+'<tr>';
				}
				str = str+ss;
			}
			str='<tr>'+str+'</tr>';
			document.getElementById('ppaytype'+s1[1]).innerHTML = str;
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	 onChanged();
}

function remove(id){
	$("#div"+id).empty();
	onChanged();
}


//计算输入金额的结算金额
function  scount(){
	type = null;
	var count = 0;
	for(var j =0;j<tableNum+1;j++){
		for(var i =0;i<10;i++){
			if(document.getElementById(j+"02010"+i)==null||document.getElementById(j+"02010"+i).value==""){
				
			}else{
				var dk = parseFloat(document.getElementById(j+"02010"+i).value);
				count= count+dk;
				type=type+","+j+"02010"+i+"p"+dk;
			}
		}
	}
	if(type==null||type==""){
		
	}else{
		typeList = type.split(",");
	}
	return count;
}

function checkField(id){
	 var str = "";
	 var s1=id.split("optaccount");
	 $("#ppaytype"+s1[1]).empty();
	 var myselect=document.getElementById("optaccount"+s1[1]);
	 var index=myselect.selectedIndex;
	 var c  =myselect.options[index].value
   var json = {
   		accountId:c,
   		token:token
   }
	nui.ajax({
		url : apiPath + frmApi + "/com.hsapi.frm.setting.queryAccountSettleType.biz.ext",
		type : "post",
		data : json,
		success : function(data) {
			for(var i = 0;i<data.list.length;i++){
				var ss = '<td width="110" height="44" align="right">'+data.list[i].customName+'</td>'+'<td>'+'<input class="nui-textbox" id ='+s1[1]+data.list[i].customId+' name ="amount" onvaluechanged="onChanged" style="width: 100px;">'+'</td>';
				if(((i+1)%3)==0){
					ss=ss+'</tr>'+'<tr>';
				}
				str = str+ss;
			}
			str='<tr>'+str+'</tr>';
			document.getElementById('ppaytype'+s1[1]).innerHTML = str;
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	 onChanged();
}