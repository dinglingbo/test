var editForm1 = null;
var editForm2 = null;
var editForm3 = null;
var form1 = null;
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
$(document).ready(function () {

});

function setData(data)
{
    init();
    data = data || {};
    if(data.number){
    	nui.get("number").setValue(data.number);
    }
    if(data.comguest)
    {
        var comguest = data.comguest;
        form1.setData(comguest);
    }
}

function init()
{
	editForm1 = new nui.Form("#editForm1");
	editForm2 = new nui.Form("#editForm2");
	editForm3 = new nui.Form("#editForm3");
	form1 = new nui.Form("#form1");
}

function onCancel() {
    CloseWindow("cancel");
}

var saveUrl = baseUrl + "com.hsapi.crm.page.newcomponent.saveInsurance.biz.ext";
function saveData(){
	var data = form1.getData();
	data.number = nui.get("number").value;
	nui.mask({
        html: '保存中...'
    });
	nui.ajax({
        url:saveUrl,
        data:{
            comguest:data,
            RpbCardTimes : data
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                showMsg("保存成功", "S");
                CloseWindow("ok");
            }
            else{
                showMsg(data.errMsg || "保存失败", "W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR.responseText);
            nui.unmask();
            showMsg("网络出错", "W");
        }
    });
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}