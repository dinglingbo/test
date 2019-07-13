/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.query.getRpsItemByServiceId.biz.ext";
var partGridUrl = baseUrl + "com.hsapi.repair.repairService.query.getRpsPartByServiceId.biz.ext";
var queryUrl = baseUrl + "com.hsapi.repair.repairService.crud.queryOurCartReport.biz.ext";

var itemGrid = null;
var partGrid = null;
var fserviceId = 0;
var form = null;
var statusHash = {"0":"草稿","1":"施工中","2":"已完工"};
$(document).ready(function (){
    itemGrid = nui.get("itemGrid");
    partGrid = nui.get("partGrid");
    itemGrid.setUrl(itemGridUrl);
    partGrid.setUrl(partGridUrl);
    form = new nui.Form("#basicInfoForm");
    partGrid.on("drawcell",function(e){
        var grid = e.sender;
        var record = e.record;

        switch (e.field) {
            case "notPickQty":
                var qty = record.qty||0;
                var pickQty = record.pickQty||0;
                var notPickQty = qty - pickQty;
                e.cellHtml = notPickQty;
                break;
            default:
                break;
        }
    });
    itemGrid.on("drawcell",function(e){
        var grid = e.sender;
        var record = e.record;
        switch (e.field) {
            case "status":
                e.cellHtml = statusHash[e.value];
                break;
            default:
                break;
        }
    });
    partGrid.focus();
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
     };

});
function setData(params){
    var serviceId = params.serviceId||0;
    fserviceId = serviceId;
    itemGrid.load({
        token:token,
        serviceId:serviceId
    });

    partGrid.load({
        token:token,
        serviceId:serviceId
    }
    ,function(){
        var rows = partGrid.findRows(function(row){
            var qty = row.qty||0;
            var pickQty = row.pickQty||0;
            var notPickQty = qty - pickQty;
            if(notPickQty>0){
                return true;
            }
        });
        if(rows && rows.length>0){
            document.getElementById("checkDescribe").innerHTML = "本工单有配件未出库";
        }else{
            document.getElementById("checkDescribe").innerHTML = "";
        }
    });
    getDrawOutReport(serviceId);
}
function getDrawOutReport(serviceId){
	var json = nui.encode({
		"serviceId":serviceId,
		token : token
	});
  nui.ajax({
	url : queryUrl,
	type : 'POST',
	data : json,
	cache : false,
	contentType : 'text/json',
	success : function(text) {
		var returnJson = nui.decode(text);
		var outCar = returnJson.main;
		if(outCar){
			var outCarData = {};
			outCarData.content = outCar.drawOutReport;
			form.setData(outCarData);
		}
	}
});	
} 
var resultData = {};
function finish(){	
	var itemData = itemGrid.getData();
	var falg = false;
	for(var i = 0;i<itemData.length;i++){
		if(itemData[i].workers == "" || itemData[i].workers == null){
			falg = true ;
			break;
		}		
	}				
	if(falg){	
	  nui.confirm("工单有未派工项目，是否确定完工", "友情提示",function(action){
	       if(action == "ok"){
	    	   var drawOutReport = form.getData().content;
	    	    nui.mask({
	    	        el: document.body,
	    	        cls: 'mini-mask-loading',
	    	        html: '处理中...'
	    	    });
	    	    var params = {
	    	        data:{
	    	            id:fserviceId||0,
	    	            "drawOutReport":drawOutReport
	    	        }
	    	    };
	    	    svrRepairAudit(params, function(data){
	    	        data = data||{};
	    	        var errCode = data.errCode||"";
	    	        var errMsg = data.errMsg||"";
	    	        var flag = data.flag||"";
	    	        if(errCode == 'S'){
	    	            var dataHash = data.data||{};
	    	            resultData = dataHash.maintain||{};
	    	            resultData.action = 'ok';
	    	            showMsg("操作成功","S");
	    	            if(nui.get("completionWeChat").getValue()=="true"){
	    		            completionWeChat(resultData);//发送微信
	    	            }
	    	            CloseWindow('ok');
	    	        }else{
	    	        	if(data.errSign==2){
	    	        		//pc提醒
	    					var carNo = data.data.maintain.carNo||"";
	    					var carModel = data.data.maintain.carModel||"";
	    					var serviceCode = data.data.maintain.serviceCode||"";
	    					var content = "您好,"+carNo + "("+carModel+"),请您审核 !";
	    					var msg = {
	    						title: "配件待审核",
	    						serviceCode: serviceCode,
	    						serviceId :data.data.maintain.id,
	    						remindType : 5,
	    						url:webPath + contextPath + "/repair/RepairBusiness/Reception/repairOutDetail.jsp",
	    						urlId : "checkDetail",
	    						content: content,
	    						sender: currUserName,
	    						sendDate: now.Format("yyyy-MM-dd HH:mm:ss")
	    					};
	    					getUserInfo(null, 1, function(text){
	    						var memberList = text.data || [];
	    						for(var i=0;i<memberList.length;i++){
	    							member = memberList[i];
	    							var userId = member.imCode;
	    							var params = {
	    								type: 3,
	    								cmd: 10,
	    								group: null,
	    								sender: "0",
	    								receiver: userId.toString(),
	    								msg: nui.encode(msg)
	    							};
	    							sendNoticeMsg(parent.socket,params);
	    						}
	    					});
	    	        	}else if(data.errSign==1){
	    	        		//pc提醒
	    					var carNo = data.data.maintain.carNo||"";
	    					var carModel = data.data.maintain.carModel||"";
	    					var serviceCode = data.data.maintain.serviceCode||"";
	    					var content = "您好,"+carNo + "("+carModel+"),请您领料 !";
	    					var msg = {
	    						title: "配件待领料",
	    						serviceCode: serviceCode,
	    						serviceId :data.data.maintain.id,
	    						remindType : 5,
	    						url:webPath + contextPath + "/repair/RepairBusiness/Reception/repairOutDetail.jsp",
	    						urlId : "checkDetail",
	    						content: content,
	    						sender: currUserName,
	    						sendDate: now.Format("yyyy-MM-dd HH:mm:ss")
	    					};
	    					getUserInfo(null, 1, function(text){
	    						var memberList = text.data || [];
	    						for(var i=0;i<memberList.length;i++){
	    							member = memberList[i];
	    							var userId = member.imCode;
	    							var params = {
	    								type: 3,
	    								cmd: 10,
	    								group: null,
	    								sender: "0",
	    								receiver: userId.toString(),
	    								msg: nui.encode(msg)
	    							};
	    							sendNoticeMsg(parent.socket,params);
	    						}
	    					});
	    	        	}
	    	        	showMsg(errMsg||"操作失败","E");
	    	            //resultData.action = 'cancel';
	    	            //CloseWindow("cancel");
	    	        }
	    	        nui.unmask(document.body);
	    	    }, function(){
	    	        nui.unmask(document.body);
	    	    });
	     }else {
	    	 onCancel();
		 }
		 });		
	}else{
		var drawOutReport = form.getData().content;
	    nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '处理中...'
	    });
	    var params = {
	        data:{
	            id:fserviceId||0,
	            "drawOutReport":drawOutReport
	        }
	    };
	    svrRepairAudit(params, function(data){
	        data = data||{};
	        var errCode = data.errCode||"";
	        var errMsg = data.errMsg||"";
	        var flag = data.flag||"";
	        if(errCode == 'S'){
	            var dataHash = data.data||{};
	            resultData = dataHash.maintain||{};
	            resultData.action = 'ok';
	            showMsg("操作成功","S");
	            if(nui.get("completionWeChat").getValue()=="true"){
		            completionWeChat(resultData);//发送微信
	            }
	            CloseWindow('ok');
	        }else{
	        	if(data.errSign==2){
	        		//pc提醒
					var carNo = data.data.maintain.carNo||"";
					var carModel = data.data.maintain.carModel||"";
					var serviceCode = data.data.maintain.serviceCode||"";
					var content = "您好,"+carNo + "("+carModel+"),请您审核 !";
					var msg = {
						title: "配件待审核",
						serviceCode: serviceCode,
						serviceId :data.data.maintain.id,
						remindType : 5,
						url:webPath + contextPath + "/repair/RepairBusiness/Reception/repairOutDetail.jsp",
						urlId : "checkDetail",
						content: content,
						sender: currUserName,
						sendDate: now.Format("yyyy-MM-dd HH:mm:ss")
					};
					getUserInfo(null, 1, function(text){
						var memberList = text.data || [];
						for(var i=0;i<memberList.length;i++){
							member = memberList[i];
							var userId = member.imCode;
							var params = {
								type: 3,
								cmd: 10,
								group: null,
								sender: "0",
								receiver: userId.toString(),
								msg: nui.encode(msg)
							};
							sendNoticeMsg(parent.socket,params);
						}
					});
	        	}else if(data.errSign==1){
	        		//pc提醒
					var carNo = data.data.maintain.carNo||"";
					var carModel = data.data.maintain.carModel||"";
					var serviceCode = data.data.maintain.serviceCode||"";
					var content = "您好,"+carNo + "("+carModel+"),请您领料 !";
					var msg = {
						title: "配件待领料",
						serviceCode: serviceCode,
						serviceId :data.data.maintain.id,
						remindType : 5,
						url:webPath + contextPath + "/repair/RepairBusiness/Reception/repairOutDetail.jsp",
						urlId : "checkDetail",
						content: content,
						sender: currUserName,
						sendDate: now.Format("yyyy-MM-dd HH:mm:ss")
					};
					getUserInfo(null, 1, function(text){
						var memberList = text.data || [];
						for(var i=0;i<memberList.length;i++){
							member = memberList[i];
							var userId = member.imCode;
							var params = {
								type: 3,
								cmd: 10,
								group: null,
								sender: "0",
								receiver: userId.toString(),
								msg: nui.encode(msg)
							};
							sendNoticeMsg(parent.socket,params);
						}
					});
	        	}
	        	showMsg(errMsg||"操作失败","W");
	            //resultData.action = 'cancel';
	            //CloseWindow("cancel");
	        }
	        nui.unmask(document.body);
	    }, function(){
	        nui.unmask(document.body);
	    });
	}
}
function getRtnData(){
    return resultData;
}

function SelectReport(){
	nui.open({
        url: webPath + contextPath +"/repair/DataBase/OutCar/OutCarReport.jsp?token="+token,
        title: "出车报告", width: "50%", height: "60%", 
        onload: function () {
           /* var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(params);*/
        },
        ondestroy: function (action) {
			var iframe = this.getIFrameEl();
			var data = iframe.contentWindow.getData();
			form.setData(data);
        }
    });
}



//关闭窗口
function CloseWindow(action) {
    // if (action == "close" && form.isChanged()) {
    //     if (confirm("数据被修改了，是否先保存？")) {
    //         saveData();
    //     }
    // }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}

 

