/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryNotSettleMaintain.biz.ext";
var getdRpsPackageUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext";
var getRpsItemUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";

//var getRpsItemBillUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPartBill.biz.ext";
//var getdRpsPackageBillUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPartBill.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"车架号(VIN)"},{id:"2",name:"客户名称"},{id:"3",name:"手机号"}];
var billTypeIdList = [{name:"综合开单"},{name:"检查开单"},{name:"洗美开单"},{name:"销售开单"},{name:"理赔开单"},{name:"退货开单"},{name:"波箱开单"}];
var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var receTypeIdList = [];
var receTypeIdHash = {};
var mtAdvisorIdEl = null;
var orgidsEl = null;
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
    beginDateEl = nui.get("sEnterDate");
	endDateEl = nui.get("eEnterDate");
    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
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

    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
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
    initDicts({
        //carSpec:CAR_SPEC,//车辆规格
        //kiloType:KILO_TYPE,//里程类别
        //source:GUEST_SOURCE,//客户来源
        //identity:IDENTITY, //客户身份
        guestProperty:GUEST_PROPERTY //客户类别
    },function(data){

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
	                if (servieTypeHash && servieTypeHash[e.value]) {
	                    e.cellHtml = servieTypeHash[e.value].name;
	                }
	            }
            break;
	        case "serviceTypeName":
	        	e.cellHtml = retSerTypeStyle(e.cellHtml);
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
    //beginDateEl.setValue(getMonthStartDate());
   // endDateEl.setValue(addDate(getMonthEndDate(), 1));
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

/*function quickSearch(type){
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sEnterDate = getNowStartDate();
            params.eEnterDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sEnterDate = getPrevStartDate();
            params.eEnterDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sEnterDate = getWeekStartDate();
            params.eEnterDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sEnterDate = getLastWeekStartDate();
            params.eEnterDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sEnterDate = getMonthStartDate();
            params.eEnterDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sEnterDate = getLastMonthStartDate();
            params.eEnterDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sEnterDate = getYearStartDate();
            params.eEnterDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sEnterDate = getPrevYearStartDate();
            params.eEnterDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
       
        default:
            break;
    }
    
    beginDateEl.setValue(params.sEnterDate);
    endDateEl.setValue(addDate(params.eEnterDate,-1));
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    
    doSearch(params);
}
*/


function onSearch()
{
    doSearch();
}
function doSearch() {
    var gsparams = getSearchParam();


    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    params.sEnterDate = nui.get("sEnterDate").getValue();
    params.eEnterDate = addDate(endDateEl.getValue(),1); 
    
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
function edit(){
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
/*	searchData.outDateStart = nui.get("outDateStart").getValue();
	if(nui.get("outDateEnd").getValue()){
		searchData.outDateEnd = addDate(nui.get("outDateEnd").getValue(),1); 
	}
	searchData.collectMoneyDateStart = nui.get("collectMoneyDateStart").getValue();
	if(nui.get("collectMoneyDateEnd").getValue()){
		searchData.collectMoneyDateEnd = addDate(nui.get("collectMoneyDateEnd").getValue(),1); 
	}*/
	searchData.sEnterDate = nui.get("sEnterDate1").getValue();
	if(nui.get("eEnterDate1").getValue()){
		searchData.eEnterDate = addDate(nui.get("eEnterDate1").getValue(),1);  
	}
/*	if((nui.get("isCollectMoney").getValue())!=1){
	searchData.isCollectMoney = 1;
	} */
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
function onExport(){
	var detail = nui.clone(mainGrid.getData());
//多级
	exportMultistage(mainGrid.columns)
//单级
       //exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
		
		
		detail[i].status=statusHash[detail[i].status]

		detail[i].billTypeId=billTypeIdList[detail[i].billTypeId].name;
        if(detail[i].isSettle== 1){
        	detail[i].isSettle = "已结算";
        }else{
        	detail[i].isSettle = "未结算";
        }

		if(detail[i].isOutBill==1){
			detail[i].isOutBill="√";
		}else{
			detail[i].isOutBill="";
		}
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,mainGrid.columns,"未结算工单明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,rightGrid.columns,"已结算工单明细表导出");
	}
	
}