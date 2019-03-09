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
	if(currOrgId == 0){
		document.getElementById("funcName").style.display = "";
		document.getElementById("funcAction").style.display = "";
		document.getElementById("funcName").innerHTML = row.funcName || "";
		document.getElementById("funcAction").innerHTML = row.funcAction || "";
	}
	
	var recordDate = format(row.recordDate, "yyyy-MM-dd HH:mm");
	document.getElementById("recordDate").innerHTML = recordDate;
	showTab(row.questionType,row.questionContent);//updaFree
	var settleContent = row.settleContent || "";
	nui.get("settleContent").setValue(settleContent);
	$("#imgShow").attr("src",row.fileUrl);
	$("#maxImgShow").attr("src",row.fileUrl);
	document.getElementById("settlor").innerHTML = row.settlor || "";
	if(row.settleDate){
		var settleDate = format(row.settleDate, "yyyy-MM-dd HH:mm");
		document.getElementById("settleDate").innerHTML = settleDate;
	}
	var updaFree = row;
	var finish = 0;
	var json = nui.encode({
		updaFree:updaFree,
		finish:finish,
		token:token
	});
	if(row.status == 0 && row.user==0){
		/*var date = new Date();
		document.getElementById("settlor").innerHTML = currUserName;
		var settleDate = format(date, "yyyy-MM-dd HH:mm");
		document.getElementById("settleDate").innerHTML = settleDate;*/
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
	 				showMsg("打开页面有误，请重新打开！","E");
	 		    }
	 		}
	 	 });
	}
	
	if(row.user && row.user==1){
		$("#updFinish").hide();
		$("#Oncancel").hide();
	}
}

function changeShow(){
	$(".max_img").show();
}

function changeHide(){
	$(".max_img").hide();
}
function showTab(str,questionContent){
	var list = [];
	if(str){
		var list = str.split(",");
	}
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
	if(rowData.status == 2){
		showMsg("反馈已解决","W");
		return;
	}
	var updaFree = rowData;
	updaFree.status = 2;
	var finish = 1;
	//获取回复的值
	var settleContent = nui.get("settleContent").getValue().replace(/\s+/g, "") || "";
	updaFree.settleContent = settleContent;
	var json = nui.encode({
		updaFree:updaFree,
		finish:finish,
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

