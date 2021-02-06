var baseUrl = apiPath + cloudPartApi + "/";
var clientGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellClient.biz.ext";
var manGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellOrderMan.biz.ext";
var partGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellPart.biz.ext";
var storeGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellStore.biz.ext";
var businessTypeGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellBusinessType.biz.ext";
var partBrandGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellPartBrand.biz.ext";
var partTypeGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.querySellPartType.biz.ext";
var deptUrl = apiPath + sysApi + "/com.hsapi.system.tenant.employee.queryDept.biz.ext";

var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
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
var manGrid = null;
var partGrid = null;
var storeGrid = null;
var businessTypeGrid = null;
var partBrandGrid = null;
var partTypeGrid = null;
var mainTabs = null;
var storehouse = [];
var storehouseHash = {};
var businessTypeList = [];
var businessTypeHash = {};
 
$(document).ready(function(v) {
	clientGrid = nui.get("clientGrid");
	clientGrid.setUrl(clientGridUrl);
	
	manGrid = nui.get("manGrid");
	manGrid.setUrl(manGridUrl);

    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);
    
    storeGrid = nui.get("storeGrid");
    storeGrid.setUrl(storeGridUrl);
	
    businessTypeGrid = nui.get("businessTypeGrid");
    businessTypeGrid.setUrl(businessTypeGridUrl);

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
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));
	
	provinceEl = nui.get("provinceId");

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
                    enterAmt = sellList[j]["costAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(clientList[i].guestId == rtnList[j].guestId)
                {
                    clientList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                    clientList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["costAmt"];
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
                clientList[i]["trueAmt"] = (sellAmt - rtnAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
                clientList[i]["trueEnterAmt"] = (enterAmt - rtnEnterAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
                clientList[i]["trueProfitAmt"] = (sellAmt - enterAmt - rtnAmt + rtnEnterAmt).toFixed(2);
                if(sellAmt - rtnAmt != 0) {
                	clientList[i]["trueProfitRate"] = ((sellAmt - enterAmt - rtnAmt + rtnEnterAmt)/(sellAmt - rtnAmt)*100*1.0).toFixed(2);
                }
            }
            
            
        }
              
        clientGrid.setData(clientList);
       

    });
    
    manGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    manGrid.on("preload",function(e)
    {
        var manList = e.result.manList;
        var sellList = e.result.sellList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<manList.length;i++)
        {
            var enterAmt = 0, rtnEnterAmt = 0;
            for(var j=0;j<sellList.length;j++)
            {
                if(manList[i].name == sellList[j].orderMan)
                {
                	manList[i]["sellQty"] = sellList[j]["sellQty"];
                	manList[i]["sellAmt"] = sellList[j]["sellAmt"];
                    enterAmt = sellList[j]["costAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(manList[i].name == rtnList[j].orderMan)
                {
                	manList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                	manList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["costAmt"];
                }
            }

            var sellQty = manList[i]["sellQty"]||0;
            var sellAmt = manList[i]["sellAmt"]||0;
            var rtnQty = manList[i]["sellRtnQty"]||0;
            var rtnAmt = manList[i]["sellRtnAmt"]||0;
            if(sellQty!=0 || rtnQty!=0){
            	manList[i]["trueQty"] = sellQty - rtnQty;
            }
            if(sellAmt!=0 || rtnAmt!=0){
            	manList[i]["trueAmt"] = (sellAmt - rtnAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
            	manList[i]["trueEnterAmt"] = (enterAmt - rtnEnterAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
            	manList[i]["trueProfitAmt"] = (sellAmt - enterAmt - rtnAmt + rtnEnterAmt).toFixed(2);
                if(sellAmt - rtnAmt != 0) {
                	manList[i]["trueProfitRate"] = ((sellAmt - enterAmt - rtnAmt + rtnEnterAmt)/(sellAmt - rtnAmt)*100*1.0).toFixed(2);
                }
            }
            
            
        }
              
        manGrid.setData(manList);
       

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
                    enterAmt = sellList[j]["costAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(partList[i].partId == rtnList[j].partId)
                {
                    partList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                    partList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["costAmt"];
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
                partList[i]["trueAmt"] = (sellAmt - rtnAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
                partList[i]["trueEnterAmt"] = (enterAmt - rtnEnterAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
                partList[i]["trueProfitAmt"] = (sellAmt - enterAmt - rtnAmt + rtnEnterAmt).toFixed(2);
                if(sellAmt - rtnAmt != 0) {
                	partList[i]["trueProfitRate"] = ((sellAmt - enterAmt - rtnAmt + rtnEnterAmt)/(sellAmt - rtnAmt)*100*1.0).toFixed(2);
                }
            }
            
            
        }
              
        partGrid.setData(partList);
       

    });
    
    storeGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    storeGrid.on("preload",function(e)
    {
        var storeList = e.result.storeList;
        var sellList = e.result.sellList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<storeList.length;i++)
        {
            var enterAmt = 0, rtnEnterAmt = 0;
            for(var j=0;j<sellList.length;j++)
            {
                if(storeList[i].storeId == sellList[j].storeId)
                {
                	storeList[i]["sellQty"] = sellList[j]["sellQty"];
                	storeList[i]["sellAmt"] = sellList[j]["sellAmt"];
                    enterAmt = sellList[j]["costAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(storeList[i].storeId == rtnList[j].storeId)
                {
                	storeList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                	storeList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["costAmt"];
                }
            }

            var sellQty = storeList[i]["sellQty"]||0;
            var sellAmt = storeList[i]["sellAmt"]||0;
            var rtnQty = storeList[i]["sellRtnQty"]||0;
            var rtnAmt = storeList[i]["sellRtnAmt"]||0;
            if(sellQty!=0 || rtnQty!=0){
            	storeList[i]["trueQty"] = sellQty - rtnQty;
            }
            if(sellAmt!=0 || rtnAmt!=0){
            	storeList[i]["trueAmt"] = (sellAmt - rtnAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
            	storeList[i]["trueEnterAmt"] = (enterAmt - rtnEnterAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
            	storeList[i]["trueProfitAmt"] = (sellAmt - enterAmt - rtnAmt + rtnEnterAmt).toFixed(2);
                if(sellAmt - rtnAmt != 0) {
                	storeList[i]["trueProfitRate"] = ((sellAmt - enterAmt - rtnAmt + rtnEnterAmt)/(sellAmt - rtnAmt)*100*1.0).toFixed(2);
                }
            }
            
            
        }
              
        storeGrid.setData(storeList);
       

    });
    
    businessTypeGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    businessTypeGrid.on("preload",function(e)
    {
        var typeList = e.result.typeList;
        var sellList = e.result.sellList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<typeList.length;i++)
        {
            var enterAmt = 0, rtnEnterAmt = 0;
            for(var j=0;j<sellList.length;j++)
            {
                if(typeList[i].businessTypeId == sellList[j].businessTypeId)
                {
                	typeList[i]["sellQty"] = sellList[j]["sellQty"];
                	typeList[i]["sellAmt"] = sellList[j]["sellAmt"];
                    enterAmt = sellList[j]["costAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(typeList[i].businessTypeId == rtnList[j].businessTypeId)
                {
                	typeList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                	typeList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["costAmt"];
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
            	typeList[i]["trueAmt"] = (sellAmt - rtnAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
            	typeList[i]["trueEnterAmt"] = (enterAmt - rtnEnterAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
            	typeList[i]["trueProfitAmt"] = (sellAmt - enterAmt - rtnAmt + rtnEnterAmt).toFixed(2);
                if(sellAmt - rtnAmt != 0) {
                	typeList[i]["trueProfitRate"] = ((sellAmt - enterAmt - rtnAmt + rtnEnterAmt)/(sellAmt - rtnAmt)*100*1.0).toFixed(2);
                }
            }
            
            
        }
              
        businessTypeGrid.setData(typeList);
       

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
                    enterAmt = sellList[j]["costAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(brandList[i].partBrandId == rtnList[j].partBrandId)
                {
                    brandList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                    brandList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["costAmt"];
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
                brandList[i]["trueAmt"] = (sellAmt - rtnAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
                brandList[i]["trueEnterAmt"] = (enterAmt - rtnEnterAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
                brandList[i]["trueProfitAmt"] = (sellAmt - enterAmt - rtnAmt + rtnEnterAmt).toFixed(2);
                if(sellAmt - rtnAmt != 0) {
                	brandList[i]["trueProfitRate"] = ((sellAmt - enterAmt - rtnAmt + rtnEnterAmt)/(sellAmt - rtnAmt)*100*1.0).toFixed(2);
                }
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
                    enterAmt = sellList[j]["costAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(typeList[i].carTypeIdF == rtnList[j].carTypeIdF)
                {
                    typeList[i]["sellRtnQty"] = rtnList[j]["sellRtnQty"];
                    typeList[i]["sellRtnAmt"] = rtnList[j]["sellRtnAmt"];
                    rtnEnterAmt = rtnList[j]["costAmt"];
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
                typeList[i]["trueAmt"] = (sellAmt - rtnAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0){
                typeList[i]["trueEnterAmt"] = (enterAmt - rtnEnterAmt).toFixed(2);
            }
            if(enterAmt!=0 || rtnEnterAmt!=0 || enterAmt!=0 || rtnAmt!=0){
                typeList[i]["trueProfitAmt"] = (sellAmt - enterAmt - rtnAmt + rtnEnterAmt).toFixed(2);
                if(sellAmt - rtnAmt != 0) {
                	typeList[i]["trueProfitRate"] = ((sellAmt - enterAmt - rtnAmt + rtnEnterAmt)/(sellAmt - rtnAmt)*100*1.0).toFixed(2);
                }
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

    var dictDefs ={"guestType":GUEST_TYPE, "orgCarBrandId": "10444", "businessTypeId": "10445"};
    initDicts(dictDefs, function(){
        var data = nui.get("guestType").getData();
        data.forEach(function(v) {
            guestTypeHash[v.customid] = v;
        });

        var orgCarBrandList = nui.get("orgCarBrandId").getData();
        nui.get("searchOrgCarBrandId").setData(orgCarBrandList);
        
        businessTypeList = nui.get("businessTypeId").getData();
        businessTypeList.forEach(function(v){
        	businessTypeHash[v.customid]=v;
    	});
    });
    
    getProvinceAndCity(function(data){
		
	});
    
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        nui.get("elStoreId").setData(storehouse);
        nui.get("searchStoreId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
        
    });
    
    getDept(function(data) {
    	nui.get("elPartment").setData(data);
    });

});
function getDept(callback) {
    nui.ajax({
        url : deptUrl,
        data : {
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.rs) {
                callback && callback(data.rs);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function getSearchParam() {
	var params = {};
    //params.partBrandId = partBrandIdEl.getValue();
    //params.partNameAndPY = partNameEl.getValue().replace(/\s+/g, "");
    params.partCode = partCodeEl.getValue().replace(/(^\s*)|(\s*$)/g, "");
    params.guestId = advanceGuestIdEl.getValue();
    params.storeId = nui.get("searchStoreId").getValue();
    params.orgCarBrandId = nui.get("searchOrgCarBrandId").getValue();
    params.orderMan = nui.get("searchOrderMan").getValue();
	return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "本日";
    switch (type)
    {
	    case 0:
	    	params.startDate = getNowStartDate();
			params.endDate = addDate(getNowEndDate(), 1);
	        queryname = "本日";
	        break;
	    case 1:
	    	params.startDate = getPrevStartDate();
			params.endDate = addDate(getPrevEndDate(), 1);
	        queryname = "昨日";
	        break;
	    case 2:
	    	params.startDate = getWeekStartDate();
			params.endDate = addDate(getWeekEndDate(), 1);
	        queryname = "本周";
	        break;
	    case 3:
	    	params.startDate = getLastWeekStartDate();
			params.endDate = addDate(getLastWeekEndDate(), 1);
	        queryname = "上周";
	        break;
        case 4:
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;
        case 6:
            params.startDate = getQuarterStartDate();
            params.endDate = addDate(getQuarterEndDate(), 1);
            queryname = "本季";
            break;
        case 7:
            params.startDate = getLastQuarterStart();
            params.endDate = addDate(getLastQuarterEnd(), 1);
            queryname = "上季";
            break;
        case 8:
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 9:
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
    }else if(tab.name == "manGridTab"){
    	manGrid.load({
            params:params,
            token:token
        });  
    }else if(tab.name == "partGridTab"){
        partGrid.load({
            params:params,
            token:token
        });  
    }else if(tab.name == "storeGridTab"){
    	storeGrid.load({
            params:params,
            token:token
        });  
    }else if(tab.name == "businessTypeGridTab"){
    	businessTypeGrid.load({
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
        case "provinceId":
            if (provinceHash[e.value]) {
                e.cellHtml = provinceHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
        case "cityId":
            if (cityHash[e.value]) {
                e.cellHtml = cityHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
        case "storeId":
            if (storehouseHash[e.value]) {
                e.cellHtml = storehouseHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
        case "businessTypeId":
            if (businessTypeHash[e.value]) {
                e.cellHtml = businessTypeHash[e.value].name || "";
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
                isClient: 1
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
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }else{
        nui.get("sAuditDate").setValue(getWeekStartDate());
        nui.get("eAuditDate").setValue(addDate(getWeekEndDate(), 1));
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
        searchData.guestId = nui.get("advanceGuestId").getValue();
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            //tmpList[i] = "'"+tmpList[i].replace(/(^\s*)|(\s*$)/g, "")+"'";
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    if(searchData.elStoreId)
    {
        searchData.storeId = nui.get("elStoreId").getValue();
    }
    if(searchData.elOrderMan)
    {
        searchData.orderMan = nui.get("elOrderMan").getValue();
    }
    if(searchData.elPartment)
    {
    	searchData.orderManList = getOrderMans(nui.get("elPartment").getValue());
    }
    /*if(searchData.outableQtyGreaterThanZero == 0)
    {
        delete searchData.outableQtyGreaterThanZero;
    }*/
  //去除空格
	/*for(var key in searchData){
		searchData[key]=searchData[key].replace(/(^\s*)|(\s*$)/g, "");
    }*/
    advancedSearchWin.hide();
    doSearch(searchData);
}
function getOrderMans(deptId) {
	var orderManList = "";
	nui.ajax({
        url : apiPath + sysApi + "/com.hsapi.system.tenant.employee.getEmployee.biz.ext",
        async: false,
        data : {
        	params: {
        		deptId: deptId
        	},
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.rs) {
            	 var tmpList = data.rs;
            	 var list = [];
                 for(i=0;i<tmpList.length;i++)
                 {
                	 list[i] = "'"+tmpList[i].name+"'";
                 }
                 orderManList = list.join(",");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
	return orderManList;
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}

function onExport(){
	var tab = mainTabs.getActiveTab();
    if(tab.name == "clientGridTab"){
        var detail = nui.clone(clientGrid.getData());
    	exportNoMultistage(clientGrid.columns);
    	for(var i=0;i<detail.length;i++){
    		if(provinceHash[detail[i].provinceId]){
    			detail[i].provinceId = provinceHash[detail[i].provinceId].name;
    		}else {
    			detail[i].provinceId = "";
    		}
    		if(cityHash[detail[i].cityId]){
    			detail[i].cityId = cityHash[detail[i].cityId].name;
    		}else {
    			detail[i].cityId = "";
    		}
    		if(guestTypeHash[detail[i].guestType]){
    			detail[i].guestType=guestTypeHash[detail[i].guestType].name;
    		}else {
    			detail[i].guestType = "";
    		}
    	}
    	if(detail && detail.length > 0){
    		setInitExportDataNoMultistage( detail,clientGrid.columns,"销售-客户排行");
    	}
    }else if(tab.name == "manGridTab"){
    	var detail = nui.clone(manGrid.getData());
    	exportNoMultistage(manGrid.columns);
    	if(detail && detail.length > 0){
    		setInitExportDataNoMultistage( detail,manGrid.columns,"销售-业务员排行");
    	} 
    }else if(tab.name == "partGridTab"){
    	var detail = nui.clone(partGrid.getData());
    	exportNoMultistage(partGrid.columns);
    	for(var i=0;i<detail.length;i++){
    		if(brandHash[detail[i].partBrandId]){
    			detail[i].partBrandId = brandHash[detail[i].partBrandId].name;
    		}else {
    			detail[i].partBrandId = "";
    		}
    	}
    	if(detail && detail.length > 0){
    		setInitExportDataNoMultistage( detail,partGrid.columns,"销售-商品排行");
    	}
    }else if(tab.name == "storeGridTab"){
        var detail = nui.clone(storeGrid.getData());
    	exportNoMultistage(storeGrid.columns);
    	for(var i=0;i<detail.length;i++){
    		if(brandHash[detail[i].storeId]){
    			detail[i].storeId = brandHash[detail[i].storeId].name;
    		}else {
    			detail[i].storeId = "";
    		}
    	}
    	if(detail && detail.length > 0){
    		setInitExportDataNoMultistage( detail,storeGrid.columns,"销售-仓库排行");
    	}
    }else if(tab.name == "businessTypeGridTab"){
        var detail = nui.clone(businessTypeGrid.getData());
    	exportNoMultistage(businessTypeGrid.columns);
    	for(var i=0;i<detail.length;i++){
    		if(businessTypeHash[detail[i].businessTypeId]){
    			detail[i].businessTypeId = businessTypeHash[detail[i].businessTypeId].name;
    		}else {
    			detail[i].businessTypeId = "";
    		}
    	}
    	if(detail && detail.length > 0){
    		setInitExportDataNoMultistage( detail,businessTypeGrid.columns,"销售-销售类型排行");
    	}
    }else if(tab.name == "partBrandGridTab"){
        var detail = nui.clone(partBrandGrid.getData());
    	exportNoMultistage(partBrandGrid.columns);
    	for(var i=0;i<detail.length;i++){
    		if(brandHash[detail[i].partBrandId]){
    			detail[i].partBrandId = brandHash[detail[i].partBrandId].name;
    		}else {
    			detail[i].partBrandId = "";
    		}
    	}
    	if(detail && detail.length > 0){
    		setInitExportDataNoMultistage( detail,partBrandGrid.columns,"销售-品牌排行");
    	}
    }else if(tab.name == "partTypeGridTab"){
        var detail = nui.clone(partTypeGrid.getData());
    	exportNoMultistage(partTypeGrid.columns);
    	for(var i=0;i<detail.length;i++){
    		if(typeHash[detail[i].carTypeIdF]){
    			detail[i].carTypeIdF = typeHash[detail[i].carTypeIdF].name;
    		}else {
    			detail[i].carTypeIdF = "";
    		}
    	}
    	if(detail && detail.length > 0){
    		setInitExportDataNoMultistage( detail,partTypeGrid.columns,"销售-配件类型排行");
    	}
    }
    
	
}