var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var maintainAll = {};
var fserviceId = null;
$(document).ready(function (){
	mainGrid = nui.get("mainGrid");
});
function setData(params){
	maintainAll = params;
	fserviceId = params.serviceId;
	var getRpsItemPPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsItemPPart.biz.ext";
	var json = nui.encode({
		serviceId:params.serviceId,
		token:token
	});
	 //查找项目下的所有配件
    nui.ajax({
		url : getRpsItemPPartUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.errCode == "S") {
				var ppart = []//接口mml提供的，查询项目下的配件，需要筛选
				for(var i = 0;i<returnJson.data.length;i++){
					if(returnJson.data[i].billItemId!=0){
						ppart.push(returnJson.data[i]);
					}
				}
				mainGrid.setData(ppart);
			} else {
				showMsg(returnJson.errMsg||"查询需要报价失败","E");
		    }
		}
	 });
}

function onCancel(){
	CloseWindow("ok");
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else
        window.close();
}

function setNormal(){
	var data=mainGrid.getData();
	var nrow={noMtType:1};
	var row2={noMtType:0};
	var count=0;
		for(var i=0;i<data.length;i++){
			if(data[i].noMtType==1){
				count++;
			}
		}
		for(var i=0;i<data.length;i++){
			if(count==data.length){
				mainGrid.updateRow(data[i],row2);
			}				
			else{
				mainGrid.updateRow(data[i],nrow);
			}
				
		}
}

function addRemind(){
	var pushInfoUrl = baseUrl + "com.hsapi.repair.repairService.sendWeChat.sAllShoppingSale.biz.ext";
	var saveRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveOffer.biz.ext";
	var updList=mainGrid.getData();
	var num = 0;
	for(var i =0;i<updList.length;i++){
		if(updList[i].noMtType==1){
			num++;
		}
	}
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '消息提醒中...'
    });
	
	nui.ajax({
		url : saveRpsPartUrl,
		type : "post",
		data : {
			serviceId:fserviceId,
			updList:updList,
			type : 0,
			token:token
		},
		success : function(data) {
			if(data.errCode == "S"){
				//pc提醒
				var carNo = maintainAll.carNo;
				var carModel = maintainAll.carModel;
				var serviceCode = maintainAll.serviceCode;
				var content = "您好,"+carNo + "("+carModel+"),请您报价 !";
				var msg = {
					title: "配件待报价",
					serviceCode: serviceCode,
					serviceId :fserviceId,
					remindType : 1,
					url:webPath + contextPath + "/com.hsweb.RepairBusiness.offerMain.flow",
					urlId : 2695,
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
				//推送app微信
				nui.ajax({
					url : pushInfoUrl,
					type : "post",
					data : {
						serviceId:fserviceId,
						partNum:num
					},
					success : function(data) {
						nui.unmask(document.body);
						if(data.errCode == "S"){
							showMsg("提醒成功","S");							
						}else{
							showMsg("提醒失败","E");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						nui.unmask(document.body);
						// nui.alert(jqXHR.responseText);
						console.log(jqXHR.responseText);
						
					}
				});				
			}else{
				showMsg("提醒失败","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.unmask(document.body);
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			
		}
	});

}