/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl + "com.hsapi.cloud.part.report.finance.queryRPAccountDetail.biz.ext";
var mainGrid = null;
var accountIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var isMainEl = null;
var advanceGuestIdEl = null;
var accountList = null;
var accountHash = {};
var enterTypeIdList = [];
var enterTypeIdHash = {};

$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);

	accountIdEl = nui.get("accountId");
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");
    advanceGuestIdEl = nui.get("advanceGuestId");
    isMainEl = nui.get("isMain");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));

	getAccountList(function(data) {
        accountList = data.settleAccount;
        accountIdEl.setData(accountList);
        accountList.forEach(function(v) {
            accountHash[v.id] = v;
        });
    });

    getItemType(function(data) {
        enterTypeIdList = data.list || [];
        enterTypeIdList.filter(function(v){
            enterTypeIdHash[v.id] = v;
        });

    });

	doSearch();
});
function doSearch() {
	var params = {};
	params.id = accountIdEl.getValue();
	params.startDate = beginDateEl.getFormValue();
    params.endDate = endDateEl.getFormValue();
    params.guestId = advanceGuestIdEl.getValue();
    params.isMain = isMainEl.getValue();
    params.rpDc = -1;

	mainGrid.load({
		params:params,
		token : token
	});
}
var queryAccountUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFiSettleAccountForTenant.biz.ext";
function getAccountList(callback) {
    nui.ajax({
        url : queryAccountUrl,
        data : {
        	tenantId :currTenantId,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.settleAccount) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title : "供应商资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

            }
        }
    });
}
var pList = [{id:1,text:"是"},{id:0,text:"否"}];
var pHash = {"1":"是","0":"否"};
function onDrawCell(e){
    switch (e.field) {
        case "settAccountId":
            if (accountHash[e.value]) {
                if(e.column.header == "账户编码"){
                    e.cellHtml = accountHash[e.value].code || "";
                }else if(e.column.header == "账户名称"){
                    e.cellHtml = accountHash[e.value].name || "";
                }else{
                    e.cellHtml = "";
                }
            } else {
                e.cellHtml = "";
            }
            break;
        case "billTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            } else {
                e.cellHtml = "";
            }
            break;
        case "isPrimaryBusiness":
            if(pHash && pHash[e.value])
            {
                e.cellHtml = pHash[e.value];
            } else {
                e.cellHtml = "";
            }
            break;
        default:
            break;
    }
}
var typeUrl = baseUrl
        + "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getItemType(callback) {
    nui.ajax({
        url : typeUrl,
        data : {
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
