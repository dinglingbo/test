/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryComprehensive.biz.ext";
var getdRpsPackageUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext";
var getRpsItemUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";

var beginDateEl = null;
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"车架号(VIN)"},{id:"2",name:"客户名称"},{id:"3",name:"手机号"}];
var brandList = [];
var brandHash = {};
var servieTypeList = [];  
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};
var mtAdvisorIdEl = null;
var serviceTypeIdEl = null;
var serviceTypeIds = null;
var advancedMore = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var editFormDetail = null;
var innerItemGrid = null;
var advancedSearchWin = null;
//var serviceTypeIds = null;
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"工时",
	    "3":"配件"
};
$(document).ready(function ()
{
    beginDateEl = nui.get("sOutDate");
	endDateEl = nui.get("eOutDate");

    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);

    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    serviceTypeIds = nui.get("serviceTypeIds");
    advancedSearchForm = new nui.Form("#advancedSearchForm");
    editFormDetail = document.getElementById("editFormDetail");
    innerItemGrid = nui.get("innerItemGrid");
    innerpackGrid = nui.get("innerpackGrid");
	advancedSearchWin = nui.get("advancedSearchWin");
    innerItemGrid.setUrl(getRpsItemUrl);
    innerpackGrid.setUrl(getdRpsPackageUrl);

    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
    onSearch();
    initMember("mtAdvisorId",function(){     
        initServiceType("serviceTypeId",function(data) {
            servieTypeList = nui.get("serviceTypeId").getData();
            servieTypeList.forEach(function(v) {
                servieTypeHash[v.id] = v;
            });
            serviceTypeIds.setData(servieTypeList);

            initCarBrand("carBrandId",function(data) {
                brandList = nui.get("carBrandId").getData();
                brandList.forEach(function(v) {
                    brandHash[v.id] = v;
                });

            });


        });

    });


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
        }else if (e.field == "serviceTypeName") {
                e.cellHtml = retSerTypeStyle(e.cellHtml);
        }else if(e.field == "isSettle"){
            if(e.value == 1){
                e.cellHtml = "已结算";
            }else{
                e.cellHtml = "未结算";
            }
        }else if(e.field == "serviceCode"){
        	e.cellHtml ='<a href="##" onclick="edit('+e.record._uid+')">'+e.record.serviceCode+'</a>';
        }else if(e.field == "carNo"){
        	e.cellHtml ='<a href="##" onclick="showCarInfo('+e.record._uid+')">'+e.record.carNo+'</a>';
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
                if(value&&value!="0"){
                    e.cellHtml = e.value + '%';
                }
                break;
            default:
                break;
        }
        
    });
    mainGrid.on("rowdblclick",function(){
    	edit();
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
                if(value&&value!="0"){
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
    quickSearch(2);
    
});
var statusHash = {
    "0" : "报价",
    "1" : "施工",
    "2" : "完工",
    "3" : "待结算",
    "4" : "已结算"
};

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

function quickSearch(type){
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sOutDate = getNowStartDate();
            params.eOutDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sOutDate = getPrevStartDate();
            params.eOutDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sOutDate = getWeekStartDate();
            params.eOutDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sOutDate = getLastWeekStartDate();
            params.eOutDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sOutDate = getMonthStartDate();
            params.eOutDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sOutDate = getLastMonthStartDate();
            params.eOutDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sOutDate = getYearStartDate();
            params.eOutDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sOutDate = getPrevYearStartDate();
            params.eOutDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
       
        default:
            break;
    }
    
    beginDateEl.setValue(params.sOutDate);
    endDateEl.setValue(addDate(params.eOutDate,-1));
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    
    doSearch(params);
}



function onSearch()
{
    doSearch();
}
function doSearch() {
    var gsparams = getSearchParam();
    if(gsparams.billTypeIds && gsparams.billTypeIds==5){
    	gsparams.billTypeIds = "0,2,4";
    }
    gsparams.isSettle = 1;
   // gsparams.billTypeId = 0;
    gsparams.isDisabled = 0;

    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    params.sOutDate = nui.get("sOutDate").getValue();
    params.eOutDate = addDate(endDateEl.getValue(),1);  
    params.mtAuditorId = mtAdvisorIdEl.getValue();

    if((nui.get("billTypeId").getValue())==5){
    	
    }else{
        params.billTypeIds = nui.get("billTypeId").getValue();
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
        params.mobile = typeValue;
    }
    return params;
}
function onAdvancedSearchCancel(){
    advancedSearchWin.hide();
}
function onAdvancedSearchOk(){
    var params = {};
    doSearch(params);
    advancedSearchWin.hide();
}
function add(){
    var item={};
    item.id = "2000";
    item.text = "综合开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairBill.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {};
    window.parent.activeTabAndInit(item,params);

}
/*function edit(){
    var row = mainGrid.getSelected();
    if(!row) return;
    var item={};
    item.id = "2000";
    item.text = "综合开单详情";
    item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairBill.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {
        id: row.id
    };
    window.parent.activeTabAndInit(item,params);
}*/
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

