var baseUrl = apiPath + repairApi + "/";

var workOrder = null;

$(document).ready(function(v){
	workOrder = nui.get("workOrder");


var params = {
	    	readSign : 1,
	    	readerTargetId : currEmpId
};
	query(params);
});
function query (params){
	var queryMaintainUrl = baseUrl+"com.hsapi.repair.repairService.query.queryRemind.biz.ext";
	workOrder.setUrl(queryMaintainUrl);
	workOrder.load({
		params:params,
        token: token
    });
	/*nui.ajax({
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
	});*/
}



//查询消息提醒，msg_Type消息类型
function queryRemind (list){
	var queryworkOrderList = [];//1

	
	for(var i =0;i<list.length;i++){
		/*if(list[i].msgType==1){
        	if(list[i].recordDate.indexOf(".") > -1){
        		list[i].recordDate = list[i].recordDate.substring(0, list[i].recordDate.indexOf(".")-3);
        	}
        	queryworkOrderList.push(list[i]);
		}*/
		if(list[i].recordDate.indexOf(".") > -1){
    		list[i].recordDate = list[i].recordDate.substring(0, list[i].recordDate.indexOf(".")-3);
    	}
    	queryworkOrderList.push(list[i]);
	}

	workOrder.setData(queryworkOrderList);


}


