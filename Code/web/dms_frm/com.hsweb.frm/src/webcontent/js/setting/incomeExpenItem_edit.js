var basicInfoForm;//表单
var itemTypeId; //话术类型
var action;

$(document).ready(function(v){
    basicInfoForm = new nui.Form("#basicInfoForm");
    itemTypeId = nui.get("itemTypeId");
});

function setData(data){
    basicInfoForm.setData(data);
    itemTypeId.setData(data.itemTypeId);
}

function onOk(){
    //验证
    basicInfoForm.validate();
    if (!basicInfoForm.isValid()) return;

    try {
        nui.ajax({
            url: webPath + crmDomain + "/com.hsapi.crm.basic.crmBasic.saveTalkArt.biz.ext",
            type: 'post',
            data: nui.encode({
                data: basicInfoForm.getData()
            }),
            cache: false,
            success: function (data) {
                $("#save").show();
                if (data.errCode == "S"){
                    nui.alert("保存成功！");
                    closeWindow();
                }else {
                    nui.alert(data.errMsg);
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