var baseUrl = apiPath + partApi + "/";
var rightGridUrl = baseUrl + "com.hsapi.part.query.report.queryRepairOutForPartName.biz.ext";
var nameUrl = baseUrl + "com.hsapi.part.query.report.queryRepairOutPartNameColumn.biz.ext";

var pickNameList = [];
var brandHash = {};
var sPickDateEl = null;
var ePickDateEl = null;
var sOutDateEl = null;
var eOutDateEl = null;

var rightGrid = null;
var keyEnterList = [];

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

	sPickDateEl = nui.get("sPickDate");
	ePickDateEl = nui.get("ePickDate");
	sOutDateEl = nui.get("sOutDate");
	eOutDateEl = nui.get("eOutDate");

	sPickDateEl.setValue(getMonthStartDate());
	ePickDateEl.setValue(addDate(getMonthEndDate(), 1));

	initGrid();

    keyEnterList = [];
  
    keyOutQtyList = [];
    keyCostAmtList = [];
    keySellAmtList = [];

	rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    rightGrid.on("preload",function(e)
    {
        var manList = e.result.manList;
        var outList = e.result.outList;

        for(var i=0;i<manList.length;i++)
        {
            for(var j=0;j<outList.length;j++)
            {
                if(manList[i].empName == outList[j].pickMan)
                {
                    for(var k=0; k<keyEnterList.length; k++){
                    	manList[i][keyEnterList[k]] = outList[j][keyEnterList[k]];
                    }
                }
            }

            var sumOutQty=0,sumCostAmt=0,sumSellAmt=0;
            for(var j=0;j<keyOutQtyList.length;j++){
                var outQty = manList[i][keyOutQtyList[j]]||0;
                var costAmt = manList[i][keyCostAmtList[j]]||0;
                var sellAmt = manList[i][keySellAmtList[j]]||0;

                sumOutQty+=outQty;
                sumCostAmt+=costAmt;
                sumSellAmt+=sellAmt;
            }
            if(sumOutQty!=0){
            	manList[i]["sumOutQty"] = sumOutQty;
            }
            if(sumCostAmt!=0){
            	manList[i]["sumCostAmt"] = sumCostAmt;
            }
            if(sumSellAmt!=0){
            	manList[i]["sumSellAmt"] = sumSellAmt;
            }

        }
              
        rightGrid.setData(manList);

        keyEnterList = [];
        
        keyOutQtyList = [];
        keyCostAmtList = [];
        keySellAmtList = [];
    });

    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // F9
            onSearch();
        }
    }

    onSearch();
});
function getSearchParam() {
	var params = {};
    params.sPickDate = sPickDateEl.getValue();
    params.ePickDate = ePickDateEl.getValue();
    params.sOutDate = sOutDateEl.getValue();
    params.eOutDate = eOutDateEl.getValue();
    
	return params;
}
function onSearch(){
	var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
	initGrid();

    rightGrid.load({
        params:params,
        token:token
    });
}
function initGrid(){
	
	var params = getSearchParam();
	nui.ajax({
        url : nameUrl,
        type : "post",
        data : JSON.stringify({
        	params : params,
            token : token
        }),
        success : function(text) {
            nui.unmask(document.body);
            if (text.errCode == "S") {
                var data = text.data || [];
                if(data && data.length > 0) {
                	initGridByName(data);
                }
                
            } else {
                showMsg(data.errMsg || "查询失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
	
}

function initGridByName(columnList) {
	var columnsObj = {};
	var columnsList = [];
	columnsList.push({type: "indexcolumn",width:"40", header: "序号" });
	columnsList.push({field: "empName",width:"80", summaryType:"count", headerAlign: "center", allowSort: true, header: "领料人"});
	if(columnList && columnList.length > 0){
		for (i = 0; i < columnList.length; i++) {
			var partName = columnList[i];
			var outQtyColumnName = partName+'_outQty';
			var costAmtColumnName = partName+'_costAmt';
			var sellAmtColumnName = partName+'_sellAmt';
			var obj = {header:month,columns:[
			        	{field: outQtyColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "出库数量",dataType:"float"},
			        	{field: costAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "成本金额",dataType:"float"},
			        	{field: sellAmtColumnName, width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "销售金额",dataType:"float"}
		          	 ]};
			columnsList.push(obj);

            keyEnterList.push(outQtyColumnName);
            keyEnterList.push(costAmtColumnName);
            keyEnterList.push(sellAmtColumnName);
            
            keyOutQtyList.push(outQtyColumnName);
            keyCostAmtList.push(costAmtColumnName);
            keySellAmtList.push(sellAmtColumnName);
		}

        var sumObj = {header:"汇总",columns:[
                        {field: "sumOutQty", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "出库数量",dataType:"float"},
                        {field: "sumCostAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "成本金额",dataType:"float"},
                        {field: "sumSellAmt", width: 60, headerAlign: "center", summaryType:"sum", allowSort: true, header: "销售金额",dataType:"float"}
                     ]};
        columnsList.push(sumObj);
	}
	
	rightGrid.set({
        columns: columnsList
    });
}

