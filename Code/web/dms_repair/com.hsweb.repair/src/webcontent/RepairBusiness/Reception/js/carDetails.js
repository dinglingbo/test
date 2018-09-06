var tabs = null;
var grid_fw = null;
$(document).ready(function () {
    tabs = nui.get("tabs");
    grid_fw = nui.get("mainGrid1");
    tabs.on("activechanged",function(e){
        var index = e.index;
        if(index == 0){
            nui.ajax({
                url: "com.hsapi.repair.common.carDetails.searchCarMsg.biz.ext",
                success: function (text) {
                    var RpbCar = nui.decode(text.RpbCar);
                    var form = new nui.Form("#editForm1");
                    var form3 = new nui.Form("#editForm3");
                    form.setData(RpbCar[1]);
                    form3.setData(RpbCar[1]);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "W");
                }
            });
        }
        if (index == 1) {
            nui.ajax({
                url: "com.hsapi.repair.common.carDetails.searchComGuest.biz.ext",
                success: function (text) {
                    var comGuest = nui.decode(text.comGuest);
                    var form = new nui.Form("#editForm4");
                    form.setData(comGuest[0]);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(jqXHR.responseText);
                    showMsg("网络出错", "W");
                }
            });
        }
        if(index == 2){
            grid_fw.load();
        }
        if(index == 3){

        }
    });
});