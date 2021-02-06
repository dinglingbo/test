/**
 * Created by Administrator on 2018/3/17.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.query.queryPartStoreStock.biz.ext";
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
var showAll = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
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
    showAll = nui.get("showAll");

    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
     //   nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
    });
});
function getSearchParam(){
    var params = {};
    /*var outableQtyGreaterThanZero = nui.get("outableQtyGreaterThanZero").getValue();
    if(outableQtyGreaterThanZero == 1)
    {
        params.outableQtyGreaterThanZero = 1;
    }*/
    var showZero = nui.get("showAll").getValue();
    if(showZero == 0){
        params.notShowAll = 1;
    }

    params.partNameAndPY = nui.get("comPartNameAndPY").getValue();
    params.partCode = nui.get("comPartCode").getValue();
    params.partBrandId = nui.get("partBrandId").getValue();
    params.storeId = nui.get("storeId").getValue();
    params.storeShelf = nui.get("storeShelf").getValue();
    params.partId = nui.get("partId").getValue();
    params.limitQuery = 1;
    return params;
}
function onSearch(){
    var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
    //params.sortField = "audit_date";
    //params.sortOrder = "desc";
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
function onOk()
{
    var node = rightGrid.getSelected();
    var nodec = nui.clone(node);
    var part = {};
    
    if(!nodec)
    {
        return;
    }
    resultData = {
        part:nodec
    };
    if(!parent.addDetail)
    {
        return;
    }
    else{
        //需要判断是否已经添加了此配件
        var checkMsg = parent.checkPartIDExists(nodec.partId);
        if(checkMsg) 
        {
            nui.confirm(checkMsg, "友情提示",
                function (action) { 
                    if (action == "ok") {
                        part.id = nodec.partId;
                        part.partId = nodec.partId;
                        part.oemCode = nodec.comOemCode;
                        part.partBrandId = nodec.partBrandId;
                        part.applyCarModel = nodec.applyCarModel;
                        part.unit = nodec.unit;
                        part.oemCode = nodec.comOemCode;
                        part.spec = nodec.spec;
                        part.code = nodec.comPartCode;
                        part.name = nodec.partName;
                        part.fullName = nodec.fullName;
                        part.unit = nodec.unit;
                        part.qty = 1;

                        parent.addDetail(part);
                    }else {
                        return;
                    }
                }
            );
        }else
        {
            //弹出数量，单价和金额的编辑界面
            part.id = nodec.partId;
            part.partId = nodec.partId;
            part.oemCode = nodec.comOemCode;
            part.partBrandId = nodec.partBrandId;
            part.applyCarModel = nodec.applyCarModel;
            part.unit = nodec.unit;
            part.oemCode = nodec.comOemCode;
            part.spec = nodec.spec;
            part.code = nodec.comPartCode;
            part.name = nodec.partName;
            part.fullName = nodec.fullName;
            part.unit = nodec.unit;
            part.qty = 1;
            parent.addDetail(part);
        }

    }
}
function onRowDblClick()
{
    onOk();
}
function setToolBar(type){
	if(type == "hide"){
		nui.get("toolmain").hide();
	}
}
