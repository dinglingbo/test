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
var storehouse = null;
var storeHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var outTypeIdHash = {};
var sDateEl=null;
var eDateEl =null;
var servieTypeList = [];
var servieTypeHash = {};
var orgidsEl = null;
var workTeamIdEl = null;
var workTeamIdList = [];
var billTypeIdEl=null;
var billTypeIdList=[{id:"0",name:"综合"},{id:"1",name:"检查"},{id:"2",name:"洗美"},{id:"3",name:"销售"},{id:"4",name:"理赔"},{id:"5",name:"退货"},{id:"6",name:"波箱"}];
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    sDateEl =nui.get('sDate');
    eDateEl = nui.get('eDate');
    setReturnSign = mini.get("ReturnSign");
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

    workTeamIdEl=nui.get('workTeamId');
    billTypeIdEl=nui.get('billTypeId');
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    advancedSearchForm.clear();
    advancedSearchForm.gusetId=null;
    billTypeIdEl.setData(billTypeIdList);
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
		if(currRepairStoreControlFlag == "1") {
        	if(storehouse && storehouse.length>0) {
        		nui.get("storeId").setValue(storehouse[0].id);
        	}
        }else {
        	nui.get("storeId").setAllowInput(true);
        }
		
		quickSearch(4);
	});
	
	initServiceType("serviceTypeId",function(data) {
	        servieTypeList = nui.get("serviceTypeId").getData();
	        servieTypeList.forEach(function(v) {
	            servieTypeHash[v.id] = v;
	        });
	});
	rightGrid.on("drawSummaryCell", function (e) {
    	var result = e.result.list;
        var grossSum = 0;
        var sellAmtSum = 0; 
        var trueCostSum = 0;
        for(var i = 0;i<result.length;i++){
        	grossSum = grossSum+result[i].gross||0;
        	sellAmtSum = sellAmtSum +result[i].sellAmt||0;
        	trueCostSum = trueCostSum +result[i].trueCost||0;
        }
        if (e.field == "grossRate") {
        	if(sellAmtSum!=0){
                var grossRateSum = parseFloat(grossSum)/parseFloat(sellAmtSum);
                grossRateSum = ((grossRateSum*100).toFixed(2))+"%";
                e.cellHtml = grossRateSum;
        	}else{
        		e.cellHtml = "0%";
        	}
        }
        if (e.field == "costRate") {
        	if(sellAmtSum!=0){
                var costRateSum = parseFloat(trueCostSum)/parseFloat(sellAmtSum);
                costRateSum = ((costRateSum*100).toFixed(2))+"%";
                e.cellHtml = costRateSum;
        	}else{
        		e.cellHtml = "0%";
        	}

        }

    });
	rightGrid.on("drawcell",function(e){
		var record = e.record;
		switch (e.field) {
/*		case "serviceCode":
			e.cellHtml ='<a href="##" onclick="editSell()">'+e.value+'</a>';
			break;*/
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
			 break;
		 case "serviceTypeId":
			 if(servieTypeHash[record.serviceTypeId]){		 
				 e.cellHtml = servieTypeHash[record.serviceTypeId].name ||"";
			 }else{
				 e.cellHtml = '';
			 }
			 break
		 case  "orgid":
	        	for(var i=0;i<currOrgList.length;i++){
	        		if(currOrgList[i].orgid==e.value){
	        			e.cellHtml = currOrgList[i].shortName || "";
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
            {name:'carNo'},
            {name: 'recorder'}
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

	getAllPartType(function(data){
		partTypeList=data.partTypes;
		nui.get('partTypeId').setData(partTypeList);
		partTypeList.forEach(function(v){
			partTypeHash[v.id]=v;
		});
	});
	
	getWorkTeam(function(data){
		workTeamIdList = data.list||[];
		workTeamIdEl.setData(workTeamIdList);
	});
	//仓库控制权限
    if(currRepairStoreControlFlag==1){  	
    	nui.get("storeId").setShowNullItem(false);
    }
});
function getSearchParams(params){
	if(params == null) {
		params = {};
	}
    if((nui.get("sdDate").getValue())==0){
    	params.sPickDate=nui.get("sDate").getFormValue();	
        params.ePickDate=addDate(eDateEl.getValue(),1);
    }else{
    	params.sOutDate=nui.get("sDate").getFormValue();
    	params.eOutDate=addDate(eDateEl.getValue(),1);	
    }
    params.partCode=nui.get("partCode").getValue();
    params.partName=nui.get("partName").getValue();
    params.pjBillTypeId="050206";

    //params.partTypeId=nui.get("partTypeId").value;
    params.storeId=nui.get("storeId").getValue();
    params.carNo = nui.get("carNo").getValue();
    //params.serviceTypeId=nui.get("serviceTypeId").value;
    //params.billTypeId =nui.get("billTypeId").value;
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }


   
    return params;
}
var currType = 2;
function quickSearch(type){
	var params = getSearchParams(null);
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
    sDateEl.setValue(params.sPickDate);
    eDateEl.setValue(addDate(params.ePickDate,-1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}

function onSearch(){
	var params=getSearchParams(null);
	doSearch(params);
}
function doSearch(params)
{
//	params.orgid = currOrgId;
  //params.returnSign = 0; //出库
//	params.isSettle=1; //已结算
//	params.status=2; //状态已完工
	params.storeId = nui.get("storeId").value;
	if(mini.get("delSign").checked) {
		params.delSign = 1;
	}
	if(!setReturnSign.checked){	
		params.returnSign = 0;
	}
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

function changed(){
	var params=getSearchParams(null);
	params.orgid = currOrgId;
	if(!setReturnSign.checked){	
		params.returnSign = 0;
	}
	rightGrid.load({
        params:params,
        token :token     
    });
	
}

function onExport(){
	var detail = nui.clone(rightGrid.getData());
	exportMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
		for(var j in servieTypeHash) {
		    if(detail[i].serviceTypeId ==servieTypeHash[j].id ){
		    	detail[i].serviceTypeId=servieTypeHash[j].name;
		    }
		}
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
		setInitExportData( detail,rightGrid.columns,"配件出库明细表");
	}
	
}

function advancedSearch()
{
	
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData(true);
    searchData = getSearchParams(searchData);
    searchData.pjBillTypeId="050206";
    advancedSearchFormData = {};
    var workTeamId = workTeamIdEl.getValue();
    if(workTeamId) {
    	var pickMans = "''";
    	var pd = {
    		memberGroupId: workTeamId,
    		token: token
    	};
    	nui.ajax({
    		url : apiPath + sysApi + "/com.hsapi.system.dict.org.queryMember.biz.ext",
    		type : "post",
    		async: false,
    		data : JSON.stringify(pd),
    		success : function(data) {
    			var memList = data.data||[];
    			if(memList && memList.length>0) {
    				
    				for(var i=0; i<memList.length; i++) {
    					if(i==0) {
    						pickMans = "'" + memList[i].empName + "'";
    					}else {
    						pickMans = pickMans + ",'" + memList[i].empName + "'";
    					}
    				}
    				
    			}
    		},
    		error : function(jqXHR, textStatus, errorThrown) {
    			console.log(jqXHR.responseText);
    		}
    	});
    	searchData.pickMans = pickMans; 
    }

    advancedSearchWin.hide();
    doSearch(searchData);
    advancedSearchForm.gusetId=null;
  
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function cancelData(){
	advancedSearchForm.setData([]);
}