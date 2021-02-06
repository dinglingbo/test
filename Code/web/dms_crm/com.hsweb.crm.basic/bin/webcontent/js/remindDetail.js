		
var visitModeList=null;
var visitModeHash={};
var guestId=null;
var gridTabs=null;
var grid1=null;
var grid2=null;
var grid3=null;
var grid4=null;
var grid5=null;
var grid6=null;
var baseUrl=apiPath + repairApi+"/";
var gridUrl= baseUrl +"com.hsapi.repair.baseData.query.queryCareRecord.biz.ext";
$(document).ready(function(){
	gridTabs=nui.get('gridTabs');
	grid1=nui.get('grid1');
	grid1.setUrl(gridUrl);
	grid2=nui.get('grid2');
	grid2.setUrl(gridUrl);
	grid3=nui.get('grid3');
	grid3.setUrl(gridUrl);
	grid4=nui.get('grid4');
	grid4.setUrl(gridUrl);
	grid5=nui.get('grid5');
	grid5.setUrl(gridUrl);
	grid6=nui.get('grid6');
	grid6.setUrl(gridUrl);
	
	gridTabs.on("activechanged",function(e){
		showTabInfo();
	});
	
	var dictDefs = {
		"visitMode" : "DDT20130703000021"
	};
	initDicts(dictDefs, function(e) {
		var visitModeList = nui.get("visitMode").getData();
		visitModeList.forEach(function(v) {
			visitModeHash[v.customid] = v;
		});
	});
	
	grid1.on("drawcell",function(e){
		switch (e.field) {
		case "visitMode":
			if (visitModeHash[e.value]) {
				e.cellHtml = visitModeHash[e.value].name || "";
			} 
			break;
		default:
			break;	
		}
	});
	grid2.on("drawcell",function(e){
		switch (e.field) {
		case "visitMode":
			if (visitModeHash[e.value]) {
				e.cellHtml = visitModeHash[e.value].name || "";
			} 
			break;
		default:
			break;	
		}
	});
	grid3.on("drawcell",function(e){
		switch (e.field) {
		case "visitMode":
			if (visitModeHash[e.value]) {
				e.cellHtml = visitModeHash[e.value].name || "";
			} 
			break;
		default:
			break;	
		}
	});
	grid4.on("drawcell",function(e){
		switch (e.field) {
		case "visitMode":
			if (visitModeHash[e.value]) {
				e.cellHtml = visitModeHash[e.value].name || "";
			} 
			break;
		default:
			break;	
		}
	});
	grid5.on("drawcell",function(e){
		switch (e.field) {
		case "visitMode":
			if (visitModeHash[e.value]) {
				e.cellHtml = visitModeHash[e.value].name || "";
			} 
			break;
		default:
			break;	
		}
	});
	grid6.on("drawcell",function(e){
		switch (e.field) {
		case "visitMode":
			if (visitModeHash[e.value]) {
				e.cellHtml = visitModeHash[e.value].name || "";
			} 
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

function showTabInfo(){
	var params={};
	params.guestId=guestId;
	var tab =gridTabs.getActiveTab();
	var name = tab.name;
	if(name=='grid1Tab'){
		params.careType=1;
		grid1.load({params :params,token:token});
	}
	if(name=='grid2Tab'){
		params.careType=2;
		grid2.load({params :params,token:token});
	}
	if(name=='grid3Tab'){
		params.careType=3;
		grid3.load({params :params,token:token});
	}
	if(name=='grid4Tab'){
		params.careType=4;
		grid4.load({params :params,token:token});
	}
	if(name=='grid5Tab'){
		params.careType=5;
		grid5.load({params :params,token:token});
	}
	if(name=='grid6Tab'){
		params.careType=6;
		grid6.load({params :params,token:token});
	}
}
	
function SetData(params) {
	guestId=params.guestId;
	grid1.load({params :params,token:token});
}
		