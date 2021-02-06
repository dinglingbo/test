var baseUrl = apiPath + repairApi + "/";
var webBaseUrl = webPath + contextPath + "/"; 
var queryForm;
var upGrid;
var downGrid;
var menuBtnStatusQuickSearch;
var menuBtnDateQuickSearch;
var serviceTypeHash = [];
var carBrandHash = [];
var carSeriesHash = [];
var mtAdvisorHash = [];
var scoutModeHash = [];
var scoutResutHash = [];
var beginDateEl = null;
var endDateEl = null;
var prebookCategoryHash = [{ name: '客户主动预约', id: '0' }, { name: '客户被动预约', id: '1' }];
var prebookSourceHash = [{ name: '线下预约', id: '0' }, { name: '网络预约', id: '1' }];
var prebookStatusHash = [{ name: '待确认', id: '0' }, { name: '已确认', id: '1' }, {name: '已取消' , id: '2' }, { name: '已开单', id: '3' }, { name: '已评价', id: '4' }];

var upGridUrl = baseUrl + "com.hsapi.repair.repairService.booking.queryPrebookList.biz.ext";
var downGridUrl = baseUrl + "com.hsapi.repair.repairService.booking.queryBookingTrace.biz.ext";

$(document).ready(function (v) {
	
	beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
	//日期
    menuBtnDateQuickSearch = nui.get("menuBtnDateQuickSearch");
    //状态对象
    menuBtnStatusQuickSearch = nui.get("menuBtnStatusQuickSearch");

    //数据列表
    upGrid = nui.get("upGrid");
    upGrid.setUrl("upGridUrl");
    upGrid.on("drawcell", onDrawCell);

    //跟进人信息
    downGrid = nui.get("downGrid");
    downGrid.setUrl("downGridUrl");
    downGrid.on("drawcell", onDrawCell);

    init();
    quickSearch(menuBtnDateQuickSearch, 0, '本日');

    //行选择改变时发生
    upGrid.on("selectionchanged", function () {
        onupGridSelectionchanged();
    });
    
    
    
    
    var filter = new HeaderFilter(upGrid, {
        columns: [
            { name: 'status' },
            { name: 'prebookSource' },
            { name: 'serviceTypeId' },
            { name: 'prebookCategory' },
            { name: 'mtAdvisor' },
            { name: 'mtAdvisorId' },
            { name: 'isOpenBill' }
        ],
        callback: function (column, filtered) {
        },

        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
	    		case "status" ://状态 
	    			value = prebookStatusHash;// [{ name: '待确认', id: '0' }, { name: '已确认', id: '1' }, {name: '已取消' , id: '2' }, { name: '已开单', id: '3' }, { name: '已评价', id: '4' }];
	    			break;
	    		case "prebookSource"://预约来源
	    			value = prebookSourceHash;
	    			break;
	    		case "serviceTypeId" : //业务类型
	    			value = serviceTypeHash;
	    			break;
	    		case "prebookCategory" : // 预约类型
	    			value = prebookCategoryHash;
	    			break;
	    		case "isOpenBill": case "isJudge": // 是否开单是否评价
	    			value = [{name:"否",id:"0"},{name:"是",id:"1"}];
	    			break;
	    	}
        	return value;
        }
    });
});

function init() {
//    initCarBrand("carBrandList", function () {
//        var data = nui.get("carBrandList").getData();
//        data.forEach(function (v) {
//            carBrandHash[v.id] = v;
//        });
//    });
//
//    
//    initCarSeries("carSeriesList", "", function () {
//        var data = nui.get("carSeriesList").getData();
//        data.forEach(function (v) {
//            carSeriesHash[v.id] = v;
//        });
//    });

    initMember("mtAdvisorList", function () {
        var data = nui.get("mtAdvisorList").getData();
        data.forEach(function (v) {
            mtAdvisorHash[v.id] = v;
        });
    });

    initServiceType("bisinessList", function () {
        var data = nui.get("bisinessList").getData();
        data.forEach(function (v) {
            serviceTypeHash[v.id] = v;
        });
    });

    initDicts({
        scoutModeList: SCOUT_MODE, //跟进方式
        scoutReustList: IS_USABLED //跟踪状态
    }, function () {
        var data = nui.get("scoutModeList").getData();
        data.forEach(function (v) {
            scoutModeHash[v.customid] = v;
        });
        var data = nui.get("scoutReustList").getData();
        data.forEach(function (v) {
            scoutResutHash[v.customid] = v;
        });
    });
}

