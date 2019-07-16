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

//var getRpsItemBillUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPartBill.biz.ext";
//var getdRpsPackageBillUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPartBill.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"车架号(VIN)"},{id:"2",name:"客户名称"},{id:"3",name:"手机号"},{id:"4",name:"工单号"}];
var billTypeIdList = [{name:"综合开单"},{name:"检查开单"},{name:"洗美开单"},{name:"销售开单"},{name:"理赔开单"},{name:"退货开单"},{name:"波箱开单"}];
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
//var editFormDetail = null;
var innerItemGrid = null;
var advancedSearchWin = null;
var orgidsEl = null;
//var serviceTypeIds = null;
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"工时",
	    "3":"配件"
};
var rpsPackageGrid = null;
var rpsItemGrid = null;
$(document).ready(function ()
{
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
    beginDateEl = nui.get("sEnterDate");
	endDateEl = nui.get("eEnterDate");

    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);

    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    serviceTypeIds = nui.get("serviceTypeIds");
    advancedSearchForm = new nui.Form("#advancedSearchForm");
    //editFormDetail = document.getElementById("editFormDetail");
    innerItemGrid = nui.get("innerItemGrid");
    innerpackGrid = nui.get("innerpackGrid");
	advancedSearchWin = nui.get("advancedSearchWin");
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");

    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
    onSearch();
	  var filter = new HeaderFilter(mainGrid, {
	        columns: [
	            { name: 'mtAdvisor' },
	            { name: 'serviceCode' },
		            { name: 'guestFullName' },
	            { name: 'carModel' },
	            { name: 'carNo' },
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    	}
	        	return value;
	        }
	    });
	    initDicts({
	        //carSpec:CAR_SPEC,//车辆规格
	        //kiloType:KILO_TYPE,//里程类别
	        //source:GUEST_SOURCE,//客户来源
	        //identity:IDENTITY, //客户身份
	        guestProperty:GUEST_PROPERTY //客户类别
	    },function(data){

	    });
    initMember("mtAdvisorId",function(){     
        initServiceType("serviceTypeId",function(data) {
            servieTypeList = nui.get("serviceTypeId").getData();
            servieTypeList.forEach(function(v) {
                servieTypeHash[v.id] = v;
            });
/*            serviceTypeIds.setData(servieTypeList);

            initCarBrand("carBrandId",function(data) {
                brandList = nui.get("carBrandId").getData();
                brandList.forEach(function(v) {
                    brandHash[v.id] = v;
                });

            });*/


        });

    });
    mainGrid.on("cellclick",function(e){ 
		var field=e.field;
		var row = e.row;
        if(field=="isOutBill" ){
        	if(e.value==1){
    			var item={};
    			item.id = "123321";
    		    item.text = "报销单详情";
    			item.url =webBaseUrl+  "com.hsweb.print.ExpenseAccount.flow";
    			item.iconCls = "fa fa-file-text";
    			row.isEdit = true;//打开页面是否可编辑
    			window.parent.activeTabAndInit(item,row);
        	}

        }
    });
    mainGrid.on("drawSummaryCell", function (e) {
    	var result = e.result.list;
        var grossProfitSum = 0;
        var netinAmtSum = 0;
        for(var i = 0;i<result.length;i++){
        	grossProfitSum = grossProfitSum+result[i].grossProfit;
        	netinAmtSum = netinAmtSum +result[i].netinAmt;
        }
        if (e.field == "grossProfitRate") {
            var grossProfitRateSum = parseFloat(grossProfitSum)/parseFloat(netinAmtSum);
            grossProfitRateSum = ((grossProfitRateSum*100).toFixed(2))+"%";
            e.cellHtml = grossProfitRateSum;
        }

    });

    mainGrid.on("drawcell", function (e) {

    	    
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if (e.field == "carBrandId") {
            if (brandHash && brandHash[e.value]) {
                e.cellHtml = brandHash[e.value].name;
            }
        }else if (e.field == "billTypeId") {
        	e.cellHtml = billTypeIdList[e.value].name; 
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
        }else if(e.field == "orgid"){
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
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
                    if (servieTypeHash && servieTypeHash[e.value]) {
                        e.cellHtml = servieTypeHash[e.value].name;
                    }
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
            case "prdtCode":
            	var type = record.type||0;
                if(type == 3){
                	e.cellHtml = e.value;
                }else{
                	e.cellHtml = "--";
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
	                if (servieTypeHash && servieTypeHash[e.value]) {
	                    e.cellHtml = servieTypeHash[e.value].name;
	                }
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
            case "prdtCode":
            	var type = record.type||0;
                if(type == 3){
                	e.cellHtml = e.value;
                }else{
                	e.cellHtml = "--";
                }
                break;
            default:
                break;
        }
    });
    //quickSearch(4);
    rpsPackageGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value;
		var record = e.record;
		var uid = record._uid;
		if(field=="packageName"){
            var billPackageId = record.billPackageId || 0;
            if(billPackageId != 0){
            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
            }
		}
		if(field == "rate"){
			if(value){
				e.cellHtml = value + "%";
			}else{
				e.cellHtml = 0 + "%";
			}
		}
		if(field == "subtotal"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		
	});
    
    rpsItemGrid.on("drawcell",function(e){
		var field = e.field,
		value = e.value,
		row = e.row;
		var record = e.record;
		var uid = record._uid;
		if(field=="itemName"){
            var billItemId = record.billItemId||0;
            if(billItemId != 0){
            	e.cellHtml ='<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>' + e.value;
            }
		}
		if(field == "rate"){
			if(value){
				e.cellHtml = value + "%";
			}else{
				e.cellHtml = 0 + "%";
			}
		}
		if(field == "itemTime" || field == "unitPrice"){
			if(!value){
				e.cellHtml = 0;
			}
		}
		if(field == "itemCode"){
			var billItemId = record.billItemId||0;
			if(billItemId == 0){
	            e.cellHtml = "--";
	        }
		}
	});
 
    
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
/*    if(row.isOutBill==1){
        innerItemGrid.setUrl(getRpsItemBillUrl);
        innerpackGrid.setUrl(getdRpsPackageBillUrl);
    }else{
        innerItemGrid.setUrl(getRpsItemUrl);
        innerpackGrid.setUrl(getdRpsPackageUrl);
    }*/
    innerItemGrid.setUrl(getRpsItemUrl);
    innerpackGrid.setUrl(getdRpsPackageUrl);
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
    	gsparams.billTypeIds = "0,2,4,6";
    }
    if(nui.get("isCollectMoney").getValue()==1){
    	gsparams.isCollectMoneys="0,1";
    }else{
    	
    	gsparams.isSettle = 1;
    	gsparams.isCollectMoney=1;
    }
   // gsparams.billTypeId = 0;
    gsparams.isDisabled = 0;

    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    params.outDateStart = nui.get("sEnterDate").getValue();
    params.outDateEnd = addDate(endDateEl.getValue(),1); 
    
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
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
    var type = params.type||"";
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
				carNo : row.carNo,
				guestId : row.guestId,
				contactorId:row.contactorId
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


