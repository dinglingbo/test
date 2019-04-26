
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var guestInfoUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryCustomerWithContactList.biz.ext";
var netInAmt = 0;//应结金额
var cardType = 1;//什么界面过来的  1计次卡，2储值卡
var tableNum = 0;
var card = {};//传进逻辑流的卡
var cardList=[];//所有计次卡
var form = null;
var type = null;
var typeList = {};
var guestData = {};
var deductible = 0;
var row = {};
var searchKeyEl = null;
var searchNameEl = null;
var userCouponDataHash = {};
var codeHash = {};
//优惠券抵扣的金额
var deductionAmt = 0;
//结算接口的优惠券对象
var couponList = [];
$(document).ready(function (){
	$("body").on("blur","input[name='amount']",function(){
		onChanged();
	});
	searchKeyEl = nui.get("search_key");
	searchNameEl = nui.get("search_name");
    searchKeyEl.setUrl(guestInfoUrl);
    addTimesCardList();
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
        //清除应收，实际金额
    	couponList = [];
    	userCouponDataHash = {};
    	codeHash = {};
    	deductionAmt = 0;
    	document.getElementById('quanAmt').innerHTML = 0;
    	document.getElementById('amount').innerHTML = netInAmt;
    	document.getElementById('totalAmt1').innerHTML = netInAmt;

     });
    
    searchKeyEl.focus();
    
	$("body").on("click","a[name='quan']",function(e){
		var id = e.currentTarget.id;
		var str = "quan"+id;
		var changStr = "#chang"+id;
		var userCoupon = userCouponDataHash[id];
		//判断优惠券是否重复，以及是否达到可用条件
		var boolean = false;
		if(document.getElementById(str).getAttribute("class")=="quan-item1"){
			document.getElementById(str).className = "quan-item";
			$(changStr).html("使用");
			delete codeHash[id];
			var strCode = isEmptyObject(codeHash);
			if(strCode != ""){
				document.getElementById("showCode").style.display = "";
				$("#strCode").val(strCode);
				$("#strCode").text(strCode);
				document.getElementById('quanAmt').innerHTML = deductionAmt || 0;
			}else{
				deductionAmt = 0;
				$("#strCode").val("");
				$("#strCode").text("");
				document.getElementById("showCode").style.display = "none";
				document.getElementById('quanAmt').innerHTML = 0;
			}
			onChanged();
		}else{
			if(userCoupon.couponType == 1){
				boolean = false;
			}else{
				var b = false;
				for(var k in codeHash){
					var tep = codeHash[k];
					if(tep.cardId == row.id){
						b = true;
					}
				}
				if(b){
					boolean = false;
				}else{
					if(userCoupon.cardId && userCoupon.cardId == row.id){
						boolean = true;
					}
				}
			}
			if(boolean){	
				document.getElementById(str).className = "quan-item1";
				codeHash[id] = userCoupon;
				$(changStr).html("取消");
				var strCode = isEmptyObject(codeHash);
				if(strCode != ""){
					document.getElementById("showCode").style.display = "";
					$("#strCode").val(strCode);
					$("#strCode").text(strCode);
					document.getElementById('quanAmt').innerHTML = deductionAmt || 0;
				}else{
					deductionAmt = 0;
					$("#strCode").val("");
					$("#strCode").text("");
					document.getElementById("showCode").style.display = "none";
					document.getElementById('quanAmt').innerHTML = 0;
				}
				onChanged();
			}
			
		}	
	});
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
    //判断是否绑定了微信
    if(guestData.wechatOpenId){
		document.getElementById("inputUserCode").style.display = "";
		document.getElementById("showCode").style.display = "none";
		var list  = "";
	    document.getElementById("show").innerHTML = list;
    }else{
       document.getElementById("inputUserCode").style.display = "none";
       document.getElementById("showCode").style.display = "none";
	   var list  = "没有可用优惠券或者该用户未在微信公众号注册";
       document.getElementById("show").innerHTML = list;
    }
   
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
	var amountAmt = parseFloat(netInAmt) - parseFloat(deductionAmt);
	amountAmt = amountAmt.toFixed(2);
	document.getElementById('amount').innerHTML = amountAmt;
	var count = scount();
	var totalCount = parseFloat(count) + parseFloat(deductionAmt);
	totalCount = totalCount.toFixed(2);
	/*if(parseFloat(count) > netInAmt){
		showMsg("收款大于应收金额，请重新填写","W");
		return;
	}*/
	//更新页面实收金额
	if( totalCount > netInAmt){
		showMsg("加上优惠券金额不能大于应收金额","W");
		return;
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
		url : baseUrl + "com.hsapi.repair.baseData.crud.queryTimesCardNoPage.biz.ext?token="+ token,
		type : "post",
		data : "",
		success : function(data) {	
				cardList = data.timesCard;
				$("<option value='0' >—请选择计次卡—</option>").appendTo("#cardList");
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
			card = data.card;
				$("<option value='0'>—请选择储值卡—</option>").appendTo("#cardList");
				for(var i = 0;i<data.card.length;i++){
						$("<option  value="+data.card[i].id+">"+data.card[i].name+"&nbsp;&nbsp;&nbsp;&nbsp;"+"充值："+data.card[i].rechargeAmt+"&nbsp;&nbsp;&nbsp;&nbsp;"+"赠送："+data.card[i].giveAmt+"</option>").appendTo("#cardList");
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
	var totalCount = parseFloat(count) + parseFloat(deductionAmt);
	totalCount = totalCount.toFixed(2);
	if(totalCount!=netInAmt){
		showMsg("付款金额与实收金额不一致，请重新确认！","W");
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
				carNo:guestData.carNo,
				buySource:1,
				discountAmt:deductionAmt
                
		};
		json={
				payAmt:count,
				remark:nui.get("txtreceiptcomment").getValue(),
				payType:020104,
				accountTypeList:accountTypeList,
				cardTimes :card,
				couponList:couponList,
				token:token
		}
	}else if(cardType==2){
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
				sellAmt :row.rechargeAmt,
				carId:guestData.carId,
				carNo:guestData.carNo
		};

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
								//清除应收、储值卡，实际金额
					            if(nui.get("cardTimesSettleWeChat").getValue()=="true"){
					            	cardTimesSettleWeChat(data.cardTimes);//发送微信
					            }
					        	couponList = [];
					        	userCouponDataHash = {};
					        	codeHash = {};
					        	document.getElementById('quanAmt').innerHTML = 0;
					        	netInAmt = 0;
					        	document.getElementById('amount').innerHTML = 0;
					        	document.getElementById('totalAmt1').innerHTML = 0;
					        	document.getElementById("cardList").value="0";
					        	var guestData2 = guestData;
					        	guestData={};
					        	var row2 = row;
					        	row2.deductionAmt = deductionAmt;
					        	deductionAmt = 0;
					        	row = {};
					        	print(row2,guestData2);
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
function print(row2,guestData2){
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
	params = {
		guestData:guestData2,
		row :row2,
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
				carNo:guestData.carNo,
				buySource:1
		    };
		//整理数据
		 var amountAmt = parseFloat(netInAmt) - parseFloat(deductionAmt);
		 payAmt = amountAmt.toFixed(2);
		 json = nui.encode({
			    "cardTimes":cardTimes,
			    couponList:couponList,
			    remark:nui.get("txtreceiptcomment").getValue(),
			    token:token
		  });
	}else if(cardType==2){
		noPayMeth = apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.preSettleRecharge.biz.ext";
		//实收金额
		payAmt=row.rechargeAmt;
		var stored={
				cardId		: row.id,
				cardName	: row.name,
				giveAmt		: row.giveAmt,
				guestId		: guestData.guestId,
				guestName	: guestData.guestFullName,	
				rechargeAmt	: row.rechargeAmt,
				totalAmt 	: row.totalAmt,
				periodValidity : row.periodValidity,
				balaAmt : row.totalAmt,
				carId:guestData.carId,
				carNo:guestData.carNo
		};
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
				        	//清除应收、储值卡，实际金额
				        	couponList = [];
				        	userCouponDataHash = {};
				        	codeHash = {};
				        	document.getElementById('quanAmt').innerHTML = 0;
				        	netInAmt = 0;
				        	document.getElementById('amount').innerHTML = 0;
				        	document.getElementById('totalAmt1').innerHTML = 0;
				        	document.getElementById("cardList").value="0";
				        	add();
				        	//CloseWindow("onok");
				        	var guestData2 = guestData;
				        	guestData={};
				        	var row2 = row;
				        	row2.deductionAmt = deductionAmt;
				        	deductionAmt = 0;
				        	row = {};
				        	print(row2,guestData2);
				        	
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
	var isUserEmp = false;
	for(var key in userCouponDataHash ){
		isUserEmp = true;
		break;
	}
	if(index == 0){
		row = {};
		netInAmt = 0;
		if(isUserEmp){
			//循环判断优惠券
			for(var key in userCouponDataHash){
				var v = userCouponDataHash[key];
				var id = v.couponDistributeId;
				var str = "quan" + id;
				var changStr = "#chang"+id;
				document.getElementById(str).className = "quan-item";
				$(changStr).html("使用");
				delete codeHash[id];
			}
			var strCode = isEmptyObject(codeHash);
			if(strCode != ""){
				document.getElementById("showCode").style.display = "";
				$("#strCode").val(strCode);
				$("#strCode").text(strCode);
				document.getElementById('quanAmt').innerHTML = deductionAmt || 0;
			}else{
				deductionAmt = 0;
				$("#strCode").val("");
				$("#strCode").text("");
				document.getElementById("showCode").style.display = "none";
				document.getElementById('quanAmt').innerHTML = 0;
			}
			onChanged();
		}else{
			document.getElementById('amount').innerHTML = netInAmt;
		}
		return;
	}
	var c  =myselect.options[index].value;
	for(var i = 0;i<cardList.length;i++){
		if(c==cardList[i].id){
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
	//更新页面应付金额
	document.getElementById('totalAmt1').innerHTML = netInAmt;
	//当扫描了优惠券后，购买的计次卡改变，判断选择的计次卡是否适合该优惠券
	if(index != 0){
		if(isUserEmp){
			var tpb = true;
			//循环判断优惠券
			for(var key in userCouponDataHash){
				var v = userCouponDataHash[key];
				var id = v.couponDistributeId;
				var str = "quan" + id;
				var changStr = "#chang"+id;
				//只要有一个适合，其他都不选中
				 
				if(v.cardId == row.id && tpb){
					document.getElementById(str).className = "quan-item1";
					$(changStr).html("取消");
					codeHash[id] = v;
					tpb = false;
				}else{
					document.getElementById(str).className = "quan-item";
					$(changStr).html("使用");
					delete codeHash[id];
				}
			}
			var strCode = isEmptyObject(codeHash);
			if(strCode != ""){
				document.getElementById("showCode").style.display = "";
				$("#strCode").val(strCode);
				$("#strCode").text(strCode);
				document.getElementById('quanAmt').innerHTML = deductionAmt || 0;
			}else{
				deductionAmt = 0;
				$("#strCode").val("");
				$("#strCode").text("");
				document.getElementById("showCode").style.display = "none";
				document.getElementById('quanAmt').innerHTML = 0;
			}
			onChanged();
		}else{
			document.getElementById('amount').innerHTML = netInAmt;
		}
		
	}else{
		document.getElementById('amount').innerHTML = netInAmt;
	}
}

function isEmptyObject (obj){
	var str = "";
    var n = 1;
	couponList = [];
	deductionAmt = 0;
	for(var key in obj ){
		var objTemp = obj[key];
		var temp = {};
		temp.orgid = currOrgid;
		temp.tenantId  = currTenantId;
		temp.carId = guestData.carId;
		temp.carNo = guestData.carNo;
		temp.guestId = guestData.guestId;
		temp.billTypeId = 7;
		temp.contactorId = guestData.contactorId;
		temp.couponCode = objTemp.userCouponCode;
		temp.couponName = objTemp.couponTitle;
		temp.couponAmt = objTemp.couponDiscountsPrice;
		temp.couponType = objTemp.couponType;
		temp.couponDescribe = objTemp.couponDescribe;
		temp.couponEndDate = objTemp.couponEndDate;
		temp.couponConditionPrice = objTemp.couponConditionPrice;
		couponList.push(temp);
		if(n==1){
			str = objTemp.userCouponCode;
			n = 2; 
		}else{
			str += "," + objTemp.userCouponCode;
		}
		deductionAmt = parseFloat(deductionAmt) + parseFloat(objTemp.couponDiscountsPrice);
		
	 }
	return str;
}

function setInitData(params){
	 //清除应收，实际金额
	couponList = [];
	userCouponDataHash = {};
	codeHash = {};
	deductionAmt = 0;
	document.getElementById('quanAmt').innerHTML = 0;
	document.getElementById('amount').innerHTML = netInAmt;
	document.getElementById('totalAmt1').innerHTML = netInAmt;
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
	
	/*if(guestData.wechatOpenId){
		document.getElementById("inputUserCode").style.display = "";
    }else{
       document.getElementById("inputUserCode").style.display = "none";
	   var list  = "没有可用优惠券或者该用户未在微信公众号注册";
       document.getElementById("show").innerHTML = list;
    }*/
	if(guestData.wechatOpenId){
		document.getElementById("inputUserCode").style.display = "";
		document.getElementById("showCode").style.display = "none";
		var list  = "";
	    document.getElementById("show").innerHTML = list;
    }else{
       document.getElementById("inputUserCode").style.display = "none";
       document.getElementById("showCode").style.display = "none";
	   var list  = "没有可用优惠券或者该用户未在微信公众号注册";
       document.getElementById("show").innerHTML = list;
    }
	
	document.getElementById("quanAmt").innerHTML = 0;
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

function inputUserQuan(e){
	var isRow = false;
	for(var a in row){
		isRow = true;
		break;
	}
    if(!isRow){
		showMsg("请选择购买的计次卡!","W");
		return;
	}
	var code =  nui.get("inputCode").getValue();
	var paraMap = {};
	paraMap.userOpenId = guestData.wechatOpenId;
	paraMap.couponCode = code;
	paraMap.orgid = currOrgid;
	paraMap.tenantId = currTenantId;
	paraMap.userCarId = guestData.carId;
	
	var json2 = {
			param:paraMap,
			token: token
	}
	var list = '';
if(code != "" && code != null){
	nui.ajax({
		url :  apiPath + wechatApi +"/wechatApi/com.hsapi.wechat.autoServiceBackstage.weChatCardCoupon.queryCardCouponByCode.biz.ext",
		type : "post",
		data : json2,
		success : function(data) {
			if(data.result.code=="S"){
				var v = data.result.data;
				//判断对象是否为空
				var isEnp = false;
				for(var a in v){
					isEnp = true;
					break;
				}
				var list = "";
				if(isEnp){
					//判断已扫描的优惠券中是否存在该优惠券
					 var isExistTemp = userCouponDataHash[v.couponDistributeId];
					 if(!isExistTemp){
						 var key = null;
						  key = v.couponDistributeId;
						  var type = v.couponType==1?'通用券':'专属劵';
						  var str = null;
						  if(v.couponType==1){
							  str="(满"+v.couponConditionPrice+")";
						  }else{
							  str="";
						  }
						  list += 
							  '<div class="quan-item" id=quan'+ v.couponDistributeId +'> '+
							 '<div class="q-opbtns "><strong class="num1">￥'+ v.couponDiscountsPrice + '<br>'+ type +'</strong></div>'+
						     '<div class="q-type">'+
						        '<div class="q-range">'+
						            '<div class="typ-txt">'+
						                '<span >'+ v.couponTitle+ '</span>'+
						               '<a href="##" class="useText" name="quan" id='+v.couponDistributeId+'><span id = chang'+v.couponDistributeId+'>使用</span></a></div>'+
						            '<div class="range-item">'+ v. couponDescribe + str +'</div>'+
						            '<div class="range-item">到期时间：'+v.couponEndDate +'</div>'+
						            '<div class="range-item">编码：'+v.userCouponCode +'</div>'+
						        '</div>'+
						    '</div>'+ 
						    '</div>';
							var boolean = false;
							if(v.couponType == 1){
								boolean = false;
							}else{
								var b = false;
								for(var k in codeHash){
									var tep = codeHash[k];
									if(tep.cardId == row.id){
										b = true;
									}
								}
								if(b){
									boolean = false;
								}else{
									if(v.cardId && v.cardId == row.id){
										boolean = true;
									}
								}
								
							}
							if(boolean){	
								document.getElementById("show").innerHTML = document.getElementById("show").innerHTML + list;
								userCouponDataHash[key] = v;
								var changStr = "#chang"+key;
								var strQuan = "quan"+key;
								document.getElementById(strQuan).className = "quan-item1";
								codeHash[key] = v;
								$(changStr).html("取消");
								var strCode = isEmptyObject(codeHash);
								if(strCode != ""){
									document.getElementById("showCode").style.display = "";
									$("#strCode").val(strCode);
									$("#strCode").text(strCode);
									document.getElementById('quanAmt').innerHTML = deductionAmt || 0;
								}else{
									deductionAmt = 0;
									$("#strCode").val(""); 
									$("#strCode").text("");
									document.getElementById("showCode").style.display = "none";
									document.getElementById('quanAmt').innerHTML =  0;
								}
								onChanged();
							}else{
								showMsg("优惠券不满足抵扣条件！","W");
								 nui.get("inputCode").setValue("");
								return;
							}
							nui.get("inputCode").setValue("");
					 }else{
						 showMsg("该优惠券已扫描！","W");
						 nui.get("inputCode").setValue("");
						 return;
					 }
					  
			}else{	
				showMsg("用户没有该优惠券！","W");
				nui.get("inputCode").setValue("");
				return;
			}
		 }
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
/*
	  var v  =  {
			  "storeId": 6,
	            "orgid": 601,
	            "tenantId": 121,
	            "storeName": "华胜宜修店",
	            "storeAverageScore": 4.8,
	            "storePicture": "/hsWechatImager/201903/201903231645_51.jpg",
	            "storeBusinessBeginTime": "06:00:00",
	            "storeBusinessEndTime": "16:00:00",
	            "storeDetailsContent": "206,207,208,209,",
	            "storeStatus": 0,
	            "storeLatitude": 23.02069092,
	            "storeLongitude": 113.75180817,
	            "storePhone": "18674656852",
	            "storeStreetAddress": "广东省东莞市长安镇新安街口麦 园工业区1号",
	            "is_delete": 0,
	            "carId": 474,
	            "carVin": "LSVET69F9A2578883",
	            "carNo": "云F041GW",
	            "userCarId": 31914,
	            "carBrandId": null,
	            "carBrandName": null,
	            "carSeriesId": null,
	            "carSeriesName": null,
	            "carModelId": null,
	            "carModelName": null,
	            "lastPatronageCar": 0,
	            "userCouponId": 187,
	            "userOpenId": "obdhQ5p371BTH5EDBSyrk5dT2gnE",
	            "userCouponCode": "phpLu2019041311003161565",
	            "couponDistributeId": 291,
	            "couponUseTime": null,
	            "userCouponStatus": "0",
	            "couponCode": "RuixL201903081206330",
	            "couponName": null,
	            "couponTitle": "测试",
	            "couponDescribe": "只限此店使用",
	            "couponConditionPrice": null,
	            "couponDiscountsPrice": 100,
	            "serviceItemId": 45,
	            "serviceitemName": "无忧轮胎卡",
	            "couponType": "2",
	            "couponNumber": 10,
	            "distributePeopleId": 2222,
	            "distributePeopleName": "宜修壹",
	            "distributeDate": "2019-04-13 10:55:12.0",
	            "distributeStatus": "2",
	            "couponStatus": "2",
	            "isCarUse": 0,
	            "isStoreUse": 1,
	            "isTenantUse": 1,
	            "couponBeginDate": "2019-03-08",
	            "couponEndDate": "2019-04-18",
	            "couponDeleteStatus": 0,
	            "cardId": 521
	    }
	  
	  var key = null;
	  key = v.couponDistributeId;
	  var type = v.couponType==1?'通用券':'专属劵';
	  var str = null;
	  if(v.couponType==1){
		  str="(满"+v.couponConditionPrice+")"
	  }else{
		  str="";
	  }
	  list += 
		  '<div class="quan-item" id=quan'+ v.couponDistributeId +'> '+
		 '<div class="q-opbtns "><strong class="num1">￥'+ v.couponDiscountsPrice + '<br>'+ type +'</strong></div>'+
	     '<div class="q-type">'+
	        '<div class="q-range">'+
	            '<div class="typ-txt">'+
	                '<span >'+ v.couponTitle+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="##" class="useText" name="quan" id='+v.couponDistributeId+'><span id = chang'+v.couponDistributeId+'>使用</span></a></span>'+
	               '</div>'+
	            '<div class="range-item">'+ v. couponDescribe + str +'</div>'+
	            '<div class="range-item">到期时间：'+v.couponEndDate +'</div>'+
	            '<div class="range-item">编码：'+v.userCouponCode +'</div>'+
	        '</div>'+
	    '</div>'+ 
	    '</div>';
		var boolean = false;
		if(v.couponType == 1){
			boolean = false;
		}else{
			if(v.cardId && v.cardId == row.id){
				boolean = true;
			}
		}
		if(boolean){	
			document.getElementById("show").innerHTML = document.getElementById("show").innerHTML + list;
			userCouponDataHash[key] = v;
			var changStr = "#chang"+key;
			var strQuan = "quan"+key;
			document.getElementById(strQuan).className = "quan-item1";
			codeHash[key] = v;
			$(changStr).html("取消");
			var strCode = isEmptyObject(codeHash);
			if(strCode != ""){
				document.getElementById("showCode").style.display = "";
				$("#strCode").val(strCode);
				$("#strCode").text(strCode);
				document.getElementById('quanAmt').innerHTML = deductionAmt || 0;
			}else{
				deductionAmt = 0;
				$("#strCode").val(""); 
				$("#strCode").text("");
				document.getElementById("showCode").style.display = "none";
				document.getElementById('quanAmt').innerHTML =  0;
			}
			onChanged();
		}else{
			showMsg("优惠券不满足抵扣条件！","W");
			 nui.get("inputCode").setValue("");
			return;
		}*/
   }	
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
            					uest(data[0]);
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


function cardTimesSettleWeChat(cardTimes){
	 var cardTimesSettleWeChatUrl = baseUrl+ "com.hsapi.repair.repairService.sendWeChat.sendTimeCardSellInfo.biz.ext";
		var json = nui.encode({
			"cardTimes":cardTimes,
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
