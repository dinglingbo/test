var investGrid = null;
var baseUrl = apiPath + crmApi + "/";
var queryInvestListUrl = baseUrl+"com.hsapi.crm.svr.svr.queryInvestList.biz.ext";
var gAuditSign=[{
	"id":0,
	"text":"未审核"
},{
	"id":1,
	"text":"通过"
},{
	"id":2,
	"text":"不通过"
}];
var headerHash = [{ name: '未审核', id: '0' }, { name: '通过', id: '1' }, { name: '不通过', id: '2' }];
var headerHash1 = [{ name: '首次到店', id: '1' }, { name: '再次回厂', id: '2' }, { name: '流失召回', id: '3' }];
var brandList=[];
var brandHash={};
var serviceList=[];
var serviceHash={};
var currType = 2;
$(document).ready(function(){
	investGrid = nui.get("investGrid");
	investGrid.setUrl(queryInvestListUrl);
	
	initCarBrand("carBrandId",function(data) {
		brandList = nui.get("carBrandId").getData();
		brandList.forEach(function(v) {brandHash[v.id] = v;});
	});
	initServiceType("serviceTypeId",function(data) {
		serviceList = nui.get("serviceTypeId").getData();
		serviceList.forEach(function(v) {serviceHash[v.id] = v;});
	});
	
	   
	   var filter = new HeaderFilter(investGrid, {
	        columns: [
	            { name: 'visitMan' },
	            { name: 'recorder' },
	            { name: 'auditSign' },
	            { name: 'carType' }
	        ],
	        callback: function (column, filtered) {
	        },

	        tranCallBack: function (field) {
	        	var value = null;
	        	switch(field){
		    		
		    		case "auditSign" : // 预约类型
		    			value = headerHash;
		    			break;
		    		case "carType" : // 预约类型
		    			value = headerHash1;
		    			break;
		    	}
	        	return value;
	        }
	    });
	investGrid.on("rowdblclick", function(e) {
		var row = investGrid.getSelected();
		var rowc = nui.clone(row);
		if (!rowc)
			return;
		onEditClick();

	});
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // Enter
        	search();
        }

    }
	quickSearch(2);
});


function quickSearch(type){
    //var params = getSearchParams();
    var params = {};
    var queryname = "本日";
    switch (type)
    {
      case 0:
      params.today = 1;
      params.startDate = getNowStartDate();
      params.endDate = addDate(getNowEndDate(), 1);
      queryname = "本日";
      break;
      case 1:
      params.yesterday = 1;
      params.startDate = getPrevStartDate();
      params.endDate = addDate(getPrevEndDate(), 1);
      queryname = "昨日";
      break;
      case 2:
      params.thisWeek = 1;
      params.startDate = getWeekStartDate();
      params.endDate = addDate(getWeekEndDate(), 1);
      queryname = "本周";
      break;
      case 3:
      params.lastWeek = 1;
      params.startDate = getLastWeekStartDate();
      params.endDate = addDate(getLastWeekEndDate(), 1);
      queryname = "上周";
      break;
      case 4:
      params.thisMonth = 1;
      params.startDate = getMonthStartDate();
      params.endDate = addDate(getMonthEndDate(), 1);
      queryname = "本月";
      break;
      case 5:
      params.lastMonth = 1;
      params.startDate = getLastMonthStartDate();
      params.endDate = addDate(getLastMonthEndDate(), 1);
      queryname = "上月";
      break;

      case 10:
      params.thisYear = 1;
      params.startDate = getYearStartDate();
      params.endDate = getYearEndDate();
      queryname="本年";
      break;
      case 11:
      params.lastYear = 1;
      params.startDate = getPrevYearStartDate();
      params.endDate = getPrevYearEndDate();
      queryname="上年";
      break;
      default:
      break;
  }
  currType = type;
  nui.get('startDate').setValue(params.startDate);
  nui.get('endDate').setValue(addDate(params.endDate,-1));
  var menunamedate = nui.get("menunamedate");
  menunamedate.setText(queryname);
    //doSearch(params);
    search();
}
function search(){
    var p={
        serviceCode:nui.get("serviceCode").getValue(),
        carNo:nui.get("carNo").getValue(),
        auditSign:nui.get("auditSign").getValue(),
        startDate:nui.get('startDate').getFormValue(),
        endDate:nui.get('endDate').getFormValue()+" 23:59:59"
    };
    investGrid.load({params:p});
}

