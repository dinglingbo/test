var baseUrl = apiPath + repairApi + "/";


//var appointment = null;

var employeeBirthday = null;
var datagrid1 = null;
var params = {};
var queryMaintainUrl = baseUrl+"com.hsapi.repair.repairService.query.queryRemind.biz.ext";
var updateUrl = baseUrl+"com.hsapi.repair.repairService.repairInterface.updateComMsg.biz.ext";
$(document).ready(function(v){

//	appointment = nui.get("appointment");

	employeeBirthday = nui.get("employeeBirthday");



//	appointment.on("drawcell", function (e) {
//        if(e.field == "readSign"){
//             if(e.value == 1){
//                 e.cellHtml = "已读";
//             }else{
//                 e.cellHtml = "未读";
//             }
//         }
//     });

	employeeBirthday.on("drawcell", function (e) {
        if(e.field == "readSign"){
             if(e.value == 1){
                 e.cellHtml = "已读";
             }else{
                 e.cellHtml = "未读";
             }
        }
        if (e.field == 'recordDate') {
            e.cellHtml = nui.formatDate (new Date(e.value) ,'yyyy-MM-dd HH:mm' )
        }
     });

    params = {
	    	readSign : 0,
	    	msgType:18
/*	    	readerTargetId : currEmpId*/
};
	query(params);
});
function query (params){
	
	nui.ajax({
		url : queryMaintainUrl,
		type : "post",
		cache : false,
		data :{
			params:params,
			token:token
		},
		success : function(text) {
			var queryEmployeeBirthdayList = text.data||0;
			employeeBirthday.setData(queryEmployeeBirthdayList);
//			queryRemind(list); 
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
//查询消息提醒，msg_Type消息类型
function queryRemind (list){

//	var queryAppointmentList = [];//6预约到店

	var queryEmployeeBirthdayList = [];//18员工生日
	
	for(var i =0;i<list.length;i++){
//		 if(list[i].msgType==6){
//        	if(list[i].recordDate.indexOf(".") > -1){
//        		list[i].recordDate = list[i].recordDate.substring(0, list[i].recordDate.indexOf(".")-3);
//        	}
//			queryAppointmentList.push(list[i]);
//		}else 
			if(list[i].msgType==18){
        	if(list[i].recordDate.indexOf(".") > -1){
        		list[i].recordDate = list[i].recordDate.substring(0, list[i].recordDate.indexOf(".")-3);
        	}
			queryEmployeeBirthdayList.push(list[i]);
		}
	}

//		appointment.setData(queryAppointmentList);
		employeeBirthday.setData(queryEmployeeBirthdayList);


}

function setInitData(params){
	var tab = nui.get("tabs");
	//tab.activeTab (tab.getTab ( params.id-1 ) );

	
	
}

function quickSearch(type) {
    
    var queryname = "未读";
    switch (type) {
        case 0:
            queryname = "所有";
            break;
        case 1:
            params.readSign = 0;  //
            queryname = "未读";
            break;
        case 2:
            params.readSign = 1;  //
            queryname = "已读";
            break;
        default:
            break;
    }
    var menunamestatus = nui.get("menunamestatus");
    menunamestatus.setText(queryname);
/*    params.readerTargetId = currEmpId;*/
    	params.msgType = 18;
    	query(params);
}

function updateStatus() {
    var rows = employeeBirthday.getSelecteds();
    if (rows.length > 0) {
        for (var  i = 0; i < rows.length; i++) {
            var  row = rows[i];
            if (row.readSign == 1) {
                showMsg('存在已读的数据', 'W');
                return;
            }
        }

        nui.ajax({
            url: updateUrl,
            type: 'post',
            data: {
                rows: rows,
                isRead:1
            },
            success: function (res) {
                if (res.errCode == 'S') {
                    showMsg('操作成功', 'S');
                    query(params);
                } else {
                    showMsg('操作失败', 'E');
                }
            } 
        })
    } else {
        showMsg('请先选中要操作的数据', 'E');
    }
}
