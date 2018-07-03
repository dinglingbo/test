/**
 * Created by Administrator on 2018/3/17.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl+"com.hsapi.repair.repairService.svr.queryCustomerList.biz.ext";
var queryForm = null;
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var carBrandIdEl = null;
var carModelIdEl = null;
var carModelIdHash = {};
$(document).ready(function(v){

    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("drawcell",onDrawCell);
    queryForm = new nui.Form("#queryForm");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");

    carBrandIdEl = nui.get("carBrandId");
    carModelIdEl = nui.get("carModelId");
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initCarBrand',"initInsureComp"];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        onSearch();
    };
    initCarBrand("carBrandId",function()
    {
        hash.initCarBrand = true;
        checkComplete();
    });
    carBrandIdEl.on("valuechanged",function()
    {
        var carBrandId = carBrandIdEl.getValue();
        getCarModel("carModelId",{
            value:carBrandId
        });
    });
    initInsureComp("insureComp",function(){
        hash.initInsureComp = true;
        checkComplete();
    });
});
function getSearchParams()
{
    var params = queryForm.getData();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
var currType = 0;
function quickSearch(type)
{
    currType = type;
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    var params = {};
    switch(type)
    {
        case 0:
            params.todayEnter = 1;
            break;
        case 1:
            params.yesterdayEnter = 1;
            break;
        case 2:
            params.todayNew = 1;
            break;
        case 3:
            params.thisMonthNew = 1;
            break;
        case 4:
            params.thisMonthEnter = 1;
            break;
        case 5:
            params.thisMonthLoss = 1;
            break;
        case 6:
            params.lastMonthLoss = 1;
            break;
        default:
            break;
    }
}
function doSearch(params)
{
    grid.load({
        token:token,
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
    for(var key in searchData)
    {
        advancedSearchFormData[key] = searchData[key];
    }
    var i;
    if(searchData.lastEnterStart)
    {
        searchData.lastEnterStart = searchData.lastEnterStart.substr(0,10);
    }
    if(searchData.lastEnterEnd)
    {
        searchData.lastEnterEnd = searchData.lastEnterEnd.substr(0,10);
    }

    if(searchData.firstEnterStart)
    {
        searchData.firstEnterStart = searchData.firstEnterStart.substr(0,10);
    }
    if(searchData.firstEnterEnd)
    {
        searchData.firstEnterEnd = searchData.firstEnterEnd.substr(0,10);
    }

    if(searchData.lastOutStart)
    {
        searchData.lastOutStart = searchData.lastOutStart.substr(0,10);
    }
    if(searchData.lastOutEnd)
    {
        searchData.lastOutEnd = searchData.lastOutEnd.substr(0,10);
    }

    if(searchData.recordStart)
    {
        searchData.recordStart = searchData.recordStart.substr(0,10);
    }
    if(searchData.recordEnd)
    {
        searchData.recordEnd = searchData.recordEnd.substr(0,10);
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function addOrEditCustomer(guest)
{
    var title = "新增客户资料";
    if(guest)
    {
        title = "修改客户资料";
    }
    nui.open({
        url: "com.hsweb.repair.DataBase.AddEditCustomer.flow",
        title: title, width: 560, height: 570,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {};
            if(guest)
            {
                params.guest = guest;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if("ok" == action)
            {
                grid.reload();
            }
        }
    });
}

function addSimple(){
    nui.open({
        url: repairDomain + "/com.hsweb.repair.DataBase.AddEditCustSimple.flow",
        title:"快速新增", width: 400, height: 320,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {};
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if("ok" == action)
            {
                //grid.reload();
            }
        }
    });
}
function add()
{
    addOrEditCustomer();
}
function edit() {
    var row = grid.getSelected();
    if (row)
    {
        addOrEditCustomer(row);
    } else {
        nui.alert("请选中一条数据", "系统提示");
    }
}

function amalgamate() {
    nui.open({
        url: "Amalgamate.jsp",
        title: "资料合并", width: 600, height: 400,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "amalgamate"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}

function split() {
    nui.open({
        url: "Split.jsp",
        title: "资料拆分", width: 800, height: 430,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {pageType: "split"};
            iframe.contentWindow.setData(data);
        },

        ondestroy: function (action) {
            grid.reload();
        }
    });
}

function history()
{
	var row = grid.getSelected();
	if(!row || !row.guestId)
    {
        return;
    }
    nui.open({
        url: "com.hsweb.repair.common.repairHistory.flow",
        title: "维修历史", width: 850, height: 640,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {
                guestId:row.guestId
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
        }
    });
}