var currType = 0;


function quickSearch(ctlid, value, text) {
    ctlid.setValue(value);
    ctlid.setText(text);
    currType = value;
    var startDate = null;
    var endDate = null;
    var d = menuBtnDateQuickSearch.getValue();
    if (d == 0) {
        params.today = 1;
        startDate = getNowStartDate();
        endDate = getNowEndDate();
        beginDateEl.setValue(startDate);
        endDateEl.setValue(endDate);
    } else if (d == 1) {
        params.yesterday = 1;
        startDate = getPrevStartDate();
        endDate = getPrevEndDate();
        beginDateEl.setValue(startDate);
        endDateEl.setValue(endDate);
    } else if (d == 2) {
        params.thisWeek = 1;
        startDate = getWeekStartDate();
        endDate = getWeekEndDate();
        beginDateEl.setValue(startDate);
        endDateEl.setValue(endDate);
    } else if (d == 3) {
        params.lastWeek = 1;
        startDate = getLastWeekStartDate();
        endDate = getLastWeekEndDate();
        beginDateEl.setValue(startDate);
        endDateEl.setValue(endDate);
    } else if (d == 4) {
        params.thisMonth = 1;
        startDate = getMonthStartDate();
        endDate = getMonthEndDate();
        beginDateEl.setValue(startDate);
        endDateEl.setValue(endDate);
    } else if (d == 5) {
        params.lastMonth = 1;
        startDate = getLastMonthStartDate();
        endDate = getLastMonthEndDate();
        beginDateEl.setValue(startDate);
        endDateEl.setValue(endDate);
    }
    doSearch();
}

function doSearch() {
    var params = getSearchParam();
    
    upGrid.load({
        params: params,
        token: token
    });
}

/*
 * 快速查找要关联后面的查询条件
 * */
function getSearchParam(){
    var params = {};
    params.mtAdvisorId = nui.get("mtAdvisorList").getValue();
    params.carNo = nui.get("carNo").getValue();
    params.contactorTel = nui.get("contactorTel").getValue();
    var radiobuttonlist = nui.get("radiobuttonlist");
	var value = radiobuttonlist.getValue();
	if(value=="1"){
		params.predictComeDate = 1;
	}else{
		params.recordDate = 1;
	}
    params.startDate = beginDateEl.getFormValue();
    params.endDate = addDate(endDateEl.getValue(), 1); 
    
    var status = menuBtnStatusQuickSearch.getValue();
    if(status == 0 || status == 1 || status == 2){
        params.status = status;
    }else if(status == 3){
        params.isOpenBill = 1;
    }else if(status == 4){
        params.isJudge = 1;
    }
    return params;
}


function onupGridSelectionchanged(e) {
    var row = upGrid.getSelected();
    if (!row) return;

    var status = row.status;

    var btnEdit = nui.get("btnEdit");
    var btnconfirm = nui.get("btnconfirm");
    //开单按钮
    var btnNewBill = nui.get("btnNewBill");
    var btnCancel = nui.get("btnCancel");
    var btnCall = nui.get("btnCall");

    if (status == 0) { //待确认
        btnEdit.enable();
        btnconfirm.enable();
        btnNewBill.disable();
        btnCancel.enable();
        btnCall.enable();
    } else if (status == 1) { //已确认
        btnEdit.disable();
        btnconfirm.disable();
        btnNewBill.enable();
        btnCancel.disable();
        btnCall.enable();
        
    } else if (status >= 2) { //已开单，已取消，已评价
        btnEdit.disable();
        btnconfirm.disable();
        btnNewBill.disable();
        btnCancel.disable();
        btnCall.disable();
    }

    //isOpenBill：是否开单
    if(row.isOpenBill && row.isOpenBill == 1){
        btnNewBill.disable();
    }

    //还有这种写法
    var params = {};
    params.serviceId = row.id;

    /*点击某一行数据，查出相应的跟踪数据
     * 
     * 
     * */
    downGrid.load({
        params: params,
        token: token
    });
}

