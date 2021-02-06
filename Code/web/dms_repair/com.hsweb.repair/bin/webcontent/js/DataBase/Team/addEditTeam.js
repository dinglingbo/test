var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;

var codeList = [];
var typeEl = null;
var codeEl = null;
var typeList = [];
var typeHash = {};
$(document).ready(function(v)
{
});
function init(callback)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    typeEl = nui.get("type");
    codeEl = nui.get("code");
    typeEl.on("valuechanged",function(){
        var customid = typeEl.getValue();
        var dictid = typeHash[customid].id;
        var list = codeList.filter(function(v){
            return v.dictid == dictid;
        });
        codeEl.setData(list);
    });
    nui.mask({
        html:'数据加载中..'
    });
    var parentId = "DDT20130703000057";
    getDatadictionaries(parentId,function(data)
    {
        if(data && data.list && data.list.length>0)
        {
            var dictIdList = [];
            var list = data.list;
            typeList = list;
            for(var i=0;i<list.length;i++)
            {
                var v = list[i];
                dictIdList.push(v.id);
                typeHash[v.customid] = v;
            }
            typeEl.setData(typeList);
            getDictItems(dictIdList,function(data)
            {
                nui.unmask();
                if(data && data.dataItems && data.dataItems.length>0)
                {
                    var dataItems = data.dataItems;
                    codeList = dataItems;
                    callback && callback();
                }
                else
                {
                    nui.alert("数据加载失败");
                    callback && callback();
                }
            });
        }
        else
        {
            nui.unmask();
            nui.alert("数据加载失败");
            callback && callback();
        }
    });
}
function setData(data)
{
    init(function()
    {
        data = data||{};
        var detail = data.detail;
        if(detail)
        {
            basicInfoForm.setData(detail);
            typeEl.doValueChanged();
            typeEl.disable();
            codeEl.disable();
        }
    });

}
var requiredField = {
    captainName:"班组长名称",
    code:"班组名称",
    type:"维修工种"
};
var saveUrl = baseUrl+"com.hsapi.repair.baseData.team.saveTeam.biz.ext";
function onOk()
{
	var data = basicInfoForm.getData();
    //console.log(data);
    data.captainName = nui.get("captainId").getText();
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    data.name = nui.get("code").getText();
    nui.mask({
        html:'保存中..'
    });
    doPost({
        url:saveUrl,
        data:{
            team:data
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
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
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
function selectCaptain(elId)
{
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.repair.common.empSelect.flow",
        title: "选择用户", width: 300, height: 500,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                multiSelect:false
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var empList = data.empList;
                var emp = empList[0];
                console.log(emp);
                if(nui.get(elId))
                {
                    nui.get(elId).setValue(emp.nodeId);
                    if(nui.get(elId).setText)
                    {
                        nui.get(elId).setText(emp.nodeName);
                    }
                }
            }
        }
    });
}