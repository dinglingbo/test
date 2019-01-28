/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var queryUrl = baseUrl + "com.hsapi.system.employee.feedback.updatFeedBack.biz.ext";
$(document).ready(function(v) {
   
	
});

function close() {
	if (window.CloseOwnerWindow){
		return window.CloseOwnerWindow('OK');
    } else {
        window.close();
        return ;
    }
}

function Oncancel(){
    //closeWindow("cancel");
	close();
}
var rowData = {};
function setFeedbackData(row){
	rowData = row;
	document.getElementById("recorder").innerHTML = row.recorder || "";
	document.getElementById("recordMobile").innerHTML = row.recordMobile || "";
	document.getElementById("orgname").innerHTML = row.orgname || "";
	document.getElementById("questionSource").innerHTML = row.source || "";
	document.getElementById("funcName").innerHTML = row.funcName || "";
	document.getElementById("funcAction").innerHTML = row.funcAction || "";
	recordDate = format(row.recordDate, "yyyy-MM-dd HH:mm");
	document.getElementById("recordDate").innerHTML = recordDate;
	showTab(row.questionType,row.questionContent);//updaFree
	var settleContent = row.settleContent || "";
	nui.get("settleContent").setValue(settleContent);
	var updaFree = row;
	var json = nui.encode({
		updaFree:updaFree,
		token:token
	});
	if(row.status == 0){
		nui.ajax({
	 		url : queryUrl,
	 		type : 'POST',
	 		data : json,
	 		cache : false,
	 		contentType : 'text/json',
	 		success : function(text) {
	 			var returnJson = nui.decode(text);
	 			if (returnJson.errCode == "S") {

	 			} else {
	 				
	 		    }
	 		}
	 	 });
	}
	
	
}

function showTab(str,questionContent){
	var list = str.split(",");
	var temp = "";
	if(list.length >0){
		for(var i = 0 ;i<list.length;i++){
			if(list[i]!=""){
				var aEl = "<a href='##' value="+list[i]+"  name='HotWord' class='hui'>"+list[i]+"</a>";
				 temp +=aEl;
			}	
		}
	}
	if(questionContent){
		temp=temp+"<span style='padding-top: 2px;'>"+questionContent+"</span>";
	}
	$("#addAEl").html(temp);
}


function updFinish(){
	var updaFree = rowData;
	updaFree.status = 2;
	//获取回复的值
	var settleContent = nui.get("settleContent").getValue() || "";
	updaFree.settleContent = settleContent;
	var json = nui.encode({
		updaFree:updaFree,
		token:token
	});
	nui.ajax({
 		url : queryUrl,
 		type : 'POST',
 		data : json,
 		cache : false,
 		contentType : 'text/json',
 		success : function(text) {
 			var returnJson = nui.decode(text);
 			if (returnJson.errCode == "S") {
                 showMsg("保存成功!","S");
 			} else {
 				showMsg("保存失败!","E");
 		    }
 		}
 	 });
}

