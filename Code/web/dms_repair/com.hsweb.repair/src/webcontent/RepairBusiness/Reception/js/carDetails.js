var tabs = null;
var mainGrid1 = null;
var params = {};
var form = null;
var grid1 = null;
var grid2 = null;
var mainGrid2 = null;
$(document).ready(function () {
    tabs = nui.get("tabs");
    mainGrid1 = nui.get("mainGrid1");
    form = new nui.Form("#editForm1");
    grid1 = nui.get("grid1");
    grid2 = nui.get("grid2");
    mainGrid2 = nui.get("mainGrid2");
    tabs.on("activechanged",function(e){
    	if(nui.get("carId").value != ""){
    		params = {
    				carId : nui.get("carId").value
    	    };
    		var index = e.index;
            if(index == 0){
                nui.ajax({
                    url: "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext",
                    type : "post",
                    data : {
                    	params : params
                    },
                    success: function (text) {
                        var list = nui.decode(text.list);
                        form.setData(list[0]);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR.responseText);
                        showMsg("网络出错", "W");
                    }
                });
            }
            if (index == 1) {
                nui.ajax({
                    url: "com.hsapi.repair.repairService.svr.getGuestContactorCar.biz.ext",
                    type : "post",
                    data : {
                    	guestId : nui.get("guestId").value
                    },
                    success: function (text) {
                        var guest = nui.decode(text.guest);
                        var form = new nui.Form("#editForm4");
                        form.setData(guest);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(jqXHR.responseText);
                        showMsg("网络出错", "W");
                    }
                });
                
                var p = {
                		guestId : nui.get("guestId").value
                };
                grid1.load({p : p});
                grid2.load({p : p});
            }
            if(index == 2){
            	params = {
            			carId : nui.get("carId").value,
            			guestId : nui.get("guestId").value
            	};
            	mainGrid1.load({params : params});
            }
    	}
    });
});

function SetData(params){
	nui.get("carId").setValue(params.carId);
	nui.get("guestId").setValue(params.guestId);
	params = {
			carId : nui.get("carId").value
    };
	nui.ajax({
        url: "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext",
        type : "post",
        data : {
        	params : params
        },
        success: function (text) {
            var list = nui.decode(text.list);
            form.setData(list[0]);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            showMsg("网络出错", "W");
        }
    });
}