var sellOrderRecordGrid = null;
var sellOrderRecordUrl = cloudPartApiUrl + "com.hsapi.cloud.part.invoicing.query.queryPjSellOrderMainDetailList.biz.ext";

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];
var brandHash = {};
var brandList = null;
var guestId =null;
$(document).ready(function(v){
    sellOrderRecordGrid = nui.get("sellOrderRecordGrid");
    sellOrderRecordGrid.setUrl(sellOrderRecordUrl);
//    sellOrderRecordGrid.load();

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
	initDicts(dictDefs, function(){
        billTypeIdList = nui.get("billTypeId").getData(); 
        settTypeIdList = nui.get("settleTypeId").getData(); 
        billTypeIdList.forEach(function(v)
        {
            if(v && v.customid)
            {
                billTypeIdHash[v.customid] = v;
            }
        });
        settTypeIdList.forEach(function(v)
        {
            if(v && v.customid)
            {
                settTypeIdHash[v.customid] = v;
            }
        });
    });
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

	// getAllPartBrand(function(data) {
	// 	brandList = data.brand;
	// 	brandList.forEach(function(v) {
	// 		brandHash[v.id] = v;
	// 	});
    // });
    
    if(partId){
        var params = {partId: partId};
        doSearch(params);
    }

    sellOrderRecordGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "billTypeId":
                if(billTypeIdHash[e.value])
                {
                    e.cellHtml = billTypeIdHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            case "settleTypeId":
                if(settTypeIdHash[e.value])
                {
                    e.cellHtml = settTypeIdHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            case "storeId":
                if(storehouseHash[e.value])
                {
                    e.cellHtml = storehouseHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            default:
                break;
        }
    });

});

function chainChange(){
	var chainGuest = nui.get("chainGuest").getValue();
	if(chainGuest ==1){
		nui.get("nowGuest").setValue(0);
	}else{
		nui.get("nowGuest").setValue(1);
	}
}

function nowGuestChange(){
	var nowGuest = nui.get("chainGuest").getValue();
	if(nowGuest ==1){
		nui.get("chainGuest").setValue(0);
	}else{
		nui.get("chainGuest").setValue(1);
	}
}

function doSearch(params)
{
	
    if(!params.partId || params.partId<=0){
        sellOrderRecordGrid.setData([]);
        return;
    }
    guestId = params.guestId || "";
    var nowGuest =nui.get("nowGuest").getValue() || "";
    var chainGuest=nui.get("chainGuest").getValue() || "";
    if(nowGuest ==1){
//    	params.guestId =null;
    	params.tenantId =currTenantId;
    }
    if(chainGuest==1){
    	params.guestId =null;
    	params.tenantId =currTenantId;
    }
    params.tenantId =currTenantId;
    params.isOut = 1;
    params.orderTypeId = 2;
    params.sortField = "a.audit_date";
    params.sortOrder = "desc";
    sellOrderRecordGrid.load({
        params:params,
        token:token
    });
}