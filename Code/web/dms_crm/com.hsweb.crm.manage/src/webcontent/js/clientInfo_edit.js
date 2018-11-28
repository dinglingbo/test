var form1;//表单
var recorder;//建档人
var recordDate;//建档日期
var modifier;//修改人
var modifyDate;//修改日期
var baseUrl = apiPath + crmApi + "/";
var carModelInfo;
var carModelHash = [];
var insuranceInfoUrl = baseUrl + "com.hsapi.repair.baseData.insurance.InsuranceQuery.biz.ext?params/orgid="+currOrgid+"&params/isDisabled=0";
var insureCompCode = null;
$(document).ready(function(v){
    form1 = new nui.Form("#form1");
    recorder = nui.get("recorder");
    recordDate = nui.get("recordDate");
    modifier = nui.get("modifier");
    modifyDate = nui.get("modifyDate");
    insureCompCode = nui.get("insureCompCode");
    insureCompCode.setUrl(insuranceInfoUrl);
    
    carModelInfo = nui.get("carModelInfo");
    init();
    
    document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		

		if ((keyCode == 27)) { // ESC
			onCancel();
		}
	};
});

function init(){
    initCarBrand("carBrandId");//车辆品牌
   // initInsureComp("insureCompCode");//保险公司
    initDicts({color: "DDT20130726000003"});//车辆颜色
    nui.get('guestName').focus();
}

function onCarBrandChange(e){     
	initCarModel("carModelId", e.value,"", function () {
        var data = nui.get("carModelId").getData();
        data.forEach(function (v) {
        	carModelHash[v.id] = v;
        });
    });
}

function guestNameChange(e){
	nui.get("contacts").setValue(nui.get("guestName").value);
}

function setData(data){
    var tmpUser = modifier.getValue();
    var currDate = new Date();
    form1.setData(data);
    if(!data.id){
        recorder.setValue(tmpUser);
        recordDate.setValue(currDate);
        nui.get("visitStatus").setValue(0);
        nui.get("status").setValue(0);
    }
    modifier.setValue(tmpUser);
    modifyDate.setValue(currDate);
    nui.get("carBrandId").doValueChanged();
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

function onCancel(){
    CloseWindow("cancel");
}

function onOk(){
    //验证
    if(!formValidate(form1)) return;

    //$("#save").hide();
    try {
        nui.ajax({
            url: baseUrl + "/com.hsapi.crm.telsales.crmTelsales.saveGuest.biz.ext",
            type: 'post',
            data: nui.encode({
                data: form1.getData(),
                token:token
            }),
            cache: false,
            success: function (data) {
                $("#save").show();
                if (data.errCode == "S"){
                    showMsg("保存成功！","S");
                    closeWindow();
                }else {
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