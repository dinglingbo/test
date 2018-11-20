/**
* Created by Administrator on 2018/10/23.
*/
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var gridCarUrl = baseUrl+"com.hsapi.crm.svr.visit.queryCrmVisitData.biz.ext";

var gridCar = null;
var mainId_ctrl = null;
var visitMode_ctrl = null;
var tcarNo_ctrl = null;
var memList = [];
var visitManEl = null;
var visitIdEl = null;
var hash = {};

$(document).ready(function(){
	visitManEl = nui.get("visitMan");
	visitIdEl = nui.get("visitId"); 
	tcarNo_ctrl = nui.get("tcarNo");

	gridCar = nui.get("gridCar");
	gridCar.setUrl(gridCarUrl);
	gridCar.load();

	gridCar.on("rowdblclick",function(e){
		var record = e.record;
		SetData(record);
	});
	
	document.onkeyup = function(event) {
		var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // Enter
        	quickSearch(3);
        }

    }

});

function mtAdvisorChanged(e){
	var sel = e.selected;
	mtAdvisorIdEl.setValue(sel.empId);

}


function SetData(rowData){ 
    mini.open({
        url: webPath + contextPath + "/manage/visitMgr/visitMainDetail.jsp?token="+ token,
        title: "回访信息", 
        width: 680, height: 360,
        onload: function () {
            var iframe = this.getIFrameEl(); 
            iframe.contentWindow.setData(rowData);
        },
        ondestroy: function (action) {
            gridCar.reload();
        }
    });
}



function quickSearch(e){
	var  p = null;
	if(e == 1){//我接待的车
		p ={
			mtAdvisorId:currUserId
		};
	}
	if(e == 2){//所有车辆

	}
	if(e == 3){
		p = {
			carNo:tcarNo_ctrl.value
		};
	}
	gridCar.load({params:p,token:token});
}

function WindowComplianDetail(){
	nui.open({
		url: webBaseUrl + "manage/complainDetail.jsp?token="+token,
		title:"投诉登记",
		height:"500px",
		width:"750px",
		onload:function(){
			//var iframe = this.getIFrameEl();
			//iframe.contentWindow.SetData("th");
		},
		ondestroy:function(action){
			if (action == "ok") {
				//var iframe = this.getIFrameEl();
				//var childdata = iframe.contentWindow.GetFormData();
				//savepartOutRtn(row,childdata);
                //savePartOut();     //如果点击“确定”
                //CloseWindow("close");
            }
        }

    });
}


function WindowrepairHistory(){
	var row = gridCar.getSelected();
	var params = {
			carId : row.carId,
			guestId : row.guestId
	};
	if(row.id){
		doShowCarInfo(params);
	}
}