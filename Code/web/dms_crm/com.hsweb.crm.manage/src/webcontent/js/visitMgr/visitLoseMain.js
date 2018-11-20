/**
* Created by Administrator on 2018/10/23.
*/
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var gridCarUrl = baseUrl+"com.hsapi.crm.svr.visit.queryLoseGuestByDay.biz.ext";

var gridCar = null;
var tcarNo_ctrl = null;
var loseParam_ctrl = null;

$(document).ready(function(){

	tcarNo_ctrl = nui.get("tcarNo");
	loseParam_ctrl = nui.get("loseParam");
	setLoseParams();



	
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
        

        if ((keyCode == 13)) { // ESC
        	quickSearch(0);
        }

    }

});

function mtAdvisorChanged(e){
	var sel = e.selected;
	mtAdvisorIdEl.setValue(sel.empId);

}


function SetData(rowData){ 
    mini.open({
        url: webPath + contextPath + "/manage/visitMgr/visitLoseMainDetail.jsp?token="+ token,
        title: "回访信息", 
        width: 750, height: 400,
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
	var lparam = loseParam_ctrl.value;
	var  p = null;
	if(e == 0){//车牌号
		p = {
			carNo:tcarNo_ctrl.value,
			//sloseDay:120,
		};
	}
	if(e == 1){//今日计划跟进客户
		p ={
			loseDay:120
		};
	}
	if(e == 2){//新流失客户
		p ={
			sloseDay:120,
			eloseDay:180
		};
	}
	if(e == 3){//流失超过半年客户
		p = {
			sloseDay:182
		};
	}
		if(e == 4){//流失超过一年的客户
			p = {
				sloseDay:365
			};
		}
		gridCar.load({params:p,token:token});
	}

	function WindowComplianDetail(){
		nui.open({
			url: webBaseUrl + "manage/complainDetail.jsp?token="+token,
			title:"投诉登记",
			height:"500px",
			width:"650px",
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

	function setLoseParams(){
		nui.ajax({
			url:baseUrl + "com.hsapi.crm.svr.visit.queryRemindParams.biz.ext",
			type:"post",
			async: false,
			data:{
				token:token
			},
			success:function(text){
				if(text.errCode == "S"){
					var tdata = text.data;
					if(tdata.length == 1){
						loseParam_ctrl.setValue(tdata[0].param9);
					}else if(tdata.length > 1 ){
						showMsg("未设置流失客户相关参数！","W");
					}else{}
				}

			}
		});
	}