function onExport(){
	
	var billTypeIdHash = [{name:"综合",id:"0"},{name:"检查",id:"1"},{name:"洗美",id:"2"},{name:"销售",id:"3"},{name:"理赔",id:"4"},{name:"退货",id:"5"},{name:"波箱",id:"6"}];

	var detail = mainGrid.getData();
	
	for(var i=0;i<detail.length;i++){
		for(var j=0;j<billTypeIdHash.length;j++){
			if(detail[i].billTypeId==billTypeIdHash[j].id){
				detail[i].billTypeId=billTypeIdHash[j].name;
			}
		}
	
		if(detail[i].isCollectMoney==1){
			detail[i].isCollectMoney="√";
		}
		if(detail[i].isOutBill==1){
			detail[i].isOutBill="√";
		}
		for(var k=0;k<currOrgList.length;k++){
			if(detail[i].orgid==currOrgList[k].orgid){
				detail[i].orgid=currOrgList[k].shortName;
			}
		}
	}
	
	if(detail && detail.length > 0){
		setInitExportData( detail);
	}
}


function setInitExportData( detail){

    var tds = '<td  colspan="1" align="left">[serviceCode]</td>' +
        "<td  colspan='1' align='left'>[billTypeId]</td>" +
        "<td  colspan='1' align='left'>[serviceTypeName]</td>" +
        "<td  colspan='1' align='left'>[guestFullName]</td>" +
        "<td  colspan='1' align='left'>[carNo]</td>" +
        "<td  colspan='1' align='left'>[mtAdvisor]</td>" +
        "<td  colspan='1' align='left'>[isCollectMoney]</td>" +       
        "<td  colspan='1' align='left'>[collectMoneyDate]</td>" +
        
        "<td  colspan='1' align='left'>[carModel]</td>" +
        "<td  colspan='1' align='left'>[carVin]</td>" +
        "<td  colspan='1' align='left'>[enterKilometers]</td>" +
        
        "<td  colspan='1' align='left'>[packageAmt]</td>" +
        "<td  colspan='1' align='left'>[packagePrefAmt]</td>" +
        "<td  colspan='1' align='left'>[packageSubtotal]</td>"+
        "<td  colspan='1' align='left'>[itemAmt]</td>"+
        "<td  colspan='1' align='left'>[itemPrefAmt]</td>"+
        "<td  colspan='1' align='left'>[itemSubtotal]</td>"+      
        "<td  colspan='1' align='left'>[partAmt]</td>" +
        "<td  colspan='1' align='left'>[partPrefAmt]</td>" +
        "<td  colspan='1' align='left'>[partSubtotal]</td>" +
        "<td  colspan='1' align='left'>[otherAmt]</td>" +                     
        "<td  colspan='1' align='left'>[incomeTotal]</td>" +
        
        "<td  colspan='1' align='left'>[partTaxCost]</td>" +
        "<td  colspan='1' align='left'>[partNoTaxCost]</td>"+
        "<td  colspan='1' align='left'>[partTrueCost]</td>"+
        "<td  colspan='1' align='left'>[salesDeductValue]</td>"+
        "<td  colspan='1' align='left'>[advisorDeductValue]</td>"+
        "<td  colspan='1' align='left'>[techDeductValue]</td>"+       
        "<td  colspan='1' align='left'>[otherCostAmt]</td>"+
        "<td  colspan='1' align='left'>[expenditureTotal]</td>"+
        "<td  colspan='1' align='left'>[allowanceAmt]</td>"+
        
        "<td  colspan='1' align='left'>[netinAmt]</td>" +
        "<td  colspan='1' align='left'>[cardTimesAmt]</td>" +
        "<td  colspan='1' align='left'>[balaAmt]</td>" +      
        "<td  colspan='1' align='left'>[grossProfit]</td>" +        
        "<td  colspan='1' align='left'>[grossProfitRate]</td>"+
        "<td  colspan='1' align='left'>[grossProfitRemark]</td>"+
        
        "<td  colspan='1' align='left'>[remark]</td>"+
        "<td  colspan='1' align='left'>[enterDate]</td>"+  
        "<td  colspan='1' align='left'>[checkDate]</td>"+
        "<td  colspan='1' align='left'>[outDate]</td>"+
        "<td  colspan='1' align='left'>[isOutBill]</td>"+       
        "<td  colspan='1' align='left'>[orgid]</td>";
        
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.id){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[serviceCode]", detail[i].serviceCode?detail[i].serviceCode:"")
                         .replace("[billTypeId]", detail[i].billTypeId?detail[i].billTypeId:"")
                         .replace("[serviceTypeName]", detail[i].serviceTypeName?detail[i].serviceTypeName:"")
                         .replace("[guestFullName]", detail[i].guestFullName?detail[i].guestFullName:"")                        
                         .replace("[carNo]", detail[i].carNo?detail[i].carNo:"")
                         .replace("[mtAdvisor]", detail[i].mtAdvisor?detail[i].mtAdvisor:"")
                         .replace("[isCollectMoney]", detail[i].isCollectMoney?detail[i].isCollectMoney:"")
                         .replace("[collectMoneyDate]", nui.formatDate(detail[i].collectMoneyDate?detail[i].collectMoneyDate:"",'yyyy-MM-dd HH:mm'))
                         
                         .replace("[carModel]", detail[i].carModel?detail[i].carModel:"")                       
                         .replace("[carVin]", detail[i].carVin?detail[i].carVin:"")
                         .replace("[enterKilometers]", detail[i].enterKilometers?detail[i].enterKilometers:"") 
                         
                         .replace("[packageAmt]", detail[i].packageAmt?detail[i].packageAmt:0)                        
                         .replace("[packagePrefAmt]", detail[i].packagePrefAmt?detail[i].packagePrefAmt:0)
                         .replace("[packageSubtotal]", detail[i].packageSubtotal?detail[i].packageSubtotal:0)
                         
                         .replace("[itemAmt]", detail[i].itemAmt?detail[i].itemAmt:0)
                         .replace("[itemPrefAmt]", detail[i].itemPrefAmt?detail[i].itemPrefAmt:0)
                         .replace("[itemSubtotal]", detail[i].itemSubtotal?detail[i].itemSubtotal:0)
                         
                         .replace("[partAmt]", detail[i].partAmt?detail[i].partAmt:0)
                         .replace("[partPrefAmt]", detail[i].partPrefAmt?detail[i].partPrefAmt:0)
                         .replace("[partSubtotal]", detail[i].partSubtotal?detail[i].partSubtotal:0)         
                         .replace("[otherAmt]", detail[i].otherAmt?detail[i].otherAmt:0)
                         .replace("[incomeTotal]", detail[i].incomeTotal?detail[i].incomeTotal:0)
                         
                         .replace("[partTaxCost]", detail[i].partTaxCost?detail[i].partTaxCost:0)
                         .replace("[partNoTaxCost]", detail[i].partNoTaxCost?detail[i].partNoTaxCost:0)    
                         .replace("[partTrueCost]", detail[i].partTrueCost?detail[i].partTrueCost:0)                     
                         .replace("[salesDeductValue]", detail[i].salesDeductValue?detail[i].salesDeductValue:0)
                         .replace("[advisorDeductValue]", detail[i].advisorDeductValue?detail[i].advisorDeductValue:0)
                         .replace("[techDeductValue]", detail[i].techDeductValue?detail[i].techDeductValue:0)
                         .replace("[otherCostAmt]", detail[i].otherCostAmt?detail[i].otherCostAmt:0)
                         .replace("[expenditureTotal]", detail[i].expenditureTotal?detail[i].expenditureTotal:0)
                         .replace("[allowanceAmt]", detail[i].allowanceAmt?detail[i].allowanceAmt:0)                        
                         
                         .replace("[netinAmt]", detail[i].netinAmt?detail[i].netinAmt:0)                         
                         .replace("[cardTimesAmt]", detail[i].cardTimesAmt?detail[i].cardTimesAmt:0)
                         .replace("[balaAmt]", detail[i].balaAmt?detail[i].balaAmt:0)
                         
                         .replace("[grossProfit]", detail[i].grossProfit?detail[i].grossProfit:0)
                         .replace("[grossProfitRate]", detail[i].grossProfitRate?detail[i].grossProfitRate*100+"%":"0%")
                         .replace("[grossProfitRemark]", detail[i].grossProfitRemark?detail[i].grossProfitRemark:"")                         
                         .replace("[remark]", detail[i].remark?detail[i].remark:"")                         
                         .replace("[enterDate]",nui.formatDate(detail[i].enterDate?detail[i].enterDate:"",'yyyy-MM-dd HH:mm') ) 
                         .replace("[checkDate]",nui.formatDate(detail[i].checkDate?detail[i].checkDate:"",'yyyy-MM-dd HH:mm') )
                         .replace("[outDate]",nui.formatDate(detail[i].outDate?detail[i].outDate:"",'yyyy-MM-dd HH:mm') )
                         .replace("[isOutBill]", detail[i].isOutBill?detail[i].isOutBill:"") 
                         .replace("[orgid]", detail[i].orgid?detail[i].orgid:""));
            tableExportContent.append(tr);
        }
    }

 
    method5('tableExcel',"已结算工单明细表导出",'tableExportA');
}

