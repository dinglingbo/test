/**
* Created by Administrator on 2018/10/23.
*/
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/"; 
var gridCarUrl = apiPath + crmApi+"/com.hsapi.crm.svr.visit.queryCrmVisitMainList.biz.ext";

var gridCar = null;
var tcarNo_ctrl = null;
var slost_ctrl = null;
var elost_ctrl = null;
var form = null;
var levelList = []; 
var levelHash = [];
var billTypeIdList = [{name:"综合"},{name:"检查"},{name:"洗美"},{name:"销售"},{name:"理赔"},{name:"退货"}];
$(document).ready(function(){
	form = new nui.Form("#toolbar1");   
	tcarNo_ctrl = nui.get("tcarNo");
	slost_ctrl = nui.get("slost");
	elost_ctrl = nui.get("elost");




	
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
        

        if ((keyCode == 13)) { // ESC
        	quickSearch(0);
        }

    };


    initGuestType("level", function (data) {
        levelList = nui.get("level").getData();
        levelList.forEach(function(v) {
	        levelHash[v.id] = v;
	    });//客户级别 
    });

    gridCar.on("drawcell", function (e) { 
        var uid = e.record._uid;
    	if(e.field == "serviceCode"){
    		e.cellHtml ='<a href="##" onclick="openOrderDetail('+"'"+e.record.serviceId+"'"+')">'+e.record.serviceCode+'</a>';
    	}else if (e.field == "serviceTypeName") {
            e.cellHtml = retSerTypeStyle(e.cellHtml);
        }else if (e.field == "tgrade") {
            e.cellHtml = (levelHash[e.value] == undefined ? "" : levelHash[e.value].name);
        }else if (e.field == "billTypeId") {
        	e.cellHtml = billTypeIdList[e.value].name; 
        }else if(e.field == "guestMobile"){
            var value = e.value
            value = "" + value;
            var reg=/(\d{3})\d{4}(\d{4})/;
            value = value.replace(reg, "$1****$2");
            if(e.value){
                if(e.record.wechatOpenId){
                     e.cellHtml =  '<a href="javascript:bindWechat(\'' + uid + '\')" id="showA" ><span id="wechatTag" class="fa fa-wechat fa-lg"></span></a>&nbsp;'+value;
                     /*e.cellHtml = "<span id='wechatTag' class='fa fa-wechat fa-lg'></span>"+value;*/
                }else{
                    e.cellHtml =  '<a href="javascript:bindWechat(\'' + uid + '\')" id="showA1" ><span id="wechatTag1" class="fa fa-wechat fa-lg"></span></a>&nbsp;'+value;
                }
            }else{
                e.cellHtml="";
            }
            
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
			url: webPath + contextPath + "/manage/visitMgr/visitLoseMainDetail.jsp?token="+ token,
			title: "电话回访", 
			width: 770, height: 390,
			onload: function () {
				var iframe = this.getIFrameEl(); 
				iframe.contentWindow.setData(row);
			},
			ondestroy: function (action) {
				gridCar.reload();
			}
		});
	}else{
		showMsg("请选中一条数据","W");
	}
}



function quickSearch(e){

	var  p = {};
	var queryname = "今日计划跟进客户";
	if(e == 0){//车牌号
		p = {
			carNo:tcarNo_ctrl.value,
			sLeaveDays:slost_ctrl.value,
            eLeaveDays: elost_ctrl.value,
            level:nui.get("level").value
		};
	}
	if(e == 1){//今日计划跟进客户
		slost_ctrl.setValue(0);
		elost_ctrl.setValue(120);
		queryname = "今日计划跟进客户";
	}
	if(e == 2){//新流失客户
		slost_ctrl.setValue(120);
		elost_ctrl.setValue(180);
		queryname = "新流失客户";
	}
	if(e == 3){//流失超过半年客户
		slost_ctrl.setValue(180);
		elost_ctrl.setValue(360);
		queryname = "流失超过半年客户";
	}
	if(e == 4){//流失超过一年的客户
		slost_ctrl.setValue(360);
		elost_ctrl.setValue(null);
		queryname = "流失超过一年的客户";
	}
	if(e == 5){//所有流失的客户
		slost_ctrl.setValue(0);
		elost_ctrl.setValue(null);
		queryname = "所有流失的客户";
	}
	
	
    var menunamestatus = nui.get("menunamestatus");
    menunamestatus.setText(queryname);
	
	p.type = 2;//流失回访
	p.sLeaveDays = slost_ctrl.value;
	p.eLeaveDays = elost_ctrl.value;
	p.carNo = tcarNo_ctrl.value;
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
		item.url = webBaseUrl+  "com.hsweb.repair.DataBase.orderDetail.flow";
		item.iconCls = "fa fa-cog";
		window.parent.activeTabAndInit(item,data);
	}else{
		showMsg("请选中一条数据","W");
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
    row.serviceType = 4;//客户回访
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


function sendWcText(){//发送微信消息
    // var row = gridCar.getSelected();
    // if (!row) {
    // showMsg("请选中一条数据","W");
    // return;
    // }
    // // var tit = "发送微信[" + row.guestName + '/' + row.mobile + '/' + row.carModel + ']';
    // var tit = "发送微信";
    // nui.open({
    //     url: webPath + contextPath  + "/com.hsweb.crm.manage.sWcInfoRemind.flow?token="+token,
    //     title: tit, width: 800, height: 350,
    //     onload: function () {
    //     var iframe = this.getIFrameEl();
    //     iframe.contentWindow.setData(row);
    // },
    // ondestroy: function (action) {
    //         //重新加载 
    //         // query(tab);
    //         change();
    //     }
    // });
}


function sellPoint() {//销售机会
    var row = gridCar.getSelected();
	if(row){
		nui.open({
			url: webPath + contextPath + "/manage/visitMgr/cellPoint.jsp?token="+ token,
			title: "销售机会", 
			width: 700, height: 300,
			onload: function () {
				var iframe = this.getIFrameEl(); 
				iframe.contentWindow.setData(row);
			},
			ondestroy: function (action) {
				// gridCar.reload();
			}
		});
	}else{
		showMsg("请选中一条数据","W");
	}
}