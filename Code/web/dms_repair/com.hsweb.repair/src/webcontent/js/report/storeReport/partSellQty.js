/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + repairApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.repair.repairService.report.queryPartSell.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var brandHash = {};
var brandList = [];
partTypeList=[];
partTypeHash={};
var billTypeIdHash = {};
var settTypeIdHash = {};
var outTypeIdHash = {};
var orgidsEl = null;
var sEnterDateEl=null;
var eEnterDateEl = null;

var sDateEl=null;
var eDateEl =null;
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
/*    sOutDateEl =nui.get('sOutDate');
    eOutDateEl = nui.get('eOutDate');
    sEnterDateEl = nui.get('sEnterDate');
    eEnterDateEl = nui.get('eEnterDate');*/
    
    sDateEl =nui.get('sDate');
    eDateEl = nui.get('eDate');
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
	
	rightGrid.on("drawcell",function(e){
		switch (e.field) {
		 case "serviceCode":
				e.cellHtml ='<a href="##" onclick="editSell()">'+e.value+'</a>';
				break;
		case "outReturnSign":
				e.cellHtml="已归库";
			break;
		 case  "orgid":
	        	for(var i=0;i<currOrgList.length;i++){
	        		if(currOrgList[i].orgid==e.value){
	        			e.cellHtml = currOrgList[i].shortName || "";
	        		}
	        	}
	        break;
		default:
			break;
		}
	});
	
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		if ((keyCode == 13)) { // F9
			onSearch();
		}

	}
	
	var filter = new HeaderFilter(rightGrid, {
	        columns: [
	            { name: 'partCode' },
	            { name: 'partName' }
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
	
    quickSearch(4);

});
function getSearchParams(){
    var params = {};
    params.partCode=nui.get("partCode").getValue();
    params.partName=nui.get("partName").getValue();
    params.serviceCode =nui.get('serviceCode').getValue();
    params.carNo =nui.get('carNo').getValue();
    if((nui.get("sdDate").getValue())==0){
    	params.sEnterDate=nui.get("sDate").getFormValue();	
        params.eEnterDate=addDate(eDateEl.getValue(),1);
    }else{
    	params.sOutDate=nui.get("sDate").getFormValue();
    	params.eOutDate=addDate(eDateEl.getValue(),1);	
    }
    //params.billTypeId=3;
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }

    return params;
}
var currType = 2;
function quickSearch(type){
	var params = {};
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sEnterDate = getNowStartDate();
            params.eEnterDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sEnterDate = getPrevStartDate();
            params.eEnterDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sEnterDate = getWeekStartDate();
            params.eEnterDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sEnterDate = getLastWeekStartDate();
            params.eEnterDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sEnterDate = getMonthStartDate();
            params.eEnterDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sEnterDate = getLastMonthStartDate();
            params.eEnterDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.sEnterDate = getYearStartDate();
            params.eEnterDate = getYearEndDate();
            queryname="本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sEnterDate = getPrevYearStartDate();
            params.eEnterDate = getPrevYearEndDate();
            queryname="上年";
            break;
        default:
            break;
    }
    currType = type;
    
    sDateEl.setValue(params.sEnterDate);
    eDateEl.setValue(addDate(params.eEnterDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    params = getSearchParams();
    doSearch(params);
}

function onSearch(){
	var params=getSearchParams();
	doSearch(params);
}
function doSearch(params)
{
//	params.orgid = currOrgid;
    rightGrid.load({
        params:params,
        token :token     
    });
}

function editSell(){
    var row = rightGrid.getSelected();
    if(!row) return;
    var part={};
    part.id = "5000";
    part.text = "销售开单详情";
    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.sellBill.flow?token="+token;
    part.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {
        id: row.id
    };
    window.parent.activeTabAndInit(part,params);
}

function onExport(){
	var detail = nui.clone(rightGrid.getData());
//多级
	exportMultistage(rightGrid.columns)
//单级
       //exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
/*		detail[i].status=statusHash[detail[i].status]

		detail[i].billTypeId=billTypeIdList[detail[i].billTypeId].name;
        if(detail[i].isSettle== 1){
        	detail[i].isSettle = "已结算";
        }else{
        	detail[i].isSettle = "未结算";
        }

		if(detail[i].isCollectMoney==1){
			detail[i].isCollectMoney="√";
		}else{
			detail[i].isCollectMoney="";
		}*/
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,rightGrid.columns,"配件销售明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,rightGrid.columns,"已结算工单明细表导出");
	}
	
}
