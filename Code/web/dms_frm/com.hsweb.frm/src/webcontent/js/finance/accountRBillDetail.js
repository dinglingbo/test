/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + frmApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl + "com.hsapi.frm.frmService.finance.queryRPBillDetail.biz.ext";
var mainGrid = null;
var beginDateEl = null;
var endDateEl = null;
var advanceGuestIdEl = null;
var settleStatusEl = null;
var enterTypeIdList = [];
var enterTypeIdHash = {};

$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);

	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");
    advanceGuestIdEl = nui.get("advanceGuestId");
    settleStatusEl = nui.get("settleStatus");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));

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
    params.settleStatus = settleStatusEl.getValue();
	params.startDate = beginDateEl.getFormValue();
    params.endDate = endDateEl.getValue();
    params.guestId = advanceGuestIdEl.getValue();
    params.billDc = 1;

	mainGrid.load({
		params:params,
		token : token
	});
}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        targetWindow : window,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "客户资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1
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
var settleStatusHash = {
    "0":"未结算",
    "1":"部分结算",
    "2":"已结算"
};
var settleStatusList = [{id:0,text:"未结算"},{id:1,text:"部分结算"},{id:2,text:"已结算"}];
function onDrawCell(e){
    switch (e.field) {
        case "billTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        case "settleStatus":
            if(settleStatusHash && settleStatusHash[e.value])
            {
                e.cellHtml = settleStatusHash[e.value];
            }
            break;
        default:
            break;
    }
}
var typeUrl = baseUrl
        + "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
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
