var form1;//表单
var recorder;//建档人
var recordDate;//建档日期
var modifier;//修改人
var modifyDate;//修改日期

var carModelInfo;

$(document).ready(function(v){
    form1 = new nui.Form("#form1");
    recorder = nui.get("recorder");
    recordDate = nui.get("recordDate");
    modifier = nui.get("modifier");
    modifyDate = nui.get("modifyDate");
    
    carModelInfo = nui.get("carModelInfo");
    init();
});

function init(){
    initCarBrand("carBrandId");//车辆品牌
    initInsureComp("insureCompCode");//保险公司
    initDicts({color: "DDT20130726000003"});//车辆颜色
}



function setData(data){
    /*var tmpUser = modifier.getValue();
    var currDate = new Date();
    form1.setData(data);
    if(!data.id){
        recorder.setValue(tmpUser);
        recordDate.setValue(currDate);
    }
    modifier.setValue(tmpUser);
    modifyDate.setValue(currDate);*/
}

function onOk(){
    //验证
    if(!formValidate(form1)) return;

    //$("#save").hide();
    try {
        nui.ajax({
            url: webPath + crmDomain + "/com.hsapi.crm.telsales.crmTelsales.saveGuest.biz.ext",
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

function setCharCount(){
    var charCount = nui.get("charCount");
    var txt = content.getInputText() || "";
    charCount.setValue(txt.length);
}