var webBaseUrl = webPath + contextPath + "/";
var form1 = null;
var mainData = {};
var visitContent = null;
var baseUrl = apiPath + sysApi + "/";
var sendUrl = baseUrl+"com.hsapi.system.basic.smsPush.testPush.biz.ext";
var saveUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.crud.saveRemindRecord.biz.ext";
var conUrl = apiPath + repairApi +"/com.hsapi.repair.repairService.query.getContacterByGuestId.biz.ext";
var contactorId = null;
var conDetail = {};//联系人详情

$(document).ready(function (){
	
  form1 = new nui.Form("#form1");
    visitContent = nui.get("visitContent");
    contactorId = nui.get("contactorId")
  nui.get("save").focus();
  document.onkeyup=function(event){
    var e=event||window.event;
    var keyCode=e.keyCode||e.which;//38向上 40向下

    if((keyCode==27)) { //ESC
        onClose(); 
    }
 };

});
   
function setData(row) {
    mainData = row;
        if(mainData.guestSource == 0){
            var turl = conUrl+'?guestId='+mainData.trueGuestId;
            contactorId.setUrl(turl);
            contactorId.select(0);
            contactorId.doValueChanged();
    }else{
        contactorId.disable(true);
        contactorId.setText(mainData.guestName);
        document.getElementById('mobile').innerHTML=mainData.mobile;
        nui.get("remark").setValue(mainData.remark);
    }
}
function contactorChange(e) {
    conDetail = e.selected;
   nui.get("remark").setValue(conDetail.remark);
   var con = '<span id="wechatTag" class="fa fa-wechat fa-lg"></span>&nbsp;'+conDetail.mobile;
   var con1 = '<span id="wechatTag1" class="fa fa-wechat fa-lg"></span>&nbsp;'+conDetail.mobile;
   if(conDetail.wechatOpenId){
       document.getElementById('mobile').innerHTML=con;
   }else{
       document.getElementById('mobile').innerHTML=con1;
   }
}

function save() {
    //mainData.mobile = '15607733238';
        //验证
    	var message  = visitContent.getValue();
        if(message=="" || message==null){
            showMsg("请输入短信内容!","W");
            return ;
        }
        if(!mainData.mobile){
            showMsg("手机号不能为空!","W");
            return ;
        }
         nui.mask({
           el: document.body,
           cls: 'mini-mask-loading',
           html: '短信发送中...'
        });
       
        var json = nui.encode({
			"phones" : mainData.mobile,
			"message" : message,
			token : token
        });   
        var params = {
            
        }
       nui.ajax({
			url : sendUrl,
			type : 'POST',
			data : json,
//			cache : false,
//			contentType : 'text/json',
            async:false,
			success : function(text) {
				var returnJson = nui.decode(text);
				if (returnJson.errCode == "S") {
				    nui.unmask(document.body);
                    //showMsg(returnJson.errMsg || "发送成功", "S");
                    saveRecord();
					CloseWindow("ok");
				} else {
					nui.unmask(document.body);
					//showMsg(returnJson.errMsg || "发送失败","E");
					
				}
           },
           error: function (result) { 
               console.log(result);
           }
		});
}



function saveRecord() {
    //var data = form1.getData();
    var message  = visitContent.getValue();
    var params ={
        serviceType:mainData.serviceType,
        mainId:mainData.id||'',
        guestId: conDetail.id||'',
        carId:mainData.carId||'',
        carNo: mainData.carNo || '',
        visitMode:'011402',//短信
        visitContent: message || '',
        guestSource:mainData.guestSource
    };
    nui.ajax({
        url:saveUrl,
        type:'post',
        async:false,
        data:{
            params:params
        },
        success:function(res){
            if(res.errCode == 'S'){
                 showMsg("发送成功！","S");
            }else{
                 showMsg("发送失败！","E");
            }
        },
        error: function (jqXHR) {
            showMsg(jqXHR.responseText);
        }
    })
    
}

function onClear(){
    visitContent.setValue(null);
}


    function selectModel() {
        nui.open({
            url: webPath + contextPath + "/com.hsweb.crm.basic.smsTpl.flow?token="+token,
            title: "选择短信模板", width: 1100, height: 400,
            onload: function () {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData();
            },
            ondestroy: function (action) {
                if(action == "ok"){
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.getData();
                    visitContent.setValue(data.content);
                }
            }
        });
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
