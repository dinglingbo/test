/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.purchase.svr.queryPtsStockCycVList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;

var partBrandHash = {};
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid.on("drawcell",function(e)
    {
        switch (e.field)
        {
            case "partBrandId":
            	if(partBrandIdHash[e.value])
                {
//                    e.cellHtml = partBrandIdHash[e.value].name||"";
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
            default:
                break;
        }
    });
    //console.log("xxx");
    getAllPartBrand(function(data)
    {
        var brand = data.brand||[];
        brand.forEach(function(v)
        {
            if(v && v.id)
            {
                partBrandHash[v.id] = v;
            }
        });
        quickSearch(currType);
    });
});
var currType = 14;
function quickSearch(type){
    var params = {};
    switch (type)
    {
        case 14:
            params.stockQtyLessThanDownLimit = 1;
            break;
        case 15:
            params.stockQtyGreaterThanUpLimit = 1;
            break;
        default:
            break;
    }
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
function doSearch(params)
{
    params.orgid = currOrgid
    rightGrid.load({
        params:params
    });
}