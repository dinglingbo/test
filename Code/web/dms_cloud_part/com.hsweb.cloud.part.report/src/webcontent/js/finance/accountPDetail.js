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
var settleStatusHash = {
		"0" : "未收款",
		"1" : "部分收款",
		"2" : "已收款"
	};
var auditSignHash = {
		"0" : "未审核",
		"1" : "已审核"
	};
var typeRela = [];//用于结算方式
$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	datagrid2 = nui.get("datagrid2");
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
	
	quickSearch(2);
	queryTypeRela();//查询付款方式
});

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
    params.rpDc = -1;
    params.isAdvance = 0;

    return params;
}

function onSearch(){
	var params=getSearchParam();
	doSearch(params);
}
function doSearch(params) {

   
	datagrid2.setData([]);
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
        	params: {
        		isDisabled: 2
        	},
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
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title : "往来单位选择",
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
        case "orgid":
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
            break;
        case "balaTypeCode":
        	for(var i=0;i<typeRela.length;i++){
        		if(typeRela[i].customId==e.value){
        			e.cellHtml = typeRela[i].customName;
        		}
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

function checkSettleRow() {
	var guestId = null;
	var rows = mainGrid.getSelecteds();
	var msg = "";
	var s = rows.length;

	if (s > 0) {
		for (var i = 0; i < s; i++) {			
			var row = rows[i];
			if (i == 0) {
				firstRow = row;
				guestId = firstRow.guestId;
			} else {
				var rowGuestId = row.guestId;
				if (guestId != rowGuestId) {
					return "请选择相同结算单位的单据!";
				}
			}
		}

	} else {
		msg = "请选择单据!";
	}

	return msg;
}

//查询付款方式
var queryTypeRelaUrl = baseUrl
+ "com.hsapi.cloud.part.settle.svr.queryfibAccountTypeRela.biz.ext";
function queryTypeRela(){
    nui.ajax({
        url : queryTypeRelaUrl,
        data : {
            token: token
        },
        type : "post",
        success : function(data) {
            if(data.errCode=="S"){
            	typeRela = data.list;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}


function onDrawCell1(e) {
	switch (e.field) {
	case "comPartBrandId":
		if (partBrandIdHash && partBrandIdHash[e.value]) {
			e.cellHtml = partBrandIdHash[e.value].name;
		}
		break;
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
	case "enterDayCount":
		var row = e.record;
		var enterTime = (new Date(row.enterDate)).getTime();
		var nowTime = (new Date()).getTime();
		var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
		e.cellHtml = dayCount + 1;
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
	case "nowVoidAmt":
		e.cellStyle = 'background-color:#90EE90';
		break;
	default:
		break;
	}
}

function queryFrm(){
	var row =mainGrid.getSelected(); 
	var queryRPAccountListUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFrm.biz.ext";
    nui.ajax({
        url : queryRPAccountListUrl,
        data : {
        	params:{
        		mainId : row.id
        	},
            token: token
        },
        type : "post",
        success : function(data) {
            if (data.errCode=="S") {
            	datagrid2.setData(data.detailList);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
