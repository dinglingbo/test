/**
* Created by Administrator on 2018/4/25.
*/
var baseUrl = apiPath + partApi + "/";
var mainGridUrl = baseUrl+"com.hsapi.part.invoice.partAllot.queryPjAllotMainList.biz.ext";
var webBaseUrl = webPath + contextPath + "/";
var storehouse = [];
var storehouse = [];
var storeHash={};
var mainGrid = null;
var stockStatusHash = {
		"1":"待入库",
		"2":"待出库",
		"3":"已出库",
		"4":"已入库"
}

var statusHash = ["草稿","预结算","已结算"];
var beginDateEl =null;
var endDateEl =null;
var form =null;
var currType = 0;//日期范围 
var statusType = null;//状态类型 
$(document).ready(function ()
{
    
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    getStorehouse(function(data){
        storehouse = data.storehouse || [];
        nui.get('storeId').setData(storehouse);
        nui.get('storeId2').setData(storehouse);
        if(storehouse && storehouse.length>0){
            storehouse.forEach(function(v){
                storeHash[v.id]=v;
            });
        }
    });
    mainGrid.on("drawcell", function (e) {
   	 var record = e.record;
       if (e.field == "status") {
           e.cellHtml = statusHash[e.value];
       }else if(e.field == "carNo"){
       	e.cellHtml ='<a href="##" onclick="showCarInfo('+e.record._uid+')">'+e.record.carNo+'</a>';
       }else if(e.field == "serviceCode"){
       	e.cellHtml ='<a href="##" onclick="view('+e.record._uid+')">'+e.record.serviceCode+'</a>';
       }else if(e.field == "orgid"){
       	for(var i=0;i<currOrgList.length;i++){
    		if(currOrgList[i].orgid==e.value){
    			e.cellHtml = currOrgList[i].shortName;
    		}
    	}
      }else if(e.field == "guestOrgid"){
     	for(var i=0;i<currOrgList.length;i++){
    		if(currOrgList[i].orgid==e.value){
    			e.cellHtml = currOrgList[i].shortName;
    		}
    	}
      }/*else if(e.field == "enterStoreId"){
    	  e.cellHtml = storeHash[e.value].name;
      }else if(e.field == "stockStatus"){
    	  e.cellHtml = stockStatusHash[e.value];
      }*/else if(e.field == "serviceId"){
      	e.cellHtml ='<a href="##" onclick="edit('+e.record._uid+')">'+e.record.serviceId+'</a>';
      }
       
   });
    doSearch();
  /* form = new nui.Form("#toolbar1");
    
    beginDateEl = nui.get("startDate");
    endDateEl = nui.get("endDate");
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);*/
   /* leftGrid.on("drawcell", function (e) {
    	 var record = e.record;
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if(e.field == "carNo"){
        	e.cellHtml ='<a href="##" onclick="showCarInfo('+e.record._uid+')">'+e.record.carNo+'</a>';
        }else if(e.field == "serviceCode"){
        	e.cellHtml ='<a href="##" onclick="view('+e.record._uid+')">'+e.record.serviceCode+'</a>';
        }
        else {
            onDrawCell(e);
        }
    });
    leftGrid.on("rowclick", function (e) {
        var row = e.record;

    });  
    leftGrid.on("load", function () {
        var row = leftGrid.getSelected();
        if (row) { 

        }
    });

    leftGrid.on("rowdblclick",function(e){
    	view();
    });
    quickSearch(0);*/
});


function quickSearchType(type) {
    if(type==0){

    }else if(type==1){
        statusType = 0;
    }else if(type==2){
        statusType = 1;
    }else if(type==3){
        statusType = 2;
    }
 doSearch();
}


function onAdvancedSearchClear(){
	advancedSearchForm.setData([]);
}



