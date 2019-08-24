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
	document.getElementById('popbox_1').style.display='block';
	var saveComTenantOrderUrl = apiPath + sysApi + "/com.hsapi.system.tenant.carCoin.saveComTenantOrder.biz.ext";
	//赋值线上订单
	var comTenantOrder = {};
	comTenantOrder.productName = "充值链车币";
	comTenantOrder.productAmt = sellCarCoin.sellAmt;
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
					//关闭支付，打开倒计时
					document.getElementById('popbox_1').style.display='none';
					document.getElementById('popbox_2').style.display='block';
					t1 = window.setInterval(daoTime,1000); 
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
		document.getElementById('remainingCoin').innerHTML=20;
		
	}
}