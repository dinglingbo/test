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
        if (currRepairBillCmodelFlag == "1") {
        nui.get("carModelInfo").disable();
    } else {
        nui.get("carModelInfo").enable();
    }
        
        var tip = new mini.ToolTip();
        tip.set({
            target: document,
            selector: '#carModelId .mini-buttonedit-input',
           placement:'topleft',
            onbeforeopen: function (e) {
                e.cancel = false;
            },
            onopen: function (e) {
                var el = e.element;
                
                var val = $(el).val();
                if (val == "") {
                    tip.hide();
                } else {
                    tip.setContent(val);
                }

            }
        });
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


function carVinModel() {
    var  vin = nui.get("vin").value;
    if(vin){
    getCarVinModel(vin, function (data) {
        data = data || {};
        if (data.errCode == "S") {
            var carVinModel = data.data.SuitCar || []; //list[0];
            carVinModel = carVinModel[0] || {};
            carVinModel.vin = vin;
            var carModelInfo = "品牌:" + carVinModel.carBrandName + "\n";
            carModelInfo += "车型:" + carVinModel.carModelName + "\n";
            carModelInfo += "车系:" + carVinModel.carLineName + "\n";
            var name1 = carVinModel.grandParentName || "";
            name1 = name1 ? (name1 + " ") : "";
            var name2 = carVinModel.parentName || "";
            name2 = name2 ? (name2 + " ") : "";
            var name3 = carVinModel.name || "";
            nui.get("carModelInfo").setValue(name1 + name2 + name3);
        }
    });
    }else{
        showMsg('请输入车架号','W');
    }
}