function showCarInfo(row_uid){
	var row = mainGrid.getRowByUID(row_uid);
	if(row){
		var params = {
				carId : row.carId,
				carNo : row.carNo,
				guestId : row.guestId,
				contactorId:row.contactorId
		};
		doShowCarInfo(params);
	}
}

function doShowCarInfo(params) {
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.carDetails.flow?token="+token,
        width: 1100, height: 650,
		allowResize: false,
		showHeader: true,
        onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.SetData(params);
        },
        ondestroy: function (action) {
            if ("ok" == action) {
            }
        }
    });
}
function advancedSearch()
{
	
    advancedSearchWin.show();
    advancedSearchForm.clear();
    nui.get("sEnterDate1").setValue(getMonthStartDate());
    nui.get("eEnterDate1").setValue(getMonthEndDate());
}

function onAdvancedSearchOk()
{   
	var searchData = {};
	searchData.outDateStart = nui.get("outDateStart").getValue();
	if(nui.get("outDateEnd").getValue()){
		searchData.outDateEnd = addDate(nui.get("outDateEnd").getValue(),1); 
	}
	searchData.collectMoneyDateStart = nui.get("collectMoneyDateStart").getValue();
	if(nui.get("collectMoneyDateEnd").getValue()){
		searchData.collectMoneyDateEnd = addDate(nui.get("collectMoneyDateEnd").getValue(),1); 
	}
	searchData.sEnterDate = nui.get("sEnterDate1").getValue();
	if(nui.get("eEnterDate1").getValue()){
		searchData.eEnterDate = addDate(nui.get("eEnterDate1").getValue(),1);  
	}

	searchData.serviceTypeIds = serviceTypeIdEl.getValue();
    searchData.mtAuditorId = mtAdvisorIdEl.getValue();
    searchData.guestProperty = nui.get("guestProperty").getValue();
    searchData.propertyFeatures = nui.get("propertyFeatures").getValue();
    var billTypeIdList =  nui.get("billTypeIdList").getValue();
    if(billTypeIdList!=""&&billTypeIdList!=null){
    	searchData.billTypeIdList = billTypeIdList;
    }
    
/*    if((nui.get("statusId").getValue())!=999){
    	searchData.status = nui.get("statusId").getValue();
    }*/
/*    var settleType = nui.get("settleType").getValue();
    if(settleType==0){
    	searchData.balaAuditSign = 0;
    }else if(settleType==1){
    	searchData.balaAuditSign = 1;
    	searchData.isSettle = 0;
    }else if(settleType==2){
    	searchData.isSettle = 1;
    	searchData.isCollectMoney = 0;
    }else if(settleType==3){
    	searchData.isCollectMoney = 1;
    }*/
    var settleType = nui.get("settleType").getValue();
    if(settleType==1){
    	searchData.isCollectMoney = 0;
    }else if(settleType==2){
    	searchData.balaAuditSign = 1;
    	searchData.isCollectMoney = 1;
    }
    
/*    if((nui.get("auditSign").getValue())!=999){
    	searchData.isSettle = nui.get("auditSign").getValue();
    }*/  
    searchData.carNo = nui.get("carNo").getValue();
    searchData.vin = nui.get("vin").getValue();
    searchData.name = nui.get("name").getValue();
    searchData.mobile = nui.get("mobile").getValue();
    advancedSearchWin.hide();
    doSearch2(searchData);
    advancedSearchForm.gusetId=null;
  
}
function doSearch2(params){
    mainGrid.load({
        token:token,
        params: params
    });
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();

}

