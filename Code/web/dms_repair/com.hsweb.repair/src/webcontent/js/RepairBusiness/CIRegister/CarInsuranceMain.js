/**
 * Created by Administrator on 2018/4/25.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGrid = null;
var leftGridUrl = baseUrl+"com.hsapi.repair.repairService.insurance.queryRpsInsuranceList.biz.ext";
var insuranceGrid = null;
var detailGrid = null;
var detailGridUrl = baseUrl+"com.hsapi.repair.repairService.insurance.getInsuranceDetailByServiceId.biz.ext";
var statusHash = ["草稿","提交","完成"];

var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
$(document).ready(function ()
{
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");

    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }
        else {
            onDrawCell(e);
        }
    });
    leftGrid.on("rowdblclick", function (e) {
        var row = e.record;
        getMaintainById(row.id);
        loadDetailGridData(row.id);
    });
    leftGrid.on("load", function () {
        var row = leftGrid.getSelected();
        if (row) {
            getMaintainById(row.id);
            loadDetailGridData(row.id);
        }
    });
    detailGrid = nui.get("detailGrid");
    detailGrid.setUrl(detailGridUrl);
    detailGrid.on("drawcell",function(e){
        var field = e.field;
        var row = e.record;
        if(field == "action")
        {
            e.cellHtml = "<a href='javascript:;' onclick='delDetail(\""+row.insuranceId+"\")'>删除</a>"
        }
        else{
            onDrawCell(e);
        }
    });
    insuranceGrid = nui.get("insuranceGrid");
    insuranceGrid.on("drawcell",function(e){
        var field = e.field;
        var row = e.record;
        if(field == "action")
        {
            e.cellHtml = "<a href='javascript:;' onclick='addDetail(\""+row.customid+"\")'>购买</a>"
        }
    });
    basicInfoForm = new nui.Form("#basicInfoForm");
    init(function () {
        quickSearch(0);
    });
});
function init(callback)
{
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initCarBrand'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    initDicts({
        insuranceType:INSURANCE_TYPE,//保险类型
        insuranceGrid:INSURANCE_DETAIL //险种
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    initRoleMembers({
        insuranceCommissioner:"010807"//车险专员
    },function(){
    });
    initCarBrand("carBrandId",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
    initInsureComp("insuranceSaliComany",function(){
        var list = nui.get("insuranceSaliComany").getData();
        nui.get("insuranceBizComany").setData(list);
        hash.initInsureComp = true;
        checkComplete();
    });
}
function getMaintainById(id)
{
    var url = baseUrl+"com.hsapi.repair.repairService.insurance.getRpsInsuranceMainById.biz.ext";
    doPost({
        url : url,
        data : {
            params:{
                id:id
            }
        },
        success : function(data)
        {
            data = data||{};
            var main = data.main;
            basicInfoForm.setData(main);
            nui.get("guestId").setText(main.guestFullName);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.alert("网络出错，获取数据失败")
        }
    });
}
function loadDetailGridData(serviceId)
{
    detailGrid.load({
        serviceId:serviceId,
        token:token
    });
}
function selectCustomer()
{
    var params = {
        carNo:"carNo",
        carId:"carId",
        carBrandId:"carBrandId",
        carModel:"carModel",
        underpanNo:"underpanNo",
        engineNo:"engineNo",
        guestId:"guestId",
        guestFullName:"insuranceMan",
        mobile:"mobile"
    };
    SelectCustomer(params);
}
function reload()
{

}
function addDetail(customid)
{
    var main = basicInfoForm.getData();
    if(main.status != 0)
    {
        return;
    }
    var old = detailGrid.findRow(function(v){
        return v.insuranceId == customid;
    });
    if(old)
    {
        return;
    }
    var row = {
        insuranceId:customid,
        dutyAmt:0,
        premium:0
    };
    detailGrid.addRow(row);
}
function delDetail(insuranceId)
{
    var main = basicInfoForm.getData();
    if(main.status != 0)
    {
        return;
    }
    var row = detailGrid.findRow(function(v){
        return v.insuranceId == insuranceId;
    });
    if(row)
    {
        detailGrid.removeRow(row);
    }
}
function add()
{
    var data = {
        serviceCode:"新保险单",
        orderType:1,
        recorder:currUserName
    };
    basicInfoForm.setData(data);
}
function save()
{
    var main = basicInfoForm.getData();
    if(!main.serviceCode ||  main.status !=0)
    {
        return;
    }
    if(!main.insuranceType)
    {
        nui.alert("请选择保险类型");
        return;
    }
    var detail = detailGrid.getData();
    if(detail.length == 0)
    {
        nui.alert("请选择险种");
        return;
    }
    nui.mask({
        html:'保存中..'
    });
    if(!main.id)
    {
        //新增
        getServiceCode(function(data)
        {
            var serviceCode = data.serviceCode;
            if(!serviceCode)
            {
                nui.alert("获取单号失败");
                return;
            }
            main.serviceCode = serviceCode;
            doSave(main);
        });
    }
    else{
        doSave(main);
    }
}
function calculateAmt(main,list)
{
    var insuranceSaliAmt = 0;//012110
    var insuranceBizAmt = 0;
    var carBoartTax = 0;//012112
    for(var i=0;i<list.length;i++)
    {
        var tmp = list[i];
        if(tmp.insuranceId == "012110")
        {
            insuranceSaliAmt += tmp.premium;
        }
        else if(tmp.insuranceId == "012112")
        {
            carBoartTax += tmp.premium;
        }
        else{
            insuranceBizAmt += tmp.premium;
        }
    }
    main.insuranceSaliAmt = insuranceSaliAmt;
    main.carBoartTax = carBoartTax;
    main.insuranceBizAmt = insuranceBizAmt;
    main.insuranceAmt = insuranceSaliAmt + carBoartTax + insuranceBizAmt;
    main.insuranceSaliRate = main.insuranceSaliRate||0;
    main.insuranceBizRate = main.insuranceBizRate||0;
    main.commissionAmt = (main.insuranceSaliRate * insuranceSaliAmt + main.insuranceBizRate * insuranceBizAmt) / 100;
    main.discount = main.discount||0;
    main.othetExpense = main.othetExpense||0;
    main.grossProfit = main.commissionAmt - main.discount - main.othetExpense;
    main.commissionAmt = main.commissionAmt.toFixed(2);
    main.grossProfit = main.grossProfit.toFixed(2);
}
function doSave(main)
{
    var list = detailGrid.getData();
    calculateAmt(main,list);
    var insList = list.filter(function(v){
        return !v.serviceId;
    });
    var updList = list.filter(function(v){
        return v.serviceId;
    });
    var delList = detailGrid.getChanges("removed").filter(function(v){
        return v.serviceId;
    });
    var url = baseUrl+"com.hsapi.repair.repairService.insurance.saveInsurance.biz.ext";
    doPost({
        url : url,
        data : {
            main:main,
            insList:insList,
            updList:updList,
            delList:delList
        },
        success : function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("保存成功");
                reload();
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错，保存失败");
        }
    });
}
function getServiceCode(callback)
{
    var billTypeCode = "BXD";
    getCompBillNO(billTypeCode,function(data){
        console.log(data);
        var code = data.serviceno||"";
        callback && callback({
            serviceCode:code
        });
    });
}

var searchByDateBtnTextHash = ["本日","昨日","本周","上周","本月","上月","本年","上年"];
var currType = 0;
function quickSearch(type) {
    var params = {};
    currType = type;

    var btn = nui.get("searchByDateBtn");
    if(btn)
    {
        var text = searchByDateBtnTextHash[type];
        btn.setText(text);
    }
    var dateObj = getDate(type);
    var data = advancedSearchForm.getData();
    data.startDate = dateObj.startDate;
    data.endDate = dateObj.endDate;
    advancedSearchForm.setData(data);
    onSearch();
}
function getSearchParams()
{
    var params = {};
    var data = advancedSearchForm.getData();
    params.startDate = data.startDate.substr(0,10);
    params.endDate = data.endDate.substr(0,10);
    params.carNo = nui.get("carNo-search").getValue();
    params.guestFullName = nui.get("guestName").getValue();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params) {
    params.orgid = currOrgid;
    leftGrid.load({
        token:token,
        params: params
    });
}

function settlement()
{
    var main = basicInfoForm.getData();
    if(!main.id || main.status != 0)
    {
        return;
    }
    nui.open({
        url: "com.hsweb.RepairBusiness.SettlementInsurance.flow",
        allowResize:false,
        title: "保险结算", width: 450, height: 520,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {
                main:main
            };
            console.log(main);
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action) {
            reload();
        }
    });
}

function advancedSearch()
{
    advancedSearchWin.show();
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var i,tmpList;
    if(!searchData.startDate || !searchData.endDate)
    {
        nui.alert("起始日期和终止日期不能为空");
        return;

    }
    searchData.startDate = searchData.startDate.substr(0,10);
    searchData.endDate = searchData.endDate.substr(0,10);
    if(searchData.carNoList)
    {
        tmpList = searchData.carNoList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.carNoList = tmpList.join(",");
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel()
{
    advancedSearchWin.hide();
}
function onAdvancedSearchClear()
{
    advancedSearchForm.clear();
}