
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var getAccountUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryFrmAccount.biz.ext";
var netInAmt = 0;
var tableNum = 0;
var form = null;
var type = null;
var typeList = {};
var zongAmt = 0;//实时填写的结算金额
var typeUrl = 0;//结算逻辑流，2退货.3预收预付
var guestData = null;
var deductible = 0;
var contact = {};//查询出来的联系人，用于微信结算
$(document).ready(function (){
	$("body").on("blur","input[name='amount']",function(){
		onChanged();
	});
});

//页面传值，放入本页面
function setData(data){
	
	var s = data.length;
	guestData = data;
	if (s > 1) {
		for(var i = 0;i<guestData.length;i++){
			zongAmt =parseFloat(zongAmt)+parseFloat(data[i].nowAmt||0);
			netInAmt = parseFloat(netInAmt)+parseFloat(data[i].nowAmt||0);
		}
	}else{
		
		zongAmt = parseFloat(data[0].nowAmt||0);
		netInAmt = parseFloat(data[0].nowAmt||0);
	}
	typeUrl =  data[0].typeUrl;
	var rechargeBalaAmt = 0;
	document.getElementById('carNo').innerHTML = data[0].carNo;
	document.getElementById('guest').innerHTML = data[0].guestName;
	document.getElementById('totalAmt').innerHTML = "￥"+netInAmt;
	document.getElementById('totalAmt1').innerHTML = netInAmt;
	document.getElementById('amount').innerHTML = netInAmt;
	/*	if(typeUrl==2){
		$("#wxbtnsettle").show();
	}else{
		$("#wxbtnsettle").hide();
	}*/
	//判断是什么结算，定义微信结算的按钮颜色
	var json1 = {};
	var isContacter = true;//是否查询联系人
	if(data[0].billTypeId==103||data[0].billTypeId==106||data[0].billTypeId==107||data[0].billTypeId==108||data[0].billTypeId==109||data[0].billTypeId==119){
		json1 = {
				type:1,
				serviceId : data[0].billMainId,
				token : token
			}
	}else if(data[0].billTypeId==104){
		json1 = {
				type:3,
				serviceId : data[0].billMainId,
				token : token
			}
	}else if(data[0].billTypeId==105){
		json1 = {
				type:2,
				serviceId : data[0].billMainId,
				token : token
			}
	}else{
		isContacter = false;
		$("#wxbtnsettle").hide();
	}
	if(isContacter){
		nui.ajax({
			url : apiPath + repairApi + "/com.hsapi.repair.repairService.crud.queryContacter.biz.ext" ,
			type : "post",
			data : json1,
			success : function(data) {
				if(data.errCode == "S") {
					contact = data.contact;
					if(contact.wechatOpenId==""||contact.wechatOpenId==null){
						document.getElementById("wxbtnsettle").style.background = "#3c3c3c3c";
					}
				}else{
					$("#wxbtnsettle").hide();
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			}
		});
	}

	
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
			console.log(jqXHR.responseText);
		}
	});
	
	//挂账
	if(guestData[0].guestId){
    	var accAmt = {};
    	accAmt.guestId = guestData[0].guestId;
    	nui.ajax({
            url : getAccountUrl,
            type : "post",
            data : JSON.stringify({
                params : accAmt,
                token : token
            }),
            success : function(data) {
            	data = data || {};
                if (data.errCode == "S") {
                    var account = data.account[0];
                    var Amt = account.accountAmt || 0;
                    $("#creditEl").html(Amt+"元");
                } else {
                    showMsg(data.errMsg || "获取挂账信息失败","E");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                unmaskcall && unmaskcall();
                console.log(jqXHR.responseText);
            }
        });
    }

	//查询使用了的优惠券
/*	var params = {};
	params.billMainId =data[0].billMainId;
	params.carId = data[0].carId;
	var json1 = {
			params:params,
			token : token
		}
	var deductionAmt = 0;
	nui.ajax({
		url : apiPath + repairApi + "/com.hsapi.repair.repairService.crud.queryRpsCouponRecordList.biz.ext" ,
		type : "post",
		data : json1,
		success : function(data) {
			if(data.errCode=="S"){
				var couponRecordList = data.couponRecordList;
				var list = "";
				if(couponRecordList.length>0){
					$(couponRecordList).each(function(k,v) {
						  deductionAmt = parseFloat(deductionAmt) + parseFloat(v.couponAmt);
						  var type = v.couponType==1?'通用券':'专属劵';
						  var str = null;
						  if(v.couponType==1){
							  str="(满"+v.couponConditionPrice+")";
						  }else{
							  str="";
						  }
						  var endData = format(v.couponEndDate, "yyyy-MM-dd");
						  list += 
							  '<div class="quan-item"> '+
							 '<div class="q-opbtns "><strong class="num1">￥'+ v.couponAmt + '<br>'+ type +'</strong></div>'+
						     '<div class="q-type">'+
						        '<div class="q-range">'+
						            '<div class="typ-txt">'+
						                '<span >'+ v.couponName+ '</span>'+
						               '</div>'+
						            '<div class="range-item">'+ v.couponDescribe + str +'</div>'+
						            '<div class="range-item">到期时间：'+endData+'</div>'+
						            '<div class="range-item">编码：'+v.couponCode +'</div>'+
						        '</div>'+
						    '</div>'+ 
						    '</div>';
						});
						document.getElementById("show").innerHTML = list;
						document.getElementById('quanAmt').innerHTML = deductionAmt;
				}else{
					 var list  = "没有使用优惠券或者该用户未在微信公众号注册";
				     document.getElementById("show").innerHTML = list;
				     document.getElementById('quanAmt').innerHTML = 0;
				}
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});*/
	addType();
}

