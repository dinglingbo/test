/**
 * Created by Administrator on 2018/2/1.
 */
//var baseUrl = apiPath + repairApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.repair.repairService.report.queryRepairOutList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var brandHash = {};
var brandList = [];
partTypeList=[];
partTypeHash={};
var storehouse = null;
var storeHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var outTypeIdHash = {};
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    sReturnDateEl =nui.get('sReturnDate');
    eReturnDateEl = nui.get('eReturnDate');
    

    
	getAllPartBrand(function(data) {
		brandList = data.brand;
		nui.get('partBrandId').setData(brandList);
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});
	
	getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		if(storehouse && storehouse.length>0){
			nui.get('storeId').setData(storehouse);
	
			storehouse.forEach(function(v) {
				storeHash[v.id] = v;
			});
		}
	});

	
	rightGrid.on("drawcell",function(e){
		switch (e.field) {
		case "serviceCode":
			e.cellHtml ='<a href="##" onclick="editSell()">'+e.value+'</a>';
			break;
		case "outReturnSign":
				e.cellHtml="已归库";
			break;
		case "partBrandId":
			  if(brandHash[e.value])
              {
//                  e.cellHtml = brandHash[e.value].name||"";
              	if(brandHash[e.value].imageUrl){
              		
              		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
              	}else{
              		e.cellHtml = brandHash[e.value].name||"";
              	}
              }
              else{
                  e.cellHtml = "";
              }
			break;
		 case "carTypeIdF":
		 case "carTypeIdS":
		 case "carTypeIdT":
            if(partTypeHash[e.value])
            {
                e.cellHtml = partTypeHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
		 case "storeId" :
		     if(storeHash[e.value])
	            {
	                e.cellHtml = storeHash[e.value].name||"";
	            }
	            else{
	                e.cellHtml = "";
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
	
    quickSearch(4);

	getAllPartType(function(data){
		partTypeList=data.partTypes;
		nui.get('partTypeId').setData(partTypeList);
		partTypeList.forEach(function(v){
			partTypeHash[v.id]=v;
		});
	});
});
function getSearchParams(){
    var params = {};
    params.partCode=nui.get("partCode").getValue();
    params.partName=nui.get("partName").getValue();
    params.partBrandId=nui.get("partBrandId").getValue();
    params.storeId=nui.get("storeId").getValue();
    params.partTypeId=nui.get("partTypeId").value;
    params.sReturnDate=nui.get("sReturnDate").getFormValue();
    params.eReturnDate=addDate(eReturnDateEl.getValue(),1);
    return params;
}

var currType = 2;
function quickSearch(type){
	var params = getSearchParams();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sReturnDate = getNowStartDate();
            params.eReturnDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sReturnDate = getPrevStartDate();
            params.eReturnDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sReturnDate = getWeekStartDate();
            params.eReturnDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sReturnDate = getLastWeekStartDate();
            params.eReturnDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sReturnDate = getMonthStartDate();
            params.eReturnDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sReturnDate = getLastMonthStartDate();
            params.eReturnDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.sReturnDate = getYearStartDate();
            params.eReturnDate = getYearEndDate();
            queryname="本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sReturnDate = getPrevYearStartDate();
            params.eReturnDate = getPrevYearEndDate();
            queryname="上年";
            break;
        default:
            break;
    }
    currType = type;
    sReturnDateEl.setValue(params.sReturnDate);
    eReturnDateEl.setValue(addDate(params.eReturnDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}

function onSearch(){
	var params=getSearchParams();
	doSearch(params);
}
function doSearch(params)
{
	params.orgid = currOrgid;
	params.returnSign = 1; //出库
//	params.isSettle=1; //已结算
//	params.status=2; //状态已完工
    rightGrid.load({
        params:params,
        token :token     
    });
}

function editSell(){
    var row = rightGrid.getSelected();
    if(!row) return;
    var billTypeId = row.billTypeId;
    var part={};
    if(billTypeId==0){
	    part.id = "2000";
	    part.text = "综合开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairBill.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==1){
	    part.id = "checkPrecheckDetail";
	    part.text = "查车开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkDetail.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==2){
	    part.id = "3000";
	    part.text = "洗美开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.carWashBill.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==3){
	    part.id = "5000";
	    part.text = "销售开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.sellBill.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==4){
	    part.id = "4000";
	    part.text = "理赔开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.claimDetail.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==5){
	    part.id = "5200";
	    part.text = "退货开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.returnBill.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    //window.parent.activeTab(item);
    var params = {
        id: row.id
    };
    window.parent.activeTabAndInit(part,params);
}