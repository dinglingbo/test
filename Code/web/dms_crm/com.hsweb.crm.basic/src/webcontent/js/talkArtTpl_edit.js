var basicInfoForm;//表单
var typeId; //话术类型
var recorder;//建档人
var recordDate;//建档日期
var modifier;//修改人
var modifyDate;//修改日期
var action;

$(document).ready(function(v){
    basicInfoForm = new nui.Form("#basicInfoForm");
    typeId = nui.get("typeId");
    recorder = nui.get("recorder");
    recordDate = nui.get("recordDate");
    modifier = nui.get("modifier");
    modifyDate = nui.get("modifyDate");
    
    
    initDicts({
    	typeId: "DDT20130725000001"//话术类型        
   });
    
    
    
    nui.get("content").focus();
    document.onkeyup=function(event){
    var e=event||window.event;
    var keyCode=e.keyCode||e.which;//38向上 40向下

    if((keyCode==27)) { //ESC
    	onClose();
    }
    };
});

function setData(data){
    var tmpUser = modifier.getValue();
    var currDate = new Date();
    basicInfoForm.setData(data);
   // typeId.setData(data.artType);
    if(!data.id){
        recorder.setValue(tmpUser);
        recordDate.setValue(currDate);
    }
    modifier.setValue(tmpUser);
    modifyDate.setValue(currDate);
}

function getData(){
    return 
}

function onOk(){
    //验证
    basicInfoForm.validate();
    if (!basicInfoForm.isValid()) return;

    //$("#save").hide();
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


function CloseWindow(action) {
	if (action == "close") {
	} else if (window.CloseOwnerWindow)
	return window.CloseOwnerWindow(action);
	else
	return window.close();
	}

	function onClose(){
	window.CloseOwnerWindow(); 
	}