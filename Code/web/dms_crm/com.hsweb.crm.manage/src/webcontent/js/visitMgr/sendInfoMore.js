var webBaseUrl = webPath + contextPath + "/";
var form1 = null;
var mainDatas = [];
var visitContent = null;
var baseUrl = apiPath + sysApi + "/";
var sendUrl = baseUrl+"com.hsapi.system.basic.smsPushMore.biz.ext";
var saveUrl = apiPath + repairApi +"/com.hsapi.repair.repairService.crud.saveRemindRecord.biz.ext";
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
   
function setData(rows) {
    mainDatas = rows;
}


function save() {
    //mainData.mobile = '15607733238';
        //验证
    	var message  = visitContent.getValue();
        if(message=="" || message==null){
            showMsg("请输入短信内容!","W");
            return ;
        }

         nui.mask({
           el: document.body,
           cls: 'mini-mask-loading',
           html: '短信发送中...'
        });
       
        var json = nui.encode({
			"list" : mainDatas,
			"msg" : message,
			token : token
        });   
        var params = {
            
        }
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
                    showMsg(returnJson.errMsg || "发送成功", "S");
                    //saveRecord(mainData);
					CloseWindow("ok");
				} else {
					nui.unmask(document.body);
					showMsg(returnJson.errMsg || "发送失败","E");
					
				}
			}
		});
}



function saveRecord(data) {
    //var data = form1.getData();
    var message  = visitContent.getValue();
    var params ={
        serviceType:data.serviceType,
        mainId:data.id||'',
        guestId:data.guestId||'',
        carId:data.carId||'',
        carNo: data.carNo || '',
        visitMode:'011402',//短信
        visitContent:message||'',
    }
    nui.ajax({
        url:saveUrl,
        type:'post',
        data:{
            params:params
        },
        success:function(res){
            if(res.errCode == 'S'){
                // showMsg("保存成功！","S");
            }else{
                // showMsg("保存失败！","E");
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
