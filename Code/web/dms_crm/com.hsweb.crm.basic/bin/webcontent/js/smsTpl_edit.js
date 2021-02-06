var basicInfoForm;//表单
var typeId; //话术类型
var content;//内容
var recorder;//建档人
var recordDate;//建档日期
var modifier;//修改人
var modifyDate;//修改日期

$(document).ready(function(v){
    basicInfoForm = new nui.Form("#basicInfoForm");
    typeId = nui.get("typeId");
    content = nui.get("content");
    recorder = nui.get("recorder");
    recordDate = nui.get("recordDate");
    modifier = nui.get("modifier");
    modifyDate = nui.get("modifyDate");
    nui.get('typeId').focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
});

function setData(data){
    var tmpUser = modifier.getValue();
    var currDate = new Date();
    basicInfoForm.setData(data);
    typeId.setData(data.artType);
    if(!data.id){
        recorder.setValue(tmpUser);
        recordDate.setValue(currDate);
    }
    modifier.setValue(tmpUser);
    modifyDate.setValue(currDate);
}

function onOk(){
    //验证
    basicInfoForm.validate();
    if (!basicInfoForm.isValid()) return;

    //$("#save").hide();
    try {
        nui.ajax({
            url: webPath + crmDomain + "/com.hsapi.crm.basic.crmBasic.saveSms.biz.ext",
            type: 'post',
            data: nui.encode({
                data: basicInfoForm.getData()
            }),
            cache: false,
            success: function (data) {
                $("#save").show();
                if (data.errCode == "S"){
                   // nui.alert("保存成功！");
                	showMsg("保存成功！","S");
                    closeWindow();
                }else {
                   // nui.alert(data.errMsg);
                    showMsg(data.errMsg,"E");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                nui.alert(jqXHR.responseText);
            }
		});
    }
    finally {        
    }  
}

function setCharCount(){
    var charCount = nui.get("charCount");
    var txt = content.getInputText() || "";
    charCount.setValue(txt.length);
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}