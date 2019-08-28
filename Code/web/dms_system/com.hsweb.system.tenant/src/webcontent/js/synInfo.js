$(document).ready(function(v) {
	queryTenantCoin();
	queryUpgrade();
	querySysProduct();
});

//查询租户信息
function queryTenantCoin(){
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
				document.getElementById('code').innerHTML=data.comTenant.code||"";
				document.getElementById('tenantName').innerHTML=data.comTenant.tenantName||"";
				var endDate = data.comTenant.endDate;
				document.getElementById('endDate').innerHTML=new Date(endDate).getFullYear()+"年 "+(parseFloat(new Date(endDate).getMonth())+1)+"月 "+new Date(endDate).getDate()+"日";
				//计算剩余天数
				var endDay = DateMinus(data.comTenant.endDate);
				if(endDay>0){					
					document.getElementById('endDay').innerHTML=endDay;	
				}else{
					document.getElementById('endDay').innerHTML=0;	
				}
				document.getElementById('auditMan').innerHTML=data.comTenant.auditMan||"";
				document.getElementById('mobile').innerHTML=data.comTenant.mobile||"";
				document.getElementById('storesQty').innerHTML=data.comTenant.storesQty||0;				
			} else {
				parent.showMsg(data.errMsg || "商户查询异常!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

var basisList = [{id:"",name:"微信模块"},{id:"",name:"客户模块"},{id:"",name:"EPC"}];//基础模块
//查询基础模块
function queryUpgrade(){
	var html="";
	for(var i=0;i<basisList.length;i++){
		html+='		<a class="have" id="'+basisList[i].id+'">&nbsp;'+basisList[i].name+'&nbsp;</a> ';
	}	
	document.getElementById('basis').innerHTML=html;
}
//查询升级模块
function querySysProduct(){
	var querySysProductUrl = apiPath + sysApi + "/com.hsapi.system.tenant.product.querySysProduct.biz.ext";
	nui.ajax({
		url : querySysProductUrl,
		type : "post",
		data : JSON.stringify({
			params : {
				isDisabled : 0
			},
			token: token
		}),
		success : function(data) {
			data = data || {};
			if (data.errCode == "S") {
				var ProductList = data.list;
				var querySysProductUrl = apiPath + sysApi + "/com.hsapi.system.tenant.product.queryTenantProduct.biz.ext";				
				nui.ajax({
					url : querySysProductUrl,
					type : "post",
					data : JSON.stringify({
						params : {
							status: 0,
							tenantId : currTenantId
						},
						token: token
					}),
					success : function(text) {
						text = text || {};
						if (text.errCode == "S") {
							var html="";
							for(var i=0;i<ProductList.length;i++){
								var isPermissions = true;
								for(var j=0;j<text.comTenantProduct.length;j++){
									if(ProductList[i].id==text.comTenantProduct[j].productId){
										isPermissions = false;
										html+='		<a class="have" id="'+data.list[i].id+'">&nbsp;'+data.list[i].name+'&nbsp;</a> ';
									}
								}
								if(isPermissions){	
									isPermissions = true;
									html+='		<a class="noHave" id="'+data.list[i].id+'">&nbsp;'+data.list[i].name+'&nbsp;</a> ';
								}
							}	
							document.getElementById('upgrade').innerHTML=html;
						} else {
							parent.showMsg(data.errMsg || "商户查询异常!","E");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						// nui.alert(jqXHR.responseText);
						console.log(jqXHR.responseText);
					}
				});
			} else {
				parent.showMsg(data.errMsg || "商户查询异常!","E");
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