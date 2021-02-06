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
    var hasReportEl = nui.get("hasReport");
    hasReportEl.on("valuechanged",function()
    {
        var hasReport = hasReportEl.getValue();
        if(hasReport == 1)
        {
            nui.get("selectReportBtn").show();
            nui.get("drawOutReport").show();
            $("#drawOutReportTitle").show();
        }
        else
        {
            nui.get("selectReportBtn").hide();
            nui.get("drawOutReport").hide();
            $("#drawOutReportTitle").hide();
        }
    });
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['getRoleMember'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    var roleId = [];
    roleId.push("010805");
    getRoleMember(roleId, function (data) {
        data = data || {};
        var list = data.members || [];
        nui.get("checker").setData(list);
        hash.getRoleMember = true;
        checkComplete();
    });
}
function selectReport()
{
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.repair.DataBase.OutCarMain.flow",
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
    basicInfoForm.setData({
        id:id,
        hasReport:1
    });
}

var requiredField = {
    checker:"总检员"
};
function onOk()
{
    var data = basicInfoForm.getData();
    if(data.hasReport == 1)
    {
        requiredField["drawOutReport"] = "报告内容";
    }
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    nui.mask({
        html:'保存中...'
    });
    var url = baseUrl+"com.hsapi.repair.repairService.work.workInspection.biz.ext";
    doPost({
        url:url,
        data:{
            id:data.id,
            drawOutReport:data.drawOutReport||"",
            checker:data.checker||""
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("总检成功","提示",function(){
                    CloseWindow("ok");
                });
            }
            else{
                nui.alert(data.errMsg||"总检失败");
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