function carNoSearch(){
	onSearch();
}

function edit(row_uid){
	var row = null;
	if(!row_uid){
		row = mainGrid.getSelected();
	}else{
		row = mainGrid.getRowByUID(row_uid);
	}
    if(!row) return;
    var item={};
    var data = {};
    data.id = row.id;
    var item={};
	item.id = "11111";
    item.text = "工单详情页";
	item.url =webBaseUrl+  "com.hsweb.repair.DataBase.orderDetail.flow?sourceServiceId="+data.id;
	item.iconCls = "fa fa-file-text";
	window.parent.activeTabAndInit(item,data);
}

function showCarInfo(row_uid){
	var row = mainGrid.getRowByUID(row_uid);
	if(row){
		var params = {
				carId : row.carId,
				guestId : row.guestId
		};
		doShowCarInfo(params);
	}
}

function retSerTypeStyle(string) {
    // var string = '洗车,美容,保养,机电,钣金,理赔,改装,轮胎,喷漆,代办,其它,34,55';
    //  var resText = '<div style="display:flex;height:100%;width:100%"><span class="tb-tag">' + string + '</span></div>';
    //var resText = '<div style="display:flex;height:100%;width:100%">';
    var resText = '';
    var styleTemp = '';
    var temp = '';
    var styleText = 'style="display: inline-block;padding: 2px 10px;font-size: 12px;border-radius: 4px;box-sizing: border-box;white-space: nowrap;'
    var colorArr = [
        { id: '041301', name: '洗车', col: '#409eff', backcol: 'rgba(64,158,255,.1)', borcol: 'rgba(64,158,255,.2)' },
        { id: '041302', name: '美容', col: '#67c23a', backcol: 'rgba(103,194,58,.1)', borcol: 'rgba(103,194,58,.2)' },
        { id: '041303', name: '保养', col: 'rgb(182, 202, 34)', backcol: 'rgba(182, 202, 34,.1)', borcol: 'rgba(182, 202, 34,.2)' },
        { id: '041304', name: '机电', col: '#e6a23c', backcol: 'rgba(230,162,60,.1)', borcol: 'rgba(230,162,60,.2)' },
        { id: '041305', name: '钣金', col: '#f56c6c', backcol: 'hsla(0,87%,69%,.1)', borcol: 'hsla(0,87%,69%,.2)' },
        { id: '041306', name: '理赔', col: 'rgba(230, 60, 192,.9)', backcol: 'rgba(230, 60, 192,.1)', borcol: 'rgba(230, 60, 192,.2)' },
        { id: '041307', name: '改装', col: 'rgba(136, 51, 226,.9)', backcol: 'rgba(136, 51, 226,.1)', borcol: 'rgba(136, 51, 226,.2)' },
        { id: '041308', name: '轮胎', col: 'rgba(63, 51, 226,.9)', backcol: 'rgba(63, 51, 226,.1)', borcol: 'rgba(63, 51, 226,.2)' },
        { id: '041309', name: '喷漆', col: 'rgba(51, 226, 147,.9)', backcol: 'rgba(51, 226, 147,.1)', borcol: 'rgba(51, 226, 147,.2)' },
        { id: '041310', name: '代办', col: 'rgba(77, 226, 51,.9)', backcol: 'rgba(77, 226, 51,.1)', borcol: 'rgba(77, 226, 51,.2)' },
        { id: '041311', name: '其它', col: 'rgba(63, 96, 138,.9)', backcol: 'rgba(63, 96, 138,.1)', borcol: 'rgba(63, 96, 138,.2)' },
        { id: '04131X', name: '    ', col: 'rgb(144, 147, 153)', backcol: 'rgba(144, 147, 153,.1)', borcol: 'rgba(144, 147, 153,.2)' }
    ];
    if (string) {
        var strArr = string.split(",");
        for (var i = 0; i < strArr.length; i++) {
            styleTemp = styleText + 'color:rgb(144, 147, 153);background-color:rgba(144, 147, 153,.1);border: 1px solid rgba(144, 147, 153,.2);"';
            for (var j = 0; j < colorArr.length; j++) {
                if (strArr[i] == colorArr[j].name) {
                    styleTemp = styleText + 'color:' + colorArr[j].col + ';background-color:' + colorArr[j].backcol + ';border: 1px solid ' +colorArr[j].borcol + ';"';
                }
            }
            temp = '<span '+styleTemp+'>' + strArr[i] + '</span>&nbsp;';
            resText += temp;
        }
    }
    //resText += '</div>';
    return resText;
}
