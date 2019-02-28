var baseUrl = apiPath + partApi + "/";
var rightGridUrl = baseUrl + "com.hsapi.part.query.report.querySellClientForMonth.biz.ext";
                              
var partBrandList = [];
var brandHash = {};
var guestTypeHash = {};
var partBrandIdEl = null;
var partCodeEl = null;
var partNameEl = null;
var advanceGuestIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var rightGrid = null;

var keySellList = [];
var keyRtnList = [];
var keySellQtyList = [];
var keyEnterAmtList = [];
var keySellAmtList = [];
var keyRtnQtyList = [];
var keyRtnEnterAmtList = [];
var keyRtnAmtList = [];
var keyTrueQtyList = [];
var keyTrueEnterAmtList = [];
var keyTrueAmtList = [];
var keyTrueProfitList = [];
var gparams = {};
 
$(document).ready(function(v) {
	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);
	
	partBrandIdEl = nui.get("partBrandId");
    partCodeEl = nui.get("partCode");
    partNameEl = nui.get("partName");
    advanceGuestIdEl = nui.get("advanceGuestId");
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));
    gparams.startDate = getMonthStartDate();
    gparams.endDate = addDate(getMonthEndDate(), 1);

	initGrid(getMonthStartDate(), addDate(getMonthEndDate(), 1));

    keySellList = [];
    keyRtnList = [];
    keySellQtyList = [];
    keyEnterAmtList = [];
    keySellAmtList = [];
    keyRtnQtyList = [];
    keyRtnEnterAmtList = [];
    keyRtnAmtList = [];
    keyTrueQtyList = [];
    keyTrueEnterAmtList = [];
    keyTrueAmtList = [];
    keyTrueProfitList = [];

	rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid.on("preload",function(e)
    {
        var clientList = e.result.clientList;
        var sellList = e.result.sellList;
        var rtnList = e.result.rtnList;

        for(var i=0;i<clientList.length;i++)
        {
            for(var j=0;j<sellList.length;j++)
            {
                if(clientList[i].guestId == sellList[j].guestId)
                {
                    for(var k=0; k<keySellList.length; k++){
                        clientList[i][keySellList[k]] = sellList[j][keySellList[k]];
                    }
                }
            }

            for(var j=0;j<rtnList.length;j++)
            {
                if(clientList[i].guestId == rtnList[j].guestId)
                {
                    for(var k=0; k<keyRtnList.length; k++){
                        clientList[i][keyRtnList[k]] = rtnList[j][keyRtnList[k]];
                    }
                }
            }

            var sumSellQty=0,sumSellAmt=0,sumRtnQty=0,sumRtnAmt=0,sumTrueQty=0,
                sumTrueAmt=0,sumTrueCost=0,sumTrueProfit=0,sumEnterAmt=0,sumRtnEnterAmt=0;
            for(var j=0;j<keySellQtyList.length;j++){
                var sellQty = clientList[i][keySellQtyList[j]]||0;  //销售数量
                var enterAmt = clientList[i][keyEnterAmtList[j]]||0;  //销售成本
                var sellAmt = clientList[i][keySellAmtList[j]]||0;  //销售金额

                var rtnQty = clientList[i][keyRtnQtyList[j]]||0;//退货数量
                var rtnEnterAmt = clientList[i][keyRtnEnterAmtList[j]]||0;//退货数量
                var rtnAmt = clientList[i][keyRtnAmtList[j]]||0;//退货金额

                if(sellQty!=0 || rtnQty!=0){
                    clientList[i][keyTrueQtyList[j]] = sellQty - rtnQty;
                }
                if(sellAmt!=0 || rtnAmt!=0){
                    clientList[i][keyTrueAmtList[j]] = sellAmt - rtnAmt;
                }
                if(enterAmt!=0 || rtnEnterAmt!=0){
                    clientList[i][keyTrueEnterAmtList[j]] = enterAmt - rtnEnterAmt;
                }
                if(enterAmt!=0 || rtnEnterAmt!=0 || sellAmt!=0 || rtnAmt!=0){
                    clientList[i][keyTrueProfitList[j]] = sellAmt - enterAmt - rtnAmt + rtnEnterAmt;
                }

                sumSellQty+=sellQty;
                sumSellAmt+=sellAmt;
                sumRtnQty+=rtnQty;
                sumRtnAmt+=rtnAmt;
                sumTrueQty+=(sellQty - rtnQty);
                sumTrueAmt+=(sellAmt - rtnAmt);
                sumEnterAmt+=enterAmt;
                sumRtnEnterAmt+=rtnEnterAmt;
                sumTrueCost+=(enterAmt - rtnEnterAmt);
                sumTrueProfit+=(sellAmt - enterAmt - rtnAmt + rtnEnterAmt);
            }
            if(sumSellQty!=0){
                clientList[i]["sumSellQty"] = sumSellQty;
            }
            if(sumSellAmt!=0){
                clientList[i]["sumSellAmt"] = sumSellAmt;
            }
            if(sumRtnQty!=0){
                clientList[i]["sumRtnQty"] = sumRtnQty;
            }
            if(sumRtnAmt!=0){
                clientList[i]["sumRtnAmt"] = sumRtnAmt;
            }
            if(sumSellQty!=0 || sumRtnQty!=0){
                clientList[i]["sumTrueQty"] = sumTrueQty;
            }
            if(sumSellAmt!=0 || sumRtnAmt!=0){
                clientList[i]["sumTrueAmt"] = sumTrueAmt;
            }
            if(sumEnterAmt!=0 || sumRtnEnterAmt!=0){
                clientList[i]["sumTrueCost"] = sumTrueCost;
            }
            if(sumEnterAmt!=0 || sumRtnEnterAmt!=0 || sumSellAmt!=0 || sumRtnAmt!=0){
                clientList[i]["sumTrueProfit"] = sumTrueProfit;
            }

        }
              
        rightGrid.setData(clientList);

        keySellList = [];
        keyRtnList = [];
        keySellQtyList = [];
        keyEnterAmtList = [];
        keySellAmtList = [];
        keyRtnQtyList = [];
        keyRtnEnterAmtList = [];
        keyRtnAmtList = [];
        keyTrueQtyList = [];
        keyTrueEnterAmtList = [];
        keyTrueAmtList = [];
        keyTrueProfitList = [];
    });

	getAllPartBrand(function(data) {
		partBrandList = data.brand;
		partBrandIdEl.setData(partBrandList);
		partBrandList.forEach(function(v) {
			brandHash[v.id] = v;
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
    params.partNameAndPY = partNameEl.getValue();
    params.partCode = partCodeEl.getValue();
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
function initGrid(startDate, endDate){
	var columnList = getYearMonthList(startDate, endDate);
	var columnsObj = {};
	var columnsList = [];
	columnsList.push({type: "indexcolumn", header: "序号" });
	columnsList.push({field: "clientCode",width:"60", summaryType:"count", headerAlign: "center", allowSort: true, header: "客户编码"});
    columnsList.push({field: "shortName",width:"60", headerAlign: "center", allowSort: true, header: "客户简称"});
    columnsList.push({field: "guestType",width:"60", headerAlign: "center", allowSort: true, header: "客户分类"});
    columnsList.push({field: "fullName",width:"60", headerAlign: "center", allowSort: true, header: "客户全称"});
	if(columnList && columnList.length > 0){
		for (i = 0; i < columnList.length; i++) {
			var yearMonthObj = columnList[i];
			var year = yearMonthObj.year;
			var month = yearMonthObj.month;
			var sellQtyColumnName = year.toString()+month.toString()+'_sellQty';
            var enterAmtColumnName = year.toString()+month.toString()+'_enterAmt';
			var sellAmtColumnName = year.toString()+month.toString()+'_sellAmt';
			var sellRtnQtyColumnName = year.toString()+month.toString()+'_sellRtnQty';
            var rtnEnterAmtColumnName = year.toString()+month.toString()+'_rtnEnterAmt';
			var sellRtnAmtColumnName = year.toString()+month.toString()+'_sellRtnAmt';

			var trueQtyColumnName = year.toString()+month.toString()+'_trueQty';
            var trueEnterAmtColumnName = year.toString()+month.toString()+'_trueEnterAmt';
			var trueAmtColumnName = year.toString()+month.toString()+'_trueAmt';
            var trueProfitColumnName = year.toString()+month.toString()+'_trueProfitAmt';

			var obj = {header:year,columns:[
			            	{header:month,columns:[
					        	{field: sellQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "销售数量"},
					        	{field: sellAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "销售金额"},
					        	{field: sellRtnQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货数量"},
					        	{field: sellRtnAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货金额"},
					        	{field: trueQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实销数量"},
					        	{field: trueAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实销金额"},
                                {field: trueEnterAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实销成本"},
                                {field: trueProfitColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实销毛利"}
				          	]}
			           ]};
			columnsList.push(obj);

            keySellList.push(sellQtyColumnName);
            keySellList.push(enterAmtColumnName);
            keySellList.push(sellAmtColumnName);
            keyRtnList.push(sellRtnQtyColumnName);
            keyRtnList.push(rtnEnterAmtColumnName);
            keyRtnList.push(sellRtnAmtColumnName);

            keySellQtyList.push(sellQtyColumnName);
            keyEnterAmtList.push(enterAmtColumnName);
            keySellAmtList.push(sellAmtColumnName);
            keyRtnQtyList.push(sellRtnQtyColumnName);
            keyRtnEnterAmtList.push(rtnEnterAmtColumnName);
            keyRtnAmtList.push(sellRtnAmtColumnName);
            keyTrueQtyList.push(trueQtyColumnName);
            keyTrueEnterAmtList.push(trueEnterAmtColumnName);
            keyTrueAmtList.push(trueAmtColumnName);
            keyTrueProfitList.push(trueProfitColumnName);

		}

        var sumObj = {header:"汇总",columns:[
                        {field: "sumSellQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "销售数量"},
                        {field: "sumSellAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "销售金额"},
                        {field: "sumRtnQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货数量"},
                        {field: "sumRtnAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "退货金额"},
                        {field: "sumTrueQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实销数量"},
                        {field: "sumTrueAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实销金额"},
                        {field: "sumTrueCost", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实销成本"},
                        {field: "sumTrueProfit", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "实销毛利"}
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