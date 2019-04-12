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
var typeUrl = 0;//不同工单URL不同   1销售开单  2退货开单
var settlementUrl = baseUrl+ "com.hsapi.repair.repairService.settlement.receiveSettle.biz.ext" ;
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var frmUrl = apiPath + frmApi + "/";
var expenseUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext';
var sendWCUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.sendWeChat.sendBillCostInfo.biz.ext';
var srnum = [];
var userCouponDataHash = {};
var codeHash = {};
//工单传过来的参数
var dataF = {};
//优惠券抵扣的金额
var deductionAmt = 0;
//结算接口的优惠券对象
var couponList = [];
$(document).ready(function(v) {

	
	$("body").on("blur","input[name='amount']",function(){
		onChanged();
	});
	
	$("body").on("click","a[name='quan']",function(e){
		var id = e.currentTarget.id;
		var str = "quan"+id;
		var changStr = "#chang"+id;
		var userCoupon = userCouponDataHash[id];
		//判断优惠券是否重复，以及是否达到可用条件
		var boolean = null;
		if(document.getElementById(str).getAttribute("class")=="quan-item1"){
			document.getElementById(str).className = "quan-item";
			$(changStr).html("使用");
			delete codeHash[id];
			var strCode = isEmptyObject(codeHash);
			if(strCode != ""){
				document.getElementById("showCode").style.display = "";
				$("#strCode").val(strCode);
				$("#strCode").text(strCode);
			}else{
				deductionAmt = 0;
				$("#strCode").val("");
				$("#strCode").text("");
				document.getElementById("showCode").style.display = "none";
			}
			onChanged();
		}else{
			if(userCoupon.couponType == 1){
				boolean = coupon(userCoupon);
			}else{
				boolean = excCoupon(userCoupon);
			}
			if(boolean){	
				/*if(document.getElementById(str).getAttribute("class")=="quan-item1"){
					document.getElementById(str).className = "quan-item";
					$(changStr).html("使用");
					delete codeHash[id];
				}else{
					document.getElementById(str).className = "quan-item1";
					codeHash[id] = userCoupon;
					$(changStr).html("取消");
					//document.getElementById(changStr).innerHTML="取消";
				}*/
				document.getElementById(str).className = "quan-item1";
				codeHash[id] = userCoupon;
				$(changStr).html("取消");
				var strCode = isEmptyObject(codeHash);
				if(strCode != ""){
					document.getElementById("showCode").style.display = "";
					$("#strCode").val(strCode);
					$("#strCode").text(strCode);
				}else{
					deductionAmt = 0;
					$("#strCode").val("");
					$("#strCode").text("");
					document.getElementById("showCode").style.display = "none";
				}
				onChanged();
			}
		}	
	});
});

function coupon(userCoupon){
	if(userCoupon.couponConditionPrice>netInAmt){
		return false;
	}else{
		for(var key in codeHash ){
			var type = codeHash[key].couponType;
			if(type == 1){
				return false;
			}
		 }
	}
	return true;
}


