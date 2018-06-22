/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + repairDomain + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
var partGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"VIN码"},{id:"2",name:"客户名称"},{id:"3",name:"手机号"}];
var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};
var mtAdvisorIdEl = null;
var serviceTypeIdEl = null;
var advancedMore = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var editFormDetail = null;
var innerItemGrid = null;
var innerPartGrid = null;
$(document).ready(function ()
{
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    beginDateEl = nui.get("sEnterDate");
    endDateEl = nui.get("eEnterDate");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    advancedMore = nui.get("advancedMore");
    advancedSearchForm = new nui.Form("#advancedSearchForm");
    editFormDetail = document.getElementById("editFormDetail");
    innerItemGrid = nui.get("innerItemGrid");
    innerPartGrid = nui.get("innerPartGrid");
    innerItemGrid.setUrl(itemGridUrl);
    innerPartGrid.setUrl(partGridUrl);

    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));

    initMember("mtAdvisorId",null);
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
    initCarBrand("carBrandId",function(data) {
        brandList = nui.get("carBrandId").getData();
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });
    initCustomDicts("receTypeId", "0415",function(data) {
        receTypeIdList = nui.get("receTypeId").getData();
        receTypeIdList.forEach(function(v) {
            receTypeIdHash[v.customid] = v;
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
        }
    });

    innerItemGrid.on("drawcell", function (e) {
        if (e.field == "receTypeId") {
            e.cellHtml = receTypeIdHash[e.value].name;
        }
    });
    innerPartGrid.on("drawcell", function (e) {
        if (e.field == "receTypeId") {
            e.cellHtml = receTypeIdHash[e.value].name;
        }
    });

    var statusList = "0,1,2,3";
    var p = {statusList:statusList};
    doSearch(p);
});
var statusHash = {
    "0" : "制单",
    "1" : "维修",
    "2" : "完工",
    "3" : "待结算",
    "4" : "已结算"
};
function advancedSearch(){
    if(document.getElementById("advancedMore").style.display=='block'){
        document.getElementById("advancedMore").style.display='none';
    }else{
        document.getElementById("advancedMore").style.display='block';
    }
    
}
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
    innerPartGrid.setData([]);

    var params = {};
    params.serviceId = row.id;
    innerItemGrid.load({
        params:params,
        token: token
    });

    innerPartGrid.load({
        params:params,
        token: token
    });
}
function quickSearch(type) {
    var params = {};
    switch (type) {
        case 0:
            params.status = 0;
            break;
        case 1:
            params.status = 1;
            break;
        case 2:
            params.status = 2;
            break;
        case 3:
            params.status = 3;
            break;
        case 4:
            params.status = 4;
            break;
        default:
            break;
    }

    doSearch(params);
}
function onSearch()
{
    var params = {};
    doSearch(params);
}
function doSearch(params) {
    var gsparams = getSearchParam();
    gsparams.status = params.status;
    gsparams.statusList = params.statusList;

    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    if(document.getElementById("advancedMore").style.display=='block'){
        params.sEnterDate = beginDateEl.getValue();
        params.eEnterDate = endDateEl.getValue();
        params.mtAuditor = mtAdvisorIdEl.getValue();
        params.serviceTypeId = serviceTypeIdEl.getValue();
    }
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.vin = typeValue;
    }else if(type==2){
        params.name = typeValue;
    }else if(type==3){
        params.tel = typeValue;
    }
    return params;
}
