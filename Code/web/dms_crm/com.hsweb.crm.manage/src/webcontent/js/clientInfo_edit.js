var form1;//表单
var recorder;//建档人
var recordDate;//建档日期
var modifier;//修改人
var modifyDate;//修改日期
var baseUrl = apiPath + crmApi + "/";
var carModelInfo;
var carModelHash = [];
var insuranceInfoUrl = apiPath + repairApi+ "/com.hsapi.repair.baseData.insurance.InsuranceQuery.biz.ext?params/orgid="+currOrgid+"&params/isDisabled=0";
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
            url: baseUrl + "com.hsapi.crm.telsales.crmTelsales.saveGuest.biz.ext",
            type: 'post',
            data: nui.encode({
                data: form1.getData(true),
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


// function carVinModel() {
//     var  vin = nui.get("vin").value;
//     if(vin){
//     getCarVinModel(vin, function (data) {
//         data = data || {};
//         if (data.errCode == "S") {
//             var carVinModel = data.data.SuitCar || []; //list[0];
//             carVinModel = carVinModel[0] || {};
//             carVinModel.vin = vin;
//             var carModelInfo = "品牌:" + carVinModel.carBrandName + "\n";
//             carModelInfo += "车型:" + carVinModel.carModelName + "\n";
//             carModelInfo += "车系:" + carVinModel.carLineName + "\n";
//             var name1 = carVinModel.grandParentName || "";
//             name1 = name1 ? (name1 + " ") : "";
//             var name2 = carVinModel.parentName || "";
//             name2 = name2 ? (name2 + " ") : "";
//             var name3 = carVinModel.name || "";
//             nui.get("carModelInfo").setValue(name1 + name2 + name3);
//         }
//     });
//     }else{
//         showMsg('请输入车架号','W');
//     }
// }

function onParseUnderpanNo()
{
    var vin = nui.get("vin").getValue();
    //判断VIN
    var data = {};
    data = validation(vin);
    if(data.isNo){
    	vin = data.vin//返回转化好的vin
    	nui.get("vin").setValue(vin);
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '车型解析中...'
        });
        getCarVinModel(vin,function(data)
        {
            data = data||{};
            if(data.errCode == "S")
            {
                //var list = data.rs||[];
                var carVinModel = data.data.SuitCar||[];//list[0];
                var carModelId = data.data.carModelId;
                carVinModel = carVinModel[0]||{};
                carVinModel.vin = vin;
             //   nui.get("carBrandId").setValue(carVinModel.carBrandId);
             //   nui.get("carModelId").setValue(carVinModel.carModelId);
             //   nui.get("carModelId").setText(carVinModel.carModelName);
                var carModelInfo = "品牌:"+carVinModel.carBrandName+"\n";
                carModelInfo += "车型:"+carVinModel.carModelName+"\n";
                carModelInfo += "车系:"+carVinModel.carLineName+"\n";
                var name1 = carVinModel.grandParentName||"";
                name1 = name1?(name1+" "):"";
                var name2 = carVinModel.parentName || "";
                name2 = name2?(name2+" "):"";
                var name3 = carVinModel.name||"";
                nui.get("carModelInfo").setValue(name1 + name2 + name3);
                // nui.get("carBrandId").setValue("");
                // nui.get("carModelId").setValue(carVinModel.id);
                // nui.get("carModelIdLy").setValue(carModelId);
                nui.unmask(document.body);
            }else{
            	nui.unmask(document.body);
            	showMsg("车型解析失败，请手工维护车型信息！","W");
            }
        });
    }else{
    	showMsg("VIN不规范，请确认！","W");
    	return;
    }

}


function getCarModel(callBack) {
	nui.open({
		//// targetWindow: window,,
		url : "com.hsweb.repair.common.carModelSelect.flow",
		title : "选择车型",
		width : 900,
		height : 600,
		allowDrag : true,
		allowResize : false,
		onload : function() {
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData(true);
				if (data && data.carModel) {
					var carModel = data.carModel || {};
                    callBack && callBack(carModel);
					/*if (elId && nui.get(elId)) {
						nui.get(elId).setValue(carModel.id);
						nui.get(elId).setText(carModel.carModel);
					}
					if (carBrandId && nui.get(carBrandId)) {
						nui.get(carBrandId).setValue(carModel.carBrandId);
						if (nui.get(carBrandId).doValueChanged) {
							nui.get(carBrandId).doValueChanged();
						}
					}
					if (carModelId && nui.get(carModelId)) {
						nui.get(carModelId).setValue(carModel.id);
					}*/
				}
			}
		}
	});
}


//设置车型
function setCarModel(data){
	var d = data.carModel;
    nui.get("carModel").setValue(data.carModel);
    nui.get("carModelInfo").setValue(data.carModel);
}
