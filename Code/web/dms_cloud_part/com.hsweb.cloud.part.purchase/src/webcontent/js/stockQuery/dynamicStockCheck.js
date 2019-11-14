/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.query.queryDynamicPartStoreStock.biz.ext";
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var billStatusHash = {
    "0":"未审",
    "1":"已审",
    "2":"已过账",
    "3":"已取消"
};
$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("load", function () {
        rightGrid.mergeColumns(["serviceId"]);
    });
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
 	comPartNameAndPY = nui.get("partNameAndPY");
	comPartCode = nui.get("partCode");

    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
       
    });

    quickSearch(currType);
});
function getSearchParam(){
    var params = {};
   
	params.partCode = comPartCode.getValue().replace(/(^\s*)|(\s*$)/g, "");
	params.partNameAndPY = comPartNameAndPY.getValue().replace(/\s+/g, "");
	params.storeId = nui.get("storeId").getValue();
	
	params.endDate = addDate(searchEndDate.getFormValue(), 1);
	params.startDate = searchBeginDate.getFormValue();
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(params.endDate);
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}
function onSearch(){
	var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
	params.orgid = currOrgid;
    rightGrid.load({
        params:params,
        token: token
    },function(){
        rightGrid.mergeColumns(["serviceId"]);
    });
}
var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.supplierSelect.flow?token="+token,
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
        	 var iframe = this.getIFrameEl();
             var params = {
        		 isSupplier: 1,
             };
             iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
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
        case "settleTypeId":
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


function onExport(){
	var data = rightGrid.getData();
	if(data && data.length > 0){
		setInitExportData(data);
	}
}
function setInitExportData(data){
	var tds = "<td  colspan='1' align='left'>[comPartCode]</td>" +
    "<td  colspan='1' align='left'>[comPartName]</td>" +
    "<td  colspan='1' align='left'>[comOemCode]</td>" +
    "<td  colspan='1' align='left'>[partBrandId]</td>" +
    "<td  colspan='1' align='left'>[applyCarModel]</td>" +
    "<td  colspan='1' align='left'>[unit]</td>" +
    "<td  colspan='1' align='left'>[storeId]</td>" +
    
    "<td  colspan='1' align='left'>[shelf]</td>" +
    "<td  colspan='1' align='left'>[stockQty]</td>" +
    "<td  colspan='1' align='left'>[stockAmt]</td>" +
    "<td  colspan='1' align='left'>[outableQty]</td>" +
    
    "<td  colspan='1' align='left'>[lastEnterDate]</td>"+
    "<td  colspan='1' align='left'>[lastOutDate]</td>"+      
    "<td  colspan='1' align='left'>[upLimit]</td>" +
    "<td  colspan='1' align='left'>[downLimit]</td>" +
    "<td  colspan='1' align='left'>[upLimitWinter]</td>" +
    
    "<td  colspan='1' align='left'>[downLimitWinter]</td>" +                     
    "<td  colspan='1' align='left'>[remark]</td>";
	
	var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    
    for(var i = 0 , l = data.length; i < l ; i++){
    	var row = data[i];
    	var orgid = null;
    	
    	var tr = $("<tr></tr>");
    	tr.append(tds.replace("[comPartCode]", row.comPartCode || "")
                .replace("[comPartName]", row.comPartName || "")
                .replace("[comOemCode]", row.comOemCode  || "")
                .replace("[partBrandId]", row.partBrandId?partBrandIdHash[row.partBrandId].name :"")
                .replace("[applyCarModel]", row.applyCarModel || "")  
                .replace("[unit]", row.unit || "") 
                .replace("[storeId]", row.storeId?storehouseHash[row.storeId].name : "")
                .replace("[shelf]", row.shelf || "") 
                .replace("[stockQty]", row.stockQty || "") 
                .replace("[stockAmt]", row.stockAmt || "") 
                .replace("[outableQty]", row.outableQty || "") 
                   
                .replace("[lastEnterDate]", nui.formatDate(row.lastEnterDate?row.lastEnterDate:"",'yyyy-MM-dd HH:mm') )
                .replace("[lastOutDate]", nui.formatDate(row.lastOutDate?row.lastOutDate:"",'yyyy-MM-dd HH:mm') )
                .replace("[upLimit]", row.upLimit || "") 
                .replace("[downLimit]", row.downLimit || "") 
                .replace("[upLimitWinter]", row.upLimitWinter || "") 
                .replace("[downLimitWinter]", row.downLimitWinter || "") 
                .replace("[remark]", row.remark || "") );
    			tableExportContent.append(tr);
    }
    var date = new Date();
    var title = "配件库存动态盘点表";
    title = title + nui.formatDate(date,'yyyy-MM-dd HH:mm');
    method5('tableExcel',title,'tableExportA');
}