function onChanged() {
	var count = scount();
	 deductible = nui.get("deductible").getValue()||0;
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	var memAmt = nui.get("rechargeBalaAmt").getValue()||0;
	if(memAmt!=0){
		memAmt = (memAmt.split("￥"))[1];
	} 

	if(deductible>memAmt){
		showMsg("储值抵扣不能大于储值余额","W");
/*		nui.get("deductible").setValue(0);
		deductible=0;
		nui.get("PrefAmt").setValue(0);*/
		//document.getElementById('amount').innerHTML=netInAmt;
		return;
	}
	if(parseFloat(deductible) + parseFloat(PrefAmt)+ parseFloat(count) > netInAmt){
		showMsg("收款大于应收金额，请重新填写","W");
/*		nui.get("deductible").setValue(0);
		deductible=0;
		nui.get("PrefAmt").setValue(0);*/
		//document.getElementById('amount').innerHTML=netInAmt;
		return;
	}
	
/*	var amount = parseFloat(netInAmt) - parseFloat(deductible) - parseFloat(PrefAmt)-parseFloat(count);
		amount = amount.toFixed(2);
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
						}
					}
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


function settleOK() {
	var settleAuditUrl = "";//结算接口，根据
	var accountTypeList =[];
	var accountDetail = {};
	var count = scount();
	var printCount = count;
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
		
/*		if(count==0){
			showMsg("请选择结算账户,并填写结算金额","W");
			return;
		}*/
		deductible = nui.get("deductible").getValue()||0;
		count = (count+deductible).toFixed(2);
		if(count!=zongAmt){
			showMsg("结算金额和应结金额不一致，请重新确认！","W");
			return;
		}
		var account = {};
		var accountDetailList = [];
		var rRPAmt = 0; // 应收金额
		var rTrueAmt = 0; // 实收应收
		var rVoidAmt = 0; // 优惠金额
		var rNoCharOffAmt = 0; // 未结金额
		var pRPAmt = 0; // 应付金额
		var pTrueAmt = 0; // 实付金额
		var pVoidAmt = 0; // 免付金额
		pVoidAmt = parseFloat(pVoidAmt);
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
		
		for(var i = 0;i<guestData.length;i++){
			var accountDetail = {};
			var noCharOffAmt = guestData[i].noCharOffAmt || 0; // 已结金额
			var rpAmt = guestData[i].rpAmt || 0; // 应结金额
			var nowAmt = guestData[i].nowAmt || 0;
			var nowVoidAmt = guestData[i].nowVoidAmt || 0;
			nowAmt = parseFloat(nowAmt);
			nowVoidAmt = parseFloat(nowVoidAmt);
			pRPAmt += rpAmt;
			pTrueAmt += nowAmt;
			pVoidAmt += nowVoidAmt;
			pNoCharOffAmt += noCharOffAmt;
			s1 += (nowAmt + nowVoidAmt);
			accountDetail.charOffAmt = nowAmt;
			accountDetail.voidAmt = nowVoidAmt;
			accountDetail.billRpId = guestData[i].id;
			accountDetail.billMainId = guestData[i].billMainId;
			accountDetail.billServiceId = guestData[i].billServiceId;
			accountDetail.billTypeId = guestData[i].billTypeId;
			//预收付账款typeUrl==3，不考虑别的
			if(typeUrl==3){
				accountDetail.rpDc = 2;
			}else{				
				accountDetail.rpDc = 1;
			}
			accountDetailList.push(accountDetail);
		}
		//单挑收款
/*		accountDetail.billRpId = guestData[0].id;
		accountDetail.billMainId = guestData[0].billMainId;
		accountDetail.billServiceId = guestData[0].billServiceId;
		accountDetail.billTypeId = guestData[0].billTypeId;
		var noCharOffAmt = guestData[0].noCharOffAmt || 0; // 已结金额
		var rpAmt = guestData[0].rpAmt || 0; // 应结金额
		var nowAmt = guestData[0].nowAmt || 0;
		var nowVoidAmt = guestData[0].nowVoidAmt || 0;

		accountDetail.rpDc = 1;
		nowAmt = parseFloat(nowAmt);
		nowVoidAmt = parseFloat(nowVoidAmt);
		pRPAmt += rpAmt;
		pTrueAmt += nowAmt;
		pVoidAmt += nowVoidAmt;
		pNoCharOffAmt += noCharOffAmt;
		s1 += (nowAmt + nowVoidAmt);
		accountDetail.charOffAmt = nowAmt;
		accountDetail.voidAmt = nowVoidAmt;

		accountDetailList.push(accountDetail);*/
		//预付账款typeUrl==3，不考虑别的
		if(typeUrl==3){
			account.rpDc = 2;
			account.settleType = "预收";
			settleAuditUrl =frmUrl+ "com.hsapi.frm.frmService.rpsettle.RpAccountSettleForCarSales.biz.ext";
		}else{				
			account.rpDc = 1;
			account.settleType = "应收";
			settleAuditUrl =frmUrl+ "com.hsapi.frm.frmService.rpsettle.rpAccountSettle.biz.ext";
		}
		account.voidAmt = pVoidAmt;
		account.trueCharOffAmt = pTrueAmt;
		account.charOffAmt = pVoidAmt + pTrueAmt;
		
		if(deductible!=0){
			var list={balaTypeCode:"020107",charOffAmt:deductible};
			accountTypeList.push(list);
		}

		  nui.confirm("是否确定结算?", "友情提示",function(action){
		       if(action == "ok"){
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
/*							if(typeUrl!=3){
								print(accountDetailList,printCount);	
							}else{
								CloseWindow("saveSuccess");
							}*/								
							print(accountDetailList,printCount);	
			
							} else {
								showMsg(data.errMsg || "结算失败!", "W");
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

//打印函数
function print(accountDetailList,netInAmt){
	var businessNumber = "";
	for(var i = 0;i<accountDetailList.length;i++){
		if(i==accountDetailList.length-1){
			businessNumber = businessNumber+accountDetailList[i].billServiceId
		}else{
			businessNumber = businessNumber+accountDetailList[i].billServiceId+",";
		}
		
	}
	  nui.confirm("收款成功，需要打印收款凭证吗？", "友情提示",function(action){
		       if(action == "ok"){
		    		var sourceUrl = webPath + contextPath + "/com.hsweb.print.closedmentPrint.flow?token="+token;
		    		var printName = currRepairSettorderPrintShow||currOrgName;
		    		var p = {
		    			comp : printName,
		    			partApiUrl:apiPath + partApi + "/",
		    			frmApiUrl:apiPath + frmApi + "/",
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
		    			guestData:guestData,
		    			businessNumber :businessNumber,
		    			billServiceId : accountDetailList[0].billServiceId,
		    			netInAmt:netInAmt,
		    			p:p
		    		};


		    		nui.open({
		    	        url: sourceUrl,
		    	        title:"打印收款证明单",
		    			width: "100%",
		    			height: "100%",
		    	        onload: function () {
		    	            var iframe = this.getIFrameEl();
		    	           iframe.contentWindow.SetData(params);
		    	        },
		    	        ondestroy: function (action){
		    	        }
		    	    });
		     }else {
		    	 CloseWindow("saveSuccess");
			 }
		 }); 

}

function weChatSettle(){
	if(contact.wechatOpenId==""||contact.wechatOpenId==null){
		showMsg("用户未绑定微信！","W");
	}else{
		  nui.confirm("是否确定推送支付?", "友情提示",function(action){
		       if(action == "ok"){
					nui.mask({
						el : document.body,
						cls : 'mini-mask-loading',
						html : '数据处理中...'
					});
					var json1 = {
							"token":token,
							"fisId":guestData[0].id,
							"openId":contact.wechatOpenId,
							"contactorId":contact.id,
							"amt":zongAmt
						}
					nui.ajax({
						url : apiPath + repairApi + "/com.hsapi.repair.repairService.sendWeChat.sWcSettleBill.biz.ext" ,
						type : "post",
						data : json1,
						success : function(data) {
							nui.unmask(document.body);
							if(data.errCode == "S") {
								showMsg(data.res.errMsg||"推送微信成功，请到绑定微信付款！","S");
							}else{
								showMsg(data.errMsg||"推送微信失败！","W");
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}
					});
	
		     }else {
					return;
			 }
			 }); 
	}
}