var baseUrl = apiPath + repairApi + "/";
var payType=0;

var basicInfoForm=null;
var accountTypeList=null;
var accountTypeIdEl = null;
var guestId=null;
var guestName=null;
var cardId=null;
var cardObj=null;
var name=null;
//var itemRate=null;
//var packageRate=null;
//var partRate=null;
var giveAmt=null;
var totalAmt=null;
var canModify=null;
var rechargeAmt=null;
var radio=null;
var text=null;
var id=null;
var periodValidity = -1;

$(document).ready(function(){
	basicInfoForm = new nui.Form("#basicInfoForm");
	var accountTypeIdEl = null;
/*	accountTypeIdEl=nui.get('radio');
	accountTypeList=[{id:1,name:"现金"},{id:2,name:"刷卡"},{id:3,name:"微信/支付宝"}];
	accountTypeIdEl.setData(accountTypeList);*/
	getCard();
	nui.get('guestFullName').focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
	 };
	 
	
});
//function onCard(){
//	document.getElementById('table').style.display='block';
//}

function SetData(params) {
    var params = nui.clone(params);
    if(params.data!=null){
        guestId=params.data.guestId;
        guestName=params.data.guestFullName;
        params.data.mobile=params.data.guestMobile;
        basicInfoForm.setData(params.data);
    }


}
var url=baseUrl+"com.hsapi.repair.baseData.query.queryCardstoredList.biz.ext";
function getCard(){
	nui.ajax({
		url:url,
		async:false,
		data:{		
			token:token,
		},
		type:'post',
		success: function(data){
			var cardList=data.cardStoreds;
			if(cardList && cardList.length>0){ 
				var htmlStr="";
				for(var i=0;i<cardList.length;i++){
					var cardObj=cardList[i];
					var name=cardObj.name;
					s="<a href='javascript:;' name='card'id='"+cardObj.id+"' >"+name+"</a>";
					htmlStr +=s;
				}
				$(".addyytime").html(htmlStr);
				 selectclick();
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，保存失败");           
        }
	});

}
function selectclick() {
    $("a[name=card]").click(function () {
        $(this).siblings().removeClass("xz");
        $(this).toggleClass("xz");
        text=$(this).text();
        id=$(this).attr("id");
        onCard(text);
    });
}

//赋卡的数据到表单
function onCard(text){
	var text=text;
	nui.ajax({
		url:url,
		async:false,
		data:{		
			token:token,
			gusetId:guestId
		},
		type:'post',
		success: function(data){
			var cardList=data.cardStoreds;
			if(cardList && cardList.length>0){
			
				for(var i=0;i<cardList.length;i++){
					cardObj=cardList[i];		
					name=cardObj.name;
					var cardId1=cardObj.id;
					if(id==cardId1){
						name=text;
						cardId=cardObj.id;
//						itemRate=cardObj.itemRate;
//						packageRate=cardObj.packageRate;
//						partRate=cardObj.partRate;
						giveAmt=cardObj.giveAmt;
						totalAmt=cardObj.totalAmt;
						canModify=cardObj.canModify;
						rechargeAmt=cardObj.rechargeAmt;
						periodValidity=cardObj.periodValidity;
//						nui.get('itemRate').setValue(itemRate);
//						nui.get('packageRate').setValue(packageRate);
//						nui.get('partRate').setValue(partRate);
						nui.get('giveAmt').setValue(giveAmt);
						nui.get('rechargeAmt').setValue(rechargeAmt);
						nui.get('totalAmt').setValue(totalAmt);
						if(canModify==0){
							$('table#table input').attr("disabled",true);
							showMsg("此卡不可修改",W);
						}
						else{
							$('table#table input').attr("disabled",false);
							showMsg("此卡可修改",S);
						}
					}
					
				}

			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，保存失败");           
        }
	});

}
//确认支付
var payurl=baseUrl+"com.hsapi.repair.repairService.settlement.rechargeReceive.biz.ext";
function pay(){
	name=text;
	var payAmt=rechargeAmt;
	var stored={
			cardId		: cardId,
			cardName	: name,
			giveAmt		: giveAmt,
			guestId		: guestId,
			guestName	: guestName,	
//			itemRate	: itemRate,		
//			packageRate	: packageRate,	
//			partRate	: partRate,
			rechargeAmt	: rechargeAmt,
			totalAmt 	: totalAmt,
			balaAmt		: totalAmt,
			periodValidity : periodValidity,
			sellAmt :rechargeAmt,	
			settlementUrl:2//跳转结算界面的类型，储值卡
	};
	
    //打开储值卡计次卡结算界面
	nui.open({
        url: webPath + contextPath +"/com.hsweb.frm.manage.cardSettlement.flow?token="+token,
         width: "100%", height: "100%", 
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(stored);
        },
		ondestroy : function(action) {// 弹出页面关闭前
			if (action == "saveSuccess") {
				showMsg("结算成功!", "S");
			}
		}
    });
/*    nui.confirm("结算金额【"+payAmt+"】元,确定结算吗？", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
				nui.ajax({
					url:payurl,
					type:"post",
					data :JSON.stringify({
						payAmt :payAmt,
						payType:payType,
						stored: stored[0],
						token:token
					}),
					success: function(data){
						nui.unmask(document.body);
						if(data.errCode =='S'){
							CloseWindow("saveSuccess");
							showMsg("支付成功!","S");
						}else{
							showMsg(data.errMsg || "支付失败!","W");
						}
					},
					error : function(jqXHR,textStatus,errorThrown){
						console.log(jqXHR.responseText);
					}
				});		
	     }else {
				return;
		 }
		 });*/

}

//待支付
var noPayurl=baseUrl+"com.hsapi.repair.repairService.settlement.preSettleRecharge.biz.ext";
function noPay(){
	var stored=[];
	name=text;
	var payAmt=rechargeAmt;
	var form={
			cardId		: cardId,
			cardName	: name,
			giveAmt		: giveAmt,
			guestId		: guestId,
			guestName	: guestName,	
//			itemRate	: itemRate,		
//			packageRate	: packageRate,	
//			partRate	: partRate,
			rechargeAmt	: rechargeAmt,
			totalAmt 	: totalAmt,
			periodValidity : periodValidity,
			balaAmt : totalAmt
	};
	stored.push(form);
    nui.confirm("结算金额【"+payAmt+"】元,确定保存进入待结算吗？", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
				nui.ajax({
					url:noPayurl,
					type:"post",
					data :JSON.stringify({
						stored: stored[0],
						token:token
					}),
					success: function(data){
						nui.unmask(document.body);
						if(data.errCode =='S'){
							CloseWindow("saveSuccess");
							showMsg("转待支付成功!","S");
							
							
						}else{
							showMsg(data.errMsg || "转待支付失败失败!","W");
						}
					},
					error : function(jqXHR,textStatus,errorThrown){
						console.log(jqXHR.responseText);
					}
				});		
	     }else {
				return;
		 }
		 });

}

