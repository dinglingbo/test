/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryAllMaintain.biz.ext";
var getdRpsPackageUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPart.biz.ext";
var getRpsItemUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";

var getRpsItemBillUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPartBill.biz.ext";
var getdRpsPackageBillUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsPackagePItemPPartBill.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
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
var auditSignHash = {
	    "0" : "在厂",
	    "1" : "出厂"
	};
$(document).ready(function ()
{
    beginDateEl = nui.get("sEnterDate");
	endDateEl = nui.get("eEnterDate");
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    advancedSearchForm.clear();
    advancedSearchForm.gusetId=null;
    mtAdvisorIdEl = nui.get("mtAdvisorId");
    serviceTypeIdEl = nui.get("serviceTypeId");
    serviceTypeIds = nui.get("serviceTypeIds");
    advancedSearchForm = new nui.Form("#advancedSearchForm");
    editFormDetail = document.getElementById("editFormDetail");
    advancedSearchWin = nui.get("advancedSearchWin");
    innerItemGrid = nui.get("innerItemGrid");
    innerpackGrid = nui.get("innerpackGrid");


    //判断是否有兼职门店,是否显示门店选择框
/*    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }*/
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下
        if((keyCode==27))  {  //ESC
        	advancedSearchWin.hide();
        }
      };
    //默认查今天
    beginDateEl.setValue(getNowStartDate());
    endDateEl.setValue(getNowEndDate());
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
            //serviceTypeIds.setData(servieTypeList);

/*            initCarBrand("carBrandId",function(data) {
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
    mainGrid.on("preload",function(e)
    	    {
    	        var data = e.result.data;
    	        var outBill = e.result.outBill;

    	        for(var i=0;i<data.length;i++)
    	        {
    	        	if(data[i].isOutBill==1){
        	            for(var j=0;j<outBill.length;j++)
        	            {
        	                if(data[i].id == outBill[j].sourceServiceId)
        	                {
        	                	//报销单显示报销单数据
        	                	data[i].packageSubtotal = outBill[j].packageAmt;
        	                	data[i].itemSubtotal = outBill[j].itemAmt;
        	                	data[i].partSubtotal = outBill[j].partAmt;
        	                	data[i].total = parseFloat(outBill[j].packageAmt)+parseFloat(outBill[j].itemAmt)+parseFloat(outBill[j].partAmt);
        	                	//报销单不显示优惠信息和结算信息
        	                	data[i].packagePrefAmt = null;
        	                	data[i].itemPrefAmt = null;
        	                	data[i].partPrefAmt = null;
        	                	data[i].otherAmt = null;
        	                	data[i].incomeTotal = null;
        	                	data[i].netinAmt = null;
        	                	data[i].cardTimesAmt = null;
        	                	data[i].balaAmt = null;
        	                	data[i].grossProfit = null;
        	                	data[i].grossProfitRate = null;
        	                	data[i].grossProfitRemark = null; 
        	                	outBill.splice(j,1);//如果已经匹配，删除本记录，降低循环时间
        	                }
        	            }
    	        	}
    	        }   	              
    	        mainGrid.setData(data);
    	    });

    mainGrid.on("drawSummaryCell", function (e) {
    	var result = e.result.data;
        var grossProfitSum = 0;
        var netinAmtSum = 0;
        for(var i = 0;i<result.length;i++){
        	grossProfitSum = grossProfitSum+result[i].grossProfit||0;
        	netinAmtSum = netinAmtSum +result[i].netinAmt||0;
        }
        if (e.field == "grossProfitRate") {
        	if(netinAmtSum!=0){
                var grossProfitRateSum = parseFloat(grossProfitSum)/parseFloat(netinAmtSum);
                grossProfitRateSum = ((grossProfitRateSum*100).toFixed(2))+"%";
                e.cellHtml = grossProfitRateSum;
        	}else{
        		e.cellHtml = "0%";
        	}

        }

    });
    mainGrid.on("drawcell", function (e) {
    	var record = e.record;
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if (e.field == "carBrandId") {
            if (brandHash && brandHash[e.value]) {
                e.cellHtml = brandHash[e.value].name;
            }
        }else if (e.field == "billTypeId") {
        	e.cellHtml = billTypeIdList[e.value].name; 
        }else if (e.field == "isSettle") {
        	if(e.value==null){
        		e.cellHtml = "在厂";
        	}else if (auditSignHash && auditSignHash[e.value]) {
                e.cellHtml = auditSignHash[e.value];
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
	                if(servieTypeHash[e.value])
	                {
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
    if(row.isOutBill==1){
        innerItemGrid.setUrl(getRpsItemBillUrl);
        innerpackGrid.setUrl(getdRpsPackageBillUrl);
    }else{
        innerItemGrid.setUrl(getRpsItemUrl);
        innerpackGrid.setUrl(getdRpsPackageUrl);
    }

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
}*/



function onSearch()
{
    doSearch();
}
function doSearch(setInitData) {
    var gsparams = getSearchParam();
    if(setInitData=="setInitData"){//首页进来,或者选择查询类别，不受时间限制，都查今天的
        beginDateEl.setValue(getNowStartDate());
        endDateEl.setValue(getNowEndDate());
    	gsparams.sEnterDate = getNowStartDate();
    	gsparams.eEnterDate = addDate(getNowEndDate(), 1);
        if(nui.get("seachType").getValue()==2){
        	gsparams.sEnterDate = null;
        	gsparams.eEnterDate = null;
        	gsparams.isSettle=0;
        	gsparams.seachType=2;//用于判断是查什么
        }else if(nui.get("seachType").getValue()==1){
        	gsparams.isSettle=1;
        	gsparams.seachType=1;//用于判断是查什么
        }else if(nui.get("seachType").getValue()==0){
        	gsparams.isSettle=0;
        	gsparams.seachType=0;//用于判断是查什么
        }
    }

    var xcdate = getDays(gsparams.sEnterDate,gsparams.eEnterDate);
    if(xcdate>92){
       showMsg("查询时间相差不能大于三个月！","W");
       return;
     }
    

    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    params.sEnterDate = nui.get("sEnterDate").getValue();
    params.eEnterDate = addDate(endDateEl.getValue(),1); 
    
    
 
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
/*//根据开单界面传递的车牌号查询未结算的工单
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
}*/

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
    var params = {};
    //先判断是否结算
    if(row.isCollectMoney==1){
        item.id = "11111";
        item.text = "工单详情页";
        item.url =webBaseUrl+  "com.hsweb.repair.DataBase.orderDetail.flow?sourceServiceId="+row.id;
        item.iconCls = "fa fa-file-text";
        params.id=row.id;
    	window.parent.activeTabAndInit(item,params);
    }else{
    	 //0综合，1检查，2洗美，3销售，4理赔，5退货，6波箱
        if(row.billTypeId==0){
            item.id = "2000";
            item.text = "综合开单详情";
            item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairBill.flow";
            item.iconCls = "fa fa-file-text";
            params.id=row.id;
        }else if(row.billTypeId==2){
            item.id = "3000";
            item.text = "洗美开单详情";
            item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.carWashBill.flow";
            item.iconCls = "fa fa-file-text";
            params.id=row.id;
        }else if(row.billTypeId==4){
            item.id = "4000";
            item.text = "理赔开单详情";
            item.url = webPath + contextPath + "/com.hsweb.RepairBusiness.claimDetail.flow";
            item.iconCls = "fa fa-file-text";
            params.id=row.id;
        }else if(row.billTypeId==6){
            item.id = "8000";
            item.text = "波箱开单详情";
            item.url = webPath + contextPath + "/com.hsweb.bx.waveBoxDetail.flow";
            item.iconCls = "fa fa-file-text";
            params.id=row.id;
        }
    }
    window.parent.activeTabAndInit(item,params);
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

function getDays(strDateStart,strDateEnd){
		strDateStart = new Date(strDateStart);
		strDateEnd = new Date(strDateEnd);
		var iDays =(strDateEnd-strDateStart) / (1000 * 60 * 60 * 24);

	   return iDays ;
	}

function setInitData(params) {
    if (params.id == 'settleQty') {
    	nui.get("seachType").setValue(1);
    	nui.get("seachType").setText("结算车辆");
    	doSearch("setInitData");

    } else if (params.id == 'serviceBillQty') {
    		nui.get("seachType").setValue(2);
    		nui.get("seachType").setText("在修车辆");
    		doSearch("setInitData");
    } else if (params.id == 'recordBillQty') {
		nui.get("seachType").setValue(0);
		nui.get("seachType").setText("今日进厂");
		doSearch("setInitData");
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
    
    searchData.mtAuditorId = mtAdvisorIdEl.getValue();
    searchData.serviceTypeIds = serviceTypeIdEl.getValue();
    searchData.guestProperty = nui.get("guestProperty").getValue();
    searchData.propertyFeatures = nui.get("propertyFeatures").getValue();
    var billTypeIdList =  nui.get("billTypeIdList").getValue();
    var carModel   = nui.get("carModel").getValue();
    searchData.carModel = carModel.replace(/\s+/g,""); 
    searchData.itemId = nui.get("itemId").getValue();
    if(billTypeIdList!=""&&billTypeIdList!=null){
    	searchData.billTypeIdList = billTypeIdList;
    }
    
    if((nui.get("statusId").getValue())!=999){
    	searchData.status = nui.get("statusId").getValue();
    }
    var settleType = nui.get("settleType").getValue();
    if(settleType==4){
    	searchData.balaAuditSign = 0;
    }else if(settleType==1){
    	searchData.balaAuditSign = 1;
    	searchData.isSettle = 0;
    }else if(settleType==2){
    	searchData.isSettle = 1;
    	searchData.isCollectMoney = 0;
    }else if(settleType==3){
    	searchData.isCollectMoney = 1;
    }
    if((nui.get("auditSign").getValue())!=999){
    	searchData.isSettle = nui.get("auditSign").getValue();
    }  
    searchData.carNo = nui.get("carNo").getValue();
    searchData.vin = nui.get("vin").getValue();
    searchData.name = nui.get("name").getValue();
    searchData.mobile = nui.get("mobile").getValue();
    advancedSearchWin.hide();
    doSearch2(searchData);

  
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

function queryExpense(){
	var row = mainGrid.getSelected();
		var item={};
		item.id = "123321";
	    item.text = "报销单详情";
		item.url =webBaseUrl+  "com.hsweb.print.ExpenseAccount.flow";
		item.iconCls = "fa fa-file-text";
		window.parent.activeTabAndInit(item,row);
}
function onExport(){
	var detail = nui.clone(mainGrid.getData());
	exportMultistage(mainGrid.columns)
	for(var i=0;i<detail.length;i++){
			
		detail[i].status=statusHash[detail[i].status]

		detail[i].billTypeId=billTypeIdList[detail[i].billTypeId].name;
        if(detail[i].isSettle== 1){
        	detail[i].isSettle = "已结算";
        }else{
        	detail[i].isSettle = "未结算";
        }

		if(detail[i].isCollectMoney==1){
			detail[i].isCollectMoney="√";
		}else{
			detail[i].isCollectMoney="";
		}
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,mainGrid.columns,"已结算工单明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,rightGrid.columns,"已结算工单明细表导出");
	}
	
}

function getItemId(){
	nui.open({
		// targetWindow: window,,
		url : webPath + contextPath + "/com.hsweb.repair.DataBase.RepairItemMain.flow?token=" + token,
		title : "维修项目",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {};
			iframe.contentWindow.setData(params);
			iframe.contentWindow.showCheckcolumn();
		},
		ondestroy : function(action) {
			var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getDataAll();
            for(var i = 0 , l = data.length; i < l ; i++){
            	var itemName = data[i].name || "";
            	var itemId = data[i].id;
            	
            	nui.get("itemId").setText(itemName);
            	nui.get("itemId").setValue(itemId);
            }
		}
	});
}