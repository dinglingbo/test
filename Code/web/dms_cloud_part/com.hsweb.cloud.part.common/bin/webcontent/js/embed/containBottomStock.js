/**
 * Created by Administrator on 2018/3/17.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryPartStoreStock.biz.ext";
var priceGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.pricemanage.getPartPriceInfo.biz.ext";
var basicInfoForm = null;
var rightGrid = null;
var priceGrid = null;
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

    priceGrid = nui.get("priceGrid");
    priceGrid.setUrl(priceGridUrl);

    /*comPartNameAndPY = nui.get("comPartNameAndPY");
    comPartCode = nui.get("comPartCode");
    partBrandId = nui.get("partBrandId");
    storeId = nui.get("storeId");
    storeShelf = nui.get("storeShelf");
    partId = nui.get("partId");
    showAll = nui.get("showAll");*/

    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
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
});
function getSearchParam(){
    var params = {};
    return params;
}
function onSearch(){
    var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
    //params.sortField = "b.stock_qty";
    //params.sortOrder = "desc";
    rightGrid.load({
        params:params,
        token:token
    });

    priceGrid.load({
        params:params,
        token:token
    });
}
function onDrawCell(e)
{
    switch (e.field)
    {
	    case "partBrandId":
	        if(partBrandIdHash[e.value])
	        {
	//            e.cellHtml = partBrandIdHash[e.value].name||"";
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
