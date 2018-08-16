var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm=null;
var accountTypeList=null;
var accountTypeIdEl = null;
var gusetId=null;
var member=null;
var birthday=null;
var sex=null;
var rechargeBalaAmt=null;
$(document).ready(function(){
	var accountTypeIdEl = null;
	accountTypeIdEl=nui.get('radio');
	accountTypeList=[{id:1,name:"现金"},{id:2,name:"刷卡"},{id:3,name:"微信/支付宝"}];
	accountTypeIdEl.setData(accountTypeList);
	
	
	
});
//function onCard(){
//	document.getElementById('table').style.display='block';
//}

function SetData(params) {
    basicInfoForm = new nui.Form("#basicInfoForm");
    gusetId=params.data.guestId;
    basicInfoForm.setData(params.data);
    getCard(gusetId);
}
var url=baseUrl+"com.hsapi.repair.baseData.query.queryMemberByGuestId.biz.ext";
function initData(gusetId){
	var guestId=gusetId;
	nui.ajax({
		url:url,
		async:false,
		data:{		
			token:token,
			guestId:guestId
		},
		type:'post',
		success: function(data){
			 member=data.member;
			birthday=member[0].birthday;
			 sex=member[0].sex;
			 cardNo=member[0].carNo;
			rechargeBalaAmt=member[0].rechargeBalaAmt;
			
		},
		error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，保存失败");           
        }
	});
	basicInfoForm.setData(birthday);
	basicInfoForm.setData(sex);
}
 var url2=baseUrl+"com.hsapi.repair.baseData.query.queryCardTimesByGuestId.biz.ext";
 function getCard(gusetId){
	 var guestId=gusetId;
	 nui.ajax({
			url:url,
			async:false,
			data:{		
				token:token,
				guestId:guestId
			},
			type:'post',
			success: function(data){
				if(data.errCode =="S"){
					var cardId=data.cardId;
					
				}
				alert(1);
				
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert(2);
	            nui.unmask();
	            console.log(jqXHR.responseText);
	            nui.alert("网络出错，保存失败");           
	        }
		});
 }
$(function(){
	 $("#up").change(function(){
		 var text = nui.get('up').getValue();
	$("#message").html("到账金额"+text+"元");
});


});