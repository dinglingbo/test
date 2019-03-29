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
	             default:
	                 break;
	        }
	    });
    //编辑开始前发生
   /* guestGrid.on("cellbeginedit",function(e){
    	var b = 0;
    	switch (e.field)
		{
		   case "reason":
			   e.cancel = false;
			   break;
		   default:
			   break;
		}
     });*/
   nui.get("cancle").focus();
   document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }
    } ;
    guestGrid.on("rowdblclick",function(e){
  	  onOk();
    })
});

var result = {};
function onOk(){
	var row = guestGrid.getSelected();
	 if(row){
		 result = row; 
		 CloseWindow('ok');
	}else{
		showMsg("请选中一条记录!", "W");
	}
}

function getData(){
	return result;
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

function setData(list){
	guestGrid.setData(list);
}
