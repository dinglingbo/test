var pchsOrderRecordGrid = null;
var pchsOrderRecordUrl = partApiUrl + "com.hsapi.part.invoice.query.queryPjPchsOrderMainDetailList.biz.ext";

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var brandHash = {};
var brandList = null;

$(document).ready(function(v){
    pchsOrderRecordGrid = nui.get("pchsOrderRecordGrid");
    pchsOrderRecordGrid.setUrl(pchsOrderRecordUrl);

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
        pchsOrderRecordGrid.setData([]);
        return;
    }
    params.isFinished = 1;
    params.orderTypeId = 1;
    params.sortField = "a.audit_date";
    params.sortOrder = "desc";
    pchsOrderRecordGrid.load({
        params:params,
        token:token
    });
}