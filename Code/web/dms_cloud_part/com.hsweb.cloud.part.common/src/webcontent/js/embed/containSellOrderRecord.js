var sellOrderRecordGrid = null;
var sellOrderRecordUrl = cloudPartApiUrl + "com.hsapi.cloud.part.invoicing.query.queryPjSellOrderMainDetailList.biz.ext";

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var brandHash = {};
var brandList = null;

$(document).ready(function(v){
    sellOrderRecordGrid = nui.get("sellOrderRecordGrid");
    sellOrderRecordGrid.setUrl(sellOrderRecordUrl);

    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
	initDicts(dictDefs, null);
	getStorehouse(function(data) {
		var storehouse = data.storehouse||[];
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
		
	});

	getAllPartBrand(function(data) {
		brandList = data.brand;
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
    });
    
    if(partId){
        var params = {partId: partId};
        doSearch(params);
    }

});
function doSearch(params)
{
    if(!params.partId || params.partId<=0){
        sellOrderRecordGrid.setData([]);
        return;
    }
    params.isOut = 1;
    params.orderTypeId = 2;
    params.sortField = "a.audit_date";
    params.sortOrder = "desc";
    sellOrderRecordGrid.load({
        params:params,
        token:token
    });
}