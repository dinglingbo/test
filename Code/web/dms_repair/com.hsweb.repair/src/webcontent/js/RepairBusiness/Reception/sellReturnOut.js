var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";
var beginDateEl = null;
var StatusHash = {
		"0" : "待归库",
		"1" : "已归库",
	};
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"VIN码"},{id:"2",name:"客户名称"},{id:"3",name:"手机号"}];
var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var advancedMore = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var editFormDetail = null;
var innerPartGrid = null;
var settleWin = null;

$(document).ready(function ()
{
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
//    var date = new Date();
//    var sdate = new Date();
//    sdate.setMonth(date.getMonth()-3);
//    endDateEl.setValue(date);
//    beginDateEl.setValue(sdate);
    editFormDetail = document.getElementById("editFormDetail");
    innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getRpsPartUrl);
    
	settleAccountGrid = nui.get("settleAccountGrid");
	settleWin = nui.get("settleWin");
    mainGrid.on("drawcell", function (e) {
	    var out = '<a  href="javascript:repairOut()">&nbsp;&nbsp;&nbsp;&nbsp;归库</a>';//class="icon-collapse"
	    if(e.field == "serviceCode"){
	    	 e.cellHtml = '<a id="service" href="javascript:repairOut()">'+e.value+'</a>';
	    }
	    if(e.field == "action"){
	        e.cellHtml = out +"&nbsp;&nbsp;&nbsp;";
	    }
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }
        if(e.field == "isSettle"){
            if(e.value == 1){
                e.cellHtml = "已结算";
            }else{
                e.cellHtml = "未结算";
            }
        }
             
    });
    
    var filter = new HeaderFilter(mainGrid, {
        columns: [
            { name: 'guestFullName' },
            { name: 'carModel' },
            { name: 'recorder' },
            { name: 'isSettle' }
        ], 
        callback: function (column, filtered) {
        },

        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
	    		case "isSettle":
	    			value = [{name:"未结算",id:"0"},{name:"已结算",id:"1"}];
	    			break;
	    	}
        	return value;
        }
    });
    
    mainGrid.on("celldblclick",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;  
        var sid = record.id;
        repairOut(); 
    });
    
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		
		if ((keyCode == 13)) { // Enter
			onSearch();
		}

	}
	
    innerPartGrid.on("drawcell", function (e) {
        var record = e.record;
        switch (e.field) {
            case "partName":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId>0){
                    e.cellHtml = e.value + "<font color='red'>(预存)</font>";
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value){
                    e.cellHtml = e.value + '%';
                }
                break;
            default:
                break;
        }
    });  
