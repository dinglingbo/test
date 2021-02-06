/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl + "com.hsapi.part.query.finance.queryAccountDetail.biz.ext";
var mainGrid = null;
var accountIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var advanceGuestIdEl = null;
var rpDcEl = null;
var accountList = null;
var accountHash = {};


$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);

	accountIdEl = nui.get("accountId");
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");
    advanceGuestIdEl = nui.get("advanceGuestId");
    rpDcEl = nui.get("rpDc");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));
	


	getAccountList(function(data) {
        accountList = data.settleAccount;
        accountIdEl.setData(accountList);
        accountList.forEach(function(v) {
            accountHash[v.id] = v;
        });
    });

	doSearch();
});
function doSearch() {
	var params = {};
	params.id = accountIdEl.getValue();
	params.startDate = beginDateEl.getFormValue();
    params.endDate = endDateEl.getValue();
    params.guestId = advanceGuestIdEl.getValue();
    params.rpDc = rpDcEl.getValue();


	mainGrid.load({
		params:params,
		token : token
	});
}
var queryAccountUrl = baseUrl + "com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext";
function getAccountList(callback) {
    nui.ajax({
        url : queryAccountUrl,
        data : {
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
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "往来单位",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
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
var dcList = [{id:"1",text:"收"},{id:"-1",text:"支"}];
var dcHash = {"1":"收","-1":"支"};
function onDrawCell(e){
    switch (e.field) {
        case "rpDc":
            if (dcHash[e.value]) {
                e.cellHtml = dcHash[e.value] || "";
            } else {
                e.cellHtml = "";
            }
            break;
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
        default:
            break;
    }
}
