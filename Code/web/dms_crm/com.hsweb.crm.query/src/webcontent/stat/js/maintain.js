var baseUrl = apiPath + repairApi + "/";


var appointment = null;

var employeeBirthday = null;

var datagrid1 = null;
$(document).ready(function(v){

	appointment = nui.get("appointment");

	employeeBirthday = nui.get("employeeBirthday");



	appointment.on("drawcell", function (e) {
        if(e.field == "readSign"){
             if(e.value == 0){
                 e.cellHtml = "已读";
             }else{
                 e.cellHtml = "未读";
             }
         }
     });

	employeeBirthday.on("drawcell", function (e) {
        if(e.field == "readSign"){
             if(e.value == 0){
                 e.cellHtml = "已读";
             }else{
                 e.cellHtml = "未读";
             }
         }
     });

var params = {
	    	readSign : 1,
/*	    	readerTargetId : currEmpId*/
};
	query(params);
});
function query (params){
	var queryMaintainUrl = baseUrl+"com.hsapi.repair.repairService.query.queryRemind.biz.ext";
	nui.ajax({
		url : queryMaintainUrl,
		type : "post",
		cache : false,
		data :{
			params:params,
			token:token
		},
		success : function(text) {
			var list = text.data||0;
			queryRemind(list); 
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
//查询消息提醒，msg_Type消息类型
function queryRemind (list){

	var queryAppointmentList = [];//6预约到店

	var queryEmployeeBirthdayList = [];//18员工生日
	
	for(var i =0;i<list.length;i++){
		 if(list[i].msgType==6){
        	if(list[i].recordDate.indexOf(".") > -1){
        		list[i].recordDate = list[i].recordDate.substring(0, list[i].recordDate.indexOf(".")-3);
        	}
			queryAppointmentList.push(list[i]);
		}else if(list[i].msgType==18){
        	if(list[i].recordDate.indexOf(".") > -1){
        		list[i].recordDate = list[i].recordDate.substring(0, list[i].recordDate.indexOf(".")-3);
        	}
			queryEmployeeBirthdayList.push(list[i]);
		}
	}

		appointment.setData(queryAppointmentList);
		employeeBirthday.setData(queryEmployeeBirthdayList);


}

function setInitData(params){
	var tab = nui.get("tabs");
	tab.activeTab (tab.getTab ( params.id-1 ) );

	
	
}

function quickSearch(type) {
    var params = {};
    var queryname = "未读";
    switch (type) {
        case 0:
            queryname = "所有";
            break;
        case 1:
            params.readSign = 1;  //报价
            queryname = "未读";
            break;
        case 2:
            params.readSign = 0;  //施工
            queryname = "已读";
            break;
        default:
            break;
    }
    var menunamestatus = nui.get("menunamestatus");
    menunamestatus.setText(queryname);
/*    params.readerTargetId = currEmpId;*/
    	query(params);
}

