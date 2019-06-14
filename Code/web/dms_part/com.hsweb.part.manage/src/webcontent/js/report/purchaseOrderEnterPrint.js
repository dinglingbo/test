var date=new Date();
var sumOrderQty=0;
var sumOrderAmt=0;
var brandHash = {};
var brandList = [];
var storehouse = [];
var storeHash={};
var billTypeIdList=[];
var settleTypeIdList=[];
var billTypeIdHash={};
var settleTypeIdHash={};
var dictDefs ={"billTypeIdE":"DDT20130703000008", "settleTypeIdE":"DDT20130703000035"};
var baseUrl = apiPath + partApi + "/";
var supplierUrl=apiPath + partApi + "/"+"com.hsapi.part.baseDataCrud.crud.queryGuestList.biz.ext";
var MainUrl = baseUrl
		+ "com.hsapi.part.invoice.svr.queryPjPchsOrderMainList.biz.ext";
var DetailUrl = baseUrl
		+ "com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
$(document).ready(function(){
	
	$("#print").click(function () {
        $(".print_btn").hide();
         document.getElementById("query-table").style.overflow="hidden"
        window.print();
    }); 
      initDicts(dictDefs, function(){
    	billTypeIdList=nui.get('billTypeIdE').getData();     		
    	settleTypeIdList=nui.get('settleTypeIdE').getData();
    	billTypeIdList.forEach(function(v){
    		billTypeIdHash[v.customid]=v;
    	});
    	settleTypeIdList.forEach(function(v){
    		settleTypeIdHash[v.customid]=v;
    	});
    	
    });
   /* getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		storehouse.forEach(function(v){
		storeHash[v.id]=v;
	});
	});*/
    	
	getAllPartBrand(function(data) {
		brandList = data.brand;
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
	});
	});
     document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
    
});

