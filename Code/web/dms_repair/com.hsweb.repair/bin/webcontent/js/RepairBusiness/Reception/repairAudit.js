/**
 * Created by Administrator on 2018/3/30.
 */


var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";

$(document).ready(function (v)
{
//    init();
});
var basicInfoForm = null;
function init(callback)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
}
function selectReport()
{
    nui.open({
        // targetWindow: window,
        url: "../OutCar/OutCarMain.html",
        title: "出车报告",
        width: 900,
        height: 600,
        allowResize: false,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
            if (action == "ok") {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var report = data.report;
                nui.get("drawOutReport").setValue(report.content);
            }
        }
    });
}
function setData(data)
{
    init();
    var id = data.id;
    data.amt = data.itemAmt+data.partAmt+data.packageAmt;
    basicInfoForm.setData(data);
}

function onOk()
{
    var data = basicInfoForm.getData();
    nui.mask({
        html:'保存中...'
    });
    var url = baseUrl+"com.hsapi.repair.repairService.work.repairAudit.biz.ext";
    doPost({
        url:url,
        data:data,
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("审核成功","提示",function(){
                    CloseWindow("ok");
                });
            }
            else{
                nui.alert(data.errMsg||"审核失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });

}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
