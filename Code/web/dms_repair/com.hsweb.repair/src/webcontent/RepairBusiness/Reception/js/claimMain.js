/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
//var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemQuoteByServiceId.biz.ext";
//var partGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPartByServiceId.biz.ext";
var getdRpsPackageUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext";
var getRpsItemUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"VIN码"},{id:"2",name:"客户名称"},{id:"3",name:"手机号"}];
var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};
var mtAdvisorIdEl = null;
var serviceTypeIdEl = null;
var advancedMore = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var editFormDetail = null;
var innerItemGrid = null;
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"工时",
	    "3":"配件"
};
$(document).ready(function ()
{
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    beginDateEl = nui.get("sEnterDate");
    endDateEl = nui.get("eEnterDate");
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    advancedMore = nui.get("advancedMore");
    advancedSearchForm = new nui.Form("#advancedSearchForm");
    editFormDetail = document.getElementById("editFormDetail");
    innerItemGrid = nui.get("innerItemGrid");
    innerpackGrid = nui.get("innerpackGrid");
    innerItemGrid.setUrl(getRpsItemUrl);
    innerpackGrid.setUrl(getdRpsPackageUrl);

    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));

    initMember("mtAdvisorId",null);
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
    initCarBrand("carBrandId",function(data) {
        brandList = nui.get("carBrandId").getData();
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });
    // initCustomDicts("receTypeId", "0415",function(data) {
    //     receTypeIdList = nui.get("receTypeId").getData();
    //     receTypeIdList.forEach(function(v) {
    //         receTypeIdHash[v.customid] = v;
    //     });
    // });

    mainGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if (e.field == "carBrandId") {
            if (brandHash && brandHash[e.value]) {
                e.cellHtml = brandHash[e.value].name;
            }
        }else if (e.field == "serviceTypeId") {
            if (servieTypeHash && servieTypeHash[e.value]) {
                e.cellHtml = servieTypeHash[e.value].name;
            }
        }else if(e.field == "isSettle"){
            if(e.value == 1){
                e.cellHtml = "已结算";
            }else{
                e.cellHtml = "未结算";
            }
        }
    });

    innerItemGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        switch (e.field) {
            case "prdtName":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId>0){
                    e.cellHtml = e.value + "<font color='red'>(预存)</font>";
                }
                break;
            case "serviceTypeId":
                var type = record.type||0;
                if(type>2){
                    e.cellHtml = "--";
                    e.cancel = false;
                }else{
                    e.cellHtml = servieTypeHash[e.value].name;
                }
                break;
            case "workers":
                var type = record.type||0;
                if(type != 2){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = e.value;
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value && value != "0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            default:
                break;
        }
        
    });
    
    
    innerpackGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        switch (e.field) {
		   case "prdtName":
		        var cardDetailId = record.cardDetailId||0;
		        if(cardDetailId>0){
		            e.cellHtml = e.value + "<font color='red'>(预存)</font>";
		        }
            break;
	        case "serviceTypeId":
	            var type = record.type||0;
	            if(type>1){
	                e.cellHtml = "--";
	            }else{
	                e.cellHtml = servieTypeHash[e.value].name;
	            }
            break;
            case "saleMan":
                var type = record.type||0;
                var cardDetailId = record.cardDetailId||0;
                if(type>1 || cardDetailId> 0){
                    e.cellHtml = "--";
                }
                break;
            case "workers":
                var type = record.type||0;
                var cardDetailId = record.cardDetailId||0;
                if(type != 2){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = e.value;
                }
                break;
            case "serviceTypeId":
                if(servieTypeHash[e.value])
                {
                    e.cellHtml = servieTypeHash[e.value].name;
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value && value != "0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            case "type":
                if(e.value == 1){
                    e.cellHtml = "--";
                }else{
                    e.cellHtml = prdtTypeHash[e.value];
                }
                break;
            default:
                break;
        }
    });

    var statusList = "0,1,2,3";
    var p = {statusList:statusList};
    doSearch(p);
});
var statusHash = {
    "0" : "报价",
    "1" : "施工",
    "2" : "完工",
    "3" : "待结算",
    "4" : "已结算"
};
function advancedSearch(){
    if(document.getElementById("advancedMore").style.display=='block'){
        document.getElementById("advancedMore").style.display='none';
    }else{
        document.getElementById("advancedMore").style.display='block';
    }
    
}
function clear(){
    advancedSearchForm.setData([]); 
    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
}
function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = mainGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";

    innerItemGrid.setData([]);
    innerpackGrid.setData([]);
    //var params = {};
   // params.serviceId = row.id;
    var serviceId = row.id;
    innerItemGrid.load({
    	serviceId:serviceId,
        token: token
    });

    innerpackGrid.load({
    	serviceId:serviceId,
        token: token
    });
}
function quickSearch(type) {
    var params = {};
    switch (type) {
        case 0:
            params.status = 0;  //制单
            break;
        case 1:
            params.status = 1;  //施工
            break;
        case 2:
            params.status = 2;  //完工
            document.getElementById("advancedMore").style.display='block';
            break;
        case 3:
            params.status = 2;  //待结算  is_settle
            params.isSettle = 0;
            break;
        case 4:
            params.isSettle = 1;
            document.getElementById("advancedMore").style.display='block';
            break;
        default:
            break;
    }

    doSearch(params);
}
function onSearch()
{
    var params = {};
    if(document.getElementById("advancedMore").style.display!='block'){
        var value = nui.get("carNo-search").getValue()||"";
        value = value.replace(/\s+/g, "");
        if(!value){
            showMsg("请输入查询条件!","W");
            return;
        }
    }
    doSearch(params);
}
function doSearch(params) {
    var gsparams = getSearchParam();
    gsparams.status = params.status;
    gsparams.statusList = params.statusList;
    gsparams.isSettle = params.isSettle;
    gsparams.billTypeId = 4;

    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    if(document.getElementById("advancedMore").style.display=='block'){
        params.sEnterDate = beginDateEl.getValue();
        params.eEnterDate = endDateEl.getValue();
        params.mtAuditorId = mtAdvisorIdEl.getValue();
        params.serviceTypeId = serviceTypeIdEl.getValue();
    }
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.vin = typeValue;
    }else if(type==2){
        params.name = typeValue;
    }else if(type==3){
        params.tel = typeValue;
    }
    return params;
}
function add(){
    var item={};
    item.id = "4000";
    item.text = "理赔-工单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.claimDetail.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {};
    window.parent.activeTabAndInit(item,params);

}
function edit(){
    var row = mainGrid.getSelected();
    if(!row) return;
    var item={};
    item.id = "4000";
    item.text = "理赔-工单";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.claimDetail.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {
        id: row.id
    };
    window.parent.activeTabAndInit(item,params);
}
//根据开单界面传递的车牌号查询未结算的工单
function setInitData(params){
    var carNo = params.carNo||"";
    var type = params.type||""
    if(type=='view' && carNo != ""){
        var p = {
            carNoEqual: carNo,
            isSettle: 0
        };
        mainGrid.load({
            token:token,
            params: p
        });
    }
}
function finish(){
    var row = mainGrid.getSelected();
    if(!row) {
        showMsg("请选择一条记录!","W");
        return;
    }

    if(row.status == 2){
        showMsg("本工单已经完工!","W");
        return;
    }
    var params = {
        serviceId:row.id||0
    };
    doFinishWork(params, function(data){
        data = data||{};data = data||{};
        if(data.action){
            var action = data.action||"";
            if(action == 'ok'){
                var newRow = {status: 2};
                mainGrid.updateRow(row, newRow);
                showMsg("完工成功!","S");
            }else{
                if(data.errCode){
                    showMsg("完工失败!","W");
                    return;
                }
            }
        }
    });
}
function unfinish(){
    var row = mainGrid.getSelected();
    if(!row) {
        showMsg("请选择一条记录!","W");
        return;
    }

    var isSettle = row.isSettle||0;
    if(isSettle == 1){
        showMsg("本工单已经结算,不能返工!","W");
        return;
    }
    if(row.status != 2){
        showMsg("本工单未未完工,不能返工!!","W");
        return;
    }
    
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
    var params = {
        data:{
            id:row.id||0
        }
    };
    svrUnRepairAudit(params, function(data){
        data = data||{};
        var errCode = data.errCode||"";
        var errMsg = data.errMsg||"";
        if(errCode == 'S'){
            var newRow = {status: 1};
            mainGrid.updateRow(row, newRow);
            showMsg("返工成功!","S");
        }else{
            showMsg(errMsg||"返工失败!","W");
        }
        nui.unmask(document.body);
    }, function(){
        nui.unmask(document.body);
    });
}
function pay(){
    var row = mainGrid.getSelected();
    if(!row) {
        showMsg("请选择一条记录!","W");
        return;
    }
}
function del(){
    var row = mainGrid.getSelected();
    if(!row) {
        showMsg("请选择一条记录!","W");
        return;
    }

    if(row.status != 0){
        showMsg("本工单不能删除!","W");
        return;
    }
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
    var params = {
        data:{
            id:row.id||0,
            isDisabled:0
        }
    };
    svrDelBill(params, function(data){
        data = data||{};
        var errCode = data.errCode||"";
        var errMsg = data.errMsg||"";
        if(errCode == 'S'){
            mainGrid.removeRow(row);
            showMsg("删除成功!","S");
        }else{
            showMsg(errMsg||"删除失败!","W");
        }
        nui.unmask(document.body);
    }, function(){
        nui.unmask(document.body);
    });
}