//    var statusList = "1,2";
//    var p = {statusList:statusList};
//    doSearch(p);
    quickSearch(12);
});
var statusHash = {
    "0" : "草稿",
    "1" : "待归库",
    "2" : "已归库",
    "3" : "待结算",
    "4" : "已结算",
    "5" : "所有"
    
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

    innerPartGrid.setData([]);
    
    var serviceId = row.id;
    innerPartGrid.load({
    	serviceId:serviceId,
        token: token
    });
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本月";
    var querystatusname = "待归库";
    params.sRecordDate = getMonthStartDate();
    params.eRecordDate = addDate(getMonthEndDate(), 1);
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sRecordDate = getNowStartDate();
            params.eRecordDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sRecordDate = getPrevStartDate();
            params.eRecordDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sRecordDate = getWeekStartDate();
            params.eRecordDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sRecordDate = getLastWeekStartDate();
            params.eRecordDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sRecordDate = getMonthStartDate();
            params.eRecordDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sRecordDate = getLastMonthStartDate();
            params.eRecordDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sRecordDate = getYearStartDate();
            params.eRecordDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sRecordDate = getPrevYearStartDate();
            params.eRecordDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
        //待归库
        case 12:
        	params.status=1;
        	querysign = 2;
        	querystatusname = "待归库";
        	break;
        //已归库
        case 13:
        	params.status=2;
        	querysign = 2;
        	querystatusname = "已归库";
        	break;
       //所有
        case 14:
        	params.status=null;
        	params.statusList = "1,2";
        	querysign = 2;
        	querystatusname = "所有";
        	break;
        default:
            break;
    }
    beginDateEl.setValue(params.sRecordDate);
    
    endDateEl.setValue(addDate(params.eRecordDate,-1));
    nui.get('status').setValue(params.status);
    currType = type;
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    else if(querysign == 2){
    	var menubillstatus = nui.get("menubillstatus");
		menubillstatus.setText(querystatusname);
    }
    doSearch(params);
}
function onSearch()
{
    var params = {};
//    var statusList = "1,2";
//    var p = {statusList:statusList};
//    params = p;
   // var value = nui.get("carNo-search").getValue()||"";
    //value = value.replace(/\s+/g, "");
   /* if(!value){
        showMsg("请输入查询条件!","W");
        return;
    }*/
    doSearch(params);
}
function doSearch(params) {
    var params = getSearchParam();
//    gsparams.status = params.status;
//    gsparams.statusList = params.statusList;
//    gsparams.isSettle = params.isSettle;
    //表示退货单
    params.billTypeId = 5;
    mainGrid.load({
        token:token,
        params: params
    });
}
function getSearchParam() {
    var params = {};
    params.sRecordDate = beginDateEl.getFormValue();
    params.eRecordDate = addDate(endDateEl.getValue(),1);
    params.status=nui.get('status').getValue();
    if(params.status===""){
    	params.statusList = "1,2";
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


function repairOut() {
    var row = mainGrid.getSelected();
    var mainIdStr="";
    var mainIdList=[];
    
    innerPartGrid.load({
    	serviceId:row.id,
        token: token
    },function(){
    	if(innerPartGrid.data.length>0){
    		var data=innerPartGrid.getData();
    		for(var i=0;i<data.length;i++){
    			mainIdStr +=data[i].detailId+",";
    			mainIdList.push({mainId : data[i].detailId});
//    			mainIdList[i].mainId=data[i].detailId;
    		}
    		mainIdStr=mainIdStr.substring(0, mainIdStr.length-1);
    		row.mainIdStr=mainIdStr;
    		row.mainIdList=mainIdList;
    	}
    });

//    var partDetail=repairOutGrid.get
    if(row){ 
        var item={};
        item.id = "7000";
        item.text = "退货归库详情";
        item.url = webPath + contextPath + "/repair/RepairBusiness/Reception/returnOutDetail.jsp";
        item.iconCls = "fa fa-cog";
        //window.parent.activeTab(item);
        var params = {
            id:row.id,
            row: row
        };
        window.parent.activeTabAndInit(item,params);
    }else{
        nui.alert("请先选择一条记录！");
    }
} 

//function addSell(){
//    var part={};
//    part.id = "5200";
//    part.text = "退货-工单";
//    part.url = webPath + contextPath + "/repair/RepairBusiness/Reception/returnBill.jsp?token="+token;
//    part.iconCls = "fa fa-file-text";
//    var params = {};
//    window.parent.activeTabAndInit(part,params);
//
//}
//function editSell(){
//    var row = mainGrid.getSelected();
//    if(!row) return;
//    var part={};
//    part.id = "5200";
//    part.text = "退货-工单";
//    part.url = webPath + contextPath + "/repair/RepairBusiness/Reception/returnBill.jsp?token="+token;
//    part.iconCls = "fa fa-file-text";
//    //window.parent.activeTab(item);
//    var params = {
//        id: row.id
//    };
//    window.parent.activeTabAndInit(part,params);
//}


//根据开单界面传递的车牌号查询未结算的工单
//function setInitData(params){
//    var carNo = params.carNo||"";
//    var type = params.type||""
//    if(type=='view' && carNo != ""){
//        var p = {
//            carNoEqual: carNo,
//            isSettle: 0
//        };
//        mainGrid.load({
//            token:token,
//            params: p
//        });
//    }
//}
//转出库
//var updOutUrl = baseUrl + "com.hsapi.repair.repairService.crud.UpdateMainStatusOut.biz.ext";
//function out(){	
//	var row = mainGrid.getSelected();
//	if(row)
//	{
//		if(row.isSettle == 1){
//	        showMsg("此单已结算!","W");
//	        return;
//	    }
//		if(row.status==0){
//			showMsg("此单需审核才能出库!","W");
//	        return;
//		}
//		if(row.status==2){
//			showMsg("此单已出库!","W");
//	        return;
//		}
//		var json = nui.encode({
//			"main" : row,
//			token : token
//		});
//		
//		nui.ajax({
//			url : updOutUrl,
//			type : 'POST',
//			data : json,
//			cache : false,
//			contentType : 'text/json',
//			success : function(text) {
//				var returnJson = nui.decode(text);
//				if (returnJson.errCode == "S") {
//					b = 1;
//					showMsg("出库成功");
//					//表示退货单
//				    gsparams.billTypeId = 5;
//				    mainGrid.load({
//				        token:token,
//				        params: gsparams
//				    });
//				} else {
//					showMsg("出库失败","W");
//				}
//					
//			}
//		});
//		
//	}
//	else{
//		showMsg("请选择工单", "W");
//	}
//}
////转结算
//payUrl = webPath + contextPath + "/repair/RepairBusiness/Reception/partBillPay.jsp?token="+token;
//function pay(){	
//	var row = mainGrid.getSelected();
//	if(row)
//	{
//		if(row.isSettle == 1){
//	        showMsg("此单已结算!","W");
//	        return;
//	    }
//		if(row.status != 2){
//			 showMsg("此单未归库，不能结算!","W");
//		     return;
//		}
//		nui.open({
//			url:payUrl,
//			width:"40%",
//			height:"50%",
//			//加载完之后
//			onload: function(){	
//			//把值传递到支付页面
//		    var iframe = this.getIFrameEl();
//		    iframe.contentWindow.getData(row);			
//			},
//		   ondestroy : function(action) {
//			if (action == 'ok') {
//				var iframe = this.getIFrameEl();
//				var data = iframe.contentWindow.getData();
//				supplier = data.supplier;
//				var value = supplier.id;
//				var text = supplier.fullName;
//				var el = nui.get(elId);
//				el.setValue(value);
//				el.setText(text);
//			}
//		}
//		});		
//	}
//	else{
//		showMsg("请选择单据", "W");
//	}
//}
//
//
//
//var updUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.updateReturnMainAndPart.biz.ext";
//function finish(){
//
//	var main = mainGrid.getSelected();
//	var isSettle = main.isSettle||0;
//    
//    if(isSettle == 1){
//        showMsg("此单已结算,不能审核!","W");
//        return;
//    }
//	if(main.status==1){
//		showMsg("此单已审核,不能重复审核!","W");
//        return;
//	} 
//	
//	var json = nui.encode({
//		"main" : main,
//		token : token
//	});
//	
//	nui.ajax({
//		url : updUrl,
//		type : 'POST',
//		data : json,
//		cache : false,
//		contentType : 'text/json',
//		success : function(text) {
//			var returnJson = nui.decode(text);
//			if (returnJson.errCode == "S") {
//				showMsg("审核成功");
//				var gsparams = {};
//				gsparams.billTypeId = 5;
//			    mainGrid.load({
//			        token:token,
//			        params: gsparams
//			    });
//				
//			} else {
//				showMsg(returnJson.errMsg,"W");
//			}
//				
//		}
//	});
//}


