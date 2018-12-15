var webBaseUrl = webPath + contextPath + "/";
var form1 = null;
var phones = "";
var visitContent = null;
var baseUrl = apiPath + sysApi + "/";
var sendUrl = baseUrl+"com.hsapi.system.basic.smsPush.testPush.biz.ext";
$(document).ready(function (){
	
  form1 = new nui.Form("#form1");
  visitContent = nui.get("visitContent");
  nui.get("save").focus();
  document.onkeyup=function(event){
    var e=event||window.event;
    var keyCode=e.keyCode||e.which;//38向上 40向下

    if((keyCode==27)) { //ESC
        onClose();
    }
 };

});
   


    function save(){
       // phones = "13973231730";
        //验证
    	var message  = visitContent.getValue();
        if(message=="" || message==null){
            showMsg("请输入短信内容!","W");
            return ;
        }
        if(phones ==""|| phones == null){
            showMsg("手机号不能为空!","W");
            return ;
        }
         nui.mask({
           el: document.body,
           cls: 'mini-mask-loading',
           html: '短信发送中...'
        });
       
        var json = nui.encode({
			"phones" : phones,
			"message" : message,
			token : token
		});       
       nui.ajax({
			url : sendUrl,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				if (returnJson.errCode == "S") {
				    nui.unmask(document.body);
					showMsg(returnJson.errMsg || "发送成功","S");
				} else {
					nui.unmask(document.body);
					showMsg(returnJson.errMsg || "发送失败","E");
				}
			}
		});
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
    function setPhones(phone){
        phones = phone;
    }