function onAddClick(){
	nui.open({
		url:  webPath + contextPath+ "/com.hsweb.crm.manage.investDetail.flow?token="+ token,
		title: "业绩新增",
		allowResize:false,
		width: 400, 
		height: 300,
		onload: function () {
			var iframe = this.getIFrameEl();
        	iframe.contentWindow.setData(null);
         },
         ondestroy: function (action) {
             if(action == "ok"){
            	 search();
             }
         }
	});
}

function onEditClick(){
	var data = investGrid.getSelected();
	if(data == null){
		showMsg("请先选择一条数据","W");
		return;
	}
	if(data.auditSign == 1){
		showMsg("已审核通过，无法修改","W");
		return;
	}
	nui.open({
		url: webPath + contextPath+ "/com.hsweb.crm.manage.investDetail.flow?token="+ token,
		title: "业绩修改",
		allowResize:false,
		width: 400,
		height: 300,
		onload: function () {
			var iframe = this.getIFrameEl();
        	iframe.contentWindow.setData(data);
         },
         ondestroy: function (action) {
        	 if(action == "ok"){
            	 search();
             }
         }
	});
}

function onDeleteClick(){
	var data = investGrid.getSelected();
	if(data == null){
		showMsg("请先选择一条数据","W");
		return;
	}
	if(data.auditSign == 1){
		showMsg("已审核通过，无法删除","W");
		return;
	}
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '正在删除...'
    });

    nui.ajax({
        url :baseUrl+ "com.hsapi.crm.svr.svr.deleteInvest.biz.ext",
        type : "post",
        data : {
        	invest:data,
        	token:token
        },
        success : function(data) {
            nui.unmask();
            data = data || {};
            if (data.errCode == "S") {
                var errMsg = data.errMsg;
                showMsg(errMsg,"S");
                search();
            } else {
            	showMsg(data.errMsg || "删除失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}

function onDrawcell(e) {
	var hash = new Array("首次到店", "再次回厂", "流失召回");
    if(e.field == "auditSign"){
        for(var i=0;i<gAuditSign.length;i++){
            if(e.value == gAuditSign[i].id){
                e.cellHtml = gAuditSign[i].text;
            }
        }
    }
    if (e.field == "carType") {
        e.cellHtml = hash[e.value-1];
	}
    if (e.field == "serviceTypeId") {
        if (serviceHash && serviceHash[e.value]) {
            e.cellHtml = serviceHash[e.value].name;
        }
    }
    if (e.field == "carBrandId") {
        if (brandHash && brandHash[e.value]) {
            e.cellHtml = brandHash[e.value].nameCn;
        }
    }
}



function onEditClick22(){
	var data = investGrid.getSelected();
	if(data == null){
		showMsg("请先选择一条数据","W");
		return;
	}

}

function trackDetail(){
		var data = investGrid.getSelected();
	if(data == null){
		showMsg("请先选择一条数据","W");
		return;
	}

	nui.open({
		url: webPath + contextPath+ "/manage/trackInfo.jsp?token="+ token,
		title: "跟踪记录",
		allowResize:false,
		width: 800,
		height: 300,
		onload: function () {
			var iframe = this.getIFrameEl();
        	iframe.contentWindow.setData(data);
         },
         ondestroy: function (action) {
        	 if(action == "ok"){
            	 search();
             }
         }
	});
}