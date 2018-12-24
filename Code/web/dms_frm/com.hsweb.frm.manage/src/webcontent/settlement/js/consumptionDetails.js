/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = apiPath + repairApi + "/";
var queryCardUrl = baseUrl
+"com.hsapi.repair.baseData.query.queryCardstored.biz.ext";
var queryCardUr2 = baseUrl
+"com.hsapi.repair.baseData.query.queryStoreConsume.biz.ext";
var grid = null;
var grid2 = null;
var servieTypeList = [];
var servieTypeHash = {};
var statusList = [{id:"0",name:"客户名称"},{id:"1",name:"客户电话"},{id:"2",name:"会员卡名称"}];
$(document).ready(function(v) {
	grid = nui.get("datagrid1");
	grid2 = nui.get("datagrid2");
    var date = new Date();
    var sdate = new Date();
    sdate.setMonth(date.getMonth()-6);
    var startDate = mini.get("startDate");
    var endDate = mini.get("endDate");
    endDate.setValue(date);
    startDate.setValue(sdate);
    
    var query = {
    		startDate:sdate,
    		endDate:date
    }; 
    grid.setUrl(queryCardUrl);
    grid.load({
    	query:query,
    	token : token
    });
    
    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
   
    grid2.on("drawcell", function (e) {
        switch (e.field) {
            case "serviceTypeId":
            	e.cellHtml = servieTypeHash[e.value].name;
                break;
            case "recordDate":
            	if(e.value.indexOf(".") > -1){
            		e.cellHtml = e.value.substring(0, e.value.indexOf(".")-3);
            	}
                break;
            default:
                break;
        }
    });
});

function search(){
	var guestName =  null;
	var guestTelephone = null;
	var cardName = null;
	var startDate = nui.get("startDate").getFormValue();
	var endDate = nui.get("endDate").getValue();
	endDate = addDate(endDate, 1);
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
    	guestName = typeValue;
    }else if(type==1){
    	guestTelephone = typeValue;
    }else if(type==2){
    	cardName = typeValue;
    }
	var params = {
			guestName:guestName,
			guestTelephone:guestTelephone,
			cardName:cardName,
			startDate:startDate,
			endDate:endDate
	}
	var json1 = {
			params:params,
			token:token
	}
	nui.ajax({
		url : queryCardUrl,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			grid.setData(text.data);
			
			
			
		}
	});
}


// 重新刷新页面
function refresh() {
	var form = new nui.Form("#queryform");
	var json = form.getData(false, false);
	grid.load(json);// grid查询
	nui.get("updateBtn").enable();
}





function onDrawCell(e) {
	// var hash = new Array("原价比例(%)", "折后价比例(%)", "产值比例(%)", "固定金额(元)");
	var hash = {
		"1" : "原价比例(%)",
		"2" : "折后价比例(%)",
		"3" : "产值比例(%)",
		"4" : "固定金额(元)"
	};
	switch (e.field) {
	case "useRange":
		e.cellHtml = e.value == 1 ? "连锁" : "本店";
		break;
	case "canModify":
		e.cellHtml = e.value == 1 ? "是" : "否";
		break;
	case "packageRate":
		e.cellHtml = e.value + "%";
		break;
	case "itemRate":
		e.cellHtml = e.value + "%";
		break;
	case "partRate":
		e.cellHtml = e.value + "%";
		break;
	case "salesDeductType":
		e.cellHtml = hash[e.value];
		break;
	case "status":
		e.cellHtml = e.value == 1 ? "禁用" : "启用";
		break;
	/*
	 * case "periodValidity": e.cellHtml = e.value == -1 ? "永久有效"
	 * :e.periodValidity ; break;
	 */
	default:
		break;
	}
	if (e.field == "periodValidity") {
		if (e.value == -1) {
			e.cellHtml = "永久有效";
		}
	}
}
// 当选择列时
function selectionChanged() {
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	var rows = grid.getSelecteds();
	var id = rows[0].id;
	var params = {};
	params.id = id;
	var json1 = {
			params:	params
	};
	nui.ajax({
		url : queryCardUr2,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			grid2.setData(text.data);
		}
	});
}