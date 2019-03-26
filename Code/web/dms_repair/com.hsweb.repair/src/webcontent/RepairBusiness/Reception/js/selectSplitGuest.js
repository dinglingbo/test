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

var saveSplit = baseUrl + "com.hsapi.repair.repairService.crud.saveSplitCar.biz.ext";
function wechatBin(row_uid){
	var row = guestGrid.getRowByUID(row_uid);
	 if(row){
		var json = nui.encode({
			 car:carData,
			 guest:row,
			 action:"split",
	 		 token:token
	 	  });
		 nui.ajax({
		 		url : saveSplit,
		 		type : 'POST',
		 		data : json,
		 		cache : false,
		 		contentType : 'text/json',
		 		success : function(text) {
		 			if(text.errCode=="S"){
		 			    CloseWindow('ok');
		 			    showMsg(text.errMsg || "拆分成功!","S");
		 			    return;
		 			}else{
		 				showMsg(text.errMsg || "拆分失败!","E");
		 				return;
		 			}
		 		}
		});
	}else{
		showMsg("请选中一条记录!", "W");
	}
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
var carData= null;
function setData(params,car){
	carData = car;
	guestGrid.setData(params);
}