function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function SetData(mainParams,detailParms){
	getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		storehouse.forEach(function(v){
		storeHash[v.id]=v;
	    });
   
		var imgUrl = mainParams.currCompLogoPath || "";
		if(imgUrl && imgUrl != ""){
		   $('#showImg').show();
		   $("#showImg").attr("src",imgUrl);
		}
		document.getElementById("spstorename").innerHTML = "入库单";
		document.getElementById("guestAddr").innerHTML = "地址:"+mainParams.currCompAddress;
		document.getElementById("phone").innerHTML ="电话:"+mainParams.currCompTel;
		$('#currOrgName').text(mainParams.currRepairSettorderPrintShow||mainParams.currOrgName);
		$('#nowDate').text("打印日期:"+format(date,"yyyy-MM-dd HH:mm"));
		$('#currUserName').text("制单:"+mainParams.currUserName);
		$.ajaxSettings.async = false;
		if(mainParams.id){
			$.post(MainUrl+"?params/id="+mainParams.id+"&params/auditSign="+mainParams.auditSign+"&token="+token,{},function(text){
				var formParms =text.pjPchsOrderMainList[0];
		   		$('#guestFullName').text("供应商:"+formParms.guestFullName);
		   		$('#createDate').text("订单日期:"+format(formParms.createDate,"yyyy-MM-dd HH:mm"));
		   		$('#serviceId').text(formParms.serviceId);
		 		if(billTypeIdHash){
		 			$('#billTypeId').text("票据类型:"+billTypeIdHash[formParms.billTypeId].name);
		 		}
				if(settleTypeIdHash){
					$('#settleTypeId').text("结算方式:"+settleTypeIdHash[formParms.settleTypeId].name);
				}
			});
		}
		if(mainParams.guestId){
			$.post(supplierUrl+"?params/guestId="+mainParams.guestId+"&token="+token,{},function(text){
				var guest=text.guest[0];
				if(guest.contactor){		
					$('#contactor').text("联系人:"+guest.contactor);
				}
				if(guest.contactorTel){
					$('#contactorTel').text("联系人方式:"+guest.contactorTel);
				}
				if(guest.addr){
					$('#addr').text("地址:"+guest.addr);
				}
				
			});
		}
		if(detailParms.mainId && storeHash && brandHash){
			$.post(DetailUrl+"?params/mainId="+detailParms.mainId+"&token="+token,{},function(text){
				var data= text.pjPchsOrderDetailList;
				var tBody = $("#tbodyId");
				tBody.empty();
				var tds='<td align="center">[index]</td>'+
						'<td align="left">[comPartCode]</td>'+
						'<td align="center">[comOemCode]</td>'+
						'<td align="left">[comPartName]</td>'+
						'<td align="center">[comPartBrindId]</td>'+
						'<td id="CarModel"align="center">[comApplyCarModel]</td>'+
						'<td align="center">[comSpec]</td>'+		  			
						'<td align="center">[comUnit]</td>'+
						'<td align="center">[orderQty]</td>'+
						'<td align="center">[orderPrice]</td>'+
						'<td align="center">[orderAmt]</td>'+
						'<td align="center">[storehouse]</td>'+
						'<td align="center">[storeShelf]</td>'+
						'<td align="center">[remark]</td>';
					for(var i = 0; i < data.length; i++ ){ 
						var tr=$("<tr></tr>");
						if(brandHash[data[i].comPartBrandId]){
							tr.append(
							tds.replace("[index]",i+1 ||"")
								.replace("[comPartCode]",data[i].comPartCode ||"")
								.replace("[comOemCode]",data[i].comOemCode ||"")
								.replace("[comPartName]",data[i].comPartName ||"")
								.replace("[comPartBrindId]",data[i].comPartBrandId?brandHash[data[i].comPartBrandId].name :"")
								.replace("[comApplyCarModel]",data[i].comApplyCarModel ||"")
								.replace("[comSpec]",data[i].comSpec ||"")
								.replace("[comUnit]",data[i].comUnit ||"")
								.replace("[orderQty]",data[i].orderQty ||0)
								.replace("[orderPrice]",data[i].orderPrice ||0)
								.replace("[orderAmt]",data[i].orderAmt ||0)
								.replace("[storehouse]",data[i].storeId?storeHash[data[i].storeId].name :"")
								.replace("[storeShelf]",data[i].storeShelf ||"")
								.replace("[remark]",data[i].remark ||""));
						}else{
							tr.append(
							tds.replace("[index]",i+1 ||"")
								.replace("[comPartCode]",data[i].comPartCode ||"")
								.replace("[comOemCode]",data[i].comOemCode ||"")
								.replace("[comPartName]",data[i].comPartName ||"")
								.replace("[comPartBrindId]",data[i].comPartBrandId || "")
								.replace("[comApplyCarModel]",data[i].comApplyCarModel ||"")
								.replace("[comSpec]",data[i].comSpec ||"")
								.replace("[comUnit]",data[i].comUnit ||"")
								.replace("[orderQty]",data[i].orderQty ||0)
								.replace("[orderPrice]",data[i].orderPrice ||0)
								.replace("[orderAmt]",data[i].orderAmt ||0)
								.replace("[storehouse]",data[i].storeId?storeHash[data[i].storeId].name :"")
								.replace("[storeShelf]",data[i].storeShelf ||"")
								.replace("[remark]",data[i].remark ||""));
						}
						
						tBody.append(tr);
						sumOrderQty +=parseFloat(data[i].orderQty);
						sumOrderAmt +=parseFloat(data[i].orderAmt);
					}
					var sum=transform(parseFloat(sumOrderAmt).toFixed(1)+"");
					$('#sumOrderQty').text("合计:"+parseFloat(sumOrderQty).toFixed(1));
					$('#sumOrderAmt').text(""+parseFloat(sumOrderAmt).toFixed(1));
					$('#sum').text("合计:"+sum);
					setTimeout(function(){
				    	$(".print_btn").hide();
			            document.getElementById("query-table").style.overflow="hidden"
			            window.print();
				    },100);
			});
		  }
	});
}