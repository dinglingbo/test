/**
* Created by Administrator on 2018/10/23.
*/
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var gridCarUrl = apiPath + crmApi+"/com.hsapi.crm.svr.visit.queryCrmVisitMainList.biz.ext";

var gridCar = null;
var mainId_ctrl = null;
var visitMode_ctrl = null;
var tcarNo_ctrl = null;
var memList = [];
var visitManEl = null;
var visitIdEl = null;
var hash = {};

var statusHash = {
	"0" : "报价",
	"1" : "施工",
	"2" : "完工",
	"3" : "待结算",
	"4" : "已结算"
};
var brandHash = [];
var brandList = [];
var servieTypeHash = [];
var servieTypeList = [];

$(document).ready(function(){
	visitManEl = nui.get("visitMan");
	visitIdEl = nui.get("visitId"); 
	tcarNo_ctrl = nui.get("tcarNo");

	gridCar = nui.get("gridCar");
	gridCar.setUrl(gridCarUrl);
	quickSearch(2);

	gridCar.on("rowdblclick",function(e){
		var record = e.record;
		SetData();
	});
	
	document.onkeyup = function(event) {
		var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // Enter
        	quickSearch(3);
        }
    };

    initCarBrand("carBrandId",function() {
    	brandList = nui.get("carBrandId").getData();
    	brandList.forEach(function(v) {
    		brandHash[v.id] = v;
    	});
    });
    initServiceType("serviceTypeId",function() {
    	servieTypeList = nui.get("serviceTypeId").getData();
    	servieTypeList.forEach(function(v) {
    		servieTypeHash[v.id] = v;
    	});
    });
    gridCar.on("drawcell", function (e) { 
    	if (e.field == "status") {
    		e.cellHtml = statusHash[e.value];
    	}else if (e.field == "carBrandId") {
    		if (brandHash && brandHash[e.value]) {
    			e.cellHtml = brandHash[e.value].name;
    		}
    	}else if (e.field == "serviceTypeId") {
    		if (servieTypeHash && servieTypeHash[e.value]) {
    			e.cellHtml = servieTypeHash[e.value].name;
    		}
    	}else if(e.field == "isSettle"){
    		if(e.value == 1){
    			e.cellHtml = "已结算";
    		}else{
    			e.cellHtml = "未结算";
    		}
    	}else if(e.field == "serviceCode"){
    		e.cellHtml ='<a href="##" onclick="openOrderDetail('+"'"+e.record.serviceId+"'"+')">'+e.record.serviceCode+'</a>';
    	}
    });

});

function mtAdvisorChanged(e){
	var sel = e.selected;
	mtAdvisorIdEl.setValue(sel.empId);

}

function SetData(){
	var row = gridCar.getSelected();
	if(row){
		mini.open({
			url: webPath + contextPath + "/manage/visitMgr/visitMainDetail.jsp?token="+ token,
			title: "电话回访", 
			width: 680, height: 330,
			onload: function () {
				var iframe = this.getIFrameEl(); 
				iframe.contentWindow.setData(row);
			},
			ondestroy: function (action) {
				gridCar.reload();
			}
		});
	}else{
		showMsg("请选择一条记录","W");
	}
}



function quickSearch(e){
	var  p = {};
	if(e == 1){//我接待的车
		p ={
			mtAdvisorId:currEmpId
		};
	}
	if(e == 2){//所有车辆

	}
	if(e == 3){
		p = {
			carNo:tcarNo_ctrl.value
		};
	}
	p.type = 1;//客户回访
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
		carNo : row.carNo,
		guestId : row.guestId
	};
	if(row.id){
		doShowCarInfo(params);
	}
}


function openOrderDetail(serviceId){
	var row = gridCar.getSelected();
	var data = {};
	data.id = row.serviceId;
	if(serviceId){
		data.id = serviceId;
	}

	if(data.id){
		var item={};
		item.id = "11111";
		item.text = "工单详情页";
		item.url =webBaseUrl+  "com.hsweb.repair.DataBase.orderDetail.flow";
		item.iconCls = "fa fa-cog";
		window.parent.activeTabAndInit(item,data);
	}
}



function sendInfo(){
	var row = gridCar.getSelected();
	if (row == undefined) {
		showMsg("请选中一条数据","W");
		return;
    }
    if (!row.guestMobile) {
		showMsg("该数据没有手机号码，无法发送短信","W");
		return;
    }
    row.mobile = row.guestMobile;
    row.serviceType = 3;//客户回访
	nui.open({
		url: webPath + contextPath  + "/com.hsweb.crm.manage.sendInfo.flow?token="+token,
		title: "发送短信", width: 655, height: 386,
		onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(row);
		},
		ondestroy: function (action) {
            //重新加载
            //query(tab);
        }
    });

}