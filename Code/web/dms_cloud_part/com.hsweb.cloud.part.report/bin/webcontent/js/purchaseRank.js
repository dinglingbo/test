var baseUrl = apiPath + cloudPartApi + "/";
var supplierGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.queryPchsSupplier.biz.ext";
var partGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.queryPchsPart.biz.ext";
var partBrandGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.queryPchsPartBrand.biz.ext";
var partTypeGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.queryPchsPartType.biz.ext";

var partBrandList = [];
var brandHash = {};
var supplierTypeHash = {};
var partTypeList = [];
var typeHash = {};
var partBrandIdEl = null;
var partCodeEl = null;
var partNameEl = null;
var advanceGuestIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var supplierGrid = null;
var partGrid = null;
var partBrandGrid = null;
var partTypeGrid = null;
var mainTabs = null;
 
$(document).ready(function(v) {
	supplierGrid = nui.get("supplierGrid");
	supplierGrid.setUrl(supplierGridUrl);

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

	supplierGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    supplierGrid.on("preload",function(e)
    {
        var supplierList = e.result.supplierList;
        var enterList = e.result.enterList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<supplierList.length;i++)
        {
            for(var j=0;j<enterList.length;j++)
            {
                if(supplierList[i].guestId == enterList[j].guestId)
                {
                    supplierList[i]["orderQty"] = enterList[j]["orderQty"];
                    supplierList[i]["orderAmt"] = enterList[j]["orderAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(supplierList[i].guestId == rtnList[j].guestId)
                {
                    supplierList[i]["orderRtnQty"] = rtnList[j]["orderRtnQty"];
                    supplierList[i]["orderRtnAmt"] = rtnList[j]["orderRtnAmt"];
                }
            }

            var enterQty = supplierList[i]["orderQty"]||0;
            var enterAmt = supplierList[i]["orderAmt"]||0;
            var rtnQty = supplierList[i]["orderRtnQty"]||0;
            var rtnAmt = supplierList[i]["orderRtnAmt"]||0;

            if(enterQty!=0 || rtnQty!=0){
                supplierList[i]["trueQty"] = enterQty - rtnQty;
            }
            if(enterAmt!=0 || rtnAmt!=0){
                supplierList[i]["trueAmt"] = enterAmt - rtnAmt;
            }
            
            
        }
              
        supplierGrid.setData(supplierList);
       
        clearGrid(supplierGrid);

    });

    partGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partGrid.on("preload",function(e)
    {
        var partList = e.result.partList;
        var enterList = e.result.enterList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<partList.length;i++)
        {
            for(var j=0;j<enterList.length;j++)
            {
                if(partList[i].partId == enterList[j].partId)
                {
                    partList[i]["orderQty"] = enterList[j]["orderQty"];
                    partList[i]["orderAmt"] = enterList[j]["orderAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(partList[i].partId == rtnList[j].partId)
                {
                    partList[i]["orderRtnQty"] = rtnList[j]["orderRtnQty"];
                    partList[i]["orderRtnAmt"] = rtnList[j]["orderRtnAmt"];
                }
            }

            var enterQty = partList[i]["orderQty"]||0;
            var enterAmt = partList[i]["orderAmt"]||0;
            var rtnQty = partList[i]["orderRtnQty"]||0;
            var rtnAmt = partList[i]["orderRtnAmt"]||0;
            if(enterQty!=0 || rtnQty!=0){
                partList[i]["trueQty"] = enterQty - rtnQty;
            }
            if(enterAmt!=0 || rtnAmt!=0){
                partList[i]["trueAmt"] = enterAmt - rtnAmt;
            }
            
            
        }
              
        partGrid.setData(partList);
       
        clearGrid(partGrid);

    });

    partBrandGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partBrandGrid.on("preload",function(e)
    {
        var brandList = e.result.brandList;
        var enterList = e.result.enterList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<brandList.length;i++)
        {
            for(var j=0;j<enterList.length;j++)
            {
                if(brandList[i].partBrandId == enterList[j].partBrandId)
                {
                    brandList[i]["orderQty"] = enterList[j]["orderQty"];
                    brandList[i]["orderAmt"] = enterList[j]["orderAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(brandList[i].partBrandId == rtnList[j].partBrandId)
                {
                    brandList[i]["orderRtnQty"] = rtnList[j]["orderRtnQty"];
                    brandList[i]["orderRtnAmt"] = rtnList[j]["orderRtnAmt"];
                }
            }

            var enterQty = brandList[i]["orderQty"]||0;
            var enterAmt = brandList[i]["orderAmt"]||0;
            var rtnQty = brandList[i]["orderRtnQty"]||0;
            var rtnAmt = brandList[i]["orderRtnAmt"]||0;
            if(enterQty!=0 || rtnQty!=0){
                brandList[i]["trueQty"] = enterQty - rtnQty;
            }
            if(enterAmt!=0 || rtnAmt!=0){
                brandList[i]["trueAmt"] = enterAmt - rtnAmt;
            }
            
            
        }
              
        partBrandGrid.setData(brandList);
    
        clearGrid(partBrandGrid);
    });

    partTypeGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partTypeGrid.on("preload",function(e)
    {
        var typeList = e.result.typeList;
        var enterList = e.result.enterList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<typeList.length;i++)
        {
            for(var j=0;j<enterList.length;j++)
            {
                if(typeList[i].carTypeIdF == enterList[j].carTypeIdF)
                {
                    typeList[i]["orderQty"] = enterList[j]["orderQty"];
                    typeList[i]["orderAmt"] = enterList[j]["orderAmt"];
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(typeList[i].carTypeIdF == rtnList[j].carTypeIdF)
                {
                    typeList[i]["orderRtnQty"] = rtnList[j]["orderRtnQty"];
                    typeList[i]["orderRtnAmt"] = rtnList[j]["orderRtnAmt"];
                }
            }

            var enterQty = typeList[i]["orderQty"]||0;
            var enterAmt = typeList[i]["orderAmt"]||0;
            var rtnQty = typeList[i]["orderRtnQty"]||0;
            var rtnAmt = typeList[i]["orderRtnAmt"]||0;
            if(enterQty!=0 || rtnQty!=0){
                typeList[i]["trueQty"] = enterQty - rtnQty;
            }
            if(enterAmt!=0 || rtnAmt!=0){
                typeList[i]["trueAmt"] = enterAmt - rtnAmt;
            }
            
            
        }
              
        partTypeGrid.setData(typeList);

        clearGrid(partTypeGrid);
    
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

    var dictDefs ={"supplierType":SUPPLIER_TYPE};
    initDicts(dictDefs, function(){
        var data = nui.get("supplierType").getData();
        data.forEach(function(v) {
            supplierTypeHash[v.customid] = v;
        });
    });

});
function clearGrid(grid){
    var rows = grid.findRows(function(row){
        var enterQty = row.orderQty||0;
        var enterAmt = row.orderAmt||0;
        var rtnQty = row.orderRtnQty||0;
        var rtnAmt = row.orderRtnAmt||0;
        if(enterQty <= 0 && enterAmt <= 0 && rtnQty <= 0 && rtnAmt <= 0){
            return true;
        }
    });
    grid.removeRows(rows);
}
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
    if(tab.name == "supplierGridTab"){
        supplierGrid.load({
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
        case "supplierType":
            if (supplierTypeHash[e.value]) {
                e.cellHtml = supplierTypeHash[e.value].name || "";
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
        title : "供应商资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1
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