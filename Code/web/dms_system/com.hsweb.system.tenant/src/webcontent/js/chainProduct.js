var product = {};//充值的产品
var sellCarCoinId = null;
$(document).ready(function(v) {
	//loadCarCoin(2);
});


function loadCarCoin(productId){
	var queryCarCoinUrl = apiPath + sysApi + "/com.hsapi.system.tenant.product.querySysProduct.biz.ext";
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});

	nui.ajax({
		url : queryCarCoinUrl,
		type : "post",
		data : JSON.stringify({
			params : {"id":productId},
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			carCoin = data.carCoin;
			if (data.errCode == "S") {		
				if(data.list.length>0){				
					product = data.list[0]
					document.getElementById('name').innerHTML=product.name||"";
					document.getElementById('periodValidity').innerHTML=product.periodValidity||0;
					document.getElementById('remark').innerHTML=product.remark||"";
					document.getElementById('sellPrice').innerHTML=product.sellPrice||0;
					queryTenantProduct();
				}
			} else {
				parent.showMsg(data.errMsg || "加载失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}


function sellCoin(){
	document.getElementById('popbox_1').style.display='block';
	var saveComTenantOrderUrl = apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.saveComTenantOrder.biz.ext";
	//赋值线上订单
	var comTenantOrder = {};
	comTenantOrder.productName = product.name;
	comTenantOrder.productAmt = product.sellPrice;
	comTenantOrder.type = 0;
	comTenantOrder.productId = product.id;
	comTenantOrder.periodValidity = product.periodValidity;	
	nui.ajax({
		url : saveComTenantOrderUrl,
		type : "post",
		data : JSON.stringify({
			comTenantOrder : comTenantOrder,
			token: token
		}),
		success : function(data) {
			data = data || {};
			carCoin = data.carCoin;
			if (data.errCode == "S") {
				sellCarCoinId = data.comTenantOrder.id;
				validation();
			} else {
				parent.showMsg(data.errMsg || "生成失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var t1;
var t2;//计时器
//验证是否已付款
function validation(){ 
	//重复执行验证方法 
	 t1 = window.setInterval(validationPost,5000); 
	//去掉定时器的方法 
	//window.clearInterval(t1);
	//alert("hello"); 
} 
function validationPost(){
	var queryComTenantOrderUrl = apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.queryComTenantOrder.biz.ext";
	//赋值线上订单
	nui.ajax({
		url : queryComTenantOrderUrl,
		type : "post",
		data : JSON.stringify({
			id : sellCarCoinId,
			token: token
		}),
		success : function(data) {
			data = data || {};
			if (data.errCode == "S") {
				if(data.comTenantOder.isPayment==1){
					//去掉定时器的方法 
					window.clearInterval(t1);
					var weChatBCoinUrl = apiPath + sysApi + "/com.hsapi.system.tenant.product.weChatProduct.biz.ext";
					//充值成功后
					nui.ajax({
						url : weChatBCoinUrl,
						type : "post",
						data : JSON.stringify({
							params : {id:data.comTenantOder.id},
							token: token
						}),
						success : function(data) {
							data = data || {};
							if (data.errCode == "S") {	
									queryTenantProduct();
									//关闭支付，打开倒计时
									document.getElementById('popbox_1').style.display='none';
									document.getElementById('popbox_2').style.display='block';
									t1 = window.setInterval(daoTime,1000); 
							} else {
								parent.showMsg(data.errMsg || "订单异常!","E");
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							// nui.alert(jqXHR.responseText);
							console.log(jqXHR.responseText);
						}
					});
				}
			} else {
				parent.showMsg(data.errMsg || "订单异常!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
function onclosePopbox_1(){
	document.getElementById('popbox_1').style.display='none';
	//关掉计时器
	window.clearInterval(t1);
}
function onclosePopbox_2(){
	document.getElementById('popbox_2').style.display='none';
	//关掉计时器
	window.clearInterval(t2);
}
var dindex = 5;
function daoTime(){
	if(dindex>0){
		document.getElementById('dtime').innerHTML=dindex;
		dindex--;
	}else{
		document.getElementById('popbox_2').style.display='none';
		//关掉计时器
		window.clearInterval(t2);
		
	}
}

//查询剩余天数
function queryTenantProduct(){
	var queryTenantProductUrl = apiPath + sysApi + "/com.hsapi.system.tenant.product.queryTenantProduct.biz.ext";
	nui.ajax({
		url : queryTenantProductUrl,
		type : "post",
		data : JSON.stringify({
			params:{"productId":product.id},
			token: token
		}),
		success : function(data) {
			data = data || {};
			if (data.errCode == "S") {		
				var comTenantProduct = data.comTenantProduct[0];
				var endDate = comTenantProduct.endDate;
				document.getElementById('endDate').innerHTML=new Date(endDate).getFullYear()+"年 "+(parseFloat(new Date(endDate).getMonth())+1)+"月 "+new Date(endDate).getDate()+"日";
				//计算剩余天数
				var endDay = DateMinus(comTenantProduct.endDate);
				document.getElementById('endDay').innerHTML=endDay;
			} else {
				parent.showMsg(data.errMsg || "到期日期查询异常!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

//计算日期相减天数 
function DateMinus(sDate){ 
   var sdate = new Date(sDate.replace(/-/g, "/")); 
   var now = new Date(); 
   var days = sdate.getTime()-now.getTime();
   var day = parseInt(days / (1000 * 60 * 60 * 24)); 
  return day; 
}