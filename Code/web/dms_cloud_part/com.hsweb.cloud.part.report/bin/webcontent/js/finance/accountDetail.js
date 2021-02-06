/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl + "com.hsapi.cloud.part.report.finance.queryAccountDetail.biz.ext";
var mainGrid = null;
var accountIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var advanceGuestIdEl = null;
var rpDcEl = null;
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
    rpDcEl = nui.get("rpDc");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));

	getAccountList(function(data) {
        accountList = data.settleAccount;
        accountIdEl.setData(accountList);
        accountList.forEach(function(v) {
            accountHash[v.id] = v;
        });
        
        getItemType(function(data) {
            enterTypeIdList = data.list || [];
            enterTypeIdList.filter(function(v){
                enterTypeIdHash[v.id] = v;
            });


        	doSearch();
	        
        });
        
    });

});
var itemUrl = baseUrl
+ "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getItemType(callback) {
	nui.ajax({
		url : itemUrl,
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
function doSearch() {
	var params = {};
	params.settAccountId = accountIdEl.getValue();
	params.startDate = beginDateEl.getFormValue();
    params.endDate = endDateEl.getFormValue();
    params.guestId = advanceGuestIdEl.getValue();
    params.rpDc = rpDcEl.getValue();
    params.isAdvance=0;
    params.auditor=nui.get("elAuditor").getValue();
    params.remark=nui.get("elRemark").getValue();
    params.rpAccountId=nui.get("elRpAccountId").getValue();

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
        	params:{isDisabled:2},
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
        case "billTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        default:
            break;
    }
}

function onExport(){
	var detail = nui.clone(mainGrid.getData());
	//多级
	//exportMultistage(mainGrid.columns);
	//单级
	exportNoMultistage(mainGrid.columns)
	for(var i=0;i<detail.length;i++){
		if(dcHash[detail[i].rpDc]){
			detail[i].rpDc=dcHash[detail[i].rpDc];
		}
		
		if(accountHash[detail[i].settAccountId]){
			detail[i].settAccountId = accountHash[detail[i].settAccountId].name;
		}
		
		if(enterTypeIdHash[detail[i].billTypeId]){
			detail[i].billTypeId = enterTypeIdHash[detail[i].billTypeId].name;
		}
		
		
	}
	if(detail && detail.length > 0){
		//多级表头类型
		//setInitExportData( detail,mainGrid.columns,"账户结算明细");
		//单级表头类型 与上二选一
		setInitExportDataNoMultistage( detail,mainGrid.columns,"账户结算明细");
	}
}
