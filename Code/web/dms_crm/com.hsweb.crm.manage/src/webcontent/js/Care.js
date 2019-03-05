var visitMode_ctrl = null;
var careRows = [];
var careType = 0;
var sysUrl =apiPath +sysApi+"/";
var visitModeCtrlUrl = sysUrl + "com.hsapi.system.dict.dictMgr.queryDict.biz.ext?dictid=DDT20130703000021&fromDb=true";
$(document).ready(function(){
	
	visitMode_ctrl = nui.get("visitMode");
	visitMode_ctrl.setUrl(visitModeCtrlUrl);

});
function save(){
	var visitMode = nui.get("visitMode").getValue();
	var visitContent = nui.get("visitContent").getValue();
	var record=[];
	if(!visitMode){
		showMsg("请先选择提醒方式","W");
		return;
	}
	if(!visitContent){
		showMsg("清填写内容","W");
		return;
	}
	for(var i =0;i<careRows.length;i++){
		record[i]={
					orgid: currOrgId,
					careType:careType,
					guestId:careRows[i].guestId,
					carId:careRows[i].carId,
					visitMode : visitMode,
					visitContent:visitContent,
					visitId:currEmpId,
					visitMan:currUserName
		};
	}
	nui.ajax({
		url:apiPath +repairApi + "/com.hsapi.repair.repairService.crud.saveCareRecord.biz.ext",
		type:"post",
		data:{
			data:record
		},
		success:function(text){
			if(text.errCode == "S"){
				showMsg("保存成功！","S");
				onClose();
			}

		}
	});
}


function setData(rows,type){
	careRows=rows;
	careType =type;
}

function CloseWindow(action) {
	if (action == "close") {
	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function onClose(){
	window.CloseOwnerWindow();	
}