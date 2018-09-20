/**
 * Created by Administrator on 2018/3/21.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var itemGridUrl = baseUrl + "com.hsapi.repair.repairService.query.getRpsItemByServiceId.biz.ext";
var partGridUrl = baseUrl + "com.hsapi.repair.repairService.query.getRpsPartByServiceId.biz.ext";
var itemGrid = null;
var partGrid = null;
var fserviceId = 0;
$(document).ready(function (){
    itemGrid = nui.get("itemGrid");
    partGrid = nui.get("partGrid");
    itemGrid.setUrl(itemGridUrl);
    partGrid.setUrl(partGridUrl);

    partGrid.on("drawcell",function(e){
        var grid = e.sender;
        var record = e.record;

        switch (e.field) {
            case "notPickQty":
                var qty = record.qty||0;
                var pickQty = record.pickQty||0;
                var notPickQty = qty - pickQty;
                e.cellHtml = notPickQty;
                break;
            default:
                break;
        }
    });

});
function setData(params){
    var serviceId = params.serviceId||0;
    fserviceId = serviceId;
    itemGrid.load({
        token:token,
        serviceId:serviceId
    });

    partGrid.load({
        token:token,
        serviceId:serviceId
    },function(){
        var rows = partGrid.findRows(function(row){
            var qty = row.qty||0;
            var pickQty = row.pickQty||0;
            var notPickQty = qty - pickQty;
            if(notPickQty>0){
                return true;
            }
        });
        if(rows && rows.length>0){
            $("checkDescribe").text("本工单有配件未出库");
        }else{
            $("checkDescribe").text("");
        }
    });
}
var resultData = {};
function finish(){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
    var params = {
        data:{
            id:fserviceId||0
        }
    };
    svrRepairAudit(params, function(data){
        data = data||{};
        var errCode = data.errCode||"";
        if(errCode == 'S'){
            var dataHash = data.data||{};
            resultData = dataHash.maintain||{};
            resultData.action = 'ok';
            CloseWindow('ok');
        }else{
            resultData.action = 'cancel';
            CloseWindow("cancel");
        }
    }, function(){
        nui.unmask(document.body);
    })
}
function getRtnData(){
    return resultData;
}
//关闭窗口
function CloseWindow(action) {
    // if (action == "close" && form.isChanged()) {
    //     if (confirm("数据被修改了，是否先保存？")) {
    //         saveData();
    //     }
    // }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}