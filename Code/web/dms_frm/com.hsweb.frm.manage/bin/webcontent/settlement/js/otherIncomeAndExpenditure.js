var baseUrl = apiPath + frmApi + "/";
var datagrid1 = null;
var queryOtherIncomeAndExpenditureUrl = baseUrl
+ "com.hsapi.frm.setting.queryOtherIncomeAndExpenditure.biz.ext";
var statusList = [{id:"4",name:"全部"},{id:"0",name:"未结算"},{id:"1",name:"部分结算"},{id:"2",name:"全部结算"}];

var statusList1 = [{id:"4",name:"全部"},{id:"1",name:"已审核"},{id:"0",name:"未审核"}];
var statusList2 = [{id:"0",name:"发生日期"},{id:"1",name:"审核日期"}];
var orgidsEl = null;

var auditSignHash = {
	    "0" : "未审核",
	    "1" : "已审核"
	};
var settleStatusHash = {
	    "0" : "未结算",
	    "1" : "部分结算",
	    "2" : "全部结算"
	};
var sDate = null;
var eDate = null;

$(document).ready(function(v) {
	datagrid1 = nui.get("datagrid1");
	sDate = nui.get("sDate");
	eDate = nui.get("eDate");
	datagrid1.setUrl(queryOtherIncomeAndExpenditureUrl);
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
    datagrid1.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if (e.field == "auditSign") {
            if (auditSignHash && auditSignHash[e.value]) {
                e.cellHtml = auditSignHash[e.value];
            }
        }else if (e.field == "settleStatus") {
            if (settleStatusHash && settleStatusHash[e.value]) {
                e.cellHtml = settleStatusHash[e.value];
            }
        }else if(e.field == "billDc"){
            if(e.value == 1){
                e.cellHtml = "应收";
            }else{
                e.cellHtml = "应付";
            }
        }else if(e.field == "orgid"){
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
        	
        }
    });
    
	  var filter = new HeaderFilter(datagrid1, {  
	        columns: [
	            { name: 'rpBillId' },
	            { name: 'billServiceId' },
	            { name: 'carNo' },
	            { name: 'remark' },
	            { name: 'auditor' },
	            { name: 'guestName' }
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
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
    nui.get("auditSign").setValue(4);
    nui.get("settleStatus").setValue(4);
    search();
}


function search() {
    var params = {};
    params.guestName = nui.get("advanceGuestId").getValue();
    if(nui.get("auditSign").getValue()==4){
    	
    }else{
    	params.auditSign=nui.get("auditSign").getValue();
    }
    if(nui.get("settleStatus").getValue()==4){
    	
    }else{
    	params.settleStatus=nui.get("settleStatus").getValue();
    }
    
    var type = nui.get("search-date").getValue();
    if(type==0){
    	params.screateDate = nui.get("sDate").getValue();
    	params.ecreateDate = nui.get("eDate").getValue();
    }else if(type==1){
    	params.sauditDate = nui.get("sDate").getValue();
    	params.eauditDate = nui.get("eDate").getValue();
    }
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
    datagrid1.load({params:params,token:token});
}


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
function onExport(){
	var detail = nui.clone(datagrid1.getData());
	exportNoMultistage(datagrid1.columns)
	for(var i=0;i<detail.length;i++){


        if(auditSignHash && auditSignHash[detail[i].auditSign]){
        	detail[i].auditSign = auditSignHash[detail[i].auditSign];
        } else {
        	detail[i].auditSign = "";
        }
        
        if(settleStatusHash && settleStatusHash[detail[i].settleStatus]){
        	detail[i].settleStatus = settleStatusHash[detail[i].settleStatus];
        } else {
        	detail[i].auditSign = "";
        }
        if(detail[i].billDc == 1){
        	detail[i].billDc = "应收";
        }else{
        	detail[i].billDc = "应付";
        }

	}
	if(detail && detail.length > 0){
		setInitExportDataNoMultistage( detail,datagrid1.columns,"其他收支明细表导出");
	}
	
}