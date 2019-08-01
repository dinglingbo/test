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
var sOutDateEl=null;
var eOutDateEl =null;
var sPickDateEl =null;
var ePickDateEl=null;
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
    sOutDateEl =nui.get('sOutDate');
    eOutDateEl = nui.get('eOutDate');
    
    sPickDateEl =nui.get('sPickDate');
    ePickDateEl = nui.get('ePickDate');
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
});
function getSearchParams(){
    var params = {};
    params.partCode=nui.get("partCode").getValue();
    params.partName=nui.get("partName").getValue();
    params.pjBillTypeId="050206";
    params.partBrandId=nui.get("partBrandId").getValue();
    params.partTypeId=nui.get("partTypeId").value;
    params.storeId=nui.get("storeId").getValue();
    params.sPickDate=nui.get("sPickDate").getFormValue();
    params.carNo = nui.get("carNo").getValue();
    params.serviceTypeId=nui.get("serviceTypeId").value;
    params.billTypeId =nui.get("billTypeId").value;
    if(ePickDateEl.getValue()){ 	
    	params.ePickDate=addDate(ePickDateEl.getValue(),1);
    }
    params.sOutDate=nui.get("sOutDate").getFormValue();
    if(eOutDateEl.getValue()){
    	params.eOutDate=addDate(eOutDateEl.getValue(),1);	
    }
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
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
    	params.pickMans = pickMans; 
    }

   
    return params;
}
var currType = 2;
function quickSearch(type){
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
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}

function onSearch(){
	var params=getSearchParams();
	doSearch(params);
}
function doSearch(params)
{
//	params.orgid = currOrgId;
  //params.returnSign = 0; //出库
//	params.isSettle=1; //已结算
//	params.status=2; //状态已完工
	params.storeId = nui.get("storeId").value;
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
	var params=getSearchParams();
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
	

	var detail = rightGrid.getData();
	
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
			if(detail[i].carTypeIdF==partTypeHash[j].code){
				detail[i].carTypeIdF=partTypeHash[j].name;
			}
			if(detail[i].carTypeIdS==partTypeHash[j].code){
				detail[i].carTypeIdS=partTypeHash[j].name;
			}
			if(detail[i].carTypeIdT==partTypeHash[j].code){
				detail[i].carTypeIdT=partTypeHash[j].name;
			}
		}
	}
	if(detail && detail.length > 0){
		setInitExportData( detail);
	}
	
}

function setInitExportData( detail){

    var tds = '<td  colspan="1" align="left">[serviceCode]</td>' +
        "<td  colspan='1' align='left'>[carNo]</td>" +
        "<td  colspan='1' align='left'>[serviceTypeId]</td>" +
        "<td  colspan='1' align='left'>[storeId]</td>" +
        "<td  colspan='1' align='left'>[partCode]</td>" +
        "<td  colspan='1' align='left'>[partName]</td>" +
        "<td  colspan='1' align='left'>[oemCode]</td>" +       
        "<td  colspan='1' align='left'>[outQty]</td>" +
        
        "<td  colspan='1' align='left'>[trueUnitPrice]</td>" +
        "<td  colspan='1' align='left'>[trueCost]</td>" +
        "<td  colspan='1' align='left'>[sellUnitPrice]</td>" +
        
        "<td  colspan='1' align='left'>[sellAmt]</td>" +
        "<td  colspan='1' align='left'>[gross]</td>" +
        "<td  colspan='1' align='left'>[grossRate]</td>"+
        "<td  colspan='1' align='left'>[costRate]</td>"+
        "<td  colspan='1' align='left'>[pickMan]</td>"+
        "<td  colspan='1' align='left'>[pickDate]</td>"+      
        "<td  colspan='1' align='left'>[recorder]</td>" +
        "<td  colspan='1' align='left'>[recordDate]</td>" +
        "<td  colspan='1' align='left'>[returnSign]</td>" +
        "<td  colspan='1' align='left'>[returnDate]</td>" +                     
        "<td  colspan='1' align='left'>[partBrandId]</td>" +
        
        "<td  colspan='1' align='left'>[applyCarModel]</td>" +
        "<td  colspan='1' align='left'>[unit]</td>"+
        "<td  colspan='1' align='left'>[carTypeIdF]</td>"+
        "<td  colspan='1' align='left'>[carTypeIdS]</td>"+
        "<td  colspan='1' align='left'>[carTypeIdT]</td>"+
        "<td  colspan='1' align='left'>[spec]</td>";
        
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.id){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[serviceCode]", detail[i].serviceCode?detail[i].serviceCode:"")
                         .replace("[carNo]", detail[i].carNo?detail[i].carNo:"")
                         .replace("[serviceTypeId]", detail[i].serviceTypeId?detail[i].serviceTypeId:"")
                         .replace("[storeId]", detail[i].storeId?detail[i].storeId:"")                        
                         .replace("[partCode]", detail[i].partCode?detail[i].partCode:"")
                         .replace("[partName]", detail[i].partName?detail[i].partName:"")
                         .replace("[oemCode]", detail[i].oemCode?detail[i].oemCode:"")
                         //.replace("[collectMoneyDate]", nui.formatDate(detail[i].collectMoneyDate?detail[i].collectMoneyDate:"",'yyyy-MM-dd HH:mm'))
                         
                         .replace("[outQty]", detail[i].outQty?detail[i].outQty:"")                       
                         .replace("[trueUnitPrice]", detail[i].trueUnitPrice?detail[i].trueUnitPrice:"")
                         .replace("[trueCost]", detail[i].trueCost?detail[i].trueCost:"") 
                         
                         .replace("[sellUnitPrice]", detail[i].sellUnitPrice?detail[i].sellUnitPrice:"")                        
                         .replace("[sellAmt]", detail[i].sellAmt?detail[i].sellAmt:"")
                         .replace("[gross]", detail[i].gross?detail[i].gross:"")
                         
                         .replace("[grossRate]", detail[i].grossRate?detail[i].grossRate:"")
                         .replace("[costRate]", detail[i].costRate?detail[i].costRate:"")
                         .replace("[pickMan]", detail[i].pickMan?detail[i].pickMan:"")
                         .replace("[pickDate]", nui.formatDate(detail[i].pickDate?detail[i].pickDate:"",'yyyy-MM-dd HH:mm'))
                         
                         .replace("[recorder]", detail[i].recorder?detail[i].recorder:"")  
                         .replace("[recordDate]", nui.formatDate(detail[i].recordDate?detail[i].recordDate:"",'yyyy-MM-dd HH:mm'))                         
                         .replace("[returnSign]", detail[i].returnSign?detail[i].returnSign:"")
                         .replace("[returnDate]", nui.formatDate(detail[i].returnDate?detail[i].returnDate:"",'yyyy-MM-dd HH:mm'))                          
                         .replace("[partBrandId]", detail[i].partBrandId?detail[i].partBrandId:"")
                         .replace("[applyCarModel]", detail[i].applyCarModel?detail[i].applyCarModel:"")    
                         .replace("[unit]", detail[i].unit?detail[i].unit:"")                     
                         .replace("[carTypeIdF]", detail[i].carTypeIdF?detail[i].carTypeIdF:"")
                         .replace("[carTypeIdS]", detail[i].carTypeIdS?detail[i].carTypeIdS:"")
                         .replace("[carTypeIdT]", detail[i].carTypeIdT?detail[i].carTypeIdT:"")
                         .replace("[spec]", detail[i].spec?detail[i].spec:""));
            tableExportContent.append(tr);
        }
    }

 
    method5('tableExcel',"维修出库明细表导出",'tableExportA');
}