//充值金额或赠送金额改变时总金额改变
$(function(){
	 $("#rechargeAmt").change(function(){
		 var text = nui.get('rechargeAmt').getValue();
		 var text2=nui.get('#giveAmt').getValue();
		 var num1=  Number(text);
		 var num2=Number(text2);
		 var num=num1+num2;
		 nui.get('totalAmt').setValue(num);
}); 
	 $("#giveAmt").change(function(){
		 var text = nui.get('rechargeAmt').getValue();
		 var text2=nui.get('#giveAmt').getValue();
		 var num1=  Number(text);
		 var num2=Number(text2);
		 var num=num1+num2;
		 nui.get('totalAmt').setValue(num);
}); 
});


/*$ (function(){
	$('#radio').click(function(){
		radio=$('input:radio:checked').val();
		switch(radio){
		//现金
		case "1":
			payType="020101";
			break;
		//刷卡
		case "2":
			payType="020102";
			break;
		//微信/支付宝
		case "3":
			payType="020104";	
			break;
		}
	});
});*/

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function selectCustomer() {
    openCustomerWindow(function (v) {
       var main = {};
        main.guestId = v.guestId;
        main.guestFullName = v.guestFullName;
        main.mobile = v.guestMobile;
        mini.get("guestFullName").setText(v.guestFullName);
        guestId=v.guestId;
        guestName=v.guestFullName;
        basicInfoForm.setData(main);
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

//取消
function onCancel() {
	CloseWindow("cancel");
}
