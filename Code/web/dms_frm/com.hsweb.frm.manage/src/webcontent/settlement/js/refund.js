/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = apiPath + repairApi + "/";
var form = null;
$(document).ready(function(v) {
	form = new nui.Form("#dataform1");
   

});

function setData(params){
	form.setData(params.row||{});
	nui.get("fullName").disable();
	nui.get("cardName").disable();
	nui.get("balaAmt").disable();
	nui.get("rechargeAmt").disable();
	nui.get("giveAmt").disable();
	nui.get("refundAmt").disable();
	
}








