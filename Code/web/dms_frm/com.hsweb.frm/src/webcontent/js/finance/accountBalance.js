/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + frmApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl + "com.hsapi.frm.frmService.finance.queryAccountBalance.biz.ext";
var mainGrid = null;
var accountIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var accountList = null;
var orgidsEl = null;

$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);

	accountIdEl = nui.get("accountId");
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));

    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
    
    mainGrid.on("drawcell", function (e) {
        if(e.field == "orgid"){
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
        	
        }
    });
	getAccountList(function(data) {
        accountList = data.settleAccount;
        accountIdEl.setData(accountList);
    });
	 var filter = new HeaderFilter(mainGrid, {
	        columns: [
	            { name: 'settAccountName' }
	        ],
	        callback: function (column, filtered) {
	        },
	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
	        	case "rpDc":
	    			value = dcListType;
		    		default:
		                break;
		    	}
	        	return value;
	        }
	    });

	doSearch();
});
function doSearch() {
	var params = {};
	params.id = accountIdEl.getValue();
	params.startDate = beginDateEl.getFormValue();
    params.endDate = endDateEl.getValue();
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }

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

function quickSearch(type){
	var params = {};
    var querysign = 1;
    var queryname = "本月";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getQuarterStartDate();
            params.endDate = addDate(getQuarterEndDate(), 1);
            querysign = 1;
            queryname = "本季度";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getYearStartDate();
            params.endDate = addDate(getYearEndDate(), 1);
            querysign = 1;
            queryname = "本年";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = addDate(getPrevYearEndDate(), 1);
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
    doSearch();
}

function onExport(){
	var detail = nui.clone(mainGrid.getData());
	exportNoMultistage(mainGrid.columns)
	for(var i=0;i<detail.length;i++){
        	detail[i].id = 1;
	}
	if(detail && detail.length > 0){
		setInitExportDataNoMultistage( detail,mainGrid.columns,"账户余额汇总表导出");
	}
	
}