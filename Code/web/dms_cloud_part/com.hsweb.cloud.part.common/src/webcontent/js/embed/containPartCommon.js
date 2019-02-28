var partCommonGrid = null;
var partCommonUrl = cloudPartApiUrl + "com.hsapi.cloud.part.invoicing.query.queryQuickPartCommonWithStock.biz.ext";
var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];

$(document).ready(function(v) {
	partCommonGrid = nui.get("partCommonGrid");
    partCommonGrid.setUrl(partCommonUrl);

    if(partId){
        var params = {partId:partId,type:"LOCAL"};
        doSearch(params);
    }

    getAllPartBrand(function(data) {
        qualityList = data.quality;
        qualityList.forEach(function(v) {
            qualityHash[v.id] = v;
        });
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });

    });

    partCommonGrid.on("drawcell",function(e){
        var row = e.record;
        switch (e.field)
        {
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
//                    e.cellHtml = brandHash[e.value].name||"";
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
            case "partCode":
                if(row.sourceType == 'EPC'){
                    var value = e.value;
                    var brandname = row.brandname||"";
                    if(brandname){
                        value = value+'('+brandname+')';
                    }
                    e.cellHtml = "<span class='fa fa-cloud' style='color:#1e395b'></span>"+(value||"");
                }
                break;
            default:
                break;
        }
    });
});

function doSearch(params)
{
    if(!params.partId || params.partId<=0){
        partCommonGrid.setData([]);
        return;
    }
    //partId
    partCommonGrid.load({
        partId:params.partId,
        type:params.type,
        token: token
    });
}