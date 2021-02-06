var baseUrl = apiPath + partApi + "/";
var rightGridUrl = baseUrl + "com.hsapi.part.query.report.queryPchsSupplierForMonth.biz.ext";

var partBrandList = [];
var brandHash = {};
var supplierTypeHash = {};
var partBrandIdEl = null;
var partCodeEl = null;
var partNameEl = null;
var advanceGuestIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var rightGrid = null;
var keyEnterList = [];
var keyRtnList = [];
var keyEnterQtyList = [];
var keyEnterAmtList = [];
var keyRtnQtyList = [];
var keyRtnAmtList = [];
var keyTrueQtyList = [];
var keyTrueAmtList = [];
var orgidsEl = null;

$(document).ready(function(v) {
	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);
	
	partBrandIdEl = nui.get("partBrandId");
    partCodeEl = nui.get("partCode");
    partNameEl = nui.get("partName");
    advanceGuestIdEl = nui.get("advanceGuestId");
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");
	orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }


	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));

	initGrid(getMonthStartDate(), addDate(getMonthEndDate(), 1));

    keyEnterList = [];
    keyRtnList = [];
    keyEnterQtyList = [];
    keyEnterAmtList = [];
    keyRtnQtyList = [];
    keyRtnAmtList = [];
    keyTrueQtyList = [];
    keyTrueAmtList = [];

	rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid.on("preload",function(e)
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
                    for(var k=0; k<keyEnterList.length; k++){
                        supplierList[i][keyEnterList[k]] = enterList[j][keyEnterList[k]];
                    }
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(supplierList[i].guestId == rtnList[j].guestId)
                {
                    for(var k=0; k<keyRtnList.length; k++){
                        supplierList[i][keyRtnList[k]] = rtnList[j][keyRtnList[k]];
                    }
                }
            }

            var sumEnterQty=0,sumEnterAmt=0,sumRtnQty=0,sumRtnAmt=0,sumTrueQty=0,sumTrueAmt=0;
            for(var j=0;j<keyEnterQtyList.length;j++){
                var enterQty = supplierList[i][keyEnterQtyList[j]]||0;
                var enterAmt = supplierList[i][keyEnterAmtList[j]]||0;
                var rtnQty = supplierList[i][keyRtnQtyList[j]]||0;
                var rtnAmt = supplierList[i][keyRtnAmtList[j]]||0;
                if(enterQty!=0 || rtnQty!=0){
                    supplierList[i][keyTrueQtyList[j]] = enterQty - rtnQty;
                }
                if(enterAmt!=0 || rtnAmt!=0){
                    supplierList[i][keyTrueAmtList[j]] = enterAmt - rtnAmt;
                }
                sumEnterQty+=enterQty;
                sumEnterAmt+=enterAmt;
                sumRtnQty+=rtnQty;
                sumRtnAmt+=rtnAmt;
                sumTrueQty+=(enterQty - rtnQty);
                sumTrueAmt+=(enterAmt - rtnAmt);
            }
            if(sumEnterQty!=0){
                supplierList[i]["sumEnterQty"] = sumEnterQty;
            }
            if(sumEnterAmt!=0){
                supplierList[i]["sumEnterAmt"] = sumEnterAmt;
            }
            if(sumRtnQty!=0){
                supplierList[i]["sumRtnQty"] = sumRtnQty;
            }
            if(sumRtnAmt!=0){
                supplierList[i]["sumRtnAmt"] = sumRtnAmt;
            }
            if(sumEnterQty!=0 || sumRtnQty!=0){
                supplierList[i]["sumTrueQty"] = sumTrueQty;
            }
            if(sumEnterAmt!=0 || sumRtnAmt!=0){
                supplierList[i]["sumTrueAmt"] = sumTrueAmt;
            }

        }
              
        rightGrid.setData(supplierList);
        //rightGrid.setData(brandList);

        keyEnterList = [];
        keyRtnList = [];
        keyEnterQtyList = [];
        keyEnterAmtList = [];
        keyRtnQtyList = [];
        keyRtnAmtList = [];
        keyTrueQtyList = [];
        keyTrueAmtList = [];
    });

	getAllPartBrand(function(data) {
		partBrandList = data.brand;
		partBrandIdEl.setData(partBrandList);
		partBrandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});

    var dictDefs ={"supplierType":SUPPLIER_TYPE};
    initDicts(dictDefs, function(){
        var data = nui.get("supplierType").getData();
        data.forEach(function(v) {
            supplierTypeHash[v.customid] = v;
        });
    });
    quickSearch(0);
});
function getSearchParam() {
	var params = {};
    params.partBrandId = partBrandIdEl.getValue();
    params.partNameAndPY = partNameEl.getValue();
    params.partCode = partCodeEl.getValue();
    if(typeof advanceGuestIdEl.getValue() !== 'number'){
    	params.guestId=null;
    	params.guestName = advanceGuestIdEl.getValue();
	}else{
	params.guestId = advanceGuestIdEl.getValue();
	}
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }

