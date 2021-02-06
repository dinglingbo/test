var bearUrl  = apiPath +cloudPartApi + "/";
var advancedSearchForm = null;
var plist = [];
var rlist = [];
var advanceId = null;
var prepaid = {};//主页面传过来
var guestIdEl =null;
var getGuestInfo = bearUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
$(document).ready(function(v){
	advancedSearchForm = new nui.Form("#advancedSearchForm");
	var params = {isMain:0};
	account(params,function(data) {
		var list = data.settleAccount||[];
		nui.get("balaAccountId").setData(list);	
	    
	    
    }); 
	
	nui.get("rpSettleDate").setValue(now);

});

var accountUrl = bearUrl + "com.hsapi.cloud.part.settle.svr.queryFiSettleAccount.biz.ext";
function account(params, callback) {
    nui.ajax({
        url : accountUrl,
        data : {
            params: params,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.settleAccount) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}

function setData(data){
	advanceId = data.advanceId;
}

var requiredField = {
	balaAccountId : "结算账户",
	balaTypeCode : "结算方式",
	refundAmt : "退款金额"
};
var auditUrl = bearUrl+"com.hsapi.cloud.part.invoicing.ordersettle.advanceRefundSettle.biz.ext";
function onOk(){
	var data = advancedSearchForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!", "W");
			return;
		}
	}
	
	if(nui.get("rpSettleDate") == null) {
    	showMsg("请选择结算日期!","W");
    	return;
    }
	
	if(data.refundAmt <= 0) {
		showMsg("退款金额必须大于0!", "W");
		return;
	}
	
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '退款中...'
	});
    nui.ajax({
        url: auditUrl,
        type:"post",
        async: false,
        data:{
        	advanceId: advanceId,
            refundAmt: data.refundAmt,
            remark: data.remark,
            balaTypeCode: data.balaTypeCode,
            balaAccountId: data.balaAccountId,
			settleDate: nui.get("rpSettleDate").getValue(),
        	token:token
        },
        cache: false,
        success: function (text) {
        	nui.unmask(document.body);
            var list = text.list;
            if(text.errCode=="S"){
            	parent.showMsg("退款成功","S");
            	onCancel();
            }else{
            	parent.showMsg(text.errMsg||"退款异常","W");
            }
        }
    });
}

function onCancel(){
	CloseWindow("ok");
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else
        window.close();
}

function onAccountValueChanged(e)
{

	var data = e.selected;
	if (data) { 
		var id = data.id;
		accountType(id,function(rs) {
			nui.get("balaTypeCode").setData(rs.list||[]);	
		});
    }else {
    	nui.get("balaTypeCode").setData([]);	
    }
}

var accountTypeUrl = bearUrl + "com.hsapi.cloud.part.baseDataCrud.crud.queryAccountSettleType.biz.ext";
function accountType(accountId, callback) {
    nui.ajax({
        url : accountTypeUrl,
        data : {
        	accountId: accountId,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}