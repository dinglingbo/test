var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var payType=0;

$(document).ready(function(){
	var accountTypeIdEl = null;
	accountTypeIdEl=nui.get('radio');
	accountTypeList=[{id:1,name:"现金"},{id:2,name:"刷卡"},{id:3,name:"微信/支付宝"}];
	accountTypeIdEl.setData(accountTypeList);
	var basicInfoForm=null;
	var accountTypeList=null;
	var accountTypeIdEl = null;
	var guestId=null;
	var guestName=null;
	var cardId=null;
	var cardObj=null;
	var name=null;
	var itemRate=null;
	var packageRate=null;
	var partRate=null;
	var giveAmt=null;
	var giveAmt=null;
	var totalAmt=null;
	var canModify=null;
	var rechargeAmt=null;
	var radio=null;
	var text=null;

	getCard();
	
});
//function onCard(){
//	document.getElementById('table').style.display='block';
//}

function SetData(params) {
    basicInfoForm = new nui.Form("#basicInfoForm");
    guestId=params.data.guestId;
    guestName=params.data.guestFullName;
    basicInfoForm.setData(params.data);
    console.log(basicInfoForm);

}
var url=baseUrl+"com.hsapi.repair.baseData.query.queryCardstored.biz.ext";
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
					s="<a href='javascript:;' name='card'id='card'>"+name+"</a>";
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
					if(name==text){
						name=text;
						cardId=cardObj.id;
						itemRate=cardObj.itemRate;
						packageRate=cardObj.packageRate;
						partRate=cardObj.partRate;
						giveAmt=cardObj.giveAmt;
						totalAmt=cardObj.totalAmt;
						canModify=cardObj.canModify;
						rechargeAmt=cardObj.rechargeAmt;
						nui.get('itemRate').setValue(itemRate);
						nui.get('packageRate').setValue(packageRate);
						nui.get('partRate').setValue(partRate);
						nui.get('giveAmt').setValue(giveAmt);
						nui.get('rechargeAmt').setValue(rechargeAmt);
						nui.get('totalAmt').setValue(totalAmt);
						if(canModify==0){
							$('table#table input').attr("disabled",true);
							showMsg("此卡不可修改");
						}
						else{
							$('table#table input').attr("disabled",false);
							showMsg("此卡可修改");
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
	if(payType==0){
		showMsg("请选择支付方式");
		return;
	}
	var stored=[];
	name=text;
	var payAmt=rechargeAmt;
	var form={
			cardId		: cardId,
			cardName	: name,
			giveAmt		: giveAmt,
			guestId		: guestId,
			guestName	: guestName,	
			itemRate	: itemRate,		
			packageRate	: packageRate,	
			partRate	: partRate,
			rechargeAmt	: rechargeAmt,
			totalAmt 	: totalAmt
	};
	stored.push(form);
	nui.mask({
		el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
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
				showMsg("保存成功!","S");			
			}else{
				showMsg(data.errMsg || "保存失败!","W");
			}
		},
		error : function(jqXHR,textStatus,errorThrown){
			console.log(jqXHR.responseText);
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


$ (function(){
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
});

