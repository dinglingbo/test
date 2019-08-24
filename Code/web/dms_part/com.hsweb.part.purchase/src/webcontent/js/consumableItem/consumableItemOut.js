
/**
 * Created by Administrator on 2018/2/2.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterMainDetailWithPage.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.part.purchase.repair.queryRepairOutList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var queryForm = null;
var leftGrid = null;
var rightGrid = null;

$(document).ready(function()
{
	leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    leftGrid.on("rowdblclick",function(){
        itemOut();
    });
    
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid.on("drawcell",function(e)
    {
        if(e.field == "action")
        {
            var row = e.record;
            if(row.returnSign != 1)
            {
                e.cellHtml = "<a href='javascript:;' onclick='returnStore("+row.id+")'>退回仓库</a>";
            }
        }
    });
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    queryForm = new nui.Form("#queryForm");

    getStorehouse(function(data)
    {
        var storehouseList = data.storehouse||[];
        if(storehouseList.length>0)
        {
            nui.get("storeId").setData(storehouseList);
            nui.get("storeId").setValue(storehouseList[0].id);
        }
    });
});
function onSearch1()
{
    var params = getSearchParams();
    doSearchLeft(params);
}
function doSearchLeft(params)
{
	params.outableQtyGreaterThanZero = 1;
	params.orgid = currOrgid;
    leftGrid.load({
        params:params
    });
}
function onSearch2()
{
    var params = getSearchParams();
    doSearchRight(params);
}
function doSearchRight(params)
{
    params.pickType = "050210";
    params.serviceId = "0";
    params.orgid = currOrgid;
    rightGrid.load({
        params:params
    });
}
function getSearchParams()
{
    var params = queryForm.getData();
    if(params.showConsumableItemOnly == 1)
    {
        params.carTypeIdF = '00001942';
    }
    params.orgid = currOrgid;
    return params;
}
function itemOut(){
    var row = leftGrid.getSelected();
    if(!row)
    {
        nui.alert("请选择要领的材料");
        return;
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.purchase.consumableItemOutDetail.flow?token=" + token,
        title: "耗材出库", width: 500, height: 240,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                part:row
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	 leftGrid.reload();
                 rightGrid.reload();
            }
        }
    });
}

function returnStore(id)
{
    var row = rightGrid.findRow(function(v)
    {
        if(v.id = id)
        {
            return true;
        }
    });
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.purchase.consumableItemReturn.flow?token=" + token,
        title: "耗材退回", width: 500, height: 270,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({
                part:row
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	leftGrid.reload();
                rightGrid.reload();
            }
        }
    });
}

function advancedSearch()
{
	if(!advancedSearchFormData)
    {
        advancedSearchFormData = {};
    }
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk(type)
{
    var searchData = advancedSearchForm.getData();
    for(var key in searchData)
    {
        advancedSearchFormData[key] = searchData[key];
    }
    var i,tmpList;
    if(searchData.startDate)
    {
        searchData.startDate = searchData.startDate.substr(0,10);
    }
    if(searchData.endDate)
    {
        searchData.endDate = searchData.endDate.substr(0,10);
    }
    if(searchData.enterIdList)
    {
        tmpList = searchData.enterIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.enterIdList = tmpList.join(",");
    }
    if(searchData.partCodeList)
    {
        tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    advancedSearchWin.hide();
    if(type==1)
    {
        doSearchLeft(searchData);
    }
    else{
        doSearchRight(searchData);
    }
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}