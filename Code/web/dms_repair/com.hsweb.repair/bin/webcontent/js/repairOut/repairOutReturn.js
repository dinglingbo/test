/**
 * Created by Administrator on 2018/3/29.
 */
var baseUrl = window._rootPartUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;
$(document).ready(function()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    nui.mask({
        html:'数据加载中...'
    });
    var dictIdList = [];
    dictIdList.push("DDT20130703000074");
    getDictItems(dictIdList,function(data)
    {
        nui.unmask();
        var items = data.dataItems||[];
        nui.get("returnId").setData(items);
        if(items.length>0)
        {
            nui.get("returnId").setValue(items[0].customid);
        }
    });
});
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
var saveUrl = baseUrl + "com.hsapi.part.purchase.repair.repairReturn.biz.ext";
function onOk()
{
    var out = basicInfoForm.getData();
    out.returnMan = currUserName;
    out.pickType = "050102";
    nui.mask({
        html:'归库中...'
    });
    doPost({
        url:saveUrl,
        data:out,
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("归库成功");
                CloseWindow("ok");
            }
            else{
                nui.alert(data.errMsg||"归库失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function setData(data)
{
    var part = data.part;
    basicInfoForm.setData(part);
}
