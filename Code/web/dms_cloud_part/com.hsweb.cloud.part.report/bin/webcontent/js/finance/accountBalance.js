/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl + "com.hsapi.cloud.part.report.finance.queryAccountBalance.biz.ext";
var mainGrid = null;
var accountIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var accountList = null;

$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);

	accountIdEl = nui.get("accountId");
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));

	getAccountList(function(data) {
        accountList = data.settleAccount;
        accountIdEl.setData(accountList);
    });

	doSearch();
});
function doSearch() {
	var params = {};
	params.id = accountIdEl.getValue();
	params.startDate = beginDateEl.getFormValue();
    params.endDate = endDateEl.getFormValue();

	mainGrid.load({
		params:params,
		token : token
	});
}
var queryAccountUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFiSettleAccount.biz.ext";
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


function onExport(){
	var detail = nui.clone(mainGrid.getData());
	//多级
	//exportMultistage(rightGrid.columns);
	//单级
	exportNoMultistage(mainGrid.columns)
	/*for(var i=0;i<detail.length;i++){
		if(enterTypeIdHash[detail[i].billTypeId]){
			detail[i].billTypeId = enterTypeIdHash[detail[i].billTypeId].name;
		}
		
		if(settleStatusHash[detail[i].settleStatus]){
			detail[i].settleStatus=settleStatusHash[detail[i].settleStatus];
		}
		
		
	}*/
	if(detail && detail.length > 0){
		//多级表头类型
		//setInitExportData( detail,rightGrid.columns,"采购入库明细表");
		//单级表头类型 与上二选一
		setInitExportDataNoMultistage( detail,mainGrid.columns,"财务余额汇总表");
	}
}