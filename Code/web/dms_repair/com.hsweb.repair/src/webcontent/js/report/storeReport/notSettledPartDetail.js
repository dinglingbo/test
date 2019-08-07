/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + repairApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.repair.repairService.report.queryRepairOutList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var brandHash = {};
var brandList = [];
partTypeList=[];
partTypeHash={};
var orgidsEl = null;
var storehouse = null;
var storeHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var outTypeIdHash = {};
//var sOutDateEl=null;
//var eOutDateEl =null;
//var sPickDateEl =null;
//var ePickDateEl=null;
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    //sOutDateEl =nui.get('sOutDate');
   // eOutDateEl = nui.get('eOutDate');
    
   // sPickDateEl =nui.get('sPickDate');
   // ePickDateEl = nui.get('ePickDate');
    
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
    setReturnSign = mini.get("ReturnSign");
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		if ((keyCode == 13)) { // F9
			onSearch();
		}
	}
    
	getAllPartBrand(function(data) {
		brandList = data.brand;
		nui.get('partBrandId').setData(brandList);
		brandList.forEach(function(v) {
			brandHash[v.id] = v;
		});
	});
	
	getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		if(storehouse && storehouse.length>0){
			nui.get('storeId').setData(storehouse);
	
			storehouse.forEach(function(v) {
				storeHash[v.id] = v;
			});
		}
	});

	
	rightGrid.on("drawcell",function(e){
		switch (e.field) {
		case "serviceCode":
			e.cellHtml ='<a href="##" onclick="editSell()">'+e.value+'</a>';
			break;
		case "outReturnSign":
				e.cellHtml="已归库";
			break;
		case "partBrandId":
			  if(brandHash[e.value])
              {
//                  e.cellHtml = brandHash[e.value].name||"";
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
		 case "carTypeIdF":
		 case "carTypeIdS":
		 case "carTypeIdT":
            if(partTypeHash[e.value])
            {
                e.cellHtml = partTypeHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
		 case "storeId" :
		     if(storeHash[e.value])
	            {
	                e.cellHtml = storeHash[e.value].name||"";
	            }
	            else{
	                e.cellHtml = "";
	            }
			 break;
		 case "returnSign":
			 e.cellHtml =  e.value==0 ? "否":"是";
		 case "orgid":
	        	for(var i=0;i<currOrgList.length;i++){
	        		if(currOrgList[i].orgid==e.value){
	        			e.cellHtml = currOrgList[i].shortName;
	        		}
	        	}
		default:
			break;
		}
	});
	
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		if ((keyCode == 13)) { // F9
			onSearch();
		}

	};
	var filter = new HeaderFilter(rightGrid, {
        columns: [
            { name: 'partCode' },
            { name: 'pickMan' },
            {name:'partName'},
            {name:'serviceCode'},
            {name:'carNo'}
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
	    		default:
	                break;
	    	}
        	return value;
        }
    });
	
	
	
    //quickSearch(4);
	onSearch();
	getAllPartType(function(data){
		partTypeList=data.partTypes;
		nui.get('partTypeId').setData(partTypeList);
		partTypeList.forEach(function(v){
			partTypeHash[v.id]=v;
		});
	});
});
function getSearchParams(){
    var params = {};
    params.partCode=nui.get("partCode").getValue();
    params.partName=nui.get("partName").getValue();
    params.partBrandId=nui.get("partBrandId").getValue();
    params.partTypeId=nui.get("partTypeId").value;
    params.storeId=nui.get("storeId").getValue();
   // params.sPickDate=nui.get("sPickDate").getFormValue();
    params.carNo = nui.get("carNo").getValue();
   /* if(eOutDateEl.getValue()){ 	
    	params.ePickDate=addDate(eOutDateEl.getValue(),1);
    }*/
   // params.sOutDate=nui.get("sOutDate").getFormValue();
    /*if(eOutDateEl.getValue()){
    	params.eOutDate=addDate(eOutDateEl.getValue(),1);	
    }*/
    return params;
}
//var currType = 2;
/*function quickSearch(type){
	var params = getSearchParams();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sPickDate = getNowStartDate();
            params.ePickDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sPickDate = getPrevStartDate();
            params.ePickDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sPickDate = getWeekStartDate();
            params.ePickDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sPickDate = getLastWeekStartDate();
            params.ePickDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sPickDate = getMonthStartDate();
            params.ePickDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sPickDate = getLastMonthStartDate();
            params.ePickDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.sPickDate = getYearStartDate();
            params.ePickDate = getYearEndDate();
            queryname="本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sPickDate = getPrevYearStartDate();
            params.ePickDate = getPrevYearEndDate();
            queryname="上年";
            break;
        default:
            break;
    }
    currType = type;
    sPickDateEl.setValue(params.sPickDate);
    ePickDateEl.setValue(addDate(params.ePickDate,-1));
   // var menunamedate = nui.get("menunamedate");
   // menunamedate.setText(queryname);
    doSearch(params);
}*/

function onSearch(){
	var params=getSearchParams();
	doSearch(params);
}
function doSearch(params)
{
	if(!setReturnSign.checked){	
		params.returnSign = 0;
	}
	 var orgidsElValue = orgidsEl.getValue();
	    if(orgidsElValue==null||orgidsElValue==""){
	    	 params.orgids =  currOrgs;
	    }else{
	    	params.orgid=orgidsElValue;
	    }
  //params.returnSign = 0; //出库
	params.isSettle=0; //已结算
//	params.status=2; //状态已完工
    rightGrid.load({
        params:params,
        token :token     
    });
}

function editSell(){
    var row = rightGrid.getSelected();
    if(!row) return;
    var billTypeId = row.billTypeId;
    var part={};
    if(billTypeId==0){
	    part.id = "2000";
	    part.text = "综合开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.repairBill.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==1){
	    part.id = "checkPrecheckDetail";
	    part.text = "查车开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.checkDetail.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==2){
	    part.id = "3000";
	    part.text = "洗美开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.carWashBill.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==3){
	    part.id = "5000";
	    part.text = "销售开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.sellBill.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==4){
	    part.id = "4000";
	    part.text = "理赔开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.claimDetail.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    if(billTypeId==5){
	    part.id = "5200";
	    part.text = "退货开单详情";
	    part.url = webPath + contextPath + "/com.hsweb.RepairBusiness.returnBill.flow?token="+token;
	    part.iconCls = "fa fa-file-text";
    }
    //window.parent.activeTab(item);
    var params = {
        id: row.id
    };
    window.parent.activeTabAndInit(part,params);
}

function onExport(){
	var detail = rightGrid.getData();
//多级
	exportMultistage(rightGrid.columns)
//单级
       //exportNoMultistage(mainGrid.columns)
	for(var i=0;i<detail.length;i++){
		for(var j in storeHash) {
		    if(detail[i].storeId ==storeHash[j].id ){
		    	detail[i].storeId=storeHash[j].name;
		    }
		}
		if(detail[i].returnSign==0){
			detail[i].returnSign="否";
		}else{
			detail[i].returnSign="是";
		}
		for(var j in partTypeHash) {
			if(detail[i].carTypeIdF==partTypeHash[j].id){
				detail[i].carTypeIdF=partTypeHash[j].name;
			}
			if(detail[i].carTypeIdS==partTypeHash[j].id){
				detail[i].carTypeIdS=partTypeHash[j].name;
			}
			if(detail[i].carTypeIdT==partTypeHash[j].id){
				detail[i].carTypeIdT=partTypeHash[j].name;
			}
		}
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,rightGrid.columns,"未结算配件明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,mainGrid.columns,"已结算工单明细表导出");
	}
	
}