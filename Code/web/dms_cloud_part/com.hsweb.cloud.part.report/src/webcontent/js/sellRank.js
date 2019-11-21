var baseUrl = apiPath + cloudPartApi + "/";
var clientGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellClient.biz.ext";
var partGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellPart.biz.ext";
var partBrandGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellPartBrand.biz.ext";
var partTypeGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellPartType.biz.ext";

var partBrandList = [];
var brandHash = {};
var guestTypeHash = {};
var partTypeList = [];
var typeHash = {};
var partBrandIdEl = null;
var partCodeEl = null;
var partNameEl = null;
var advanceGuestIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var clientGrid = null;
var partGrid = null;
var partBrandGrid = null;
var partTypeGrid = null;
var mainTabs = null;
 
$(document).ready(function(v) {
	clientGrid = nui.get("clientGrid");
	clientGrid.setUrl(clientGridUrl);

    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);

    partBrandGrid = nui.get("partBrandGrid");
    partBrandGrid.setUrl(partBrandGridUrl);

    partTypeGrid = nui.get("partTypeGrid");
    partTypeGrid.setUrl(partTypeGridUrl);

    mainTabs = nui.get("mainTabs");
	
	partBrandIdEl = nui.get("partBrandId");
    partCodeEl = nui.get("partCode");
    partNameEl = nui.get("partName");
    advanceGuestIdEl = nui.get("advanceGuestId");
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));

	clientGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    clientGrid.on("preload",function(e)
    {
        var clientList = e.result.clientList;
        var sellList = e.result.sellList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<clientList.length;i++)
        {
            var enterAmt = 0, rtnEnterAmt = 0;
            for(var j=0;j<sellList.length;j++)
            {
                if(clientList[i].guestId == sellList[j].guestId)
                {
                    clientList[i]["sellQty"] = sellList[j]["sellQty"];
                    clientList[i]["sellAmt"] = sellList[j]["sellAmt"];
                    enterAmt = sellList[j]["enterAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(clientList[i].guestId == rtnList[j].guestId)
                {
                    clientList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                    clientList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["rtnEnterAmt"];
                }
            }

            var sellQty = clientList[i]["sellQty"]||0;
            var sellAmt = clientList[i]["sellAmt"]||0;
            var rtnQty = clientList[i]["sellRtnQty"]||0;
            var rtnAmt = clientList[i]["sellRtnAmt"]||0;
            if(sellQty!=0 || rtnQty!=0){
                clientList[i]["trueQty"] = sellQty - rtnQty;
            }
            if(sellAmt!=0 || rtnAmt!=0){
                clientList[i]["trueAmt"] = sellAmt - rtnAmt;
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
                clientList[i]["trueEnterAmt"] = enterAmt - rtnEnterAmt;
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
                clientList[i]["trueProfitAmt"] = sellAmt - enterAmt - rtnEnterAmt + rtnEnterAmt;
            }
            
            
        }
              
        clientGrid.setData(clientList);
       

    });

    partGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partGrid.on("preload",function(e)
    {
        var partList = e.result.partList;
        var sellList = e.result.sellList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<partList.length;i++)
        {
            var enterAmt = 0, rtnEnterAmt = 0;
            for(var j=0;j<sellList.length;j++)
            {
                if(partList[i].partId == sellList[j].partId)
                {
                    partList[i]["sellQty"] = sellList[j]["sellQty"];
                    partList[i]["sellAmt"] = sellList[j]["sellAmt"];
                    enterAmt = sellList[j]["enterAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(partList[i].partId == rtnList[j].partId)
                {
                    partList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                    partList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["rtnEnterAmt"];
                }
            }

            var sellQty = partList[i]["sellQty"]||0;
            var sellAmt = partList[i]["sellAmt"]||0;
            var rtnQty = partList[i]["sellRtnQty"]||0;
            var rtnAmt = partList[i]["sellRtnAmt"]||0;
            if(sellQty!=0 || rtnQty!=0){
                partList[i]["trueQty"] = sellQty - rtnQty;
            }
            if(sellAmt!=0 || rtnAmt!=0){
                partList[i]["trueAmt"] = sellAmt - rtnAmt;
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
                partList[i]["trueEnterAmt"] = enterAmt - rtnEnterAmt;
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
                partList[i]["trueProfitAmt"] = sellAmt - enterAmt - rtnEnterAmt + rtnEnterAmt;
            }
            
            
        }
              
        partGrid.setData(partList);
       

    });

    partBrandGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partBrandGrid.on("preload",function(e)
    {
        var brandList = e.result.brandList;
        var sellList = e.result.sellList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<brandList.length;i++)
        {
            var enterAmt = 0, rtnEnterAmt = 0;
            for(var j=0;j<sellList.length;j++)
            {
                if(brandList[i].partBrandId == sellList[j].partBrandId)
                {
                    brandList[i]["sellQty"] = sellList[j]["sellQty"];
                    brandList[i]["sellAmt"] = sellList[j]["sellAmt"];
                    enterAmt = sellList[j]["enterAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(brandList[i].partBrandId == rtnList[j].partBrandId)
                {
                    brandList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                    brandList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["rtnEnterAmt"];
                }
            }

            var sellQty = brandList[i]["sellQty"]||0;
            var sellAmt = brandList[i]["sellAmt"]||0;
            var rtnQty = brandList[i]["sellRtnQty"]||0;
            var rtnAmt = brandList[i]["sellRtnAmt"]||0;
            if(sellQty!=0 || rtnQty!=0){
                brandList[i]["trueQty"] = sellQty - rtnQty;
            }
            if(sellAmt!=0 || rtnAmt!=0){
                brandList[i]["trueAmt"] = sellAmt - rtnAmt;
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
                brandList[i]["trueEnterAmt"] = enterAmt - rtnEnterAmt;
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
                brandList[i]["trueProfitAmt"] = sellAmt - enterAmt - rtnEnterAmt + rtnEnterAmt;
            }
            
            
        }
              
        partBrandGrid.setData(brandList);
    
    });

    partTypeGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partTypeGrid.on("preload",function(e)
    {
        var typeList = e.result.typeList;
        var sellList = e.result.sellList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<typeList.length;i++)
        {
            var enterAmt = 0, rtnEnterAmt = 0;
            for(var j=0;j<sellList.length;j++)
            {
                if(typeList[i].carTypeIdF == sellList[j].carTypeIdF)
                {
                    typeList[i]["sellQty"] = sellList[j]["sellQty"];
                    typeList[i]["sellAmt"] = sellList[j]["sellAmt"];
                    enterAmt = sellList[j]["enterAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(typeList[i].carTypeIdF == rtnList[j].carTypeIdF)
                {
                    typeList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                    typeList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["rtnEnterAmt"];
                }
            }

            var sellQty = typeList[i]["sellQty"]||0;
            var sellAmt = typeList[i]["sellAmt"]||0;
            var rtnQty = typeList[i]["sellRtnQty"]||0;
            var rtnAmt = typeList[i]["sellRtnAmt"]||0;
            if(sellQty!=0 || rtnQty!=0){
                typeList[i]["trueQty"] = sellQty - rtnQty;
            }
            if(sellAmt!=0 || rtnAmt!=0){
                typeList[i]["trueAmt"] = sellAmt - rtnAmt;
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
                typeList[i]["trueEnterAmt"] = enterAmt - rtnEnterAmt;
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
                typeList[i]["trueProfitAmt"] = sellAmt - enterAmt - rtnEnterAmt + rtnEnterAmt;
            }
            
            
        }
              
        partTypeGrid.setData(typeList);
    
    });

	getAllPartBrand(function(data) {
		partBrandList = data.brand;
		partBrandIdEl.setData(partBrandList);
		partBrandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});

    getAllPartType(function(data) {
        partTypeList = data.partTypes;
        partTypeList.forEach(function(v) {
            typeHash[v.id] = v;
        });
    });

    var dictDefs ={"guestType":GUEST_TYPE};
    initDicts(dictDefs, function(){
        var data = nui.get("guestType").getData();
        data.forEach(function(v) {
            guestTypeHash[v.customid] = v;
        });
    });

});
function getSearchParam() {
	var params = {};
    params.partBrandId = partBrandIdEl.getValue();
    params.partNameAndPY = partNameEl.getValue().replace(/\s+/g, "");
    params.partCode = partCodeEl.getValue().replace(/(^\s*)|(\s*$)/g, "");
    params.guestId = advanceGuestIdEl.getValue();
	return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 1:
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;
        case 2:
            params.startDate = getQuarterStartDate();
            params.endDate = addDate(getQuarterEndDate(), 1);
            queryname = "本季";
            break;
        case 3:
            params.startDate = getLastQuarterStart();
            params.endDate = addDate(getLastQuarterEnd(), 1);
            queryname = "上季";
            break;
        case 4:
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 5:
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    beginDateEl.setValue(params.startDate);
    endDateEl.setValue(params.endDate);
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}
function onSearch(){
	var params = getSearchParam();
    params.startDate = beginDateEl.getFormValue();
    params.endDate = endDateEl.getFormValue();
    
    doSearch(params);
}
function doSearch(params)
{
    var tab = mainTabs.getActiveTab();
    if(tab.name == "clientGridTab"){
        clientGrid.load({
            params:params,
            token:token
        }); 
    }else if(tab.name == "partGridTab"){
        partGrid.load({
            params:params,
            token:token
        });  
    }else if(tab.name == "partBrandGridTab"){
        partBrandGrid.load({
            params:params,
            token:token
        });  
    }else if(tab.name == "partTypeGridTab"){
        partTypeGrid.load({
            params:params,
            token:token
        });  
    }
	

}
function onDrawCell(e) {
    var row = e.row;
	switch (e.field) {
		case "partBrandId":
	        if(brandHash[e.value])
	        {
	//            e.cellHtml = brandHash[e.value].name||"";
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
        case "carTypeIdF":
            if (typeHash[e.value]) {
                e.cellHtml = typeHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
        case "guestType":
            if (guestTypeHash[e.value]) {
                e.cellHtml = guestTypeHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
    	default:
    		break;
	}
}

var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title : "客户资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1,
                guestType:'01020102'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

            }
        }
    });
}