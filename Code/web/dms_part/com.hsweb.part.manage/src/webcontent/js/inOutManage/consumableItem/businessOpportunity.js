
/**
 * Created by Administrator on 2018/8/8.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var partApiUrl = apiPath + partApi + "/";
var repairApiUrl = apiPath + repairApi + "/";
var grid = null;
var gridUrl = apiPath + crmApi
+ "/com.hsapi.crm.basic.crmBasic.querySellList.biz.ext";
var sfData = {};
var hash = new Array("尚未联系", "有兴趣", "意向明确", "成交" ,"输单");
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"联系人名称"},{id:"2",name:"手机号"}];
var statusList1 = [{id:"0",name:"尚未联系0%"},{id:"1",name:"有兴趣30%"},{id:"2",name:"意向明确50%"},{id:"3",name:"成交100%"},{id:"4",name:"输单0%"}];
var beginDateEl = null;
var endDateEl = null;
var chanceManIdEl = null;
$(document).ready(function(v) {

	grid = nui.get("mainGrid");
	grid.setUrl(gridUrl);
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");
	chanceManIdEl = nui.get("chanceManId");
    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
	grid.on("drawcell", function(e) {
		switch (e.field) {
		case "status":
			e.cellHtml = hash[e.value];
			break;
		case "chanceType":
			for(var i=0;i<sfData.length;i++){
				if(e.value==sfData[i].customid){
					e.cellHtml =sfData[i].name;
					}
				}
			break;
		default:
			break;
		}

	});
	
	grid.on("rowdblclick",function(e){

			edit();

	});
	
    initDicts({
    	chanceType:SELL_TYPE//商机
    },function(){
    	sfData = nui.get("chanceType").data;
    });
	
    //服务顾问
    initMember("chanceManId", function () {
        var data = nui.get("chanceManId").getData();
        data.forEach(function (v) {
            //mtAdvisorHash[v.id] = v;
        });
    });
	grid.load({
		token:token
	});

});



function getSearchParams() {	
	var params = {};
	params.status = nui.get("status").getValue();
    params.startDate = beginDateEl.getValue();
    var eRecordDate = endDateEl.getValue();
    params.endDate = addDate(eRecordDate,1);
    params.chanceManId = chanceManIdEl.getValue();
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.guestName = typeValue;
    }else if(type==2){
        params.guestMobile = typeValue;
    }
    return params;
}
function onSearch() {
	var params = getSearchParams();

	doSearch(params);
}
function doSearch(params) {
	grid.load({
		token : token,
		params : params
	});
}

function add() {
	
	nui.open({
		url : webPath + contextPath
				+ "/com.hsweb.part.manage.businessOpportunityEdit.flow?token="
				+ token,
		title : "添加商机",
		width : 550,
		height : 430,
		onload : function() {
			var iframe = this.getIFrameEl();
			var list = [];
			var params = {
					type : "add"
			};
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {
			if (action == "saveSuccess") {
				grid.reload();
			}
		}
	});
}

function edit() {
		var row = grid.getSelected();
		if (row) {
			nui.open({
				url : webPath + contextPath
				+ "/com.hsweb.part.manage.businessOpportunityEdit.flow?token="
				+ token,
				title : "更新商机",
				width : 550,
				height : 410,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = row;
					data.type = 'editT';
					// 直接从页面获取，不用去后台获取
					iframe.contentWindow.setData(data);
				},
				ondestroy : function(action) {
					if (action == "saveSuccess") {
						grid.reload();
					}
				}
			});
		} else {
			showMsg("请选中一条记录!", "W");
		}
	}