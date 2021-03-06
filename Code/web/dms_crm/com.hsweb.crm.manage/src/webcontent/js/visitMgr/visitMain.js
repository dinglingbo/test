/**
* Created by Administrator on 2018/10/23.
*/
var webBaseUrl = webPath + contextPath + "/";
var gridCarUrl = apiPath + crmApi+"/com.hsapi.crm.svr.visit.queryCrmVisitMainList.biz.ext";
var gridCar = null;
var mainId_ctrl = null;
var visitMode_ctrl = null;
var tcarNo_ctrl = null;
var memList = []; 
var visitManEl = null;
var visitIdEl = null;
var hash = {}; 
var billTypeIdList = [{ id: 0, name: "综合开单" }, { id: 1, name: "检查开单" }, { id: 2, name: "洗美开单" }, { id: 3, name: "销售开单" }, { id: 4, name: "理赔开单" }, { id: 5, name: "退货开单" }, { id: 6, name: "波箱开单" }];
var dataTypeIdList = [{},{id:1,name:"第一次回访"},{id:2,name:"第二次回访"},{id:3,name:"第三次回访"}]; 
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
var levelList = []; 
var levelHash = [];

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
    
    gridCar.on("select", function (e) {
		var params = {
			carNo:e.record.carNo,
            //guestId: e.record.contactorId,
			guestSource: 0,
			//serviceType:3,
            token:token
        };
        loadVisitHis(params);

        if (e.record.wechatOpenId) {
            nui.get("wcBtn1").enable();
            nui.get("wcBtn2").enable();
            nui.get("wcBtn3").enable();
        } else {
            nui.get("wcBtn1").disable();
            nui.get("wcBtn2").disable();
            nui.get("wcBtn3").disable(); 
        }

        $("#showMonile").show();
        document.getElementById("mobileText").innerHTML = e.record.guestMobile;
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
    		servieTypeHash[v.id]= v;
    	});
    });

    initGuestType("level", function (data) {
        levelList = nui.get("level").getData();
        levelList.forEach(function(v) {
	        levelHash[v.id] = v;
	    });//客户级别 
	});
	
	initMember("mtAdvisorId",function(){
		nui.get('mtAdvisorId').setValue(currEmpId);
	});

    gridCar.on("drawcell", function (e) { 
        var uid = e.record._uid;
    	if (e.field == "status") {
    		e.cellHtml = statusHash[e.value];
    	}else if (e.field == "carBrandId") {
    		if (brandHash && brandHash[e.value]) {
    			e.cellHtml = brandHash[e.value].name;
    		}
    	}else if (e.field == "billTypeId") {
        	e.cellHtml = billTypeIdList[e.value].name; 
        } else if (e.field == "dataType") {
            if (e.value) {
                e.cellHtml = dataTypeIdList[e.value].name; 
            }
        }else if (e.field == "tgrade") {
            e.cellHtml = (levelHash[e.value] == undefined ? "" : levelHash[e.value].name);
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
    	}else if (e.field == "serviceTypeName") {
            e.cellHtml = retSerTypeStyle(e.cellHtml);
        }else if(e.field == "serviceCode"){
    		e.cellHtml ='<a href="##" onclick="openOrderDetail('+"'"+e.record.serviceId+"'"+')">'+e.record.serviceCode+'</a>';
    	}else if(e.field == "carNo"){
    		e.cellHtml ='<a href="##" onclick="WindowrepairHistory('+"'"+e.record.carNo+"'"+')">'+e.record.carNo+'</a>';
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

    
    var filter = new HeaderFilter(gridCar, {
        columns: [
            { name: 'billTypeId' },
            { name: 'carModel' },
            { name: 'guestFullName' },
            { name: 'tgrade' },
            { name: 'dataType' },
            { name: 'mtAdvisor' }
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
        		case "billTypeId" :
        			var arr = [];
        			for (var i in billTypeIdList) {
        			    var o = {};
        			    o.name = billTypeIdList[i].name;
        			    o.id = billTypeIdList[i].id;
        			    arr.push(o);
        			}
        			value = arr;
        			break;			
        		case "dataType" :
        			var arr = [];
        			for (var i in dataTypeIdList) {
        			    var o = {};
        			    o.name = dataTypeIdList[i].name;
        			    o.id = dataTypeIdList[i].id;
        			    arr.push(o);
        			}
        			value = arr;
        			break;		
        		case "tgrade" :
        			var arr = [];
        			for (var i in levelHash) {
        			    var o = {};
        			    o.name = levelHash[i].name;
        			    o.id = levelHash[i].id;
        			    arr.push(o);
        			}
        			value = arr;
        			break;	
        	}
        	return value;
        }
    });
    
});



