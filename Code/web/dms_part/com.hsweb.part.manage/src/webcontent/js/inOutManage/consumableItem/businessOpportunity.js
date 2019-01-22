
/**
 * Created by Administrator on 2018/8/8.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var partApiUrl = apiPath + partApi + "/";
var repairApiUrl = apiPath + repairApi + "/";
var grid = null;
var gridUrl = repairApiUrl+ "com.hsapi.repair.repairService.query.queryRepairOut.biz.ext";
var queryInfoForm = null;

$(document).ready(function(v) {

	queryInfoForm = new nui.Form("#queryInfoForm").getData(false, false);
	grid = nui.get("grid");

	grid.load(queryInfoForm);
	grid.setUrl(gridUrl);
	grid.on("drawcell", onDrawCell);





	
	grid.on("rowdblclick", function(e) {
		var row = grid.getSelected();
		var rowc = nui.clone(row);
		if (!rowc)
			return;


	});
	grid.on("drawcell", function(e) {
		switch (e.field) {
		case "partBrandId":
			if (brandHash[e.value]) {
				e.cellHtml = brandHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		case "storeId":
			if (storeHash[e.value]) {
				e.cellHtml = storeHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		case "billTypeId":
			if (billTypeHash[e.value]) {
				e.cellHtml = billTypeHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		default:
			break;
		}

	});

});


function quickSearch(type){
    var params = getSearchParams();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.sCreateDate = getNowStartDate();
            params.eCreateDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sCreateDate = getPrevStartDate();
            params.eCreateDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sCreateDate = getWeekStartDate();
            params.eCreateDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sCreateDate = getLastWeekStartDate();
            params.eCreateDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sCreateDate = getMonthStartDate();
            params.eCreateDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sCreateDate = getLastMonthStartDate();
            params.eCreateDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        default:
            break;
    }
    
    sCreateDateEl.setValue(params.sCreateDate);
    eCreateDateEl.setValue(addDate(params.eCreateDate,-1));
    currType = type;
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    doSearch(params);
}
function getSearchParams() {
	var params = {};
	params.returnSign=0;
	params.billTypeId='050207';
	params.sCreateDate = sCreateDateEl.getText();
	params.eCreateDate = addDate(eCreateDateEl.getText(),1);
	params.pickMan = nui.get('pickMan1').getText();
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
		height : 450,
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
				url :  webPath + contextPath
				+ "/com.hsweb.part.manage.businessOpportunityEdit.flow?token="
				+ token,
				title : "修改计次卡",
				width : 900,
				height : 580,
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