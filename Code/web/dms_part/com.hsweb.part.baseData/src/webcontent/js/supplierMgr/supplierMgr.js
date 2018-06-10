/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.querySupplierList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;
//信誉等级
var tgradeList = [
    {
        "customid":0,
        "name":"高"
    },
    {
        "customid":1,
        "name":"中"
    },
    {
        "customid":2,
        "name":"低"
    }
];
var tgradeHash = {
    0:tgradeList[0],
    1:tgradeList[1],
    2:tgradeList[2]
};
var billTypeIdList = [];
var billTypeIdHash = {};
var settTypeIdList = [];
var settTypeIdHash = {};
var managerDutyList = [];
var managerDutyHash = {};
var supplierTypeList = [];
var supplierTypeHash = {};
var orgHash={};
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("beforeload",function(e){
        e.data.token = token;
    });
    grid.on("drawcell",function(e)
    {
        var field = e.field;
        if("isDisabled" == field)
        {
            e.cellHtml = e.value==1?"是":"否";
        }
        else if("provinceId" == field)
        {
            if(provinceHash[e.value])
            {
                e.cellHtml = provinceHash[e.value].name||"";
            }
        }
        else if("cityId" == field)
        {
            if(cityHash[e.value])
            {
                e.cellHtml = cityHash[e.value].name||"";
            }
        }
        else if("tgrade" == field)
        {
            if(tgradeHash[e.value]){
                e.cellHtml = tgradeHash[e.value].name||"";
            }
        }
        else{
            onDrawCell(e);
        }
    });
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    //console.log("xxx");
    provinceEl = nui.get("provinceId");
    getProvinceAndCity(function(data)
    {});
    initDicts({
        billTypeId:BILL_TYPE,//票据类型
        managerDuty:MANAGER_DUTY,//供应商负责人职务
        settType:SETT_TYPE,//结算方式
        supplierType:SUPPLIER_TYPE //对象类型
    },function(){
        initComp("orgId");
    });
});
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam() {

    var params = {
        fullName : nui.get("fullName").getValue(),
        advantageCarbrandId : nui.get("advantageCarbrandId").getValue(),
        mobile : nui.get("mobile").getValue(),
        supplierType : nui.get("supplierType").getValue()
    };

    return params;

}
function doSearch(params)
{
    grid.load({
        params:params
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    advancedSearchFormData = searchData;
    advancedSearchWin.hide();
    //console.log(searchData);
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}

function addSuplier()
{
    billTypeIdList = nui.get("billTypeId").getData();
    supplierTypeList = nui.get("supplierType").getData();
    settTypeIdList = nui.get("settType").getData();
    managerDutyList = nui.get("managerDuty").getData();
    nui.open({
        targetWindow: window,
        url: webPath+partDomain+"/com.hsweb.part.baseData.supplierDetail.flow?token=" + token,
        title: "供应商资料", width: 530, height: 480,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                province:provinceList,
                city:cityList,
                supplierType:supplierTypeList,
                billTypeId:billTypeIdList,
                settTypeId:settTypeIdList,
                tgrade:tgradeList,
                managerDuty:managerDutyList
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                grid.reload();
            }
        }
    });
}
function editSuplier()
{
    var row = grid.getSelected();

    if(!row)
    {
        nui.alert("请选择要编辑的数据");
        return;
    }

    if(row && row.orgid == currOrgid)
    {    
        billTypeIdList = nui.get("billTypeId").getData();
        supplierTypeList = nui.get("supplierType").getData();
        settTypeIdList = nui.get("settType").getData();
        managerDutyList = nui.get("managerDuty").getData();
        nui.open({
            targetWindow: window,
            url: webPath+partDomain+"/com.hsweb.part.baseData.supplierDetail.flow?token=" + token,
            title: "供应商资料", width: 530, height: 480,
            allowDrag:true,
            allowResize:false,
            onload: function ()
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData({
                    province:provinceList,
                    city:cityList,
                    supplier:row,
                    supplierType:supplierTypeList,
                    billTypeId:billTypeIdList,
                    settTypeId:settTypeIdList,
                    tgrade:tgradeList,
                    managerDuty:managerDutyList
                });
            },
            ondestroy: function (action)
            {
                if(action == "ok")
                {
                    grid.reload();
                }
            }
        });
    }
}
function onRowDblClick(e)
{
    editSuplier();
}
function onGridRowClick(e)
{
    var row = e.record||grid.getSelected();
    if(!row)
    {
        return;
    }
    if(row.orgid != currOrgid)
    {
        nui.get("editBtn").disable();
    }
    else{
        nui.get("editBtn").enable();
    }
}
function importGuest(){
    billTypeIdList = nui.get("billTypeId").getData();
    settTypeIdList = nui.get("settType").getData();

    nui.open({
        targetWindow: window,
        url: webPath + partDomain + "/com.hsweb.part.baseData.importSupplier.flow?token="+token,
        title: "供应商导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.initData({
                    province:provinceList,
                    city:cityList,
                    billTypeId:billTypeIdList,
                    settTypeId:settTypeIdList
                });
        },
        ondestroy: function (action)
        {
            doSearch();
        }
    });
}