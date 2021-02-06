/**
 * Created by Administrator on 2018/4/3.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
$(document).ready(function (v)
{
    setData({
        maintain:{
            id:1,
            status:4
        }
    });
});

var maintain = {};
function setData(data)
{
    maintain = data.maintain||{};
    nui.get("oldStatus").setValue(maintain.status);
}


function onOk()
{
    var oldStatus = maintain.status;
    var newStatus = nui.get("newStatus").getValue();
    newStatus = parseInt(newStatus);
    if(newStatus>=oldStatus)
    {
        nui.alert("不能返回当前进程或进程之后");
        return;
    }
    nui.mask({
        html:'保存中...'
    });
    var url = baseUrl+"com.hsapi.repair.repairService.settlement.resetBill.biz.ext";
    doPost({
        url:url,
        data:{
            newStatus:newStatus,
            serviceId:maintain.id
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("返单成功","提示",function(){
                    CloseWindow("ok");
                });
            }
            else{
                nui.alert(data.errMsg||"返单失败");
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