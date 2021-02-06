
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var netInAmt = 0;//应结金额
var cardType = 2;//什么界面过来的  1计次卡，2储值卡
var tableNum = 0;
var card = {};//传进逻辑流的卡
var cardList=[];//所有储值卡
var form = null;
var type = null;
var typeList = {};
var guestData = {};
var deductible = 0;
var canModify = 0;//是否允许修改金额
var row = {};
var printRow={};//打印的卡
var searchKeyEl = null;
var searchNameEl = null;
$(document).ready(function (){
	$('#edit').hide();
	$("body").on("blur","input[name='amount']",function(){
		onChanged();
	});
	searchKeyEl = nui.get("search_key");
	searchNameEl = nui.get("search_name");
    searchKeyEl.setUrl(guestInfoUrl);
    addCardList();
    searchKeyEl.on("beforeload",function(e){
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        if(value.length<3){
            e.cancel = true;
            return;
        }else{
            var reg = /^[0-9]*$/;//纯数字
            if(reg.test(value)){
                params.nums = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含字母
            var reg = /[a-z]/i;
            if(reg.test(value)){
                params.letters = value;

                data.params = params;
                e.data =data;
                return;
            }

            //包含中文
            var reg = /[\u4E00-\u9FA5\uF900-\uFA2D]/;
            if(reg.test(value)){
                params.chis = value;

                data.params = params;
                e.data =data;
                return;
            }
        }
        
    });
    
    
    searchKeyEl.on("valuechanged",function(e){
    	var item = e.selected;
        /*if(fserviceId){
            return;
        }*/
        if (item) { 
        	if(item.guestMobile == "10000"){
        		addOrEdit(item);
        	}else{
        		setGuest(item);
        	}
        	
        }
    	
    });
    
    searchKeyEl.on("itemclick",function(e){
    	var item = e.item;
       /* if (item) { 
        	setGuest(item);
        }*/
        if (item) { 
        	if(item.guestMobile == "10000"){
        		addOrEdit(item);
        	}else{
        		setGuest(item);
        	}
        	
        }
     });
    searchKeyEl.focus();
});

function setGuest(item){
	
	printGuest = item;
	guestData = item;
	var carNo = item.carNo||"";
    var tel = item.guestMobile||"";
     guestName = item.guestFullName||"";
    var carVin = item.vin||"";
     guestId = item.guestId||"";
    var sk = document.getElementById("search_key");
    sk.style.display = "none";
    searchNameEl.setVisible(true);
    
    if(tel){
        tel = "/"+tel;
    }
    if(guestName){
        guestName = "/"+guestName;
    }
    if(carVin){
        carVin = "/"+carVin;
    }
    var t = carNo + tel + guestName + carVin;
    searchNameEl.setValue(t);
       

}

/*function setData(data){
	if(data==null||data=={}){
		document.getElementById('carNo').innerHTML = "";
		document.getElementById('guest').innerHTML = "";
	}else{
		document.getElementById('carNo').innerHTML = data.carNo||"";
		document.getElementById('guest').innerHTML = data.guestFullName||"";
	}
	guestData = data||{};
	cardType = data.cardType;
	if(data.cardType==1){
		addTimesCardList();
	}else if(data.cardType==2){
		addCardList();
	}
	if(currIsCanSettle==1){
		document.getElementById("settle").style.display='none';
	}
	addType();
}*/

function onChanged() {
	var count = scount();
	//是否允许自由填写金额
	if(canModify!=1){
		if(parseFloat(count) > netInAmt){
			showMsg("收款大于应收金额，请重新填写","W");
			return;
		}
	}


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
			url : frmUrl+ "com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext?token="+ token,
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
//查询计次卡
function addTimesCardList(){
	nui.ajax({
		url : baseUrl + "com.hsapi.repair.baseData.crud.queryTimesCard.biz.ext?token="+ token,
		type : "post",
		data : "",
		success : function(data) {	
				card = data.timesCard;
				$("<option value=''>—请选择计次卡—</option>").appendTo("#cardList");
				for(var i = 0;i<data.timesCard.length;i++){
						$("<option  value="+data.timesCard[i].id+">"+data.timesCard[i].name+"&nbsp;&nbsp;&nbsp;&nbsp;"+"售价："+data.timesCard[i].sellAmt+"</option>").appendTo("#cardList");
					}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

//查询储值卡
function addCardList(){
	nui.ajax({
		url : baseUrl + "com.hsapi.repair.baseData.crud.queryCard.biz.ext?token="+ token,
		type : "post",
		data : "",
		success : function(data) {	
			cardList = data.card;
				$("<option value=''>—请选择储值卡—</option>").appendTo("#cardList");
				for(var i = 0;i<data.card.length;i++){
						$("<option  value="+data.card[i].id+","+data.card[i].canModify+">"+data.card[i].name+"&nbsp;&nbsp;&nbsp;&nbsp;"+"充值："+data.card[i].rechargeAmt+"&nbsp;&nbsp;&nbsp;&nbsp;"+"赠送："+data.card[i].giveAmt+"</option>").appendTo("#cardList");
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
				if(checkF){
					//获取待收金额
					var amt = 0;
					if(cardType==1){
						amt = row.sellAmt||0;
					}else if(cardType==2){
						amt = row.rechargeAmt||0;
					}
					
					var byId = s1[1]+data.list[0].customId;
					if(canModify==1){
						 amt = nui.get("editSellAmt").getValue();
					}
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

var settleAuditUrl = frmUrl+ "com.hsapi.frm.frmService.rpsettle.rpAccountSettle.biz.ext";//应收应付
var payMeth = baseUrl + "/com.hsapi.repair.repairService.settlement.receiveCardTimes.biz.ext";//计次卡
var payurl=baseUrl+"com.hsapi.repair.repairService.settlement.rechargeReceive.biz.ext";//储值卡支付

function settleOK() {
	var count = scount();
	if(!guestData.guestId){
		showMsg("请选择客户！","W");
		return;
	}
	if(canModify!=1){
		if(count!=netInAmt){
			showMsg("付款金额和应付金额不一致，请重新确认！","W");
			return;
		}
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
	if(cardType==1){
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
				carNo:guestData.carNo
		};
		json={
				payAmt:count,
				remark:nui.get("txtreceiptcomment").getValue(),
				payType:020104,
				accountTypeList:accountTypeList,
				cardTimes :card,
				token:token
		}
	}else if(cardType==2){
		url =payurl;
		
		var editSetAmt = nui.get("editSetAmt").getValue();//修改的赠送金额
		if(canModify==1){
			card={
					cardId:row.id,
					cardName:row.name,
					giveAmt	: editSetAmt,
					guestId:guestData.guestId,
					guestName:guestData.guestFullName,	
					rechargeAmt	: count,
					totalAmt 	: parseFloat(count)+parseFloat(editSetAmt),
					balaAmt		: parseFloat(count)+parseFloat(editSetAmt),
					periodValidity : row.periodValidity,
					sellAmt :count,
					carId:guestData.carId,
					carNo:guestData.carNo,
					contactorId :guestData.contactorId,
					contactorName : guestData.contactorName
			};
		}else{
			card={
					cardId:row.id,
					cardName:row.name,
					giveAmt	: row.giveAmt,
					guestId:guestData.guestId,
					guestName:guestData.guestFullName,	
					rechargeAmt	: count,
					totalAmt 	: parseFloat(count)+parseFloat(row.giveAmt),
					balaAmt		: parseFloat(count)+parseFloat(row.giveAmt),
					periodValidity : row.periodValidity,
					sellAmt :count,
					carId:guestData.carId,
					carNo:guestData.carNo,
					contactorId :guestData.contactorId,
					contactorName : guestData.contactorName
			};
		}
		json={
				payAmt:count,
				remark:nui.get("txtreceiptcomment").getValue(),
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
								showMsg(data.errMsg||"收款成功！","S");
								//CloseWindow("ok");
					            if(nui.get("cardSettleWeChat").getValue()=="true"){
					            	cardSettleWeChat(data.stored);//发送微信
					            }
								printRow = card;
								print();
					        	guestData={};
					        	add();
							} else {
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
        currCompLogoPath: currCompLogoPath,
		token : token
	};
	printRow.name = row.name;
	params = {
		guestData:guestData,
		row :printRow,
		p:p
	};
	if(cardType==1){
		sourceUrl = webPath + contextPath + "/com.hsweb.RepairBusiness.printCard.flow?token="+token;
		p.name="计次卡结账";
	}
	if(cardType==2){
		sourceUrl = webPath + contextPath + "/com.hsweb.RepairBusiness.printCardStored.flow?token="+token;
		p.name="储值卡结账";
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


function noPayOk(){	
	var noPayMeth = "";
	var payAmt = 0;
	var json = {};
	if(!guestData.guestId){
		showMsg("请选择客户！","W");
		return;
	}
	if(cardType==1){
		noPayMeth = apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.preSettleCardTimes.biz.ext";
		var cardTimes ={
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
				carNo:guestData.carNo
		    };
		//整理数据
		printRow = cardTimes;
		 payAmt = row.sellAmt;
		 json = nui.encode({
			    "cardTimes":cardTimes,
			    remark:nui.get("txtreceiptcomment").getValue(),
			    token:token
		  });
	}else if(cardType==2){
		noPayMeth = apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.preSettleRecharge.biz.ext";
		payAmt=scount();
		var editSetAmt = nui.get("editSetAmt").getValue();//修改的赠送金额
		if(canModify==1){
			var stored={
					cardId		: row.id,
					cardName	: row.name,
					giveAmt		: editSetAmt,
					guestId		: guestData.guestId,
					guestName	: guestData.guestFullName,	
					rechargeAmt	: payAmt,
					totalAmt 	: parseFloat(payAmt)+parseFloat(editSetAmt),
					periodValidity : row.periodValidity,
					balaAmt : parseFloat(payAmt)+parseFloat(editSetAmt),
					carId:guestData.carId,
					carNo:guestData.carNo,
					contactorId :guestData.contactorId,
					contactorName : guestData.contactorName
			};
		}else{
			var stored={
					cardId		: row.id,
					cardName	: row.name,
					giveAmt		: row.giveAmt,
					guestId		: guestData.guestId,
					guestName	: guestData.guestFullName,	
					rechargeAmt	: payAmt,
					totalAmt 	: parseFloat(payAmt)+parseFloat(row.giveAmt),
					periodValidity : row.periodValidity,
					balaAmt : parseFloat(payAmt)+parseFloat(row.giveAmt),
					carId:guestData.carId,
					carNo:guestData.carNo,
					contactorId :guestData.contactorId,
					contactorName : guestData.contactorName
			};
		}

		printRow = stored;
	    json = nui.encode({
		    "stored":stored,
		    remark:nui.get("txtreceiptcomment").getValue(),
		    token:token
	  });
	}


		//提示框 
		//判断客户有没有选择
	    nui.confirm("结算金额【"+payAmt+"】元,确定保存进入待结算吗？", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
		        nui.ajax({
				    url : noPayMeth,
				    type : 'POST',
			        data : json,
			        cache : false,
			        contentType : 'text/json',
			        success : function(text) {		
			            nui.unmask(document.body);
				        var returnJson = nui.decode(text);
				        if (returnJson.errCode == "S") {
				        	showMsg(text.errMsg||"转预结算成功！","S");
				        	//CloseWindow("onok");
				        	print();
				        	guestData={};
				        	add();
				        }
				        else {
				            showMsg("转结算失败:"+returnJson.errMsg, "W");
				        }
				   }				        	  
			  });		
	     }else {
				return;
		 }
		 });
	
	
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function payCard(){
	 var myselect=document.getElementById("cardList");
	 var index=myselect.selectedIndex;
	 var c  =myselect.options[index].value;
	  canModify = c.split(",")[1];
	  if(canModify==1){
		  $('#edit').show();
	  }else{
		  $('#edit').hide();
	  }
	  var carId = c.split(",")[0];
	for(var i = 0;i<cardList.length;i++){
		if(carId==cardList[i].id){
			row = cardList[i];
			if(cardType==1){
				netInAmt = cardList[i].sellAmt;
			}else if(cardType==2){
				netInAmt = cardList[i].rechargeAmt;
			}
			
				checkF = 1;
				checkField("optaccount0");

		}
	}
}

function setInitData(params){
	guestData = params.xyguest||{};
	if(guestData.guestId){
		var carNo = guestData.carNo||"";
	    var tel = guestData.mobile||"";
	    var guestName = guestData.guestFullName||"";
	    var carVin = guestData.carVin||"";
	    if(tel){
	        tel = "/"+tel;
	    }
	    if(guestName){
	        guestName = "/"+guestName;
	    }
	    if(carVin){
	        carVin = "/"+carVin;
	    }
	    var t = carNo + tel + guestName + carVin;
	    var sk = document.getElementById("search_key");
	    sk.style.display = "none";
	    searchNameEl.setVisible(true);
	    searchNameEl.setValue(t);
	}
    
/*	cardType = params.cardType;
	if(cardType==1){
		addTimesCardList();
	}else if(cardType==2){
		addCardList();
	}*/
	if(currIsCanSettle==0){
		document.getElementById("settle").style.display='none';
	}
	addType();
	
}

function add(){
    searchNameEl.setVisible(false);
    searchNameEl.setEnabled(false);
    searchNameEl.setValue("");
    var sk = document.getElementById("search_key");
    sk.style.display = "";
    searchKeyEl.focus();
    searchKeyEl.setValue("");//点增加给输入框个值，防止触发不了onchanged方法，不能放入客户

}

function onChangedEdit(){
	checkF = 1;
	checkField("optaccount0");
}

function addOrEdit(item)
{
    title = "完善散客信息";
    var guest = {};
    guest.guestId = item.guestId;
    guest.carNo = item.carNo;
    if(!item.guestId){
    	showMsg("数据获取失败,请重新操作!","W");
    	return;
    }
    nui.open({
        url:"com.hsweb.repair.DataBase.AddEditCustomer.flow",
        title:title,
        width:560,
        height:630,
        onload:function(){
            var iframe = this.getIFrameEl();
            var params = {};
            params.guest = guest;
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
            if(action  == "ok")
            {   //var iframe = this.getIFrameEl();
                //var data = iframe.contentWindow.getSaveData();
            	//setGuest(item);
            	var params = {};
            	params.carNo = item.carNo;
            	var json = nui.encode({
            		params:params
            	});
                nui.ajax({
            		url :guestInfoUrl,
            		type : 'POST',
            		data : json,
            		cache : false,
            		contentType : 'text/json',
            		success : function(text) {
            			var returnJson = nui.decode(text);
            			if (returnJson.errCode == "S") {
            				var data = returnJson.list;
            				if(data && data.length>0){
            					setGuest(data[0]);
            				}
            			}else {
            				showMsg("数据加载失败,请重新操作!","E");
            				return;
            		    }
            		}
            	 });
            }
        }
    });
}

function cardSettleWeChat(stored){
	 var cardTimesSettleWeChatUrl = baseUrl+ "com.hsapi.repair.repairService.sendWeChat.SendStoreCardInfo.biz.ext";
		var json = nui.encode({
			"stored":stored,
			token : token
		});
	  nui.ajax({
			url : cardTimesSettleWeChatUrl,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
			}
		});
}
