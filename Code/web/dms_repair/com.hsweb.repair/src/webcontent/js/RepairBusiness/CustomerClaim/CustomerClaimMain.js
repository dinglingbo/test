/**
 * Created by Administrator on 2018/4/16.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var serviceTypeIdHash = {};
var mtTypeHash = {};
var carBrandHash = {};
var insuranceCompanyHash = {};
var orgHash = {};
var receTypeHash = {};
var itemKindHash = {};
var claimsItemGrid = null;
var claimsPartGrid = null;
var basicInfoForm = null;
var leftGrid = null;
var leftGridUrl = baseUrl+"com.hsapi.repair.repairService.claims.queryClaimsList.biz.ext";
var queryInfoForm = null;
$(document).ready(function ()
{
    queryInfoForm = new nui.Form("#queryInfoForm");
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("drawcell",function(e){
        var field = e.field;
        if(field == "partAudit")
        {
            e.cellHtml = e.value == 1?"已审":"未审";
        }
        else if(field == "carBrandId" && carBrandHash[e.value])
        {
            e.cellHtml = carBrandHash[e.value].carBrandZh;
        }
    });
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['getDictItems','getAllCarBrand','getDatadictionaries2'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        onSearch();
    };
    var pId2 = "DDT20130703000057";
    getDatadictionaries(pId2, function (data) {
        data = data || {};
        var list = data.list || [];
        list.forEach(function (v) {
            itemKindHash[v.customid] = v;
        });
        hash.getDatadictionaries2 = true;
        checkComplete();
    });
    var dictIdList = [];
    dictIdList.push("DDT20130706000013");//收费类型
    dictIdList.push("DDT20130706000014");//收费类型
    dictIdList.push("DDT20150726000001");//索赔类型
    getDictItems(dictIdList, function (data) {
        data = data || {};
        var itemList = data.dataItems || [];
        var receTypeList = itemList.filter(function (v)
        {
            if("DDT20130706000013" == v.dictid || "DDT20130706000014" == v.dictid)
            {
                receTypeHash[v.customid] = v;
                return true;
            }
        });
        var claimsTypeList = itemList.filter(function (v) {
            return "DDT20150726000001" == v.dictid;
        });
     //   nui.get("claimsType").setData(claimsTypeList);
        hash.getDictItems = true;
        checkComplete();
    });
    getAllCarBrand(function(data)
    {
        data = data||{};
        var carBrandList = data.carBrands||[];
        carBrandList.forEach(function (v) {
            carBrandHash[v.id] = v;
        });
      //  nui.get("carBrandId").setData(carBrandList);
        hash.getAllCarBrand = true;
        checkComplete();
    });
});

function getSearchParams()
{
    var params = queryInfoForm.getData;
    if(params.startDate)
    {
        params.startDate = params.startDate.substr(0,10);
    }
    if(params.endDate)
    {
        params.endDate = params.endDate.substr(0,10);
    }
    if(params.state<0)
    {
        delete params.state;
    }
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
    params.orgid = currOrgid;
    leftGrid.load({
        params:params
    });
}




function claimDetail(claimsId,onlyShow)
{
    nui.open({
        url: "com.hsweb.RepairBusiness.ClaimRegister.flow",
        allowResize:false,
        title: "索赔登记", width: 980, height: 600,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {
                type:"new"
            };
            if(claimsId)
            {
                data.type = "edit";
                data.claimsId = claimsId;
            }
            if(onlyShow)
            {
                data.type = "show";
            }
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action)
        {
        }
    });
}

function add() {
    claimDetail();
}
function edit()
{
    var row = leftGrid.getSelected();
    if(row)
    {
        claimDetail(row.id);
    }

}
function showDetail()
{
    claimDetail(1,true);
}
