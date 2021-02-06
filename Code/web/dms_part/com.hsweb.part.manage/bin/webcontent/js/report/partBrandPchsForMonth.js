var baseUrl = apiPath + partApi + "/";
var rightGridUrl = baseUrl + "com.hsapi.part.query.report.queryPchsPartBrandForMonth.biz.ext";

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
var orgidsEl = null;

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
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

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
	 document.onkeyup = function(event) {
	        var e = event || window.event;
	        var keyCode = e.keyCode || e.which;// 38向上 40向下
	        

	        if ((keyCode == 13)) { // F9
	            onSearch();
	        }
	    }
	quickSearch(0);
});
function getSearchParam() {
	var params = {};
	params.partBrandId = nui.get("partBrandId").getValue();
	var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }

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
	columnsList.push({type: "indexcolumn", header: "序号" });
	columnsList.push({field: "partBrandId",width:"80", summaryType:"count", headerAlign: "center", allowSort: true, header: "配件品牌"});
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
					        	{field: orderQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库数量" ,dataType:"float"},
					        	{field: orderAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库金额",dataType:"float"},
					        	{field: orderRtnQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货数量", dataType:"float"},
					        	{field: orderRtnAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货金额" , dataType:"float"},
					        	{field: trueQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库数量", dataType:"float"},
					        	{field: trueAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库金额", dataType:"float"}
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
                        {field: "sumEnterQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库数量", dataType:"float"},
                        {field: "sumEnterAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "入库金额", dataType:"float"},
                        {field: "sumRtnQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货数量", dataType:"float"},
                        {field: "sumRtnAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货金额", dataType:"float"},
                        {field: "sumTrueQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库数量", dataType:"float"},
                        {field: "sumTrueAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实际入库金额", dataType:"float"}
                     ]};
        columnsList.push(sumObj);
	}
	
	rightGrid.set({
        columns: columnsList
    });
}