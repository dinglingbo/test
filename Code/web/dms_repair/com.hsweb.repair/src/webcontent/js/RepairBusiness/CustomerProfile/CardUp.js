var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm=null;
var accountTypeList=null;
var accountTypeIdEl = null;
var cardId=null;
var name=null;
$(document).ready(function(){
	var accountTypeIdEl = null;
	accountTypeIdEl=nui.get('radio');
	accountTypeList=[{id:1,name:"现金"},{id:2,name:"刷卡"},{id:3,name:"微信/支付宝"}];
	accountTypeIdEl.setData(accountTypeList);
	
	getCard();
	
});
//function onCard(){
//	document.getElementById('table').style.display='block';
//}

function SetData(params) {
    basicInfoForm = new nui.Form("#basicInfoForm");
    gusetId=params.data.guestId;
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
			gusetId:guestId
		},
		type:'post',
		success: function(data){
			var cardList=data.cardStoreds;
			if(cardList && cardList.length>0){
				var htmlStr="";
				for(var i=0;i<cardList.length;i++){
					var cardObj=cardList[i];
//					var cardId=carObj.id;
					var name=cardObj.name;
					s="<a href='' name='card'id=''>"+name+"</a>";
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
    });
}
 
$(function(){
	 $("#up").change(function(){
		 var text = nui.get('up').getValue();
	$("#message").html("到账金额"+text+"元");
});


});