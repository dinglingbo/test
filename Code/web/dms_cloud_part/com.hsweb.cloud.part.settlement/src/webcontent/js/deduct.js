var baseUrl = apiPath + cloudPartApi + "/";
var rightGridUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryRPAccountList.biz.ext";

var rRightGrid = null;
var settleAccountGrid = null;
var enterTypeIdList = [];
var enterTypeIdHash = {};
var fbillMainId = 0;
var frpDc = 1;
var fsettleType = "应收";
var fguestId = "";
var fguestName = "";

$(document).ready(function(v) {
	rRightGrid = nui.get("rRightGrid");
	rRightGrid.setUrl(rightGridUrl);
	settleAccountGrid = nui.get("settleAccountGrid");
	
	fbillMainId = 0;
	frpDc = 1;
	fsettleType = "应收";
	fguestId = "";
	fguestName = "";

	getItemType(function(data) {
		enterTypeIdList = data.list || [];
		enterTypeIdList.filter(function(v) {
			enterTypeIdHash[v.id] = v;
		});
	});
	
	rRightGrid.on("selectionchanged",function(e){
		var rows = rRightGrid.getSelecteds();
		document.getElementById('settleBillCount').innerHTML="结算单据数："+rows.length;
		
		var rtn = getSettleAmount(rows);
		document.getElementById('rRPAmt').innerHTML = rtn.rpAmtS;
		document.getElementById('rCharOffAmt').innerHTML = rtn.charOffAmtS;
		document.getElementById('rNoCharOffAmt').innerHTML = rtn.noCharOffAmtS;
		document.getElementById('rTrueAmt').innerHTML = rtn.nowAmtS;
	});
	
	rRightGrid.on("cellendedit",function(e){
		var rows = rRightGrid.getSelecteds();
		document.getElementById('settleBillCount').innerHTML="结算单据数："+rows.length;
		
		var rtn = getSettleAmount(rows);
		document.getElementById('rRPAmt').innerHTML = rtn.rpAmtS;
		document.getElementById('rCharOffAmt').innerHTML = rtn.charOffAmtS;
		document.getElementById('rNoCharOffAmt').innerHTML = rtn.noCharOffAmtS;
		document.getElementById('rTrueAmt').innerHTML = rtn.nowAmtS;
	});
	
	addSettleAccountRow();
});

function getSettleAmount(rows) {
	var s = rows.length;
	var rpAmtS = 0;
	var charOffAmtS = 0;
	var noCharOffAmtS = 0;
	var nowAmtS = 0;
	var errCode = 'S';
	var errMsg = null;
	if (s > 0) {

		for (var i = 0; i < s; i++) {
			var row = rows[i];
			var charOffAmt = row.charOffAmt || 0; // 已结金额
			var rpAmt = row.rpAmt || 0; // 应结金额
			var noCharOffAmt = row.noCharOffAmt || 0;
			var nowAmt = row.nowAmt || 0;
			charOffAmt = parseFloat(charOffAmt);
			rpAmt = parseFloat(rpAmt);
			noCharOffAmt = parseFloat(noCharOffAmt);
			nowAmt = parseFloat(nowAmt);
			
			rpAmtS += rpAmt;
			charOffAmtS += charOffAmt;
			noCharOffAmtS += noCharOffAmt;
			nowAmtS += nowAmt;
			
		}

	}
	
	var rtnMsg = {};
	rtnMsg.rpAmtS = rpAmtS; 
	rtnMsg.charOffAmtS = charOffAmtS; 
	rtnMsg.noCharOffAmtS = noCharOffAmtS; 
	rtnMsg.nowAmtS = nowAmtS; 
	rtnMsg.errCode = errCode;
	rtnMsg.errMsg = errMsg;
	return rtnMsg;
}

function setInitDate(data) {
	var params = {};
	params.guestId = data.guestId;
	params.isAdvance = data.isAdvance;
	params.billDc = data.billDc;
	fbillMainId = data.billMainId;
	frpDc = data.rpDc;
	fsettleType = data.settleType;
	
	fguestId = data.guestId;
	fguestName = data.guestName;
	
	doSearch(params);
	
	document.getElementById('settleGuestName').innerHTML="结算单位："+data.guestName;
}

function doSearch(params) {
	rRightGrid.load({
		params : params,
		token : token
	});

}

