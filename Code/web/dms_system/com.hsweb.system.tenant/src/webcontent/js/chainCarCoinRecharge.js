var carCoin = [];//全部链车币

$(document).ready(function(v) {
	loadCarCoin();

	nui.alert(type);
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
    	}
    }
    $(".cztc a").removeClass("xz");
    $("#"+id).addClass("xz");
    $("#" + id).show();
    $("#paymoney").text((money == undefined ? "0.0" : money) + "元");

    $(".btn").attr("itemid", id);
}