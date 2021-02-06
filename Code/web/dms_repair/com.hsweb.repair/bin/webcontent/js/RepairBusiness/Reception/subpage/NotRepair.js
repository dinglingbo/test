/**
 * Created by Administrator on 2018/3/28.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;
$(document).ready(function (v)
{
    init(function(){});
});
function init(callback)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
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
    dictIdList.push("DDT20130705000008");//流失主要原因
    dictIdList.push("DDT20130705000009");//流失未修次要原因
    getDictItems(dictIdList, function(data)
    {
        data = data||{};
        var itemList = data.dataItems||[];
        var noMtTypeList = itemList.filter(function(v)
        {
            return v.dictid == "DDT20130705000008" || v.dictid == "DDT20130705000009";
        });
        nui.get("noMtType").setData(noMtTypeList);
        hash.getDictItems = true;
        checkComplete();
    });
}
function setData(data)
{
    init();
    basicInfoForm.setData(data);
}
var saveUrl = baseUrl+"com.hsapi.repair.repairService.sureMt.noMtRecord.biz.ext";
var requiredField = {
    noMtType:"未修原因类别",
    noMtReason:"未修原因说明"
};
function onOk()
{
    var tmp = basicInfoForm.getData();
    for(var key in requiredField)
    {
        if(!tmp[key] || tmp[key].toString().trim().length == 0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    nui.mask({
        html:'保存中..'
    });
    doPost({
        url : saveUrl,
        data : {
            maintain:tmp
        },
        success : function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                CloseWindow("ok");
            }
            else{
                nui.alert(data.errMsg||"未修归档失败");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            nui.unmask();
            console.log(jqXHR.responseText);
            nui.alert("网络出错");
        }
    });
}
//关闭窗口
function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}

//commonRepair
function doPost(opt)
{
    var url = opt.url;
    var data = opt.data;
    var success = opt.success||function(){};
    var error = opt.error||function(){};
    data.orgid = currOrgid;
    data.userName = currUserName;
    nui.ajax({
        url:url,
        type:"post",
        data:JSON.stringify(data),
        success:success,
        error:error
    });
}
var getDatadictionariesUrl = baseUrl
    + "com.hsapi.repair.common.common.getDatadictionaries.biz.ext";
function getDatadictionaries(parentId, callback) {
    var params = {};
    params.parentId = parentId;
    doPost({
        url : getDatadictionariesUrl,
        data : params,
        success : function(data)
        {
            callback && callback(data);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}

var getDictItemsUrl = baseUrl
    + "com.hsapi.repair.common.common.getDictItems.biz.ext";
function getDictItems(dictIdList, callback) {
    var params = {};
    params.dictIdList = dictIdList;
    doPost({
        url : getDictItemsUrl,
        data : params,
        success : function(data)
        {
            callback && callback(data);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var getRoleMemberUrl = baseUrl
    + "com.hsapi.part.common.svr.getRoleMemberByRoleId.biz.ext";
function getRoleMember(roleId, callback) {
    var params = {};
    params.roleId = roleId;
    doPost({
        url : getRoleMemberUrl,
        data : params,
        success : function(data) {
            callback && callback(data);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}
var getCompBillNOUrl = baseUrl
    + "com.hs.common.uniq.getCompBillNO.biz.ext";
function getCompBillNO(billTypeCode, callback) {
    var params = {};
    params.billTypeCode = billTypeCode;
    params.orgid = currOrgid;
    doPost({
        url : getCompBillNOUrl,
        data : params,
        success : function(data)
        {
            callback && callback(data);
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}
var currOrgid = 2;
var currUserName = '刘阳';