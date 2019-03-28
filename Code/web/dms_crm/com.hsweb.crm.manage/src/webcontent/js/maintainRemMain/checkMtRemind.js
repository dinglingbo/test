
var visitModeList=null;
var visitModeHash={};
var mainGrid=null;
var baseUrl=apiPath + repairApi+"/";
var mainGridUrl= apiPath + crmApi+ "/com.hsapi.crm.svr.visit.queryCrmVisitRecordSql.biz.ext";
var serviceTypeList = [{},{ id: 1, text: '电销' }, { id: 2, text: '预约' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 10, text: '生日' }, { id: 11, text: '其他' }];

$(document).ready(function(){
	mainGrid=nui.get('mainGrid');
	mainGrid.setUrl(mainGridUrl);
	
	var dictDefs = {
		"visitMode" : "DDT20130703000021"
	};
	initDicts(dictDefs, function(e) {
		var visitModeList = nui.get("visitMode").getData();
		visitModeList.forEach(function(v) {
			visitModeHash[v.customid] = v;
		});
	});
	
	mainGrid.on("drawcell",function(e){
		switch (e.field) {
		case "visitMode":
			if (visitModeHash[e.value]) {
				e.cellHtml = visitModeHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		case "serviceType":
			e.cellHtml = serviceTypeList[e.value].text;
			break;
		default:
			break;	
		}
	});
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
});

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}
		
function SetData(params) {
	doSearch(params);
}

function doSearch(params){
	mainGrid.load({params: params,token :token});
}