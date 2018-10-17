
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var netInAmt = 0;
var tableNum = 0;
var form = null;
var type = null;
var typeList = {};
var guestData = null;
var deductible = 0;
$(document).ready(function (){

	$("body").on("input  onvaluechanged","input[name='amount']",function(){
		onChanged();

	});

});


function setData(data){
	guestData = data;
	var rechargeBalaAmt = 0;
	document.getElementById('carNo').innerHTML = data[0].carNo;
	document.getElementById('guest').innerHTML = data[0].guestName;
	document.getElementById('totalAmt').innerHTML = "￥"+data[0].nowAmt;
	document.getElementById('totalAmt1').innerHTML = data[0].nowAmt;
	document.getElementById('amount').innerHTML = data[0].nowAmt;
	netInAmt = data[0].nowAmt;
	var json = {
			guestId:data[0].guestId,
			token : token
	}
	
	nui.ajax({
		url : apiPath + repairApi + "/com.hsapi.repair.baseData.query.queryMemberByGuestId.biz.ext" ,
		type : "post",
		data : json,
		success : function(data) {
			if(data.member.length==0){
				rechargeBalaAmt=0;
			}else{	
				rechargeBalaAmt = data.member[0].rechargeBalaAmt;
			}
			nui.get("rechargeBalaAmt").setValue("￥"+rechargeBalaAmt); 
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
	addType();
}

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
	if(parseFloat(deductible) + parseFloat(PrefAmt)+ parseFloat(count) > netInAmt){
		nui.alert("收款大于应收金额，请重新填写","提示");
		nui.get("deductible").setValue(0);
		deductible=0;
		nui.get("PrefAmt").setValue(0);
		return;
	}
	
	var amount = parseFloat(netInAmt) - parseFloat(deductible) - parseFloat(PrefAmt)-parseFloat(count);
	document.getElementById('amount').innerHTML = amount;

}


function addF(){
	tableNum++;
	var str = '<div class="skbox2" id="div'+tableNum+'" name="'+tableNum+'"><table name="'+tableNum+'" width="98%" border="0" align="center" cellpadding="0" cellspacing="0"><tbody><tr><td width="50%" height="&quot;44&quot;"><select name="optaccount'+tableNum+'" id="optaccount'+tableNum+'" onchange="checkField(this.id)"  style="width: 94%; height: 33px; font-weight: bold; font-size: 15px; color: #578ccd;"></select></td><td><a class="depj" id="'+tableNum+'" data-balloon="删除收款方式" href="javascript:void(0);" onclick="remove(this.id)" style="margin-left: 15px;"></a></td></tr></tbody></table><table name="paytype'+tableNum+'" id="paytype'+tableNum+'" width="96%" border="0" cellpadding="0" cellspacing="0"><tbody></tbody></table></div>';
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
				// nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
}

function checkField(id){
		 var str = "";
		 var s1=id.split("optaccount");
		 $("#paytype"+s1[1]).empty();
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
					//var ss = '<td width="110" height="44" align="right">'+data.list[i].customName+'</td>'+'<td>'+'<input class="nui-textbox" id ='+s1[1]+data.list[i].customId+' name ='+s1[1]+data.list[i].customId+' onvaluechanged="onChanged" style="width: 100px;">'+'</td>';
					if(((i+1)%3)==0){
						ss=ss+'</tr>'+'<tr>';
					}
					str = str+ss;
				}
				str='<tr>'+str+'</tr>';
				document.getElementById('paytype'+s1[1]).innerHTML = str;
			},
			error : function(jqXHR, textStatus, errorThrown) {
				// nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
}

function remove(id){
	$("#div"+id).empty();
}

var settleAuditUrl = frmUrl
+ "com.hsapi.frm.frmService.rpsettle.rpAccountSettle.biz.ext";
function settleOK() {
	var accountTypeList =[];
	var accountDetail = {};
	for(var i = 0;i<tableNum+1;i++){
		var  Sel=document.getElementById("optaccount"+i);
		var index=Sel.selectedIndex ;
		var selectValue =  Sel.options[index].value;
		var seletText = Sel.options[index].text;
		for(var j =1;j<typeList.length;j++){
			var dtype = typeList[j].split(".");
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


	var account = {};
	var accountDetailList = [];


		var rRPAmt = 0; // 应收金额
		var rTrueAmt = 0; // 实收应收
		var rVoidAmt = 0; // 优惠金额
		var rNoCharOffAmt = 0; // 未结金额
		var pRPAmt = 0; // 应付金额
		var pTrueAmt = 0; // 实付金额
		var pVoidAmt = 0; // 免付金额
		var pNoCharOffAmt = 0; // 未结金额
		var rpAmt = 0; // 合计金额
		var pAmount = 0;
		var rAmount = 0;
		var s1 = 0; // 合计收
		var s2 = 0; // 合计付


		account.guestId = guestData[0].guestId;
		account.guestName = guestData[0].guestName;
		account.itemQty = 1;
		account.remark = nui.get('txtreceiptcomment').getValue();


			accountDetail.billRpId = guestData[0].id;
			accountDetail.billMainId = guestData[0].billMainId;
			accountDetail.billServiceId = guestData[0].billServiceId;
			accountDetail.billTypeId = guestData[0].billTypeId;

				var noCharOffAmt = guestData[0].noCharOffAmt || 0; // 已结金额
				var rpAmt = guestData[0].rpAmt || 0; // 应结金额
				var nowAmt = guestData[0].nowAmt || 0;
				var nowVoidAmt = guestData[0].nowVoidAmt || 0;
				accountDetail.rpDc = -1;
				nowAmt = parseFloat(nowAmt);
				nowVoidAmt = parseFloat(nowVoidAmt);
				pRPAmt += rpAmt;
				pTrueAmt += nowAmt;
				pVoidAmt += nowVoidAmt;
				pNoCharOffAmt += noCharOffAmt;
				s1 += (nowAmt + nowVoidAmt);
				accountDetail.charOffAmt = nowAmt;
				accountDetail.voidAmt = nowVoidAmt;
			

			accountDetailList.push(accountDetail);



			account.rpDc = 1;
			account.settleType = "应收";
			account.voidAmt = pVoidAmt;
			account.trueCharOffAmt = pTrueAmt;
			account.charOffAmt = pVoidAmt + pTrueAmt;
		
			var list={balaTypeCode:"020107",charOffAmt:deductible,settAccountId:"274"};
			accountTypeList.push(list);


		nui.mask({
			el : document.body,
			cls : 'mini-mask-loading',
			html : '数据处理中...'
		});

		nui.ajax({
			url : settleAuditUrl,
			type : "post",
			data : JSON.stringify({
				account : account,
				accountDetailList : accountDetailList,
				accountTypeList : accountTypeList,
				token : token
			}),
			success : function(data) {
				nui.unmask(document.body);
				data = data || {};
				if (data.errCode == "S") {
					CloseWindow("saveSuccess");

				} else {
					showMsg(data.errMsg || "结算失败!", "w");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				// nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});


}

function  scount(){
	type = null;
	var count = 0;
	for(var j =0;j<tableNum+1;j++){
		for(var i =0;i<10;i++){
			if(document.getElementById(j+"02010"+i)==null||document.getElementById(j+"02010"+i).value==""){
				
			}else{
				var dk = parseFloat(document.getElementById(j+"02010"+i).value);
				count= count+dk;
				type=type+","+j+"02010"+i+"."+dk;
			}
		}
	}
	typeList = type.split(",");
	return count;
}
function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}