function mtAdvisorChanged(e){
	var sel = e.selected;
	mtAdvisorIdEl.setValue(sel.empId);

}

function SetData(){
	var row = gridCar.getSelected();
	row.guestId = row.contactorId;//(回访历史表 guestId 存联系人id)
	row.serviceType = 3;//客户回访
    row.guestSource = 0;//系统客户
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
		showMsg("请选中一条数据","W");
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
            carNo: tcarNo_ctrl.value,
			mobile: nui.get("mobile").value,
			mtAdvisorId:nui.get("mtAdvisorId").value
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
        guestId: row.guestId,
        contactorId:row.contactorId
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
    row.serviceType = 3;//客户回访
    row.guestId = row.contactorId;//(回访历史表 guestId 存联系人id)
    row.guestSource = 0;//系统客户
	nui.open({
		url: webPath + contextPath  + "/com.hsweb.crm.manage.sendInfo.flow?token="+token,
		title: "发送短信", width: 655, height: 280,
		onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(row);
		},
		ondestroy: function (action) {
            // 重新加载
            gridCar.reload();
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
    //         // gridCar.reload();
    //         change();
    //     }
    // });
}


function sendWechatPicInfo(){//微信图文 回访
	var row = gridCar.getSelected();
	if(row){
		// mini.open({
		// 	url: webPath + contextPath + "/manage/visitMgr/visitMainDetail.jsp?token="+ token,
		// 	title: "电话回访", 
		// 	width: 680, height: 330,
		// 	onload: function () {
		// 		var iframe = this.getIFrameEl(); 
		// 		iframe.contentWindow.setData(row);
		// 	},
		// 	ondestroy: function (action) {
		// 		gridCar.reload();
		// 	}
		// });
	}else{
		showMsg("请选中一条数据","W");
	}
}

function sendWcCoupon() {
    var row = gridCar.getSelected();
    row.userNickname = row.guestFullName;
    row.userMarke = row.wechatServiceId;
    row.storeName = currOrgName;
	row.userOpid = row.wechatOpenId;
	row.guestId = row.contactorId;//(回访历史表 guestId 存联系人id)
	row.serviceType = 3;//客户回访
    row.guestSource = 0;//系统客户
    var list = [];
    list.push(row);

    nui.open({                        
        url: webPath + contextPath  + "/manage/sendWechatWindow/sWcInfoCoupon.jsp?token="+token,
        title: "发送卡券", width: 800, height: 350,
        onload: function () {
        var iframe = this.getIFrameEl();
        iframe.contentWindow.setData(list);
    },
    ondestroy: function (action) {
            //重新加载
            //query(tab);
    	gridCar.reload();
        }
    });
}




function sellPoint() {//销售机会
    var row = gridCar.getSelected();
	if(row){
		nui.open({
			url: webPath + contextPath + "/manage/visitMgr/cellPoint.jsp?token="+ token,
			title: "销售机会", 
			width: 800, height: 300,
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


function moreQuery(){

    //nui.get("carNo").setValue(null);
    nui.open({
        url: webPath + contextPath + "/manage/visitMgr/visitSearchDetail.jsp?token="+ token,
        title: "更多查询", width: 520, height: 380,
        //allowResize:false,
        onload: function () { 
            var iframe = this.getIFrameEl();
            //var data = { action: "edit", id: row.id };
            //iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
            if(action == "ok"){
                
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
				//dgGrid.load({p:data,token:token});
				data.type = 1;//客户回访
				data.carNo = tcarNo_ctrl.value;
				data.mobile = nui.get("mobile").value;
				data.mtAdvisorId = nui.get("mtAdvisorId").value;
				gridCar.load({params:data,token:token});
            }
        }
    });
}
