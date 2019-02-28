/**
 * Created by Administrator on 2018/1/23.
 * There must be a query condition
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";
var partGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartList.biz.ext";
var partGrid = null;

var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var abcTypeList = [];
var abcTypeHash = {};
var carBrandList = [];
var queryForm = null;
$(document).ready(function() {
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);


    getAllPartBrand(function(data) {
        qualityList = data.quality;
        qualityList.forEach(function(v) {
            qualityHash[v.id] = v;
        });
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });

        //nui.get("partBrandId").setData(brandList);

        getAllCarBrand(function(data) {
            data = data || {};
            carBrandList = data.carBrands || [];
            
            var dictIdList = [];
            dictIdList.push('DDT20130703000016');// --单位
            dictIdList.push('DDT20130703000067');// --ABC分类
            getDictItems(dictIdList, function(data) {
                if (data && data.dataItems) {
                    var dataItems = data.dataItems || [];
                    unitList = dataItems.filter(function(v) {
                        return v.dictid == 'DDT20130703000016';
                    });
                    abcTypeList = dataItems.filter(function(v) {
                        return v.dictid == 'DDT20130703000067';
                    });
                    abcTypeList.forEach(function(v) {
                        abcTypeHash[v.id] = v;
                    });
                }
            });
        });

    });
    
    getAllPartType(function(data) {
    	partTypeList = data.partTypes;
    	partTypeList.forEach(function(v)
        {
            partTypeHash[v.id] = v;
        });


    });

});
var partTypeHash = null;
function onPartGridDraw(e)
{
    if(!partTypeHash)
    {
        partTypeHash = {};
        //var partTypeList = tree.getList();
        //partTypeList.forEach(function(v)
        //{
       //     partTypeHash[v.id] = v;
        //});
    }

    switch (e.field)
    {
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
        	 if(brandHash[e.value])
             {
//                 e.cellHtml = brandHash[e.value].name||"";
             	if(brandHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
             	}else{
             		e.cellHtml = brandHash[e.value].name||"";
             	}
             }
             else{
                 e.cellHtml = "";
             }
             break;
        case "abcType":
            if(abcTypeHash[e.value])
            {
                e.cellHtml = abcTypeHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        default:
            break;
    }
}


function reloadData()
{
    if(partGrid)
    {
        partGrid.reload();
    }
}
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
function doSearch(params)
{
    partGrid.load({
        params:params,
        token:token
    });
}
