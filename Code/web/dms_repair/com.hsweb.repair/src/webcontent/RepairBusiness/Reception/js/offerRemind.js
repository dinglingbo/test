var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;

$(document).ready(function (){
	mainGrid = nui.get("mainGrid");
});
var fserviceId = null;
function setData(params){
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
				showMsg(returnJson.errMsg||"查询上次里程失败","E");
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
	var saveRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.crud.saveRpsPart.biz.ext";
	var updList=mainGrid.getData();
	
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '消息推送中...'
    });
	
	nui.ajax({
		url : saveRpsPartUrl,
		type : "post",
		data : {
			serviceId:fserviceId,
			updList:updList,
			token:token
		},
		success : function(data) {
			nui.unmask(document.body);
			if(data.errCode == "S"){
				nui.ajax({
					url : pushInfoUrl,
					type : "post",
					data : {
						serviceId:fserviceId
					},
					success : function(data) {
						nui.unmask(document.body);
						if(data.errCode == "S"){
							showMsg("推送成功","S");							
						}else{
							showMsg("推送失败","E");
						}
						console.log(data);
					},
					error : function(jqXHR, textStatus, errorThrown) {
						nui.unmask(document.body);
						// nui.alert(jqXHR.responseText);
						console.log(jqXHR.responseText);
						
					}
				});				
			}else{
				showMsg("推送失败","E");
			}
			console.log(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.unmask(document.body);
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			
		}
	});

}