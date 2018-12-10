var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryRpbBillModelList.biz.ext";
var mainGrid = null;
var servieTypeHash = {};
var carBrandHash = [];
var carSeriesHash = [];
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"项目",
	    "3":"配件"
};
var serviceTypeIdHash = {
	    "1":"综合",
	    "2":"洗美",
	    "3":"理赔"
};
$(document).ready(function ()
{
	mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    //设置日期
    var date = new Date();
    var etartDate = mini.get("eRecordDate");
    etartDate.setValue(date);   
   
    initCarBrand("carBrandList", function () {
        var data = nui.get("carBrandList").getData();
        data.forEach(function (v) {
            carBrandHash[v.id] = v;
        });
    });
    initCarSeries("carSeriesList", "", function () {
        var data = nui.get("carSeriesList").getData();
        data.forEach(function (v) {
            carSeriesHash[v.id] = v;
        });
    });

    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
   
    mainGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        switch (e.field) {
            case "billTypeId":
            	e.cellHtml = serviceTypeIdHash[e.value].name;
            case "serviceTypeId":
                e.cellHtml = servieTypeHash[e.value].name;
                break;
            case "carBrandId":
            	if(carBrandHash[e.value]){
            		e.cellHtml = carBrandHash[e.value].name;
            	};
            	break;
            case "carSeriesId":
            	if(carSeriesHash[e.value]){
            		e.cellHtml = carSeriesHash[e.value].name;
            	};
            	break;
            default:
                break;
        }
   });
    mainGrid.on("rowdblclick",function(e){
		edit();
	});
    quickSearch(4);
});
function quickSearch(type) {
    var params = {};
    var queryname = "全部";
    switch (type) {
        case 1:
            queryname = "综合";
            params.billTypeId = 1;
            break;
        case 2:
            queryname = "洗美";
            params.billTypeId = 2;
            break;
        case 3:
            queryname = "理赔";
            params.billTypeId = 3;
            break;
        case 4:
            queryname = "全部";
            params.billTypeIds = 4;
            break;
        default:
            break;
    }
    var menunamestatus = nui.get("menunamestatus");
    menunamestatus.setText(queryname);
    doSearch(params);
}

function doSearch(params) {
	 params.modelName = nui.get("modelName").getValue();
	 params.serviceTypeId = nui.get("serviceTypeId").getValue();
	 params.sRecordDate = nui.get("sRecordDate").getValue();
	 params.eRecordDate = nui.get("eRecordDate").getValue();
    mainGrid.load({
        token:token,
        params: params
    });
}

function onSearch()
{
    var params = {};
    var menunamestatus = nui.get("menunamestatus");
    var title = menunamestatus.getText();
    switch (title) {
        case "综合":
        	 params.billTypeId = 1;
             break;
        case "洗美":
            params.billTypeId = 2;  
            break;
        case "理赔":
            params.billTypeId = 3;  
            break;
        case "全部":
            params.billTypeIds = 4; 
            break;
        default:
            break;
    }
    doSearch(params);
}

function onenterModelName(e){
	onSearch();
}

function onenterServiceTypeId(e){
	onSearch();
}

function add(){
    var item={};
    item.id = "addQuickBill";
    item.text = "工单模板设置详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.addQuickBill.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var row = {};
    var params = {
    		data:row
    };
    window.parent.activeTabAndInit(item,params);
}
function edit(){
    var row = mainGrid.getSelected();
    if(!row) return;
    var item={};
    item.id = "addQuickBill";
    item.text = "工单模板设置详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.addQuickBill.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {
        data: row
    };
    window.parent.activeTabAndInit(item,params);
}
