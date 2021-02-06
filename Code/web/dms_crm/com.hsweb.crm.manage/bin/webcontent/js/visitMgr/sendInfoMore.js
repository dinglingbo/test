var webBaseUrl = webPath + contextPath + "/";
var form1 = null;
var mainDatas = [];
var visitContent = null;
var baseUrl = apiPath + sysApi + "/";
var sendUrl = baseUrl+"com.hsapi.system.basic.smsPush.testPushMore.biz.ext";
var saveUrl = apiPath + repairApi +"/com.hsapi.repair.repairService.crud.saveRemindRecordMore.biz.ext";
var taskUrl = apiPath + crmApi +"/com.hsapi.crm.svr.guest.saveSendTask.biz.ext";
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
    // 	var message  = visitContent.getValue();
    //     if(message=="" || message==null){
    //         showMsg("请输入短信内容!","W");
    //         return ;
    //     }

    //      nui.mask({
    //        el: document.body,
    //        cls: 'mini-mask-loading',
    //        html: '短信发送中...'
    //     });
       
    //     var json = nui.encode({
	// 		"list" : mainDatas,
	// 		"msg" : message,
	// 		token : token
    //     });   
    //     var params = {
            
    //     }
    //    nui.ajax({
	// 		url : sendUrl,
	// 		type : 'POST',
	// 		data : json,
	// 		cache : false,
	// 		contentType : 'text/json',
	// 		success : function(text) {
	// 			var returnJson = nui.decode(text);
	// 			if (returnJson.errCode == "S") {
	// 			    nui.unmask(document.body);
    //                 showMsg(returnJson.errMsg || "发送成功", "S");
    //                 saveRecord();
	// 				CloseWindow("ok");
	// 			} else {
	// 				nui.unmask(document.body);
	// 				showMsg(returnJson.errMsg || "发送失败","E");
					
	// 			}
	// 		}
    // 	});
    saveTask();
}


function saveTask() {
    if (mainDatas.length > 0) {
        var params = {
            serviceType: mainDatas[0].serviceType,
            visitMode: '011402',//短信
            taskNum: mainDatas.length,
        }

        var message = visitContent.getValue();
        var Arr = [];
        for (var i = 0; i < mainDatas.length; i++) {
            var data = mainDatas[i];
            var pa ={
                guestId: data.tureGuestId || '',
                contactorId: data.conId,
                mobile:data.mobile,
                carId:data.carId||'', 
                carNo: data.carNo || '',
                visitContent: message || '',
                guestSource: data.guestSource,
                wechatOpenId: data.wechatOpenId,
                wechatServiceId:data.wechatServiceId
            };
            Arr.push(pa);
        }
              nui.mask({
                el: document.body,
                cls: 'mini-mask-loading',
                html: '短信发送任务后台生成中...'
             });
        nui.ajax({
            url: taskUrl,
            type: 'post',
            data: {
                taskMain: params,
                taskDetail:Arr
            },
            success: function (res) {
                nui.unmask(document.body);
                if (res.errCode == 'S') {
                    showMsg(res.snum+"条短信发送任务生成成功！", "S");
                    //zsaveRecord();
					CloseWindow("ok");
                } else {
                    showMsg(res.fnum+"条短信发送任务生成失败！","E");
                }
            }
        })
    }
}


function saveRecord() {
    //var data = form1.getData();
    var message = visitContent.getValue();
    var Arr = [];
    for (var i = 0; i < mainDatas.length; i++) {
        var data = mainDatas[i];
        

    var params ={
            serviceType:data.serviceType,
            mainId:data.id||'',
            guestId:data.guestId||'',
            carId:data.carId||'',
            carNo: data.carNo || '',
            visitMode:'011402',//短信
            visitContent: message || '',
            guestSource:data.guestSource
        };
        Arr.push(params);
    }
    nui.ajax({
        url:saveUrl,
        type:'post',
        async:false,
        data:{
            params:Arr
        },
        success:function(res){
            // if(res.errCode == 'S'){
            //     showMsg("发送成功！","S");
            // }else{
            //     showMsg("发送失败！","E");
            // }
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