function quickSearch(type){
    var params = {};
    var querysign = 1;
    var queryname = "本日";
    var querystatusname = "所有";
    switch (type)
    {
        case 0:
        params.today = 1;
        params.sRecordDate = getNowStartDate();
        params.eRecordDate = addDate(getNowEndDate(), 1);
        querysign = 1;
        queryname = "本日";
        break;
        case 1:
        params.yesterday = 1;
        params.sRecordDate = getPrevStartDate();
        params.eRecordDate = addDate(getPrevEndDate(), 1);
        querysign = 1;
        queryname = "昨日";
        break;
        case 2:
        params.thisWeek = 1;
        params.sRecordDate = getWeekStartDate();
        params.eRecordDate = addDate(getWeekEndDate(), 1);
        querysign = 1;
        queryname = "本周";
        break;
        case 3:
        params.lastWeek = 1;
        params.sRecordDate = getLastWeekStartDate();
        params.eRecordDate = addDate(getLastWeekEndDate(), 1);
        querysign = 1;
        queryname = "上周";
        break;
        case 4:
        params.thisMonth = 1;
        params.sRecordDate = getMonthStartDate();
        params.eRecordDate = addDate(getMonthEndDate(), 1);
        querysign = 1;
        queryname = "本月";
        break;
        case 5:
        params.lastMonth = 1;
        params.sRecordDate = getLastMonthStartDate();
        params.eRecordDate = addDate(getLastMonthEndDate(), 1);
        querysign = 1;
        queryname = "上月";
        break;
        case 10:
        params.thisYear = 1;
        params.sRecordDate = getYearStartDate();
        params.eRecordDate = getYearEndDate();
        querysign = 1;
        queryname = "本年";
        break;
        case 11:
        params.lastYear = 1;
        params.sRecordDate = getPrevYearStartDate();
        params.eRecordDate = getPrevYearEndDate();
        querysign = 1;
        queryname = "上年";
        break;       
        default:        
        break;
    }
    
    beginDateEl.setValue(params.sRecordDate);
    endDateEl.setValue(addDate(params.eRecordDate,-1));
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);    

    doSearch();
}

function showCarInfo(row_uid){
	var row = leftGrid.getRowByUID(row_uid);
	if(row){
		var params = {
				carId : row.carId,
				carNo : row.carNo,
				guestId : row.guestId,
				contactorId:row.contactorId
		};
		doShowCarInfo(params);
	}
}

function doShowCarInfo(params) {
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.carDetails.flow?token="+token,
        width: 800, height: 500,
		allowResize: false,
		showHeader: true,
        onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.SetData(params);
        },
        ondestroy: function (action) {
            if ("ok" == action) {
            }
        }
    });
}
/*
 * .................................................................................................................
 */
function doSearch() {
   /* var params = form.getData(true);
    var eDate = endDateEl.getFormValue()+ " 23:59:59";
    params.orgid = currOrgId;
    params.status = statusType;
    params.endDate = eDate;*/
	var params = {};
	params.orgid = currOrgId;
    mainGrid.load({
        token:token, 
        params: params
    });
}


function add() {
    var item={};
    item.id = "allotDetail";
    item.text = "调拨单详情";
    item.url = webPath + contextPath + "/com.hsweb.part.purchase.allotDetail.flow?token="+token;
    item.iconCls = "fa fa-cog";
    var params = {};
    window.parent.activeTabAndInit(item,params);
    
    //var params = {};
    //window.parent.activeTabAndInit(item,params);
}

function edit(row_uid){
	var row = null;
	if(!row_uid){
		 row = mainGrid.getSelected();
	}else{
		 row = mainGrid.getRowByUID(row_uid);
	}
    if(!row) return;
    var item={};
    item.id = "allotDetail";
    item.text = "调拨单详情";
    item.url = webPath + contextPath + "/com.hsweb.part.purchase.allotDetail.flow?token="+token;
    item.iconCls = "fa fa-cog";
    window.parent.activeTabAndInit(item,row);
}
