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
        else
        {
            onDrawCell(e);
        }
    });
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initDicts','initCarBrand'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        onSearch();
    };
    initDicts({
        claimsType:CLAIMS_TYPE
    },function(){
        hash.initDicts = true;
        checkComplete();
    });
    initCarBrand("carBrand",function()
    {
        hash.initCarBrand = true;
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