//    params.guestId = advanceGuestIdEl.getValue();
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
    endDateEl.setValue(addDate(params.endDate,-1));
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}
function onSearch(){
	var params = getSearchParam();
    params.startDate = beginDateEl.getFormValue();
    params.endDate = addDate(endDateEl.getValue(),1);

    doSearch(params);
}
function doSearch(params)
{
	initGrid(beginDateEl.getFormValue(), endDateEl.getFormValue());

    rightGrid.load({
        params:params,
        token:token
    });
}
function onRightGridDraw(e) {
    var row = e.row;
	switch (e.field) {
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
        case "supplierType":
            if (supplierTypeHash[e.value]) {
                e.cellHtml = supplierTypeHash[e.value].name || "";
            } else {
                e.cellHtml = "";
            }
            break;
        case  "orgid":
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName || "";
        		}
        	}

    	default:
    		break;
	}
}
function initGrid(startDate, endDate){
	var columnList = getYearMonthList(startDate, endDate);
	var columnsObj = {};
	var columnsList = [];
	columnsList.push({type: "indexcolumn",width:"40" ,header: "序号" });
	columnsList.push({field: "supplierCode",width:"80", summaryType:"count", headerAlign: "center", allowSort: true, header: "供应商编码"});
    columnsList.push({field: "shortName",width:"80", headerAlign: "center", allowSort: true, header: "供应商简称"});
    columnsList.push({field: "supplierType",width:"70", headerAlign: "center", allowSort: true, header: "供应商分类"});
    columnsList.push({field: "fullName",width:"120", headerAlign: "center", allowSort: true, header: "供应商全称"});
    columnsList.push({field: "orgid",width:"120", headerAlign: "center", allowSort: true, header: "所属公司"});
	if(columnList && columnList.length > 0){
		for (i = 0; i < columnList.length; i++) {
			var yearMonthObj = columnList[i];
			var year = yearMonthObj.year;
			var month = yearMonthObj.month;
			var orderQtyColumnName = year.toString()+month.toString()+'_orderQty';
			var orderAmtColumnName = year.toString()+month.toString()+'_orderAmt';
			var orderRtnQtyColumnName = year.toString()+month.toString()+'_orderRtnQty';
			var orderRtnAmtColumnName = year.toString()+month.toString()+'_orderRtnAmt';
			var trueQtyColumnName = year.toString()+month.toString()+'_trueQty';
			var trueAmtColumnName = year.toString()+month.toString()+'_trueAmt';
			var obj = {header:year,columns:[
			            	{header:month,columns:[
					        	{field: orderQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库数量",dataType:"float" },
					        	{field: orderAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库金额" ,dataType:"float"},
					        	{field: orderRtnQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货数量" ,dataType:"float"},
					        	{field: orderRtnAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货金额",dataType:"float"},
					        	{field: trueQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库数量",dataType:"float"},
					        	{field: trueAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库金额",dataType:"float"}
				          	]}
			           ]};
			columnsList.push(obj);

            keyEnterList.push(orderQtyColumnName);
            keyEnterList.push(orderAmtColumnName);
            keyRtnList.push(orderRtnQtyColumnName);
            keyRtnList.push(orderRtnAmtColumnName);

            keyEnterQtyList.push(orderQtyColumnName);
            keyEnterAmtList.push(orderAmtColumnName);
            keyRtnQtyList.push(orderRtnQtyColumnName);
            keyRtnAmtList.push(orderRtnAmtColumnName);
            keyTrueQtyList.push(trueQtyColumnName);
            keyTrueAmtList.push(trueAmtColumnName);
		}

        var sumObj = {header:"汇总",columns:[
                        {field: "sumEnterQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库数量",dataType:"float"},
                        {field: "sumEnterAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库金额",dataType:"float"},
                        {field: "sumRtnQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货数量",dataType:"float"},
                        {field: "sumRtnAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货金额",dataType:"float"},
                        {field: "sumTrueQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库数量",dataType:"float"},
                        {field: "sumTrueAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库金额",dataType:"float"}
                     ]};
        columnsList.push(sumObj);
	}
	
	rightGrid.set({
        columns: columnsList
    });
}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "供应商资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1,
                guestType:'01020202'
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