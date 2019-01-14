/**
 * Created by Administrator on 2018/1/30.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsEnterMainDetail.biz.ext";

var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var grid = null;
var queryForm = null;

var billTypeIdList = [];
var billTypeIdHash = {};
var settTypeIdList = [];
var settTypeIdHash = {};
var storehouseHash = {};
var partBrandIdHash = {};
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("beforeload",function(e){
        e.data.token = token;
    });
    grid.on("drawcell",function(e){
        var field = e.field;
        if("isDisabled" == field)
        {
            e.cellHtml = e.value == 1?"失效":"有效";
        }
        else if("partBrandId" == field)
        {
            if(partBrandIdHash  && partBrandIdHash[e.value])
            {
                e.cellHtml = partBrandIdHash[e.value].name;
            }
        }
        else if("storeId" == field)
        {
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
        }
        else if("outQty" == field)
        {
            e.cellHtml = row.enterQty - row.outableQty;
        }
        else if("carTypeIdF" == field || "carTypeIdS" == field || "carTypeIdT" == field)
        {
            if(partTypeHash[e.value])
            {
                e.cellHtml = partTypeHash[e.value].name||"";
            }
        }
        else if("qualityTypeId" == field)
        {
            if(qualityHash[e.value])
            {
                e.cellHtml = qualityHash[e.value].name||"";
            }
        }
        else{
            onDrawCell(e);
        }
    });
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    queryForm = new nui.Form("#queryForm");
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });

        initDicts({
            billTypeId:BILL_TYPE,//票据类型
            settType:SETT_TYPE //结算方式
        },function(){
        });
    });
});
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    switch (type)
    {
        case 0:
            params.today = 1;
            break;
        case 1:
            params.yesterday = 1;
            break;
        case 2:
            params.thisWeek = 1;
            break;
        case 3:
            params.lastWeek = 1;
            break;
        case 4:
            params.thisMonth = 1;
            break;
        case 5:
            params.lastMonth = 1;
            break;
        case 6:
            params.auditStatus = 0;
            break;
        case 7:
            params.auditStatus = 1;
            break;
        case 8:
            params.postStatus = 1;
            break;
        case 10:
            params.thisYear = 1;
            break;
        case 11:
            params.lastYear = 1;
            break;
        default:
            break;
    }
    currType = type;
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    doSearch(params);
}
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam()
{
    var params = queryForm.getData();

    return params;
}
function doSearch(params)
{
	params.enterTypeId = enterTypeId;
    grid.load({
        params:params
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
 //   advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    advancedSearchWin.hide();
    console.log(searchData);
    var i;
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
        var tmpList = searchData.enterIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.enterIdList = tmpList.join(",");
        //console.log(tmpList);
    }
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.partCodeList = tmpList.join(",");
        //console.log(tmpList);
    }
  //  return;
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
  //  advancedSearchForm.clear();
    advancedSearchWin.hide();
}
var resutlData = {};
function getData()
{
    return resutlData;
}
function onOk()
{
    var enterDetail = grid.getSelected();
    if(enterDetail)
    {
        resutlData.enterDetail = enterDetail;
        if(callback)
        {
            grid.removeRow(enterDetail,true);
            callback(resutlData)
        }
        else{
            CloseWindow("ok");
        }

    }
    else
    {
        showMsg("请选择一条明细","W");
    }
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
var callback = null;
var enterTypeId = "";
function setData(data,ck)
{
    data = data||{};
    callback = ck;
    var guestId = data.guestId||"";
    var storeList = data.storeList||[];
    var guestFullName = data.guestFullName||"";
    var storeId = nui.get("storeId");
    storeId.setData(storeList);
    var store = data.store;
    if(store && store.id)
    {
        storeId.setValue(store.id);
        storeId.disable();
    }
    if(guestId)
    {
        nui.get("guestId").setValue(guestId);
        nui.get("guestId").setText(guestFullName);
        nui.get("guestId").disable();
        nui.get("guestId1").setValue(guestId);
        nui.get("guestId1").setText(guestFullName);
        nui.get("guestId1").disable();
    }
    if(data.enterTypeId)
    {
        enterTypeId = data.enterTypeId;
    }
    if(data.partBrandIdHash)
    {
        partBrandIdHash = data.partBrandIdHash;
    }
    quickSearch(currType);
}
function onPartGridDraw(e)
{
	var row = e.record;
    switch (e.field)
    {
	    case "partBrandId":
	        if(partBrandIdHash  && partBrandIdHash[e.value])
	        {
	            e.cellHtml = partBrandIdHash[e.value].name;
	        }
	        break;
	    case "outQty":
	        e.cellHtml = row.enterQty - row.outableQty;
	        break;
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        case "isDisabled":
            e.cellHtml = e.value == 1?"失效":"有效";
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
        case "qualityTypeId":
            if(qualityHash[e.value])
            {
                e.cellHtml = qualityHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        case "partBrandId":
            //if(brandHash[e.value])
            //{
            //    e.cellHtml = brandHash[e.value].name||"";
            //}
            //else{
            //    e.cellHtml = "";
            //}
            break;
        default:
            break;
    }
}







var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.part.common.supplierSelect.flow?token=" + token,
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                console.log(data);
                console.log(elId);
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
            }
        }
    });
}
