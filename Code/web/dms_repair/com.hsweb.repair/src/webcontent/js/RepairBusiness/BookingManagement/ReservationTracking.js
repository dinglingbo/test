/**
 * Created by Administrator on 2018/3/20.
 */

var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
$(document).ready(function()
{
    init(function()
    {

    });
});
var basicInfoForm = null;
var bookInfoForm = null;
function init(callback)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    bookInfoForm = new nui.Form("#bookInfoForm");
    var hash = {};
    nui.mask({
        html:'数据加载中..'
    });
    var checkComplete = function()
    {
        var keyList = ['getDictItems'];
        for(var i=0;i<keyList.length;i++)
        {
            if(!hash[keyList[i]])
            {
                return;
            }
        }
        nui.unmask();
        callback && callback();
    };
    var dictIdList = [];
    dictIdList.push("DDT20130703000021");//跟进方式
    dictIdList.push("DDT20130703000081");//跟踪状态
    getDictItems(dictIdList,function(data)
    {
        data = data||{};
        var itemList = data.dataItems||[];
        var scoutModeList = itemList.filter(function(v){
            return  "DDT20130703000021" == v.dictid;
        });
        nui.get("scoutMode").setData(scoutModeList);
        var isUsabledList = itemList.filter(function(v){
            return  "DDT20130703000081" == v.dictid;
        });
        nui.get("isUsabled").setData(isUsabledList);
        hash.getDictItems = true;
        checkComplete();
    });
}
function setData(data)
{
    data = data||{};
    if(data.prebook)
    {
        var prebook = data.prebook;
        bookInfoForm.setData(prebook);
        var serviceId = prebook.id;
        var tmp = {
            serviceId:serviceId,
            scoutMan:currUserName,
            scoutDate:new Date(currentTimeMillis)
        };
        basicInfoForm.setData(tmp);
    }
}
var saveUrl = baseUrl+"com.hsapi.repair.repairService.crud.saveProbookScout.biz.ext";
function onOk()
{
    var data = basicInfoForm.getData();
    nui.mask({
        html:'保存中..'
    });
    doPost({
        url:saveUrl,
        data:{
            scout:data
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("保存成功");
                CloseWindow("ok");
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR.responseText);
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
