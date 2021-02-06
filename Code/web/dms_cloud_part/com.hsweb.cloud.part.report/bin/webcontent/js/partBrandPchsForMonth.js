var baseUrl = apiPath + cloudPartApi + "/";
var rightGridUrl = baseUrl + "com.hsapi.cloud.part.report.report.queryPchsPartBrandForMonth.biz.ext";

var partBrandList = [];
var brandHash = {};
var partBrandIdEl = null;
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
 
$(document).ready(function(v) {
	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);
	
	partBrandIdEl = nui.get("partBrandId");
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");

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
        var brandList = e.result.brandList;
        var enterList = e.result.enterList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<brandList.length;i++)
        {
            for(var j=0;j<enterList.length;j++)
            {
                if(brandList[i].partBrandId == enterList[j].partBrandId)
                {
                    for(var k=0; k<keyEnterList.length; k++){
                        brandList[i][keyEnterList[k]] = enterList[j][keyEnterList[k]];
                    }
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(brandList[i].partBrandId == rtnList[j].partBrandId)
                {
                    for(var k=0; k<keyRtnList.length; k++){
                        brandList[i][keyRtnList[k]] = rtnList[j][keyRtnList[k]];
                    }
                }
            }

            var sumEnterQty=0,sumEnterAmt=0,sumRtnQty=0,sumRtnAmt=0,sumTrueQty=0,sumTrueAmt=0;
            for(var j=0;j<keyEnterQtyList.length;j++){
                var enterQty = brandList[i][keyEnterQtyList[j]]||0;
                var enterAmt = brandList[i][keyEnterAmtList[j]]||0;
                var rtnQty = brandList[i][keyRtnQtyList[j]]||0;
                var rtnAmt = brandList[i][keyRtnAmtList[j]]||0;
                if(enterQty!=0 || rtnQty!=0){
                    brandList[i][keyTrueQtyList[j]] = enterQty - rtnQty;
                }
                if(enterAmt!=0 || rtnAmt!=0){
                    brandList[i][keyTrueAmtList[j]] = enterAmt - rtnAmt;
                }
                sumEnterQty+=enterQty;
                sumEnterAmt+=enterAmt;
                sumRtnQty+=rtnQty;
                sumRtnAmt+=rtnAmt;
                sumTrueQty+=(enterQty - rtnQty);
                sumTrueAmt+=(enterAmt - rtnAmt);
            }
            if(sumEnterQty!=0){
                brandList[i]["sumEnterQty"] = sumEnterQty;
            }
            if(sumEnterAmt!=0){
                brandList[i]["sumEnterAmt"] = sumEnterAmt;
            }
            if(sumRtnQty!=0){
                brandList[i]["sumRtnQty"] = sumRtnQty;
            }
            if(sumRtnAmt!=0){
                brandList[i]["sumRtnAmt"] = sumRtnAmt;
            }
            if(sumEnterQty!=0 || sumRtnQty!=0){
                brandList[i]["sumTrueQty"] = sumTrueQty;
            }
            if(sumEnterAmt!=0 || sumRtnAmt!=0){
                brandList[i]["sumTrueAmt"] = sumTrueAmt;
            }

        }
              
        rightGrid.setData(brandList);
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

});
function getSearchParam() {
	var params = {};
	params.partBrandId = nui.get("partBrandId").getValue();
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
    	default:
    		break;
	}
}
function initGrid(startDate, endDate){
	var columnList = getYearMonthList(startDate, endDate);
	var columnsObj = {};
	var columnsList = [];
	columnsList.push({type: "indexcolumn", header: "序号" });
	columnsList.push({field: "partBrandId",width:"60", summaryType:"count", headerAlign: "center", allowSort: true, header: "配件品牌"});
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
					        	{field: orderQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库数量"},
					        	{field: orderAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库金额"},
					        	{field: orderRtnQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货数量"},
					        	{field: orderRtnAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货金额"},
					        	{field: trueQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库数量"},
					        	{field: trueAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库金额"}
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
                        {field: "sumEnterQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库数量"},
                        {field: "sumEnterAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库金额"},
                        {field: "sumRtnQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货数量"},
                        {field: "sumRtnAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货金额"},
                        {field: "sumTrueQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库数量"},
                        {field: "sumTrueAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库金额"}
                     ]};
        columnsList.push(sumObj);
	}
	
	rightGrid.set({
        columns: columnsList
    });
}