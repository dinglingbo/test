/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = apiPath + repairApi + "/";
var form = null;
var card={};
var printGuest = {};
var tureRefundAmt = 0;//实际能退金额
$(document).ready(function(v) {
	form = new nui.Form("#dataform1");
   

});

function setData(params){
	printGuest = params.printGuest;
	card = params.row;
	form.setData(params.row||{});
	nui.get("guestName").disable();
	nui.get("cardName").disable();
	nui.get("balaAmt").disable();
	nui.get("rechargeAmt").disable();
	nui.get("giveAmt").disable();
	nui.get("trefundAmt").disable();
	nui.get("refundAmt").disable();
	if(card.refundAmt>0){
		tureRefundAmt = parseFloat(card.balaAmt);
	}else{		
		tureRefundAmt = (parseFloat(card.balaAmt)-parseFloat(card.giveAmt)).toFixed(2);//计算最多能退金额
	}
}

function onrefundAmt(){
	var yrefundAmt = parseFloat(nui.get("yrefundAmt").getValue());
	if(yrefundAmt>tureRefundAmt){
		parent.showMsg("最大退款金额："+tureRefundAmt+",请确认！","W");
		return;
	}else{
		if(card.refundAmt>0){
			var trefundAmt = (parseFloat(card.balaAmt)-parseFloat(yrefundAmt)).toFixed(2);//计算退款后剩余金额
			nui.get("trefundAmt").setValue(trefundAmt);
		}else{		
			var trefundAmt = (parseFloat(card.balaAmt)-parseFloat(yrefundAmt)-parseFloat(card.giveAmt)).toFixed(2);//计算退款后剩余金额
			nui.get("trefundAmt").setValue(trefundAmt);
		}

	}
}


function CloseWindow(action) {
	if (action == "close") {
	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function onClose(){
	window.CloseOwnerWindow();	
}

function refundAmtPay(){
	var yrefundAmt = parseFloat(nui.get("yrefundAmt").getValue());
	if(yrefundAmt>tureRefundAmt){
		parent.showMsg("最大退款金额："+tureRefundAmt+",请确认！","W");
		return;
	}else{
		var trefundAmt = (parseFloat(card.balaAmt)-parseFloat(refundAmt)-parseFloat(card.giveAmt)).toFixed(2);//计算退款后剩余金额
		nui.get("trefundAmt").setValue(trefundAmt);
	}
	nui.open({
        url: webPath + contextPath +"/com.hsweb.frm.manage.refundPay.flow?token="+token,
         width: "100%", height: "100%", 
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {
            		printGuest:printGuest,
            		card:card,
            		payAmt:nui.get("yrefundAmt").getValue(),
            		typeCard:2
            }
            iframe.contentWindow.setData(data);
        },
		ondestroy : function(action) {// 弹出页面关闭前
			if (action == "saveSuccess") {
				CloseWindow("saveSuccess");

			}
		}
    });
}


