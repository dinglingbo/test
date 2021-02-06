/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + repairApi + "/";
var basicInfoForm = null;
var isDisabledEl = null;
var id = null;

var statusHash = {"0":"启用","1":"禁用"};
var dataList = [{id:"0",name:"启用"},{id:"1",name:"禁用"}];
$(document).ready(function(v)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    isDisabledEl = nui.get("isDisabled");
    isDisabledEl.setData(dataList);
    nui.get('name').focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
});
function doSearch(params)
{
    //
}
function setInitData(params){
    if(params.id){
        id = params.id;
        doSearch(params);
    }
}
var saveUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.saveDict.biz.ext";
function onOk(){

    var data = basicInfoForm.getData();
    var name = data.name;
    var isDisabled = data.isDisabled;
    if(!name){
        showMsg("名称为空","W");
        return;
    }
    if(!isDisabled){
        showMsg("状态为空","W");
        return;
    }
    if(!data.id){
        data.customid = (new Date()).getTime();
        data.dictid = '10081';
    }

    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            data : data,
            token: token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
            	showMsg(data.errMsg || "保存成功!","S");
            } else {
            	showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
   
}
function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}