var receiveGrid = null;
var payGrid = null;
var fserviceId = 0;
var tableNum = 0;
var rlist = [];
var typeList = {};
var mtAmtEl = null;
var guestData = null;
var amountEl = null;
var zongAmt = 0;//总金额
var showAmt = null;//结算金额是否减客户返点
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var srnum = [];
$(document).ready(function(v) {

	$("body").on("input  onvaluechanged","input[name='amount']",function(){
		onChanged();
	});

});

function setData(params){
	
	if(params.sTypeId == 1){
		$("#radio1").attr("checked", "checked");
		showAmt = "(保司保费)";
	}else if(params.sTypeId == 2){
		$("#radio2").attr("checked", "checked"); 
		showAmt = "(保司保费)";
	}else if(params.sTypeId == 3){
		$("#radio3").attr("checked", "checked"); 
		showAmt = "(保司保费-客户返点)";
	}
	guestData = params;
	zongAmt = params.moneyCost;
	var serviceId = params.data1.id||0;
	fserviceId = serviceId;
	document.getElementById('carNo').innerHTML = params.data1.carNo||"";
	document.getElementById('guest').innerHTML = params.data1.guestFullName||"";
	
	document.getElementById('totalAmt').innerHTML = "￥"+zongAmt||0;
	document.getElementById('totalAmtSpan').innerHTML = showAmt||"";
	document.getElementById('totalAmt1').innerHTML = zongAmt||0;
	document.getElementById('amount').innerHTML =  zongAmt||0;
	//document.getElementById('ycAmt').innerHTML = params.data.ycAmt||0;
	
	nui.get('compulsoryAmt').setValue("￥"+(params.gridData[0].amt||0));
	nui.get('compulsoryRate').setValue((params.gridData[0].rtnCompRate||0)+"%");
	nui.get('compulsoryRtnGuestRate').setValue((params.gridData[0].rtnGuestRate||0)+"%");
	
	nui.get('commercialAmt').setValue("￥"+(params.gridData[1].amt||0));
	nui.get('commercialRtnCompRate').setValue((params.gridData[1].rtnCompRate||0)+"%");
	nui.get('commercialRtnGuestRate').setValue((params.gridData[1].rtnGuestRate||0)+"%");
	
	nui.get('VehicleShipAmt').setValue("￥"+(params.gridData[2].amt||0));
	nui.get('VehicleShipRtnCompRate').setValue((params.gridData[2].rtnCompRate||0)+"%");
	nui.get('VehicleShipGuestRate').setValue((params.gridData[2].rtnGuestRate||0)+"%");
	
	nui.get('totalAmt').setValue("￥"+(params.t_amt||0));
	nui.get('totalRtnCompRate').setValue("￥"+(params.t_rtnCompRate||0));
	nui.get('totalRtnGuestRate').setValue("￥"+(params.t_rtnGuestRate||0));
	

	addType();
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
	if( parseFloat(count)>zongAmt){
		nui.alert("结算金额不能大于应收金额","提示");
		return;
	}
}

//转预结算
function noPay(){
	doNoPay(fserviceId,zongAmt);
}

//结算
function pay(){
	var accountTypeList =[];
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
		if(count!=zongAmt){
			nui.alert("结算金额和应结金额不一致，请重新确认！","提示");
			return;
		}
	var json = {
		accountTypeList : accountTypeList,
		allowanceAmt:0,
		cardPayAmt:0,
		serviceId:fserviceId,
		payAmt:count
	}
    nui.confirm("是否确定结算？", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
	    		nui.ajax({
	    			url : baseUrl
	    			+ "com.hsapi.repair.repairService.settlement.receiveInsuranceSettle.biz.ext" ,
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
					url : apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.PreInsuranceReceiveSettle.biz.ext" ,
					type : "post",
					data : json,
					success : function(data) {
						if(data.errCode=="S"){
							nui.unmask(document.body);
							nui.alert("转预结算成功","提示");
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