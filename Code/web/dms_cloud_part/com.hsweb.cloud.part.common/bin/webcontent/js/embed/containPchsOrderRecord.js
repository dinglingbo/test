var pchsOrderRecordGrid = null;
var pchsOrderRecordUrl = cloudPartApiUrl + "com.hsapi.cloud.part.invoicing.query.queryPjPchsOrderMainDetailList.biz.ext";

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var brandHash = {};
var brandList = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var partBrandIdHash = {};
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
    var dictIdList = [];
    dictIdList.push('DDT20130703000008');//票据类型
    dictIdList.push('DDT20130703000035');//结算方式
//	initDicts(dictDefs, null);
    getDictItems(dictIdList,function(data){
        if(data && data.dataItems)
        {
            var dataItems = data.dataItems||[];
            var billTypeIdList = dataItems.filter(function(v)
            {
                if(v.dictid == "DDT20130703000008")
                {
                    billTypeIdHash[v.customid] = v;
                    return true;
                }
            });
      //      nui.get("billTypeId").setData(billTypeIdList);
            var settTypeIdList = dataItems.filter(function(v)
            {
                if(v.dictid == "DDT20130703000035")
                {
                    settTypeIdHash[v.customid] = v;
                    return true;
                }
            });
      //      nui.get("settType").setData(settTypeIdList);
 
        }
        
        getStorehouse(function(data) {
    		var storehouse = data.storehouse||[];
            storehouse.forEach(function(v)
            {
                if(v && v.id)
                {
                    storehouseHash[v.id] = v;
                }
            });
            
            getAllPartBrand(function(data) {
        		brandList = data.brand;
        		brandList.forEach(function(v) {
        			brandHash[v.id] = v;
        		});
        		
        		if(partId){
        	        var params = {partId: partId};
        	        doSearch(params);
        	    }
        		
            });
    		
    	});
        
    });
	

});
function doSearch(params)
{
    if(!params.partId || params.partId<=0){
        pchsOrderRecordGrid.setData([]);
        return;
    }
    params.isFinished = 1;
    params.orderTypeId = 1;
    params.isDiffOrder = 1;
    params.sortField = "a.audit_date";
    params.sortOrder = "desc";
    pchsOrderRecordGrid.load({
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
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "billStatus":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
            break;
        case "enterTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        case "settelTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
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