var doDeductUrl = baseUrl+"com.hsapi.cloud.part.settle.rpsettle.rpAdvanceDeduct.biz.ext";
function doDeduct() {
	var rows = rRightGrid.getSelecteds();
	var rtn = getSettleAmount(rows);
	var msg = checkSettleAccountAmt(rtn.nowAmtS);
	if (!msg) {
		return;
	}
	
	var account = {};
    var accountDetailList = [];
    var stateMentList=[];
    var accountTypeList = settleAccountGrid.getData();
    var s = 0;
    
    account.orgid = currOrgid;
    account.guestId = fguestId;
    account.guestName = fguestName;
    account.itemQty = rows.length;
    account.remark = nui.get('rpTextRemark').getValue().replace(/\s+/g, "");
    
    for(var i=0; i<rows.length; i++){
        var row = rows[i];
        var accountDetail = {};
        var nowAmt = row.nowAmt||0;
        nowAmt = parseFloat(nowAmt);
        
        accountDetail.billRpId = row.id;
        accountDetail.billMainId = row.billMainId;
        accountDetail.billServiceId = row.billServiceId;
        accountDetail.billTypeId = row.billTypeId;
        accountDetail.charOffAmt = nowAmt;
        accountDetail.voidAmt = 0;
        accountDetail.rpDc = frpDc;
        
        s += nowAmt;

        accountDetailList.push(accountDetail);
        
        if(row.billTypeId == '102' || row.billTypeId == '202') {
            var stateHash ={};
        	stateHash.id = rows[i].billMainId;
        	stateHash.amt = nowAmt;
        	stateMentList.push(stateHash);
        }
    }
    
    account.rpDc = frpDc;
    account.settleType = fsettleType;
    account.voidAmt = 0;
    account.trueCharOffAmt = s;
    account.charOffAmt =  s;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据处理中...'
    });

    nui.ajax({
        url : doDeductUrl,
        type : "post",
        data : JSON.stringify({
        	id: fbillMainId,
            account : account,
            accountDetailList : accountDetailList,
            accountTypeList: accountTypeList,
            stateMentList  : stateMentList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("结算成功!","S");
                
                onCancel();
                
            } else {
                showMsg(data.errMsg || "结算失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    }); 
}

function checkSettleAccountAmt(charOffAmt) {
	var tAmt = 0;
	var rows = settleAccountGrid.findRows(function(row) {
		var settAccountId = row.settAccountId;
		var charOffAmt = row.charOffAmt;
		if (charOffAmt) {
			charOffAmt = parseFloat(charOffAmt);
		}

		tAmt += charOffAmt;

		if (!row.settAccountId) {
			return true;
		}
		
		if (!row.balaTypeCode) {
			return true;
		}
	});

	if (rows && rows.length > 0) {
		showMsg("请选择结算账户，结算方式!", "W");
		return false;
	}
	
	if (tAmt != charOffAmt) {
		showMsg("请确定结算金额与合计金额一致!", "W");
		return false;
	}

	return true;
}

function OnModelCellBeginEdit(e) {
	var row = settleAccountGrid.getSelected();

	var column = e.column;
	var editor = e.editor;
	var row = settleAccountGrid.getSelected();

	if (column.field == "settAccountId") {
		var url = baseUrl
				+ "com.hsapi.cloud.part.settle.svr.queryFiSettleAccount.biz.ext?token="
				+ token;
		editor.setUrl(url);
	}

	if (column.field == "balaTypeCode") {
		var str = "accountId=" + row.settAccountId + "&token=" + token;
		var url = baseUrl
				+ "com.hsapi.cloud.part.baseDataCrud.crud.queryAccountSettleType.biz.ext?" + str;
		editor.setUrl(url);
	}

}
function onAccountValueChanged(e) {

	var r = settleAccountGrid.getSelected();
	var newRow = {
		balaTypeCode : null
	};
	settleAccountGrid.updateRow(r, newRow);

}

function onActionRenderer(e) {
	var grid = e.sender;
	var record = e.record;
	var uid = record._uid;
	var rowIndex = e.rowIndex;

	var s = '<a class="" href="javascript:addSettleAccountRow()">新增</a> '
			+ '<a class="" href="javascript:delRow(\'' + uid + '\')">删除</a> ';

	return s;
}
function addSettleAccountRow() {
	var row = {};
	settleAccountGrid.addRow(row, 0);
}
function delRow(row_uid) {
	var data = settleAccountGrid.getData();
	if (data && data.length == 1) {
		return;
	}
	var row = settleAccountGrid.getRowByUID(row_uid);
	if (row) {
		settleAccountGrid.removeRow(row);
	}
}

function onDrawCell(e) {
	switch (e.field) {
	case "billTypeId":
		if (enterTypeIdHash && enterTypeIdHash[e.value]) {
			e.cellHtml = enterTypeIdHash[e.value].name;
		}
		break;
	case "billStatus":
		if (billStatusHash && billStatusHash[e.value]) {
			e.cellHtml = billStatusHash[e.value];
		}
		break;
	case "settleTypeId":
		if (settTypeIdHash && settTypeIdHash[e.value]) {
			e.cellHtml = settTypeIdHash[e.value].name;
		}
		break;
	case "storeId":
		if (storehouseHash && storehouseHash[e.value]) {
			e.cellHtml = storehouseHash[e.value].name;
		}
		break;
	case "settleStatus":
		if (settleStatusHash && settleStatusHash[e.value]) {
			e.cellHtml = settleStatusHash[e.value];
		}
		break;
	case "auditSign":
		if (auditSignHash && auditSignHash[e.value]) {
			e.cellHtml = auditSignHash[e.value];
		}
		break;		
	case "nowAmt":
		e.cellStyle = 'background-color:#90EE90';
		break;
	default:
		break;
	}
}

function onCellCommitEdit(e) {
	var editor = e.editor;
	var record = e.record;

	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!", "W");
		e.cancel = true;
	}else {
		if (e.field == "nowAmt") {
			if (e.value == null || e.value == '') {
				e.value = 0;
			} else if (e.value < 0) {
				e.value = 0;
			}
			
			var rpAmt = record.rpAmt || 0;
			var charOffAmt = record.charOffAmt || 0;
			var noCharOffAmt = rpAmt - charOffAmt;
			if(e.value > noCharOffAmt) {
				e.value = noCharOffAmt;
				showMsg("当前结算不能大于未结金额","W");
			}
		}
		
	}
	
}

var queryUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getItemType(callback) {
	nui.ajax({
		url : queryUrl,
		data : {
			token : token
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

function onCancel(){
	CloseWindow("ok");
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else
        window.close();
}














