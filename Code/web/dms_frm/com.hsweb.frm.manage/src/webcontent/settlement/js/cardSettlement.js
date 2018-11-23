
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var netInAmt = 0;
var settlementUrl = 0;//什么界面过来的  1计次卡，2储值卡
var tableNum = 0;
var card = {};//传进逻辑流的卡
var row = {}//页面传过来的卡
var form = null;
var type = null;
var typeList = {};
var zongAmt = 0;//实时填写的结算金额
var guestData = {};
var deductible = 0;
$(document).ready(function (){
	$("body").on("input  onvaluechanged","input[name='amount']",function(){
		onChanged();
	});
});


function setData(data){
	guestData = data.xyguest||{};
	row = data.row;
	zongAmt = data.row.jsAmt;
	settlementUrl = data.settlementUrl;
	document.getElementById('carNo').innerHTML = data.xyguest.carNo||"";
	document.getElementById('guest').innerHTML = data.xyguest.guestFullName||"";
	document.getElementById('totalAmt').innerHTML = "￥"+(zongAmt||0);
	document.getElementById('totalAmt1').innerHTML = zongAmt||0;
	document.getElementById('amount').innerHTML = zongAmt||0;
	netInAmt = data.jsAmt;	
	addType();
}

function onChanged() {
	var count = scount();
	if(parseFloat(count) > netInAmt){
		nui.alert("收款大于应收金额，请重新填写","提示");
		return;
	}
/*	var amount = parseFloat(netInAmt)-parseFloat(count);
	document.getElementById('amount').innerHTML = amount;*/

}


function addF(){
	tableNum++;
	var str = '<div class="skbox2" id="div'+tableNum+'" name="'+tableNum+'"><table name="'+tableNum+'" width="98%" border="0" align="center" cellpadding="0" cellspacing="0"><tbody><tr><td width="50%" height="&quot;44&quot;"><select name="optaccount'+tableNum+'" id="optaccount'+tableNum+'" onchange="checkField(this.id)"  style="width: 94%; height: 33px; font-weight: bold; font-size: 15px; color: #578ccd;border:0;"></select></td><td><a class="depj" id="'+tableNum+'" data-balloon="删除收款方式" href="javascript:void(0);" onclick="remove(this.id)" style="margin-left: 15px;"></a></td></tr></tbody></table><table name="paytype'+tableNum+'" id="paytype'+tableNum+'" width="96%" border="0" cellpadding="0" cellspacing="0"><tbody></tbody></table></div>';
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
		 $("#paytype"+s1[1]).empty();
		 var myselect=document.getElementById("optaccount"+s1[1]);
		 var index=myselect.selectedIndex;
		 var c  =myselect.options[index].value;
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
				document.getElementById('paytype'+s1[1]).innerHTML = str;
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

var settleAuditUrl = frmUrl+ "com.hsapi.frm.frmService.rpsettle.rpAccountSettle.biz.ext";//应收应付
var payMeth = baseUrl + "/com.hsapi.repair.repairService.settlement.receiveCardTimes.biz.ext";//计次卡
var payurl=baseUrl+"com.hsapi.repair.repairService.settlement.rechargeReceive.biz.ext";//储值卡支付

function settleOK() {
	var count = scount();
	if(count!=zongAmt){
		nui.alert("付款金额和应付金额不一致，请重新确认！","提示");
		return;
	}	
	var accountTypeList =[];
	
	for(var i = 0;i<tableNum+1;i++){
		var  Sel=document.getElementById("optaccount"+i);
		if(Sel!=null){
			var index=Sel.selectedIndex ;
			var selectValue =  Sel.options[index].value;
			var seletText = Sel.options[index].text;
		}
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
	
	var url = settleAuditUrl;//调用默认逻辑工单结算逻辑流
	var json = {};//结算传参
	//判断什么界面跳转过来的，调用不同的逻辑流
	if(settlementUrl==1){
		url =payMeth;
		card ={
				guestId:guestData.guestId,
				guestName:guestData.guestFullName,
				cardId:row.id,
				cardName:row.name,
				periodValidity:row.periodValidity,
				salesDeductType:row.salesDeductType,
				remark:row.remark,
				salesDeductValue:row.salesDeductValue,
				sellAmt:row.sellAmt,
				totalAmt:row.totalAmt,
				useRemark:row.useRemark,
				carId:guestData.carId,
				carNo:guestData.carNo,
		};
		json={
				payAmt:zongAmt,
				payType:020104,
				accountTypeList:accountTypeList,
				cardTimes :card,
				token:token
		}
	}else if(settlementUrl==2){
		url =payurl;
		card={
				cardId:row.id,
				cardName:row.name,
				giveAmt	: row.giveAmt,
				guestId:guestData.guestId,
				guestName:guestData.guestFullName,	
				rechargeAmt	: row.rechargeAmt,
				totalAmt 	: row.totalAmt,
				balaAmt		: row.totalAmt,
				periodValidity : row.periodValidity,
				sellAmt :row.rechargeAmt
		};

		json={
				payAmt:zongAmt,
				payType:020104,
				accountTypeList:accountTypeList,
				stored :card,
				token:token
		}
	}
		  nui.confirm("是否确定结算？", "友情提示",function(action){
		       if(action == "ok"){
					nui.mask({
						el : document.body,
						cls : 'mini-mask-loading',
						html : '数据处理中...'
					});
					nui.ajax({
						url : url,
						type : "post",
						data : json,
						success : function(data) {
							nui.unmask(document.body);
							data = data || {};
							if (data.errCode == "S") {
								nui.alert(data.errMsg,"提示");
			
							} else {
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
	if(type==null||type==""){
		
	}else{
		typeList = type.split(",");
	}
	return count;
}
function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function selectCustomer() {
    openCustomerWindow(function (v) { 
    	guestData = v;
    	document.getElementById('carNo').innerHTML = guestData.carNo||"";
    	document.getElementById('guest').innerHTML = guestData.guestFullName||"";
    });
}

function openCustomerWindow(callback) {
    nui.open({
        url: webPath + contextPath + "/com.hsweb.RepairBusiness.Customer.flow?token="+token,
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                //调用子界面的方法，返回子界面的数据
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}