var form1;//表单
var itemTypeId; //话术类型
var action;

$(document).ready(function(v){
    form1 = new nui.Form("#form1");
    itemTypeId = nui.get("itemTypeId");
});

function setData(data){
    form1.setData(data);
    itemTypeId.setData(data.itemType);
    if(data.parentId){
        $("#parenNode").show();
    }
}

function onOk(){
    //验证
    form1.validate();
    if (!form1.isValid()) return;

    try {
        nui.ajax({
            url: apiPath + frmDomain + "/com.hsapi.frm.setting.saveIncomeExpItem.biz.ext",
            type: 'post',
            data: nui.encode({
                data: form1.getData()
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