function cancelData(){
	advancedSearchForm.setData([]);
    nui.get("sEnterDate1").setValue(getMonthStartDate());
    nui.get("eEnterDate1").setValue(getMonthEndDate());
}


function activechangedmain(){
	var row = mainGrid.getSelected();
	var tabs = nui.get("mainTabs").getActiveTab();
	if(row){
		var serviceId = row.id;
		if(tabs.name=="item"){//项目
			innerItemGrid.setUrl(getRpsItemUrl);
			innerItemGrid.setData([]);
		    innerItemGrid.load({
		    	serviceId:serviceId,
		        token: token
		    });
		}else if(tabs.name=="pack"){//套餐
			innerpackGrid.setUrl(getdRpsPackageUrl);
		    innerpackGrid.setData([]);
		    innerpackGrid.load({
		    	serviceId:serviceId,
		        token: token
		    });
		}else if(tabs.name=="expense"){
			var serviceId = row.id;
			rpsPackageGrid.setData([]);
			rpsItemGrid.setData([]);
			rpsPackageGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpensePkgBill.biz.ext");
			rpsItemGrid.setUrl(baseUrl+"com.hsapi.repair.baseData.query.searchExpenseItemBill.biz.ext");
			rpsPackageGrid.load({serviceId : serviceId,type:1,token : token},function(e){
			});
			rpsItemGrid.load({serviceId : serviceId,type:1,token : token});
		}else if(tabs.name=="finish"){
			nui.mask({
		        el: document.body,
		        cls: 'mini-mask-loading',
		        html: '加载中...'
		    });
			var row = mainGrid.getSelected();
		    //完工信息
			var getdRpsMaintainUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.sureMt.getRpsMaintainById.biz.ext";
			var main = {};
			var car = {};
			var guest = {};
			var conta = {};
			var carExd = {};
			nui.ajax({
                url : getdRpsMaintainUrl,
                type : "post",
                data : JSON.stringify({
                	id : row.id,
                    token : token
                }),
                cache: false,
                async: false,
                success : function(data) {
                	data = data || {};
                    if (data.errCode == "S") {
                       main = data.maintain;
                    } else {
                        showMsg("获取完工信息失败","E");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                }
            });
			var getGuestContactorCarUrl =  window._rootRepairUrl + "com.hsapi.repair.repairService.svr.getGuestContactorCar.biz.ext";
			nui.ajax({
                url : getGuestContactorCarUrl,
                type : "post",
                data : JSON.stringify({
                	guestId: main.guestId||0,
                    contactorId: main.contactorId||0,
                    carId:main.carId || 0,
                    carExtendId:main.carId,
                    token : token
                }),
                cache: false,
                async: false,
                success : function(data) {
                	data = data || {};
                    if (data.errCode == "S") {
                        car = data.car;
                        guest = data.guest;
                        conta = data.contactor;
                        carExd = data.carExtend;
                    } else {
                        showMsg("获取完工信息失败","E");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                }
            });
			 var billForm = new nui.Form("#billForm");
			 var setData = {};
			 if(main){
				 setData.carNo = main.carNo;
				 setData.enterDate = main.enterDate;
				 setData.enterOilMass = main.enterOilMass;
				 setData.enterKilometers = main.enterKilometers;
				 setData.lastComeKilometers = main.lastEnterKilometers || 0;
				 setData.planFinishDate = main.planFinishDate;
				 setData.mtAdvisor = main.mtAdvisor;
				 setData.guestDesc = main.guestDesc;
				 setData.faultPhen = main.faultPhen;
				 setData.solveMethod = main.solveMethod; 
				 setData.serviceTypeId2= servieTypeHash[main.serviceTypeId].name;
			 }
			
			 if(car){
				 setData.carModel = car.carModel;
				 setData.carVin = car.vin;
			 }
			 
			 if(carExd){
				 setData.annualInspectionDate = carExd.annualInspectionDate || "";
				 setData.annualInspectionCompName = carExd.annualInspectionCompName || "";
				 setData.insureCompName = carExd.insureCompName || "";
				 setData.insureDueDate = carExd.insureDueDate || "";
			 }
			 if(conta){
				 setData.contactorName = conta.name;
				 setData.contactorMobile = conta.mobile;
				 setData.idNo = conta.idNo;
				 setData.sex = conta.sex; 
			 }
			
			 billForm.setData(setData);
			 nui.unmask(document.body);
		}
	}
	
}

function onLeftGridSelectionChanged(){
	activechangedmain();
}




