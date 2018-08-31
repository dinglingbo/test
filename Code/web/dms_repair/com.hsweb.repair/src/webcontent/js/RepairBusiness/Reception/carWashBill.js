/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
var partGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";

var billForm = null;

var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};
var serviceTypeIdEl = null;
var mtAdvisorIdEl = null;

var rpsPackageGrid = null;
var rpsItemGrid = null;
var rpsPartGrid = null;
var packageDetailGrid = null;
var packageDetailGridForm = null;
$(document).ready(function ()
{
    rpsPackageGrid = nui.get("rpsPackageGrid");
    rpsItemGrid = nui.get("rpsItemGrid");
    rpsPartGrid = nui.get("rpsPartGrid");

    billForm = new nui.Form("#billForm");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    
    // innerItemGrid = nui.get("innerItemGrid");
    // innerPartGrid = nui.get("innerPartGrid");
    // innerItemGrid.setUrl(itemGridUrl);
    // innerPartGrid.setUrl(partGridUrl);

    // beginDateEl.setValue(getMonthStartDate());
    // endDateEl.setValue(addDate(getMonthEndDate(), 1));

    document.getElementById("formIframe").src=webPath + contextPath + "/repair/common/pipSelect.jsp";

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
    mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
        nui.get("mtAdvisor").setValue(text);
    });
    // initCustomDicts("receTypeId", "0415",function(data) {
    //     receTypeIdList = nui.get("receTypeId").getData();
    //     receTypeIdList.forEach(function(v) {
    //         receTypeIdHash[v.customid] = v;
    //     });
    // });

    // mainGrid.on("drawcell", function (e) {
    //     if (e.field == "status") {
    //         e.cellHtml = statusHash[e.value];
    //     }else if (e.field == "carBrandId") {
    //         if (brandHash && brandHash[e.value]) {
    //             e.cellHtml = brandHash[e.value].name;
    //         }
    //     }else if (e.field == "serviceTypeId") {
    //         if (servieTypeHash && servieTypeHash[e.value]) {
    //             e.cellHtml = servieTypeHash[e.value].name;
    //         }
    //     }
    // });

    // innerItemGrid.on("drawcell", function (e) {
    //     if (e.field == "receTypeId") {
    //         //e.cellHtml = receTypeIdHash[e.value].name;
    //     }
    // });
    // innerPartGrid.on("drawcell", function (e) {
    //     if (e.field == "receTypeId") {
    //         //e.cellHtml = receTypeIdHash[e.value].name;
    //     }
    // });

    add();
    rpsPackageGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "packageOptBtn":
                    e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                '<span class="fa fa-plus" onClick="javascript:addPackNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                                ' <span class="fa fa-close" onClick="javascript:deletePackRow()" title="删除行"></span>';
                    break;
            default:
                break;
        }
    });
    rpsItemGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "itemOptBtn":
                    e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                '<span class="fa fa-plus" onClick="javascript:addItemNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                                ' <span class="fa fa-close" onClick="javascript:deleteItemRow()" title="删除行"></span>';
                    break;
            default:
                break;
        }
    });
    rpsPartGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "partOptBtn":
                    e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                                '<span class="fa fa-plus" onClick="javascript:addPartNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                                ' <span class="fa fa-close" onClick="javascript:deletePartRow()" title="删除行"></span>';
                    break;
            case "receTypeId":
                if (receTypeIdHash && receTypeIdHash[e.value]) {
                    e.cellHtml = receTypeIdHash[e.value].name;
                }
            default:
                break;
        }
    });   
    //doSearch(p);
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
            params.status = 0;  //制单
            break;
        case 1:
            params.status = 1;  //施工
            break;
        case 2:
            params.status = 2;  //完工
            document.getElementById("advancedMore").style.display='block';
            break;
        case 3:
            params.status = 2;  //待结算  is_settle
            params.isSettle = 0;
            break;
        case 4:
            params.isSettle = 1;
            document.getElementById("advancedMore").style.display='block';
            break;
        default:
            break;
    }

    doSearch(params);
}
function onSearch()
{
    var params = {};
    if(document.getElementById("advancedMore").style.display!='block'){
        var value = nui.get("carNo-search").getValue()||"";
        value = value.replace(/\s+/g, "");
        if(!value){
            showMsg("请输入查询条件!","W");
            return;
        }
    }
    doSearch(params);
}
function doSearch(params) {
    var gsparams = getSearchParam();
    gsparams.status = params.status;
    gsparams.statusList = params.statusList;
    gsparams.isSettle = params.isSettle;

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
function add(){
    // $("#servieIdEl").html("综合开单详情");
    // $("#carNoEl").html("");
    // //$("#wechatTag").css("color","#62b900");
    // $("#guestNameEl").html("");
    // $("#guestTelEl").html("");
    // $("#cardPackageEl").html("次卡套餐(0)");
    // $("#clubCardEl").html("会员卡(0)");
    // $("#creditEl").html("挂账:0");
    // $("#carHealthEl").html("车况:0");

    rpsPackageGrid.setData([]);
    rpsItemGrid.setData([]);
    rpsPartGrid.setData([]);
    billForm.setData([]);
    //sendGuestForm.setData([]);
    //insuranceForm.setData([]);
    //describeForm.setData([]);

    nui.get("mtAdvisorId").setValue(currEmpId);
    nui.get("mtAdvisor").setValue(currUserName);
    nui.get("serviceTypeId").setValue(3);
    nui.get("recordDate").setValue(now);

    var row = {};
    rpsPackageGrid.addRow(row);
    rpsItemGrid.addRow(row);
    rpsPartGrid.addRow(row);
}
function addPrdt(){
    var row = {};
    rpsPackageGrid.addRow(row);
    rpsItemGrid.addRow(row);
    rpsPartGrid.addRow(row);
}
function checkPrdt(){
    var row = {};
    rpsPackageGrid.addRow(row);
    rpsItemGrid.addRow(row);
    rpsPartGrid.addRow(row);
}
function addPackNewRow(){
    var newRow = {};
    rpsPackageGrid.addRow(newRow);
}
function addItemNewRow(){
    var newRow = {};
    rpsItemGrid.addRow(newRow);
}
function addPartNewRow(){
    var newRow = {};
    rpsPartGrid.addRow(newRow);
}
function deletePackRow(){
    var data = rpsPackageGrid.getData();
    if(data && data.length==1){
        var row = rpsPackageGrid.getSelected();
        rpsPackageGrid.removeRow(row);
        var newRow = {};
        rpsPackageGrid.addRow(newRow);
    }else{
        var row = rpsPackageGrid.getSelected();
        rpsPackageGrid.removeRow(row);
    }
}
function deleteItemRow(){
    var data = rpsItemGrid.getData();
    if(data && data.length==1){
        var row = rpsItemGrid.getSelected();
        rpsItemGrid.removeRow(row);
        var newRow = {};
        rpsItemGrid.addRow(newRow);
    }else{
        var row = rpsItemGrid.getSelected();
        rpsItemGrid.removeRow(row);
    }
}
function deletePartRow(){
    var data = rpsPartGrid.getData();
    if(data && data.length==1){
        var row = rpsPartGrid.getSelected();
        rpsPartGrid.removeRow(row);
        var newRow = {};
        rpsPartGrid.addRow(newRow);
    }else{
        var row = rpsPartGrid.getSelected();
        rpsPartGrid.removeRow(row);
    }
}