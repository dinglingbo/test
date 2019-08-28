var carCoin = [];//全部链车币
var sellCarCoin = {};//支付的链车币
var sellCarCoinId = null;
$(document).ready(function(v) {
	loadCarCoin();
});


function loadCarCoin(){
	var queryCarCoinUrl = apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.queryCarCoin.biz.ext";
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});

	nui.ajax({
		url : queryCarCoinUrl,
		type : "post",
		data : JSON.stringify({
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			carCoin = data.carCoin;
			if (data.errCode == "S") {
				//查询剩余链车币
				queryCoin();
				for(var i = 0;i<data.carCoin.length;i++){
					for(var j = 0;j<data.carCoin.length;j++){
						if(data.carCoin[j].orderIndex==i&&data.carCoin[j].isDisabled==0){
							addDiv(data.carCoin[j]);
						}
					}
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
var index = 1;
//生成 div
function addDiv(carCoin){
	var html="";
	//是否赠送
	if(carCoin.giveCoin>0){		
		html+='<a  href="#"  id="'+carCoin.id+'" itemmoney="'+carCoin.sellPrice+'" onclick="selectCoin('+carCoin.id+')">';		
		html+='		¥<font>'+carCoin.sellPrice+'</font> ';
		html+='		<p>充值'+carCoin.rechargeCoin+'个送'+carCoin.giveCoin+'个</p>';
		html+='	</a> ';
	}else{
		html+='<a  href="#"  id="'+carCoin.id+'" itemmoney="'+carCoin.sellPrice+'" onclick="selectCoin('+carCoin.id+')">';		
		html+='		¥<font>'+carCoin.sellPrice+'</font> ';
		html+='		<p>充值'+carCoin.rechargeCoin+'个</p>';
		html+='	</a> ';
	}
	index++;
	$("#demo").append(html);
}

function selectCoin(id){
	var money = 0;
    for(var i = 0;i<carCoin.length;i++){
    	if(carCoin[i].id==id){
    		money = carCoin[i].sellPrice;  
    		sellCarCoin = carCoin[i];//赋值选中的链车币，也就是要支付的链车币
    	}
    }
    $(".cztc a").removeClass("xz");
    $("#"+id).addClass("xz");
    $("#" + id).show();
    $("#paymoney").text((money == undefined ? "0.0" : money) + "元");

    $(".btn").attr("itemid", id);
}

function sellCoin(){
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});
	var saveComTenantOrderUrl = apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.saveComTenantOrder.biz.ext";
	//赋值线上订单
	var comTenantOrder = {};
	comTenantOrder.productId = 0;//链车币产品ID为0
	comTenantOrder.productName = "链车币充值";
	comTenantOrder.productAmt = sellCarCoin.sellPrice;
	comTenantOrder.rechargeCoin = sellCarCoin.rechargeCoin;
	comTenantOrder.giveCoin = sellCarCoin.giveCoin;
	comTenantOrder.type = 1;
	nui.ajax({
		url : saveComTenantOrderUrl,
		type : "post",
		data : JSON.stringify({
			comTenantOrder : comTenantOrder,
			token: token
		}),
		success : function(data) {
			data = data || {};
			if (data.errCode == "S") {
				var returnComTenantOrder = data.comTenantOrder;
				serviceId = returnComTenantOrder.serviceId;
				var generatePayCodeUrl = apiPath + sysApi + "/com.hsapi.system.tenant.order.generatePayCode.biz.ext";
				var m = new Date();
				var n = new Date(m.getTime() + 1000 * 600);
				nui.ajax({
					url : generatePayCodeUrl,
					type : "post",
					data : JSON.stringify({
						productId : returnComTenantOrder.productId,
						sellPrice : returnComTenantOrder.productAmt,
						serviceId : returnComTenantOrder.serviceId,
						bodyDes : "链车币充值",
						timeStart:format(now,'yyyyMMddHHmmss'),
						timeExpire:format(n, 'yyyyMMddHHmmss'),
						width : 250,
						height : 180,
						token: token
					}),
					success : function(data) {
						data = data || {};
						nui.unmask(document.body);
						if (data.errCode == "S") {
							var imgUrl = data.imgUrl;
							document.getElementById('popbox_1').style.display='block';
							document.getElementById('sellImg').src=imgUrl;	
							document.getElementById('payqrcodemoney').innerHTML=returnComTenantOrder.productAmt;							
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
			} else {
				nui.unmask(document.body);
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
	var queryComTenantOrderUrl = apiPath + sysApi + "/com.hsapi.system.tenant.order.getPayState.biz.ext";
	//赋值线上订单
	nui.ajax({
		url : queryComTenantOrderUrl,
		type : "post",
		data : JSON.stringify({
			serviceId : serviceId,
			token: token
		}),
		success : function(data) {
			data = data || {};
				var tradeState = data.data.data.tradeState;
				if(tradeState=="SUCCESS"){
					//去掉定时器的方法 
					window.clearInterval(t1);
					var weChatBCoinUrl = apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.weChatBCoin.biz.ext";
					//充值成功后
					nui.ajax({
						url : weChatBCoinUrl,
						type : "post",
						data : JSON.stringify({
							params : {"serviceId":serviceId},
							token: token
						}),
						success : function(data) {
							data = data || {};
							if (data.errCode == "S") {	
									queryCoin();
									//关闭支付，打开倒计时
									document.getElementById('popbox_1').style.display='none';
									document.getElementById('popbox_2').style.display='block';
									t1 = window.setInterval(daoTime,1000); 
							} else {
								document.getElementById('popbox_1').style.display='none';
								parent.showMsg(data.errMsg || "订单异常!","E");
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							// nui.alert(jqXHR.responseText);
							console.log(jqXHR.responseText);
						}
					});
				}else if(tradeState=="CLOSED"||tradeState=="PAYERROR"){
					//去掉定时器的方法 
					window.clearInterval(t1);
					document.getElementById('popbox_1').style.display='none';
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
var dindex = 4;
function daoTime(){
	if(dindex>0){
		document.getElementById('dtime').innerHTML=dindex;
		dindex--;
	}else{
		document.getElementById('popbox_2').style.display='none';
		//关掉计时器
		window.clearInterval(t2);
		//查询剩余链车币
		
	}
}

//查询剩余链车币 
function queryCoin(){
	var queryTenantCoinUrl = apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.queryTenantCoin.biz.ext";
	nui.ajax({
		url : queryTenantCoinUrl,
		type : "post",
		data : JSON.stringify({
			token: token
		}),
		success : function(data) {
			data = data || {};
			if (data.errCode == "S") {																		
				document.getElementById('remainingCoin').innerHTML=data.comTenant.remainCoin;
			} else {
				parent.showMsg(data.errMsg || "剩余链车币查询异常!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

function toSysCoinRecord(){
    var item={};
    item.id = "sysCoinRecord";
    item.text = "充值消费记录";
    item.url = webPath + contextPath + "/com.hsweb.system.tenant.sysCoinRecord.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    var params = {
        	id: ''
        };
    window.parent.activeTab(item);
}