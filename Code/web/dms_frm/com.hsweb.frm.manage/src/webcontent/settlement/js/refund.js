/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = apiPath + repairApi + "/";
var form = null;
var card={};
var tureRefundAmt = 0;//实际能退金额
$(document).ready(function(v) {
	form = new nui.Form("#dataform1");
   

});

function setData(params){
	card = params.row;
	form.setData(params.row||{});
	nui.get("fullName").disable();
	nui.get("mobile").disable();
	nui.get("cardName").disable();
	nui.get("balaAmt").disable();
	nui.get("rechargeAmt").disable();
	nui.get("giveAmt").disable();
	nui.get("trefundAmt").disable();
	tureRefundAmt = (parseFloat(card.balaAmt)-parseFloat(card.giveAmt)).toFixed(2);//计算最多能退金额
}

function onrefundAmt(){
	var refundAmt = parseFloat(nui.get("refundAmt").getValue());
	if(refundAmt>tureRefundAmt){
		showMsg("最大退款金额："+tureRefundAmt+",请确认！","W");
		return;
	}else{
		var trefundAmt = (parseFloat(card.balaAmt)-parseFloat(card.refundAmt)-parseFloat(card.giveAmt)).toFixed(2);//计算退款后剩余金额
		nui.get("trefundAmt").setValue(trefundAmt);
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
	
	nui.open({
        url: webPath + contextPath +"/com.hsweb.frm.manage.refundPay.flow?token="+token,
         width: "100%", height: "100%", 
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {
            		card:card,
            		payAmt:nui.get("refundAmt").getValue()
            }
            iframe.contentWindow.setData(data);
        },
		ondestroy : function(action) {// 弹出页面关闭前
			if (action == "saveSuccess") {
				showMsg("结算成功!", "S");
				pRightGrid.reload();
			}
		}
    });
}


