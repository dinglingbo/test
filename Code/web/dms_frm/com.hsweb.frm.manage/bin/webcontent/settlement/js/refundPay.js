
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var netInAmt = 0;
var tableNum = 0;
var form = null;
var type = null;
var typeCard = 0;//1计次，2储值
var typeList = {};
var zongAmt = 0;//实时填写的结算金额
var guestData = null;
var deductible = 0;
var printGuest = {}//打印用
$(document).ready(function (){
	$("body").on("blur","input[name='amount']",function(){
		onChanged();
	});
});


function setData(data){
	printGuest = data.printGuest;
	guestData = data.card;
	zongAmt = data.payAmt;
	typeCard = data.typeCard;

	/*document.getElementById('mobile').innerHTML = guestData.mobile||"";*/
	document.getElementById('guestName').innerHTML = guestData.guestName;
	document.getElementById('totalAmt').innerHTML = "￥"+zongAmt;
	document.getElementById('totalAmt1').innerHTML = zongAmt;
	document.getElementById('amount').innerHTML = zongAmt;
	netInAmt = parseFloat(zongAmt);

	
	addType();
}

function onChanged() {
	var count = scount();
	if(parseFloat(count) > netInAmt){
		showMsg("收款大于应收金额，请重新填写","W");
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

var flag=1;
var checkF = 0;
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
						if(data.settleAccount[j].isDefault==1 && flag==1){
							$("<option selected = 'selected' value="+data.settleAccount[j].id+">"+data.settleAccount[j].name+"</option>").appendTo("#optaccount"+i);
							checkF = 1;
							flag = 0;
						}else{
							$("<option  value="+data.settleAccount[j].id+">"+data.settleAccount[j].name+"</option>").appendTo("#optaccount"+i);
						}					}
				}
				if(checkF){
					checkField("optaccount0");
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
		// $("#paytype"+s1[1]).empty();
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
				document.getElementById('paytype'+s1[1]).innerHTML = str;
				if(checkF){
					//获取待收金额
					var amt = document.getElementById('amount').innerText;
					var byId = s1[1]+data.list[0].customId;
					document.getElementById(byId).value = amt;
					checkF = 0;
				}
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

var settleAuditUrl = frmUrl+ "com.hsapi.frm.frmService.rpsettle.rpAccountSettle.biz.ext";
function settleOK() {
	var accountTypeList =[];
	var accountDetail = {};
	var count = scount();
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


		
		if(count!=zongAmt){
			showMsg("付款金额和应付金额不一致，请重新确认！","W");
			return;
		}
		var json={};
			if(typeCard==1){
				 json = {
						accountTypeList : accountTypeList,
						serviceId:guestData.id,
						remark:nui.get("txtreceiptcomment").getValue(),
						payAmt:zongAmt,
						type:1
					};
			}else{
				 json = {
						accountTypeList : accountTypeList,
						serviceId:guestData.id,
						remark:nui.get("txtreceiptcomment").getValue(),
						payAmt:zongAmt,
						type:2
					};
			}

		    nui.confirm("是否确定结算？", "友情提示",function(action){
			       if(action == "ok"){
					    nui.mask({
					        el : document.body,
						    cls : 'mini-mask-loading',
						    html : '处理中...'
					    });
			    		nui.ajax({
			    			url : baseUrl+ "com.hsapi.repair.repairService.settlement.refundSettle.biz.ext",
			    			type : "post",
			    			data : json,
					        cache : false,
					        contentType : 'text/json',
			    			success : function(data) {
			    				nui.unmask(document.body);
			    				if(data.errCode=="S"){  					
			    					CloseWindow("saveSuccess");
			    					guestData.payAmt = zongAmt;
			    					print();
			    				}else{
			    					showMsg(data.errMsg,"W");
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
function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}


function noPay(){
		var json = {
				serviceId:guestData[0].serviceId,
				remark:nui.get("txtreceiptcomment").getValue(),
			};
	    nui.confirm("是否转入预结算？", "友情提示",function(action){
		       if(action == "ok"){
				    nui.mask({
				        el : document.body,
					    cls : 'mini-mask-loading',
					    html : '处理中...'
				    });
		    		nui.ajax({
		    			url : apiPath + repairApi + '/com.hsapi.repair.repairService.settlement.preReturnSettle.biz.ext',
		    			type : "post",
		    			data : json,
				        cache : false,
				        contentType : 'text/json',
		    			success : function(data) {
		    				nui.unmask(document.body);
		    				if(data.errCode=="S"){  					
		    					CloseWindow("ok");
		    				}else{
		    					showMsg(data.errMsg,"W");
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

//打印函数
function print(){
	var sourceUrl = "";
	var printName = currRepairSettorderPrintShow||currOrgName;
	var p = {
		comp : printName,
		partApiUrl:apiPath + partApi + "/",
		baseUrl: apiPath + repairApi + "/",
		sysUrl: apiPath + sysApi + "/",
		webUrl:webPath + contextPath + "/",
        bankName: currBankName,
        bankAccountNumber: currBankAccountNumber,
        currCompAddress: currCompAddress,
        currCompTel: currCompTel,
        currSlogan1: currSlogan1,
        currSlogan2: currSlogan2,
        currUserName : currUserName,
		token : token
	};
	params = {
			printGuest:printGuest,
		guestData:guestData,
		p:p
	};
	if(typeCard==1){
		sourceUrl = webPath + contextPath + "/com.hsweb.repair.DataBase.printCardRefund.flow?token="+token;
		p.name="计次卡退款";
	}
	if(typeCard==2){
		sourceUrl = webPath + contextPath + "/com.hsweb.repair.DataBase.printCardStoredRefund.flow?token="+token;
		p.name="储值卡退款";
	}
	nui.open({
        url: sourceUrl,
        title: p.name + "打印",
		width: "100%",
		height: "100%",
        onload: function () {
            var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(params);
        },
        ondestroy: function (action){
        }
    });
}