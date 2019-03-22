/**
* Created by Administrator on 2018/10/23.
*/
var baseUrl = apiPath +repairApi + "/";
var webBaseUrl = webPath + contextPath + "/";
var sysUrl =apiPath +sysApi+"/";
var gridCarUrl = baseUrl+"com.hsapi.repair.repairService.query.queryMainRemind.biz.ext";

var gridCar = null;
var tcarNo_ctrl = null;
var tmobileEl = null;
var serviceType = 5;//保养提醒
var hash = {};

$(document).ready(function(){
	tcarNo_ctrl = nui.get("tcarNo");
	tmobileEl=nui.get('tmobile');
	gridCar = nui.get("gridCar");
	gridCar.setUrl(gridCarUrl);


	gridCar.on("rowdblclick",function(e){
		var record = e.record;
		SetData(record);
	});
	
    gridCar.on("drawcell", function (e) { 
    	var uid = e.record._uid;
        if(e.field == "serviceCode"){
            e.cellHtml ='<a href="##" onclick="openOrderDetail('+"'"+e.record.serviceId+"'"+')">'+e.record.serviceCode+'</a>';
        }else if(e.field == "mobile"){
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


	document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        if ((keyCode == 13)) { // Enter
        	onSearch();
        }

    };
    onSearch();
    
    var filter = new HeaderFilter(gridCar, {
        columns: [
            { name: 'carModel' },
            { name: 'guestName' },
            { name: 'preAdvisorName' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	
        }
    });
});

function remind() {
    var row = gridCar.getSelected();
    if(row){
        SetData(row);
    }
}



function setInitData(params) {
    onSearch();
}

function SetData(rowData) {
    rowData.serviceType = serviceType;
    mini.open({
        url: webPath + contextPath + "/manage/maintainRemind/maintainRemMainDetail.jsp?token="+ token,
        title: "提醒信息", 
        width: 600, height: 300,
        onload: function () {
            var iframe = this.getIFrameEl(); 
            iframe.contentWindow.setData(rowData);
        },
        ondestroy: function (action) {
        	if(action == "ok"){
             gridCar.removeRow (rowData, true);
         }
     }
 });
}




function quickSearch(e){
	var  p = null;
	if(e == 1){//我接待的车
		p ={
			mtAdvisorId:currEmpId
		};
	}
	if(e == 2){//所有车辆

	}
	if(e == 3){
		p = {
			carNo:tcarNo_ctrl.value,
			mobile :tmobileEl.value
		};
	}
	gridCar.load({params:p,token:token});
}

function onSearch(){
	var params={};
	if(tcarNo_ctrl.value ||tmobileEl.value ){
		quickSearch(3);
	}
	else{		
		doSearch(params);
	}
}

function doSearch(params){
	params.isNeedRemind=1;
	params.remindStatus=0;
	gridCar.load({params:params,token:token});
}


function addBooking() {
    var row = gridCar.getSelected();
    row.contactorName=row.guestName;
    row.contactorTel=row.mobile;
    row.carSeriesId=row.carModelId;
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + repairDomain + "/repair/RepairBusiness/BookingManagement/BookingManagementEdit.jsp?token="+token,
        title: "预约", width: 655, height: 300,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { action: "edit", data: row };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
        	//重新加载
        }
    });
}

function checkMtRecord() {
    var row = gridCar.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + repairDomain + "/manage/maintainRemind/checkMtRemind.jsp?token="+token,
        title: "查看保养提醒", width: 900, height: 400,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { 
                guestId: row.conId,
                careType : 1
          };
          iframe.contentWindow.SetData(param);
      },
      ondestroy: function (action) {
        	//重新加载
        }
    });
}

function remindDetail() {
    var row = gridCar.getSelected();
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + crmDomain + "/basic/remindDetail.jsp?token="+token,
        title: "跟踪明细", width: 700, height: 386,
        onload: function () {
            var iframe = this.getIFrameEl();
            var param = { 
              guestId: row.guestId,
              careType :1 
          };
          iframe.contentWindow.SetData(param);
      },
      ondestroy: function (action) {
        	//重新加载
        }
    });
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
    row.serviceType = serviceType;
    if (row == undefined) {
        showMsg("请选中一条数据","W");
        return;
    }
    nui.open({
        url: webPath + contextPath  + "/com.hsweb.crm.manage.sendInfo.flow?token="+token,
        title: "发送短信", width: 655, height: 280,
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


function addRow() {
    nui.open({
        url: webPath + contextPath + "/repair/RepairBusiness/BookingManagement/BookingManagementEdit.jsp?token="+token,
        title: "新增预约", width: 655, height: 400,
        onload: function () {
            var iframe = this.getIFrameEl();
            var data = {};
            data.mtAdvisorId = currEmpId;
            data.mtAdvisor = currUserName;
            var param = { action: "add", data: data };
            iframe.contentWindow.SetData(param);
        },
        ondestroy: function (action) {
            dgGrid.reload();
        }
    });
}


function sendWcText(){//发送微信消息
    var row = gridCar.getSelected();
    row.serviceType = serviceType;
    if (row == undefined) {
    showMsg("请选中一条数据","W");
    return;
    }
    // var tit = "发送微信[" + row.guestName + '/' + row.mobile + '/' + row.carModel + ']';
    var tit = "发送微信";
    nui.open({
        url: webPath + contextPath  + "/com.hsweb.crm.manage.sWcInfoRemind.flow?token="+token,
        title: tit, width: 800, height: 350,
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


function bindWechat(row_uid){
	// var row = upGrid.getRowByUID(row_uid);
	// //var guestId = data.guestId;
	// if(!row.guestId){
	// 	showMsg("客户为新客户，请新增客户信息!","W");
	// 	return;
	// }
	// nui.open({
    //     url:binUrl,
    //     title:"绑定联系人",
    //     width:750, 
    //     height:300,
    //     onload:function(){
    //     	var iframe = this.getIFrameEl();
    //         var params = {};	
    //         params.guestId=row.guestId;
    //         params.carNo = row.carNo;
    //         iframe.contentWindow.setData(params);
    //     },
    //     ondestroy:function(action)
    //     {
    //     	var iframe = this.getIFrameEl();
    //         var params = {};	
    //         var params = iframe.contentWindow.getData();
    //         if(params){
    //         	if(params.success && params.success==1){
    //         		document.getElementById("showA").style.display = "";
    //             	document.getElementById("showA1").style.display='none';
    //         	}
    //         }
        	
    //     }
    // });
}
