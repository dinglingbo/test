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
var orgidsEl = null;
var settleStatusHashType=[{name:"未结算",id:"0"},{name:"部分结算",id:"1"},{name:"已结算",id:"2"}];
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
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
    mainGrid.on("drawcell", function (e) {
    	if (e.field == "orgid"){
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
        }
    });
    var filter = new HeaderFilter(mainGrid, {
        columns: [
            { name: 'shortName' },
            { name: 'settleStatus' },
            { name: 'billServiceId' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
        	    case "settleStatus":
    			value = settleStatusHashType;
    			break;
	    		default:
	                break;
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
    doSearch();
}




function doSearch() {
    var params = {};
    params.settleStatus = settleStatusEl.getValue();
    params.startDate = beginDateEl.getFormValue();
    params.endDate = endDateEl.getValue();
    params.guestId = advanceGuestIdEl.getValue();
    params.billDc = -1;
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
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        targetWindow : window,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
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


function onExport(){

	var detail = mainGrid.getData();
	
	if(detail && detail.length > 0){
		setInitExportData(detail);
	}else{
		showMsg("没有可导出数据！","W");
	}
}
function setInitExportData(detail){
    var tds = '<td  colspan="1" align="left">[billServiceId]</td>' +
        "<td  colspan='1' align='left'>[billTypeId]</td>" +
        "<td  colspan='1' align='left'>[shortName]</td>" +
        "<td  colspan='1' align='left'>[rpAmt]</td>" +
        "<td  colspan='1' align='left'>[trueCharOffAmt]</td>" +
        "<td  colspan='1' align='left'>[noCharOffAmt]</td>" +
        "<td  colspan='1' align='left'>[settleStatus]</td>" +
        "<td  colspan='1' align='left'>[auditDate]</td>"+
        "<td  colspan='1' align='left'>[fullName]</td>";
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row){
        	var billTypeName = detail[i].billTypeId;
        	var settleStatus = detail[i].settleStatus;
        	if(billTypeName) {
        		billTypeName = enterTypeIdHash[billTypeName].name;
        	}
        	settleStatus = settleStatusHash[settleStatus];
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[billServiceId]", detail[i].billServiceId?detail[i].billServiceId:"")
                         .replace("[billTypeId]", billTypeName?billTypeName:"")
                         .replace("[shortName]", detail[i].shortName?detail[i].shortName:"")
                         .replace("[rpAmt]", detail[i].rpAmt?detail[i].rpAmt:"")
                         .replace("[trueCharOffAmt]", detail[i].trueCharOffAmt?detail[i].trueCharOffAmt:"")
                         .replace("[noCharOffAmt]", detail[i].noCharOffAmt?detail[i].noCharOffAmt:0)
                         .replace("[settleStatus]", settleStatus?settleStatus:"")
                         .replace("[auditDate]", detail[i].auditDate?detail[i].auditDate.Format("yyyy-MM-dd HH:mm:ss"):"")
                         .replace("[fullName]", detail[i].fullName?detail[i].fullName:""));
            tableExportContent.append(tr);
        }
    }

    method5('tableExcel',"供应商欠款明细",'tableExportA');
}
