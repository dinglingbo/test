var baseUrl = apiPath + frmApi + "/";
var settleAccountList = {};
var statusList = [];
var datagrid1 = null;
var sDate = null;
var eDate = null;
var orgidsEl = null;
$(document).ready(function(v) {
	datagrid1 = nui.get("datagrid1");
	datagrid1.setUrl(querySummaryAccountBalances);
	sDate = nui.get("sDate");
	eDate = nui.get("eDate");
	sDate.setValue(getMonthStartDate());
	eDate.setValue(addDate(getMonthEndDate(), 1));
	setData();
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

	datagrid1.on("drawcell", function (e) {
        switch (e.field) {
            case "rpDc":
                if(e.value==1){
                    e.cellHtml = "应收";
                }else{
                	e.cellHtml = "应付";
                }
                break;
            case "orgid":
            	for(var i=0;i<currOrgList.length;i++){
            		if(currOrgList[i].orgid==e.value){
            			e.cellHtml = currOrgList[i].shortName;
            		}
            	}
                break;
                
            default:
                break;
        }
        
    });
	quickSearch(2);
	
});

function quickSearch(type){
	var params = {};
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sDate = getNowStartDate();
            params.eDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sDate = getPrevStartDate();
            params.eDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sDate = getWeekStartDate();
            params.eDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sDate = getLastWeekStartDate();
            params.eDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sDate = getMonthStartDate();
            params.eDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sDate = getLastMonthStartDate();
            params.eDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sDate = getYearStartDate();
            params.eDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sDate = getPrevYearStartDate();
            params.eDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;      
        default:
            break;
    }
    sDate.setValue(params.sDate);
    eDate.setValue(addDate(params.eDate,-1));
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);    
    }
    search();
}



var queryFiSettleAccountUrl = baseUrl
+ "com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext";
function setData(){
	var params = [];
	nui.ajax({
		url : queryFiSettleAccountUrl,
		data : {
			token: token
		},
		type : "post",
		success : function(data) {
			settleAccountList = data.settleAccount;
			if(isEmptyObject(settleAccountList)){
				
			}else{
				for(var i =0;i<settleAccountList.length;i++){
					statusList[i]={
							id:settleAccountList[i].id,
							name:settleAccountList[i].name
					}
				}
				nui.get("auditSign").setData(statusList);
				nui.get("auditSign").setValue(statusList[0].id);
				params.balaTypeId = statusList[0].id;
				/*datagrid1.load({
					params:{
						settAccountId:statusList[0].id
					},
			        token: token
			    });*/
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
}
var querySummaryAccountBalances = baseUrl
+ "com.hsapi.frm.frmService.crud.querySummaryAccountBalances.biz.ext";
function querySummaryAccountBalances(params){
	nui.ajax({
		url : querySummaryAccountBalances,
		data : {
			params:params,
			token: token
		},
		type : "post",
		success : function(data) {
			settleAccountList = data.settleAccount;
			if(isEmptyObject(settleAccountList)){
				
			}else{
				
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
	
}
function isEmptyObject (obj){
	for(var key in obj ){
		return false;
	}
	return true;
}

function search(){
	var params = {};
	var settAccountId = nui.get("auditSign").getValue()||"";
	var startDate = nui.get("sDate").getValue()||"";
	var endDate =nui.get("eDate").getValue()||"";
	 var orgidsElValue = orgidsEl.getValue();
	    if(orgidsElValue==null||orgidsElValue==""){
	    	params = {
				settAccountId:settAccountId,
				startDate :startDate,
				endDate: endDate,
				orgids : currOrgs
			};
	    		datagrid1.load({
	    			params:params,
	    	        token: token
	    	    });
	    }else{
	    	params = {
				settAccountId:settAccountId,
				startDate :startDate,
				endDate: endDate,
				orgid : orgidsElValue
			};
    		datagrid1.load({
    			params:params,
    	        token: token
    	    });
	    }
	

}

function onExport(){
	var detail = nui.clone(datagrid1.getData());
	exportNoMultistage(datagrid1.columns)
	for(var i=0;i<detail.length;i++){
    	detail[i].id = 1;
        if(detail[i].rpDc==1){
        	detail[i].rpDc = "应收";
        }else{
        	detail[i].rpDc = "应付";
        }
	}
	if(detail && detail.length > 0){
		setInitExportDataNoMultistage( detail,datagrid1.columns,"结算账户余额汇总表导出");
	}
	
}