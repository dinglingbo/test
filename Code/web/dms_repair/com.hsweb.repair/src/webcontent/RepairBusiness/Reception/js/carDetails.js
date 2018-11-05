var tabs = null;
var mainGrid1 = null;
var params = {};
var form = null;
var grid1 = null;
var grid2 = null;
var baseUrl = apiPath + repairApi + "/";
var mainGrid2 = null;
$(document).ready(function () {
    mainGrid1 = nui.get("mainGrid1");
    form = new nui.Form("#editForm1");
    grid1 = nui.get("grid1");
    grid2 = nui.get("grid2");
    grid1.setUrl(baseUrl+"com.hsapi.repair.baseData.query.queryCardTimesByGuestId.biz.ext");
    grid2.setUrl(baseUrl+"com.hsapi.repair.baseData.query.queryCardByGuestId.biz.ext");
    mainGrid1.setUrl(baseUrl+"com.hsapi.repair.repairService.query.querySettleList.biz.ext");
    mainGrid2 = nui.get("mainGrid2");
                nui.ajax({
                    url: baseUrl+"com.hsapi.repair.repairService.svr.getGuestContactorCar.biz.ext",
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
                

                grid2.on("load",function(e){
                	var data = e.data;
                	for(var i = 0;i<data.length;i++){
                		data[i].balaAmt=data[i].totalAmt-data[i].useAmt;
                		grid2.updateRow(data[i],i);
                	}
                });
});

function SetData(params){
	nui.get("carId").setValue(params.carId);
	nui.get("guestId").setValue(params.guestId);
	var json = {
			carId : nui.get("carId").value
    };
	nui.ajax({
        url: baseUrl+"com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext",
        type : "post",
        data : {
        	params:json,
        	token:token
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
    var pa = {
    		guestId:params.guestId,
    		token:token
    };
    grid1.load({p:pa});

    grid2.load({guestId:params.guestId});

}