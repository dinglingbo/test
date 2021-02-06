/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryComprehensive.biz.ext";
var getdRpsPackageUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext";
var getRpsItemUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";

var beginDateEl = null;
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"车架号(VIN)"},{id:"2",name:"客户名称"},{id:"3",name:"手机号"}];
var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};
var mtAdvisorIdEl = null;
var serviceTypeIdEl = null;
var serviceTypeIds = null;
var advancedMore = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var editFormDetail = null;
var innerItemGrid = null;
var advancedSearchWin = null;
var orgidsEl = null;
//var serviceTypeIds = null;
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"工时",
	    "3":"配件"
};
$(document).ready(function ()
{
    beginDateEl = nui.get("sOutDate");
	endDateEl = nui.get("eOutDate");
//    var date = new Date();
//    var sdate = new Date();
//    sdate.setMonth(date.getMonth()-3);
//    endDateEl.setValue(date);
//	beginDateEl.setValue(sdate);
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
//    beginDateEl = nui.get("sRecordDate");
//    endDateEl = nui.get("eRecordDate");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    serviceTypeIds = nui.get("serviceTypeIds");
    advancedSearchForm = new nui.Form("#advancedSearchForm");
    editFormDetail = document.getElementById("editFormDetail");
    innerItemGrid = nui.get("innerItemGrid");
    innerpackGrid = nui.get("innerpackGrid");
	advancedSearchWin = nui.get("advancedSearchWin");
    innerItemGrid.setUrl(getRpsItemUrl);
    innerpackGrid.setUrl(getdRpsPackageUrl);
    
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
    onSearch();
    initMember("mtAdvisorId",function(){     
        initServiceType("serviceTypeId",function(data) {
            servieTypeList = nui.get("serviceTypeId").getData();
            servieTypeList.forEach(function(v) {
                servieTypeHash[v.id] = v;
            });
            serviceTypeIds.setData(servieTypeList);

            initCarBrand("carBrandId",function(data) {
                brandList = nui.get("carBrandId").getData();
                brandList.forEach(function(v) {
                    brandHash[v.id] = v;
                });

            });


        });

    });


    mainGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if (e.field == "carBrandId") {
            if (brandHash && brandHash[e.value]) {
                e.cellHtml = brandHash[e.value].name;
            }
        }else if (e.field == "serviceTypeId") {
            if (servieTypeHash && servieTypeHash[e.value]) {
                e.cellHtml = servieTypeHash[e.value].name;
            }
        }else if(e.field == "isSettle"){
            if(e.value == 1){
                e.cellHtml = "已结算";
            }else{
                e.cellHtml = "未结算";
            }
        }else if(e.field == "orgid"){
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
        	
        }
    });
    innerItemGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        switch (e.field) {
            case "prdtName":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId>0){
                    e.cellHtml = e.value + "<font color='red'>(预存)</font>";
                }
                break;
            case "serviceTypeId":
                var type = record.type||0;
                if(type>2){
                    e.cellHtml = "--";
                    e.cancel = false;
                }else{
                    e.cellHtml = servieTypeHash[e.value].name;
                }
                break;
            case "workers":
                var type = record.type||0;
                if(type != 2){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = e.value;
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value&&value!="0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            default:
                break;
        }
        
    });
    
    innerpackGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        switch (e.field) {
		   case "prdtName":
		        var cardDetailId = record.cardDetailId||0;
		        if(cardDetailId>0){
		            e.cellHtml = e.value + "<font color='red'>(预存)</font>";
		        }
            break;
	        case "serviceTypeId":
	            var type = record.type||0;
	            if(type>1){
	                e.cellHtml = "--";
	            }else{
	                e.cellHtml = servieTypeHash[e.value].name;
	            }
            break;
            case "saleMan":
                var type = record.type||0;
                var cardDetailId = record.cardDetailId||0;
                if(type>1 || cardDetailId> 0){
                    e.cellHtml = "--";
                }
                break;
            case "workers":
                var type = record.type||0;
                var cardDetailId = record.cardDetailId||0;
                if(type != 2){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = e.value;
                }
                break;
            case "serviceTypeId":
                if(servieTypeHash[e.value])
                {
                    e.cellHtml = servieTypeHash[e.value].name;
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value&&value!="0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            case "type":
                if(e.value == 1){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = prdtTypeHash[e.value];
                }
                break;
            default:
                break;
        }
    });

    quickSearch(2);
});
var statusHash = {
    "0" : "报价",
    "1" : "施工",
    "2" : "完工",
    "3" : "待结算",
    "4" : "已结算"
};

function clear(){
    advancedSearchForm.setData([]); 
    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
}
function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = mainGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";

    innerItemGrid.setData([]);
    innerpackGrid.setData([]);
    var serviceId = row.id;
    innerItemGrid.load({
    	serviceId:serviceId,
        token: token
    });

    innerpackGrid.load({
    	serviceId:serviceId,
        token: token
    });
}

function quickSearch(type){
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sOutDate = getNowStartDate();
            params.eOutDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sOutDate = getPrevStartDate();
            params.eOutDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sOutDate = getWeekStartDate();
            params.eOutDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sOutDate = getLastWeekStartDate();
            params.eOutDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sOutDate = getMonthStartDate();
            params.eOutDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sOutDate = getLastMonthStartDate();
            params.eOutDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sOutDate = getYearStartDate();
            params.eOutDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sOutDate = getPrevYearStartDate();
            params.eOutDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
       
        default:
            break;
    }
    
    beginDateEl.setValue(params.sOutDate);
    endDateEl.setValue(addDate(params.eOutDate,-1));
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    
    doSearch(params);
}

function carNoSearch(){
	onSearch();
}

function onSearch()
{
    doSearch();
}
function doSearch() {
    var gsparams = getSearchParam();
    gsparams.isSettle = 1;
    gsparams.billTypeId = 2;
    gsparams.isDisabled = 0;

    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    params.sOutDate = nui.get("sOutDate").getValue();
    params.eOutDate = addDate(endDateEl.getValue(),1);  
    params.mtAuditorId = mtAdvisorIdEl.getValue();
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.vin = typeValue;
    }else if(type==2){
        params.name = typeValue;
    }else if(type==3){
        params.mobile = typeValue;
    }
    return params;
}
function onAdvancedSearchCancel(){
    advancedSearchWin.hide();
}
function onAdvancedSearchOk(){
    var params = {};
    doSearch(params);
    advancedSearchWin.hide();
}
function add(){
    var item={};
    item.id = "2000";
    item.text = "综合开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairBill.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {};
    window.parent.activeTabAndInit(item,params);

}
function edit(){
    var row = mainGrid.getSelected();
    if(!row) return;
    var item={};
    item.id = "3000";
    item.text = "洗美开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.carWashBill.flow?token="+token;
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {
        id: row.id
    };
    window.parent.activeTabAndInit(item,params);
}
//根据开单界面传递的车牌号查询未结算的工单
function setInitData(params){
    var carNo = params.carNo||"";
    var type = params.type||""
    if(type=='view' && carNo != ""){
        var p = {
            carNoEqual: carNo,
            isSettle: 0
        };
        mainGrid.load({
            token:token,
            params: p
        });
    }
}