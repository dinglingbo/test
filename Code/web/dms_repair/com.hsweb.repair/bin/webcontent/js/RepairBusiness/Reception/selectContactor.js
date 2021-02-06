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
$(document).ready(function (){
	  contactorGrid = nui.get("contactorGrid");
	  contactorGrid.setUrl(contactorGridUrl);
	  contactorGrid.on("drawcell",function(e){
	         switch (e.field) {
	             case "identity":
	            	 e.cellHtml = identityTypeHash[e.value];
	                 break;
	             case "sex":
	            	 e.cellHtml = sexTypeHash[e.value];
	            	 break;
	             default:
	                 break;
	        }
	    });
	  nui.get("save").focus();
	  document.onkeyup = function(event) {
	        var e = event || window.event;
	        var keyCode = e.keyCode || e.which;// 38向上 40向下
	        if ((keyCode == 27)) { // ESC
	            CloseWindow('cancle');
	        }
	    } ;
	    contactorGrid.on("rowdblclick",function(e){
	    	save();
		});
});
var result=null;
function save(){
	var row  = contactorGrid.getSelected();
	if(row){
		result=row;
		 CloseWindow('cancle')
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
function setData(params){
	 contactorGrid.load({
         token:token,
         params:params
    });
}

