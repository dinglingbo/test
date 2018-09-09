var tabs = null;
var grid_fw = null;
var params = {};
var form = null;
var grid1 = null;
var grid2 = null;
$(document).ready(function () {
    tabs = nui.get("tabs");
    grid_fw = nui.get("mainGrid1");
    form = new nui.Form("#editForm1");
    grid1 = nui.get("grid1");
    grid2 = nui.get("grid2");
    params = {
    		rid : 821
    };
    tabs.on("activechanged",function(e){
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
                	guestId : 2
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
            		id : 2
            };
            grid1.load({p : p});
        }
        if(index == 2){
            grid_fw.load();
        }
        if(index == 3){

        }
    });
});