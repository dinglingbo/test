var form2 = null;
var sellAmt = null;
//页面标签加载完之后执行，但是修改的数据还没有设置
$(document).ready(function(v) {
	form2 = new nui.Form("#dataform2");
	sellAmt = nui.get("sellAmt");
	nui.get('carNo').focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
	 };
	
	
});

var rpbCardTimes = null;
function giveData(data)
{
    var data = nui.clone(data);
    rpbCardTimes = data.row;
    sellAmt.setValue(rpbCardTimes.sellAmt);
	contactorName = mini.get("contactorName");	
    var  main = form2.getData();
    if(data.xyguest!=null){
        main.guestId = data.xyguest.guestId;
        main.contactorName = data.xyguest.guestFullName;
        main.carNo = data.xyguest.carNo;
        main.carId = data.xyguest.carId;
        contactorName.setText(data.xyguest.guestFullName);
        form2.setData(main);
    }
}


function selectCustomer() {
    openCustomerWindow(function (v) {
       
    	contactorName = mini.get("contactorName");	
       var  main = form2.getData();
        main.guestId = v.guestId;
        main.contactorName = v.guestFullName;
        main.carId = v.carId;
        main.carNo = v.carNo;
        contactorName.setText(v.guestFullName);
        form2.setData(main);
       // $("#contactorName").setValue(v.guestFullName);
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


var payType = {
		'020101':'现金',
		'020102':'刷卡',
	    '020104':'微信/支付宝'		
};


var payMeth = apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.receiveCardTimes.biz.ext";
function payOk(){	
	var data = form2.getData();
	var rpbCard = rpbCardTimes;
    var payAmt = null;
	if(data.contactorName){
		var cardTimes ={
			guestId:data.guestId,
			guestName:data.contactorName,
			cardId:rpbCard.id,
			cardName:rpbCard.name,
			periodValidity:rpbCard.periodValidity,
			salesDeductType:rpbCard.salesDeductType,
			remark:rpbCard.remark,
			salesDeductValue:rpbCard.salesDeductValue,
			sellAmt:rpbCard.sellAmt,
			totalAmt:rpbCard.totalAmt,
			useRemark:rpbCard.useRemark,
			carId:data.carId,
			carNo:data.carNo,
			settlementUrl:1
	    };
	//整理数据
/*	    payAmt = rpbCard.sellAmt;
	    var json = nui.encode({
		    "payAmt":payAmt,
		    "payType":data.payType,
		    "cardTimes":cardTimes,
		    token:token
	  });*/
	    //打开储值卡计次卡结算界面
		nui.open({
	        url: webPath + contextPath +"/com.hsweb.frm.manage.cardSettlement.flow?token="+token,
	         width: "100%", height: "100%", 
	        onload: function () {
	            var iframe = this.getIFrameEl();
	            iframe.contentWindow.setData(cardTimes);
	        },
			ondestroy : function(action) {// 弹出页面关闭前
				if (action == "saveSuccess") {
					showMsg("结算成功!", "S");
					rightGrid.reload();
				}
			}
	    });
/*		//提示框 
		//判断客户有没有选择
	    nui.confirm("结算金额【"+payAmt+"】元,确定以【"+payType[data.payType]+"】结算吗？", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
		        nui.ajax({
				    url : payMeth,
				    type : 'POST',
			        data : json,
			        cache : false,
			        contentType : 'text/json',
			        success : function(text) {		
			            nui.unmask(document.body);
				        var returnJson = nui.decode(text);
				        if (returnJson.errCode == "S") {
				        	showMsg("支付成功!","S");
				        	//nui.alert("结算成功", "系统提示");
				        	CloseWindow("saveSuccess");
				        }
				        else {
				            nui.alert("结算失败:"+returnJson.errMsg, "系统提示");
				        }
				   }				        	  
			  });		
	     }else {
				return;
		 }
		 });*/

	}else{
		nui.alert("请选择客户", "提示");
		
	}	
	
}



var noPayMeth = apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.preSettleCardTimes.biz.ext";
function noPayOk(){	
	var data = form2.getData();
	var rpbCard = rpbCardTimes;
    var payAmt = null;
	if(data.contactorName){
		var cardTimes ={
			guestId:data.guestId,
			guestName:data.contactorName,
			cardId:rpbCard.id,
			cardName:rpbCard.name,
			periodValidity:rpbCard.periodValidity,
			salesDeductType:rpbCard.salesDeductType,
			remark:rpbCard.remark,
			salesDeductValue:rpbCard.salesDeductValue,
			sellAmt:rpbCard.sellAmt,
			totalAmt:rpbCard.totalAmt,
			useRemark:rpbCard.useRemark,
			carId:data.carId,
			carNo:data.carNo
	    };
	//整理数据
	    payAmt = rpbCard.sellAmt;
	    var json = nui.encode({
		    "cardTimes":cardTimes,
		    token:token
	  });
		//提示框 
		//判断客户有没有选择
	    nui.confirm("结算金额【"+payAmt+"】元,确定保存进入待结算吗？", "友情提示",function(action){
	       if(action == "ok"){
			    nui.mask({
			        el : document.body,
				    cls : 'mini-mask-loading',
				    html : '处理中...'
			    });
		        nui.ajax({
				    url : noPayMeth,
				    type : 'POST',
			        data : json,
			        cache : false,
			        contentType : 'text/json',
			        success : function(text) {		
			            nui.unmask(document.body);
				        var returnJson = nui.decode(text);
				        if (returnJson.errCode == "S") {
				        	showMsg("转待结算成功!","S");
				        	//nui.alert("转待结算成功", "系统提示");
				        	CloseWindow("saveSuccess");
				        }
				        else {
				            nui.alert("转结算失败:"+returnJson.errMsg, "系统提示");
				        }
				   }				        	  
			  });		
	     }else {
				return;
		 }
		 });

	}else{
		nui.alert("请选择客户", "提示");
		
	}	
	
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}
//取消
function onCancel() {
	CloseWindow("cancel");
}