//只执行一次
function onDrawCell(e) {
    var field = e.field;
    var record = e.record;
    var uid = record._uid;
    if (field == "serviceTypeId" && serviceTypeHash[e.value]) {
        e.cellHtml = serviceTypeHash[e.value].name;
    } else if (field == "carBrandId" && carBrandHash[e.value]) {
        e.cellHtml = carBrandHash[e.value].name;
    } else if (field == "carSeriesId" && carSeriesHash[e.value]) {
        e.cellHtml = carSeriesHash[e.value].name;
    } else if (field == "prebookCategory" && prebookCategoryHash[e.value]) {
        e.cellHtml = prebookCategoryHash[e.value].name;
    } else if (field == "status" && prebookStatusHash[e.value]) {
        e.cellHtml = prebookStatusHash[e.value].name;
    } else if (field == "scoutMode" && scoutModeHash[e.value]) {
        e.cellHtml = scoutModeHash[e.value].name;
    } else if (field == "isUsabled" && scoutResutHash[e.value]) {
        e.cellHtml = scoutResutHash[e.value].name;
    } else if (field == "isOpenBill") {
        e.cellHtml = e.value == 0? '否':'是';
    } else if (field == "isJudge") {
        e.cellHtml = e.value == 0? '否':'是';
    } else if(field == "serviceTypeId" && e.value == 0){
        e.cellHtml = "";
    } else if(field == "prebookSource" ){
    	if(e.value=="042101"){
    		e.cellHtml = prebookSourceHash[0].name;
    	}else if(e.value=="042102"){
    		e.cellHtml = prebookSourceHash[1].name;
    	}
    	
    }else if(field == "Time"){
    	var startTime = new Date(); // 开始时间
        var endTime = record.predictComeDate; // 结束时间
        var usedTime = endTime - startTime; // 相差的毫秒数
        var s = "";

        if(usedTime<0){
        	usedTime = 0 - usedTime;
        	var days = Math.floor(usedTime / (24 * 3600 * 1000)); // 计算出天数
        	if(days>0){
        		s = days + '天';
        	}
            var leavel = usedTime % (24 * 3600 * 1000); // 计算天数后剩余的时间
            var hours = Math.floor(leavel / (3600 * 1000)); // 计算剩余的小时数
            if(hours>0){
            	s = s + hours + '小时';
            }
            var leavel2 = leavel % (3600 * 1000); // 计算剩余小时后剩余的毫秒数
            var minutes = Math.floor(leavel2 / (60 * 1000)); // 计算剩余的分钟数
            if(minutes>0){
            	s = s + minutes + '分';
            }
        	if(record.isOpenBill){
        		s = "已到店";
        	}else{
        		s = "<font color='red'>已超时"+s+"</font>"
        	}
        }else{
        	
        	var days = Math.floor(usedTime / (24 * 3600 * 1000)); // 计算出天数
        	if(days>0){
        		s = days + '天';
        	}
            var leavel = usedTime % (24 * 3600 * 1000); // 计算天数后剩余的时间
            var hours = Math.floor(leavel / (3600 * 1000)); // 计算剩余的小时数
            if(hours>0){
            	s = s + hours + '小时';
            }
            var leavel2 = leavel % (3600 * 1000); // 计算剩余小时后剩余的毫秒数
            var minutes = Math.floor(leavel2 / (60 * 1000)); // 计算剩余的分钟数
            if(minutes>0){
            	s = s + minutes + '分';
            }
        	
        	s = "<font color='green'>"+s+"</font>"
        }
        e.cellHtml = s;
    }else if(field == "contactorTel"){
    	var value = e.value
    	value = "" + value;
    	var reg=/(\d{3})\d{4}(\d{4})/;
        value = value.replace(reg, "$1****$2");
    	if(e.value){
    		if(record.wechatOpenId){
                 e.cellHtml =  '<a href="javascript:bindWechat(\'' + uid + '\')" id="showA" ><span id="wechatTag" class="fa fa-wechat fa-lg"></span></a>&nbsp;'+value;
                 /*e.cellHtml = "<span id='wechatTag' class='fa fa-wechat fa-lg'></span>"+value;*/
        	}else{
        		e.cellHtml =  '<a href="javascript:bindWechat(\'' + uid + '\')" id="showA1" ><span id="wechatTag1" class="fa fa-wechat fa-lg"></span></a>&nbsp;'+value;
        	}
    	}else{
    		e.cellHtml="";
    	}
    	
    }
}

