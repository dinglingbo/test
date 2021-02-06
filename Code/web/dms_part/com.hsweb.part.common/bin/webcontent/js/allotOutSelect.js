/**
 * Created by Administrator on 2018/2/9.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var gridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsOutMainDetail.biz.ext";
                       
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
$(document).ready(function(v)
{
    grid = nui.get("datagrid1");
    grid.setUrl(gridUrl);
    grid.on("beforeload",function(e){
        e.data.token = token;
    });
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    queryForm = new nui.Form("#queryForm");
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
    params.guestId = params.guestId.toString();
    return params;
}
function doSearch(params)
{
    params.outTypeId = "050206";
    params.outBackableQtyGreaterZero = 1;
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
    if(searchData.outIdList)
    {
        var tmpList = searchData.outIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.outIdList = tmpList.join(",");
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
    var outDetail = grid.getSelected();
    if(outDetail)
    {
        resutlData.outDetail = outDetail;
        if(callback)
        {
            grid.removeRow(outDetail,true);
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
    var guestFullName = data.guestFullName||"";
    var storeId = nui.get("storeId");
    if(guestId)
    {
        nui.get("guestId").setValue(guestId);
        nui.get("guestId").setText(guestFullName);
        nui.get("guestId").disable();
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
    switch (e.field)
    {
	    case "partBrandId":
	    	 if(partBrandIdHash[e.value])
             {
//                 e.cellHtml = partBrandIdHash[e.value].name||"";
             	if(partBrandIdHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+partBrandIdHash[e.value].name||"";
             	}else{
             		e.cellHtml =partBrandIdHash[e.value].name||"";
             	}
             }
             else{
                 e.cellHtml = "";
             }
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
