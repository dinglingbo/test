var baseUrl = apiPath + repairApi + "/";
var contactorGrid = null;
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
	guestGrid = nui.get("guestGrid");
    guestGrid.on("drawcell",function(e){
		    var record = e.record;
	        var uid = record._uid;
	         switch (e.field) {
	             case "sex":
	            	 e.cellHtml = sexTypeHash[e.value];
	            	 break;
	             case "wechatOptBtn":
	            	 e.cellHtml = '<a class="optbtn" href="javascript:void()" onclick="wechatBin(\'' + uid + '\')">拆分</a>';
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
});
var result=null;
 var saveOpenIdUrl = baseUrl + "com.hsapi.repair.repairService.svr.saveWechatOpenId.biz.ext";
function wechatBin(row_uid){
	var row = contactorGrid.getRowByUID(row_uid);
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
		showMsg("请选中一条记录!", "E");
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
	guestGrid.setData(params);
}
