/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + frmApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl + "com.hsapi.frm.frmService.finance.queryRPAccountDetail.biz.ext";
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
       
    var filter = new HeaderFilter(mainGrid, {
        columns: [
            { name: 'auditor' },
             {name:'shortName'}
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
	    		default:
	                break;
	    	}
        	return value;
        }
    });
	
	quickSearch(2);
});

var Genders = [{ id: 1, text: '男' }, { id: 2, text: '女'}];
function onGenderRenderer(e) {
    for (var i = 0, l = Genders.length; i < l; i++) {
        var g = Genders[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}

function clearFilter() {
    filter.clearAllFilter();
}

function quickSearch(type){
	var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;      
        default:
            break;
    }
    beginDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);    
    }
    doSearch(params);
}

function getSearchParam(){
	var params = {};
	params.settAccountId = accountIdEl.getValue();
	params.startDate = beginDateEl.getFormValue();
    params.endDate = addDate(endDateEl.getValue(),1);
    params.guestId = advanceGuestIdEl.getValue();
    params.isMain = isMainEl.getValue();
    params.rpDc = 1;
    return params;
}

function onSearch(){
	var params=getSearchParam();
	doSearch(params);
}
function doSearch() {
	var params = {};
	params.settAccountId = accountIdEl.getValue();
	params.startDate = beginDateEl.getFormValue();
    params.endDate = endDateEl.getValue();
    params.guestId = advanceGuestIdEl.getValue();
    params.isMain = isMainEl.getValue();
    params.rpDc = -1;

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
        //targetWindow : window,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "结算单位资料",
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
                onSearch();
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


