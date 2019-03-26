var baseUrl = apiPath + repairApi + "/";
var contactorGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.getContactListByGuestId.biz.ext";
var contactorGrid = null;
var identityTypeHash = {
	    "060301":"车主",
	    "060302":"车管",
	    "060303":"司机",
	    "060304":"其他"
};
var sexTypeHash = {
	    "0":"男",
	    "1":"女",
	    "2":"未知"
};
/*
 * var row = rpsPackageGrid.findRow(function(row){
                		rpsPackageGrid.beginEditRow(row);
                    });
 * */
$(document).ready(function (){
	  contactorGrid = nui.get("contactorGrid");
	  contactorGrid.setUrl(contactorGridUrl);
	  contactorGrid.on("drawcell",function(e){
		    var record = e.record;
	        var uid = record._uid;
	         switch (e.field) {
	             case "identity":
	            	 e.cellHtml = identityTypeHash[e.value];
	                 break;
	             case "sex":
	            	 e.cellHtml = sexTypeHash[e.value];
	            	 break;
	             case "wechatOptBtn":
	            	 e.cellHtml = '<a class="optbtn" href="javascript:void()" onclick="wechatBin(\'' + uid + '\')">绑定</a>';
	            	 break;
	             default:
	                 break;
	        }
	    });
	  nui.get("cancle").focus();
	  document.onkeyup = function(event) {
	        var e = event || window.event;
	        var keyCode = e.keyCode || e.which;// 38向上 40向下
	        if ((keyCode == 27)) { // ESC
	            CloseWindow('cancle');
	        }
	    } ;
	    /*contactorGrid.on("rowdblclick",function(e){
	    	save();
		});*/
});
var result=null;
//wechatApi/com.hsapi.wechat.autoServiceBackstage.weChatInterface.addBoundUser.biz.ext
var saveOpenIdUrl = baseUrl + "com.hsapi.repair.repairService.svr.saveWechatOpenId.biz.ext";
function wechatBin(row_uid){
	var row = contactorGrid.getRowByUID(row_uid);
	if(row.wechatOpenId){
		showMsg("此联系人已绑定!","W");
		return 0;
	}
	var wechatService = contactorGrid.getCellEditor("wechatServiceId", row);
	var wechatServiceId = wechatService.getValue();
	if(!wechatServiceId){
		 showMsg("请输入服务号!","W");
		 return 0; 
	 }
	 if(row){
		 result=row;
		 if(!carNo){
			 showMsg("车牌号为空!","W");
			 return 0;
		 }else{
			 var wechatUser = {};
			 wechatUser.userPhone = row.mobile;
			 wechatUser.userMarke = wechatServiceId;
			 wechatUser.contactorId = row.id;
			 wechatUser.guestId = guestId;
			 var json = nui.encode({
				 carNo:carNo,
				 wechatUser:wechatUser,
		 		 token:token
		 	  });
			 nui.ajax({
			 		url : saveOpenIdUrl,
			 		type : 'POST',
			 		data : json,
			 		cache : false,
			 		contentType : 'text/json',
			 		success : function(text) {
			 			if(text.errCode=="S"){
			 				var params = {};
			 				params.guestId = guestId;
			 				contactorGrid.load({
			 				     token:token,
			 				     params:params
			 				  },function(){
			 					 var row = contactorGrid.findRow(function(row){
			 						 if(!row.wechatOpenId){
			 							 contactorGrid.beginEditRow(row);
			 						 }
			 						 
			 				     });
			 				 });
			 			result.success = 1;
			 			showMsg(text.errMsg || "绑定成功!","S");
			 			return;
			 			}else{
			 				showMsg(text.errMsg,"E");
			 				return;
			 			}
			 			
			 		}
			});
		 }
	}else{
		nui.alert("请选中一条记录", "提示");
	}
}

function getData(){
	return result;
}
function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
var carNo = null;
var guestId = null;
function setData(params){
  carNo = params.carNo;
  guestId = params.guestId;
  contactorGrid.load({
     token:token,
     params:params
  },function(){
	 var row = contactorGrid.findRow(function(row){
		 if(row.wechatServiceId){
			 if(!row.wechatOpenId){
				 var rowData = row;
				 rowData.wechatServiceId = "已取消关注";
				 contactorGrid.updateRow(row,rowData); 
			 }
		 }else{
			 contactorGrid.beginEditRow(row);
		 }
		 
		 
     });
 });
}
