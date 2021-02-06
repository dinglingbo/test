/**
 * Created by Administrator on 2018/3/17.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.stockcal.queryOutableEnterGridWithPage.biz.ext";
var basicInfoForm = null;
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var partBrandId = null;
var storeId = null;
var storeShelf = null;
var partId = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var billStatusHash = {
    "0":"未审",
    "1":"已审",
    "2":"已过账",
    "3":"已取消"
};
$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);

    comPartNameAndPY = nui.get("comPartNameAndPY");
    comPartCode = nui.get("comPartCode");
    partBrandId = nui.get("partBrandId");
    storeId = nui.get("storeId");
    storeShelf = nui.get("storeShelf");
    partId = nui.get("partId");
    //console.log("xxx");
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        nui.get("partBrandId").setData(partBrandList);
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
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
    });

    comPartCode.focus();

    $("#comPartCode").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#comPartNameAndPY").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#partBrandId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#storeId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#storeShelf").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
});
function getSearchParam(){
    var params = {};
    /*var outableQtyGreaterThanZero = nui.get("outableQtyGreaterThanZero").getValue();
    if(outableQtyGreaterThanZero == 1)
    {
        params.outableQtyGreaterThanZero = 1;
    }*/

    params.partNameAndPY = nui.get("comPartNameAndPY").getValue();
	params.partCode = (nui.get("comPartCode").getValue()).replace(/\s+/g, "");
	params.partBrandId = nui.get("partBrandId").getValue();
	params.storeId = nui.get("storeId").getValue();
	params.storeShelf = nui.get("storeShelf").getValue();
	params.partId = nui.get("partId").getValue();
    return params;
}
function onSearch(){
	var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
	params.sortField = "a.audit_date";
	params.sortOrder = "desc";
	params.showAll = 1;
    rightGrid.load({
        params:params,
        token:token
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
    advancedSearchFormData = {};
    for(var key in searchData)
    {
        advancedSearchFormData[key] = searchData[key];
    }
    var i;
    if(searchData.sOrderDate)
    {
        searchData.sOrderDate = searchData.sOrderDate.substr(0,10);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eOrderDate;
        searchData.eOrderDate = addDate(date, 1);
        searchData.eOrderDate = searchData.eOrderDate.substr(0,10);
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = formatDate(searchData.sAuditDate);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        
    }
    //供应商
    if(searchData.guestId)
    {
        params.guestId = nui.get("guestId").getValue();
    }
    //订单单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    /*if(searchData.outableQtyGreaterThanZero == 0)
    {
        delete searchData.outableQtyGreaterThanZero;
    }*/
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onDrawCell(e)
{
    switch (e.field)
    {
	    case "partBrandId":
	    	 if(partBrandIdHash[e.value])
             {
//                 e.cellHtml = partBrandIdHash[e.value].name||"";
             	if(partBrandIdHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' weight=' '/><br> "+partBrandIdHash[e.value].name||"";
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
        case "enterDayCount":
            var row = e.record;
            var enterTime = (new Date(row.enterDate)).getTime();
            var nowTime = (new Date()).getTime();
            var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
            e.cellHtml = dayCount+1;
            break;
        default:
            break;
    }
}
function onExport(){
    var detail = nui.clone(rightGrid.getData());
    if(detail && detail.length > 0){
        setInitExportData(detail);
    }
}
function setInitExportData(detail){
    var tds = '<td  colspan="1" align="left">[comPartCode]</td>' +
        "<td  colspan='1' align='left'>[comPartName]</td>" +
        "<td  colspan='1' align='left'>[comOemCode]</td>" +
        "<td  colspan='1' align='left'>[partBrandId]</td>" +
        "<td  colspan='1' align='left'>[applyCarModel]</td>" +
        "<td  colspan='1' align='left'>[unit]</td>" +
        "<td  colspan='1' align='left'>[storeId]</td>" +
        "<td  colspan='1' align='left'>[shelf]</td>" +
        "<td  colspan='1' align='left'>[stockQty]</td>" +
        "<td  colspan='1' align='left'>[stockAmt]</td>" +
        "<td  colspan='1' align='left'>[orderQty]</td>" +
        "<td  colspan='1' align='left'>[outableQty]</td>" +
        "<td  colspan='1' align='left'>[onRoadQty]</td>" +
        "<td  colspan='1' align='left'>[lastEnterDate]</td>" +
        "<td  colspan='1' align='left'>[lastOutDate]</td>" +
        "<td  colspan='1' align='left'>[upLimit]</td>" +
        "<td  colspan='1' align='left'>[downLimit]</td>" +
        "<td  colspan='1' align='left'>[remark]</td>";
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.partId){
            var tr = $("<tr></tr>");
            var brandName = "";
            var storeName = "";
            if(detail[i].partBrandId && partBrandIdHash[detail[i].partBrandId]){
                brandName = partBrandIdHash[detail[i].partBrandId].name;
            }
            if(detail[i].storeId && storehouseHash[detail[i].storeId]){
                storeName = storehouseHash[detail[i].storeId].name;
            }
            var lastEnterDate = "";
            var lastOutDate = "";
            if(detail[i].lastEnterDate){
                lastEnterDate = format(detail[i].lastEnterDate, 'yyyy-MM-dd HH:mm:ss');
            }
            if(detail[i].lastOutDate){
                lastOutDate = format(detail[i].lastOutDate, 'yyyy-MM-dd HH:mm:ss');
            }
            tr.append(tds.replace("[comPartCode]", detail[i].comPartCode?detail[i].comPartCode:"")
                         .replace("[comPartName]", detail[i].comPartName?detail[i].comPartName:"")
                         .replace("[comOemCode]", detail[i].comOemCode?detail[i].comOemCode:"")
                         .replace("[partBrandId]", brandName)
                         .replace("[applyCarModel]", detail[i].applyCarModel?detail[i].applyCarModel:"")
                         .replace("[unit]", detail[i].unit?detail[i].unit:"")
                         .replace("[storeId]", storeName)
                         .replace("[shelf]", detail[i].shelf?detail[i].shelf:"")
                         .replace("[stockQty]", detail[i].stockQty?detail[i].stockQty:"")
                         .replace("[stockAmt]", detail[i].stockAmt?detail[i].stockAmt:"")
                         .replace("[orderQty]", detail[i].orderQty?detail[i].orderQty:"")
                         .replace("[outableQty]", detail[i].outableQty?detail[i].outableQty:"")
                         .replace("[onRoadQty]", detail[i].onRoadQty?detail[i].onRoadQty:"")
                         .replace("[lastEnterDate]", lastEnterDate)
                         .replace("[lastOutDate]", lastOutDate)
                         .replace("[upLimit]", detail[i].upLimit?detail[i].upLimit:"")
                         .replace("[downLimit]", detail[i].downLimit?detail[i].downLimit:"")
                         .replace("[remark]", detail[i].remark?detail[i].remark:""));
            tableExportContent.append(tr);
        }
    }
    method5('tableExcel',"库存查询"+(format((new Date()), 'yyyy-MM-dd HH:mm:ss')),'tableExportA');
}