function excCoupon(userCoupon){
	//判断是否使用了两张相同的专属券
	for(var key in codeHash ){
		var itemId = codeHash[key].itemId;
		if(itemId == userCoupon.itemId){
			return false;
		}
	 }
	var json = {
			rpbItemId:userCoupon.itemId,
			serviceId:dataF.serviceId,
			token : token
		}
	//判断是否使用了改项目：com.hsapi.repair.repairService.crud.queryRpsItemByRpbItemIdAndServiceId
	nui.ajax({
		url : baseUrl + "com.hsapi.repair.repairService.crud.queryRpsItemByRpbItemIdAndServiceId.biz.ext",
		type : "post",
		data : json,
		async: false,
		success : function(rs) {
			if(rs.itemList.length == 0){
				return false;
			}else{
				return true;
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

function isEmptyObject (obj){
	var str = ""
    var n = 1;
	couponList = [];
	for(var key in obj ){
		var objTemp = obj[key];
		var temp = {};
		temp.orgid = currOrgid;
		temp.tenantId  = currTenantId;
		temp.carId = dataF.carId;
		temp.carNo = dataF.carNo;
		temp.guestId = dataF.guestId;
		temp.billTypeId = dataF.billTypeId;
		temp.serviceId = dataF.serviceId;
		temp.contactorId = dataF.contactor.id;
		temp.couponCode = objTemp.userCouponCode;
		temp.couponName = objTemp.couponTitle;
		temp.couponAmt = objTemp.couponDiscountsPrice;
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
	dataF = params;
	typeUrl = params.typeUrl||0;
	var carId = params.carId;
	var contactor = params.contactor;
	if(typeUrl==1){
		settlementUrl = baseUrl+ "com.hsapi.repair.repairService.settlement.salesSettle.biz.ext" ;
	}else if(typeUrl==2){
		settlementUrl = baseUrl+ "com.hsapi.repair.repairService.settlement.returnSettle.biz.ext" ;
	}else{
		settlementUrl = baseUrl+ "com.hsapi.repair.repairService.settlement.receiveSettle.biz.ext" ;
	}
	guestData = params;
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
				str='<tr><td align="center" ><spand style="color: #ff7800;">无其它费用收入</spand></td></tr>';
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
			if(params.data.ycAmt==null||params.data.ycAmt==0){
				amount = parseFloat(params.data.mtAmt)+parseFloat(amt);
				params.data.mtAmt = parseFloat(params.data.mtAmt)+parseFloat(amt);
/*				params.data.mtAmt =  parseFloat(params.data.mtAmt)+parseFloat(amt);
				params.data.mtAmt = params.data.mtAmt.toFixed(2);*/
			}else{
/*				params.data.mtAmt = parseFloat(params.data.mtAmt)-parseFloat(params.data.ycAmt)+parseFloat(amt);
				params.data.mtAmt = params.data.mtAmt.toFixed(2);*/
				amount=(parseFloat(params.data.mtAmt)-parseFloat(params.data.ycAmt)+parseFloat(amt)).toFixed(2);
				params.data.mtAmt = parseFloat(params.data.mtAmt)+parseFloat(amt);
			}
			
			netInAmt = parseFloat(amount);
			zongAmt=netInAmt;
			
			document.getElementById('totalAmt').innerHTML = "￥"+params.data.mtAmt;
			document.getElementById('totalAmt1').innerHTML = params.data.mtAmt;
			document.getElementById('amount').innerHTML =  netInAmt;
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
	

	
	if(currIsCanSettle==1){
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
	}else{
		document.getElementById("carddk").style.display='none';
		document.getElementById("settle").style.display='none';
	}
	//加载优惠券
	var paraMap = {};
	paraMap.orgid = currOrgid;
	paraMap.tenantId = currTenantId;
	paraMap.userOpenId = contactor.wechatOpenId;
	paraMap.userCarId = carId;
	paraMap.itemType = 0;
	
	/*paraMap.orgid = 601;
	paraMap.itemType = 0;//0 :查专属券（普通项目的）和通用券;1 :只查专属券（套餐项目）
	paraMap.tenantId = 121;
	paraMap.userOpenId = "obdhQ5uhtQaRB6f-MzhkfKsQH0i0";
	paraMap.userCarId = 31849;*/
	var json2 = {
			paraMap:paraMap,
			token: token
	}
	var list = '';
	nui.ajax({
		url :  apiPath + wechatApi +"/com.hsapi.wechat.autoServiceBackstage.weChatInterface.queryUserUseCoupon.biz.ext",
		type : "post",
		data : json2,
		success : function(data) {
			if(data.errCode=="S"){
				 userCouponDataArray = data.userCouponDataArray;
				var list = "";
				if(userCouponDataArray.length>0){
				   $(userCouponDataArray).each(function(k,v) {
						  var key = v.couponDistributeId;
						  userCouponDataHash[key] = v;
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
						    '</div>'
						});
						document.getElementById("show").innerHTML = list;
				}else{
					 var list  = "没有可用优惠券或者该用户未在微信公众号注册";
				     document.getElementById("show").innerHTML = list;
				}
				
			}else{	
				 var list  = "没有可用优惠券或者该用户未在微信公众号注册";
			     document.getElementById("show").innerHTML = list;
			}
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	userCouponDataArray = [
{
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
    "carId": 437,
    "carVin": null,
    "carNo": "云F87321",
    "userCarId": 31849,
    "carBrandId": "b02162",
    "carBrandName": null,
    "carSeriesId": null,
    "carSeriesName": null,
    "carModelId": null,
    "carModelName": null,
    "lastPatronageCar": 0,
    "userCouponId": 148,
    "userOpenId": "obdhQ5uhtQaRB6f-MzhkfKsQH0i0",
    "userCouponCode": "zazda2019040217294431029",
    "couponDistributeId": 244,
    "couponUseTime": null,
    "userCouponStatus": "0",
    "couponCode": "SWPia201903011931400",
    "couponName": null,
    "couponTitle": "满减优惠",
    "couponDescribe": "只限此优惠",
    "couponConditionPrice": 400,
    "couponDiscountsPrice": 100,
    "serviceItemId": null,
    "serviceitemName": null,
    "couponType": "1",
    "couponNumber": 12,
    "distributePeopleId": 2222,
    "distributePeopleName": "宜修壹",
    "distributeDate": "2019-04-02 17:28:57.0",
    "distributeStatus": "2",
    "couponStatus": "2",
    "isCarUse": 1,
    "isStoreUse": 0,
    "isTenantUse": 1,
    "couponBeginDate": "2019-03-01",
    "couponEndDate": "2019-04-18",
    "couponDeleteStatus": 0
},
	                       {
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
	                           "carId": 437,
	                           "carVin": null,
	                           "carNo": "云F87321",
	                           "userCarId": 31849,
	                           "carBrandId": "b02162",
	                           "carBrandName": null,
	                           "carSeriesId": null,
	                           "carSeriesName": null,
	                           "carModelId": null,
	                           "carModelName": null,
	                           "lastPatronageCar": 0,
	                           "userCouponId": 148,
	                           "userOpenId": "obdhQ5uhtQaRB6f-MzhkfKsQH0i0",
	                           "userCouponCode": "zazda2019040217294431029",
	                           "couponDistributeId": 245,
	                           "couponUseTime": null,
	                           "userCouponStatus": "0",
	                           "couponCode": "SWPia201903011931400",
	                           "couponName": null,
	                           "couponTitle": "满减优惠",
	                           "couponDescribe": "只限此优惠",
	                           "couponConditionPrice": 400,
	                           "couponDiscountsPrice": 100,
	                           "serviceItemId": null,
	                           "serviceitemName": null,
	                           "couponType": "1",
	                           "couponNumber": 12,
	                           "distributePeopleId": 2222,
	                           "distributePeopleName": "宜修壹",
	                           "distributeDate": "2019-04-02 17:28:57.0",
	                           "distributeStatus": "2",
	                           "couponStatus": "2",
	                           "isCarUse": 1,
	                           "isStoreUse": 0,
	                           "isTenantUse": 1,
	                           "couponBeginDate": "2019-03-01",
	                           "couponEndDate": "2019-04-18",
	                           "couponDeleteStatus": 0
	                       },
	                       {
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
	                           "carId": 437,
	                           "carVin": null,
	                           "carNo": "云F87321",
	                           "userCarId": 31849,
	                           "carBrandId": "b02162",
	                           "carBrandName": null,
	                           "carSeriesId": null,
	                           "carSeriesName": null,
	                           "carModelId": null,
	                           "carModelName": null,
	                           "lastPatronageCar": 0,
	                           "userCouponId": 149,
	                           "userOpenId": "obdhQ5uhtQaRB6f-MzhkfKsQH0i0",
	                           "userCouponCode": "YEODk2019040217294582354",
	                           "couponDistributeId": 246,
	                           "couponUseTime": null,
	                           "userCouponStatus": "0",
	                           "couponCode": "xhzjK201903011935050",
	                           "couponName": null,
	                           "couponTitle": "保养优惠",
	                           "couponDescribe": "优惠劵测试1212",
	                           "couponConditionPrice": null,
	                           "couponDiscountsPrice": 50,
	                           "serviceItemId": 3,
	                           "serviceitemName": "发动机更换",
	                           "couponType": "2",
	                           "couponNumber": 100,
	                           "distributePeopleId": 2222,
	                           "distributePeopleName": "宜修壹",
	                           "distributeDate": "2019-04-02 17:28:58.0",
	                           "distributeStatus": "2",
	                           "couponStatus": "2",
	                           "isCarUse": 1,
	                           "isStoreUse": 1,
	                           "isTenantUse": 0,
	                           "couponBeginDate": "2019-03-01",
	                           "couponEndDate": "2019-04-12",
	                           "couponDeleteStatus": 0
	                       },
	                       {
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
	                           "carId": 437,
	                           "carVin": null,
	                           "carNo": "云F87321",
	                           "userCarId": 31849,
	                           "carBrandId": "b02162",
	                           "carBrandName": null,
	                           "carSeriesId": null,
	                           "carSeriesName": null,
	                           "carModelId": null,
	                           "carModelName": null,
	                           "lastPatronageCar": 0,
	                           "userCouponId": 148,
	                           "userOpenId": "obdhQ5uhtQaRB6f-MzhkfKsQH0i0",
	                           "userCouponCode": "zazda2019040217294431029",
	                           "couponDistributeId": 247,
	                           "couponUseTime": null,
	                           "userCouponStatus": "0",
	                           "couponCode": "SWPia201903011931400",
	                           "couponName": null,
	                           "couponTitle": "满减优惠",
	                           "couponDescribe": "只限此优惠",
	                           "couponConditionPrice": 400,
	                           "couponDiscountsPrice": 100,
	                           "serviceItemId": null,
	                           "serviceitemName": null,
	                           "couponType": "1",
	                           "couponNumber": 12,
	                           "distributePeopleId": 2222,
	                           "distributePeopleName": "宜修壹",
	                           "distributeDate": "2019-04-02 17:28:57.0",
	                           "distributeStatus": "2",
	                           "couponStatus": "2",
	                           "isCarUse": 1,
	                           "isStoreUse": 0,
	                           "isTenantUse": 1,
	                           "couponBeginDate": "2019-03-01",
	                           "couponEndDate": "2019-04-18",
	                           "couponDeleteStatus": 0
	                       },
	                       {
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
	                           "carId": 437,
	                           "carVin": null,
	                           "carNo": "云F87321",
	                           "userCarId": 31849,
	                           "carBrandId": "b02162",
	                           "carBrandName": null,
	                           "carSeriesId": null,
	                           "carSeriesName": null,
	                           "carModelId": null,
	                           "carModelName": null,
	                           "lastPatronageCar": 0,
	                           "userCouponId": 149,
	                           "userOpenId": "obdhQ5uhtQaRB6f-MzhkfKsQH0i0",
	                           "userCouponCode": "YEODk2019040217294582354",
	                           "couponDistributeId": 248,
	                           "couponUseTime": null,
	                           "userCouponStatus": "0",
	                           "couponCode": "xhzjK201903011935050",
	                           "couponName": null,
	                           "couponTitle": "保养优惠",
	                           "couponDescribe": "优惠劵测试1212",
	                           "couponConditionPrice": null,
	                           "couponDiscountsPrice": 50,
	                           "serviceItemId": 3,
	                           "serviceitemName": "发动机更换",
	                           "couponType": "2",
	                           "couponNumber": 100,
	                           "distributePeopleId": 2222,
	                           "distributePeopleName": "宜修壹",
	                           "distributeDate": "2019-04-02 17:28:58.0",
	                           "distributeStatus": "2",
	                           "couponStatus": "2",
	                           "isCarUse": 1,
	                           "isStoreUse": 1,
	                           "isTenantUse": 0,
	                           "couponBeginDate": "2019-03-01",
	                           "couponEndDate": "2019-04-12",
	                           "couponDeleteStatus": 0
	                       }
	 
	                   ];
	/*$(userCouponDataArray).each(function(k,v) {
		  var key = v.couponDistributeId;
		  userCouponDataHash[key] = v;
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
		    '</div>'
		});
		document.getElementById("show").innerHTML = list;*/
	
	//$(".quan-item").prepend(list2);	
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
	if(PrefAmt>-1){
		var amount = parseFloat(netInAmt) - parseFloat(PrefAmt) - parseFloat(deductionAmt);
		zongAmt = amount.toFixed(2);
		document.getElementById('amount').innerHTML = amount.toFixed(2);
	}
	var memAmt = nui.get("rechargeBalaAmt").getValue()||0;
	if(memAmt!=0){
		memAmt = (memAmt.split("￥"))[1];
	}
		
	if(deductible>memAmt){
		showMsg("储值抵扣不能大于储值余额","W");

		return;
	}
	
	if((parseFloat(deductible) + parseFloat(PrefAmt)+ parseFloat(count) + parseFloat(deductionAmt)).toFixed(2)  >netInAmt){
		showMsg("储值抵扣加上优惠金额不能大于应收金额","W");
		return;
	}
	
/*	var amount = parseFloat(netInAmt) - parseFloat(deductible) - parseFloat(PrefAmt)-parseFloat(count);
	amount = amount.toFixed(2);
	document.getElementById('amount').innerHTML = amount.toFixed(2);*/

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
	if(typeUrl==2){
		var PrefAmt = nui.get("PrefAmt").getValue()||0;
		var json = {
				allowanceAmt:PrefAmt,
				serviceId:fserviceId,
				remark:nui.get("txtreceiptcomment").getValue(),
				token:token
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
	}else{
		var PrefAmt = nui.get("PrefAmt").getValue()||0;
		doNoPay(fserviceId,PrefAmt);
	}

}

//结算
function pay(){
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
		
	var deductible = nui.get("deductible").getValue()||0;
	var PrefAmt = nui.get("PrefAmt").getValue()||0;
	
	var amt = scount();
	var json = {
		accountTypeList : accountTypeList,
		allowanceAmt:PrefAmt,
		cardPayAmt:deductible,
		serviceId:fserviceId,
		remark:nui.get("txtreceiptcomment").getValue(),
		payAmt:amt,
		couponList:couponList
	};
    nui.confirm("是否确定结算？", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
	    		nui.ajax({
	    			url : settlementUrl,
	    			type : "post",
	    			data : json,
			        cache : false,
			        contentType : 'text/json',
	    			success : function(data) {
	    				nui.unmask(document.body);
	    				if(data.errCode=="S"){  					
	    					CloseWindow("ok");
	    					if( $("#settlesendwx").is(':checked')== true){
	    						sendWCInfo(fserviceId);//发送微信通知
	    					}
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

function sendWCInfo(serviceId){
	nui.ajax({
		url:sendWCUrl,
		async:false,
		type:"post",
		data:{serviceId:serviceId},
		success:function(res){
			console.log(res);
		}
	})
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
			remark:nui.get("txtreceiptcomment").getValue(),
			couponList:couponList,
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
						nui.unmask(document.body);
						if(data.errCode=="S"){
							CloseWindow("onok");
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
	 //$("#ppaytype"+s1[1]).empty();
	 var myselect=document.getElementById("optaccount"+s1[1]);
	 var index=myselect.selectedIndex;
	 var c  =myselect.options[index].value;
   var json = {
   		accountId:c,
   		token:token
   };
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
var rs = {};
function getRtnData(){
	return rs;
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}