function addRow() {
    nui.open({
        url: webPath + contextPath + "/com.hsweb.RepairBusiness.BookingManagementEdit.flow?token="+token,
        title: "新增预约", width: 750, height: 386,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {};
            data.mtAdvisorId = currEmpId;
            data.mtAdvisor = currUserName;
            var param = { action: "add", data: data };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
            upGrid.reload();
        }
    });
}

function editRow() {
    var row = upGrid.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + contextPath + "/repair/RepairBusiness/BookingManagement/BookingManagementEdit.jsp?token="+token,
        title: "修改", width: 680, height: 386,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { action: "edit", data: row };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
        	//重新加载
            upGrid.reload();
        }
    });
}

//点击确认按钮进来这个函数
function confirmRow() {
    updateRpspreBookStatus('confirm');
}

//取消
function cancelBill() {
    updateRpspreBookStatus('cancel');
}

//已开单
var BookinUrl = baseUrl + "com.hsapi.repair.repairService.booking.saveBookingMaintain.biz.ext";
function newBill() {
	//把表单中的内容修改
    //updateRpspreBookStatus('newBill');
	var row = upGrid.getSelected();
    if (!row || row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    if(row.guestId>0){
      var title = "开单类型";
	   nui.open({
		    url: webPath + contextPath + "/com.hsweb.RepairBusiness.selectBillTypeId.flow?token="+token,
            title: title, width: 300, height: 160,
            onload: function () {
              
           },
           ondestroy: function (action){
        	   if(action == "ok"){
        		var iframe = this.getIFrameEl();
        	   var billTypeId = iframe.contentWindow.getBilltype();
        	   saveNewBill(row,billTypeId);
        	   }
               
           }
       });
    }else{
       var guest = {
       		"carNo":row.carNo,
       		"guestFullName":row.contactorName,
       		"shortName":row.contactorName,
       		"mobile":row.contactorTel
       };
       var title = "完善客户资料";
       nui.open({
    	   url: webPath + contextPath + "/com.hsweb.repair.DataBase.AddEditCustomer.flow?token="+token,
           title: title, width: 560, height:630,
           onload: function () {
             var iframe = this.getIFrameEl();
             var params = {};
             if(guest)
             {
                 params.guest = guest;
             }
             iframe.contentWindow.setGuest(params,row);
          },
          ondestroy: function (action){
        	  var iframe = this.getIFrameEl();
        	  var preBook = iframe.contentWindow.getPreBook();
        	  var title = "开单类型";
        	  if(action=="ok"){
       		  nui.open({
    			    url: webPath + contextPath + "/repair/js/RepairBusiness/BookingManagement/selectBillTypeId.jsp?token="+token,
    	            title: title, width: 300, height: 160,
    	            onload: function () {
    	              
    	           },
    	           ondestroy: function (action){
    	        	   if(action == "ok"){
    	        		   var iframe = this.getIFrameEl();
        	        	   var billTypeId = iframe.contentWindow.getBilltype();
        	        	   saveNewBill(preBook,billTypeId);
    	        	   }
    	           }
        	    });
            }
          }
     });
    }
}

function saveNewBill(data,billTypeId){
	var row = data;
	var newRow = {};
    newRow.id = row.id;
    //保存的工单  
    var maintain = {
    		"billTypeId":billTypeId,
    		"guestId":row.guestId,
    		"carId":row.carId,
    		"carNo":row.carNo,
    		"mtAdvisorId":row.mtAdvisorId,
    		"serviceTypeId":row.serviceTypeId,
    		"mtAdvisor":row.mtAdvisor,
    		"contactorId":row.contactorId	
    };
    
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    var action = "newBill";
    var json = nui.encode({
    	 rpsPrebook: newRow,
         action: action,
         maintain:maintain,
         token: token	
	});	
    
    nui.ajax({
        url: BookinUrl,
        type: 'post',
        data:json,
        cache : false,
		contentType : 'text/json',
        success: function(data) {
            if (data.errCode == "S") {
                nui.unmask();
                showMsg("开单成功","S");     
                upGrid.reload();
            } else {
                nui.unmask();
                showMsg(data.errMsg || "开单失败","E"); 
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            showMsg("网络出错，保存失败","E");           
        }
    });
}

//修改状态时执行的函数
function updateRpspreBookStatus(action) {
    var row = upGrid.getSelected();
    if (!row || row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }

    var newRow = {};
    newRow.id = row.id;

      
       newRow.status = action == "confirm" ? 1 : 
                 action ==  "cancel" ? 2 :
                 action == "newBill" ? 3 : 1;
  

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url: baseUrl + "com.hsapi.repair.repairService.booking.updateBooking.biz.ext",
        type: 'post',
        data:JSON.stringify({
            rpsPrebook: newRow,
            action: action,
            token: token
        }),        
        success: function(data) {
            if (data.errCode == "S") {
                nui.unmask();
                showMsg("保存成功","S");     
                upGrid.reload();
            } else {
                nui.unmask();
                showMsg(data.errMsg || "保存失败","E"); 
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            showMsg("网络出错，保存失败","E");           
        }
    });
}

function callBill() {
    var row = upGrid.getSelected();
    if (!row || row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + contextPath + "/com.hsweb.RepairBusiness.BookingScout.flow?token="+token,
        title: "预约跟进", width: 700, height: 350,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { action: "edit", data: row };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
        	if(action=="ok"){
        		  showMsg("跟进成功","S");			
                downGrid.reload();
        	}
        }
    });   
}
function setDate(){
	var radiobuttonlist = nui.get("radiobuttonlist");
	var value = radiobuttonlist.getValue();
	if(value=="1"){
		document.getElementById("setDate").innerHTML = "预计来厂日期";
	}else{
		document.getElementById("setDate").innerHTML = "预约创建日期";
	}
	//quickSearch(menuBtnDateQuickSearch, 0, '本日')"
	var data = ['本日','昨日','本周','上周','本月','上月'];
	var d = menuBtnDateQuickSearch.getValue();
	quickSearch(menuBtnDateQuickSearch,d,data[d]);
}

var binUrl = webBaseUrl + "repair/RepairBusiness/Reception/bindWechatContactor.jsp";
function bindWechat(row_uid){
	var row = upGrid.getRowByUID(row_uid);
	//var guestId = data.guestId;
	if(!row.guestId){
		showMsg("客户为新客户，请新增客户信息!","W");
		return;
	}
	nui.open({
        url:binUrl,
        title:"绑定联系人",
        width:750, 
        height:300,
        onload:function(){
        	var iframe = this.getIFrameEl();
            var params = {};	
            params.guestId=row.guestId;
            params.carNo = row.carNo;
            iframe.contentWindow.setData(params);
        },
        ondestroy:function(action)
        {
        	var iframe = this.getIFrameEl();
            var params = {};	
            var params = iframe.contentWindow.getData();
            if(params){
            	if(params.success && params.success==1){
            		document.getElementById("showA").style.display = "";
                	document.getElementById("showA1").style.display='none';
            	}
            }
        	
        }
    });
}


function setInitData(params){
	if(params.viewType=="reminding"){
		var radiobuttonlist = nui.get("radiobuttonlist");
		radiobuttonlist.setValue(1);
		doSearch();
	}
}




