var basicInfoForm = null;
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var guestTypeList = [];
var guestTypeHash = {};
var provice; 
var cityId;
$(document).ready(function()
{
	
	basicInfoForm = new nui.Form("#basicInfoForm");
	provice = nui.get("provice");
    cityId = nui.get("cityId");
	//nui.get("name").focus();	
	nui.get("mobile").focus();
    document.onkeyup=function(event){
		var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下
        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
      initProvince("provice");
      initGuestType("guestTypeId",function(data) {
    	guestTypeList = nui.get("guestTypeId").getData();
    	guestTypeList.forEach(function(v) {
    		guestTypeHash[v.id] = v;
        });
    });
});

var yes = 0;
var queryGuestUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.svr.queryCustomerListByMobile.biz.ext";
function onChangedMobile(id){
	if(id=="fullName"){
		fullName = nui.get("fullName").value;
		nui.get("shortName").setValue(fullName);
		
	}
	if(id=="mobile"){
		var mobile = nui.get("mobile").value;
		mobile = mobile.replace(/\s*/g,"");
		var params = 
	      {
			"guestId":row.guestId,
	        "mobile":mobile
	      };
		
		if(mobile.length==11){
			nui.mask({
		        el : document.body,
			    cls : 'mini-mask-loading',
			    html : '加载中...'
		    });
			nui.ajax({
				url : queryGuestUrl,
				type : "post",
				data : JSON.stringify({
					params:params,
					token: token
				}),
			success:function(data) {
					nui.unmask(document.body);
					var list = data.list;
					if(list.length){
						nui.open({
							//// targetWindow: window,,
							url :webBaseUrl + "repair/RepairBusiness/CustomerProfile/selectSplitGuest.jsp",
							title : "选择客户",
							width : 600,
							height : 300,
							allowDrag : true,
							allowResize : false,
							onload : function() {
								var car = {}
								car.id = row.id;
								car.carNo = row.carNo;
								var iframe = this.getIFrameEl();
								var data = iframe.contentWindow.setData(list,car);
							},
							ondestroy : function(action) {
								if (action == "ok") {
									yes = 1;
									onCancel();
								}else{
									yes = 0;
								}
							}
						});
					}			
				},
			error:function(jqXHR, textStatus, errorThrown) {
				nui.unmask(document.body);
				console.log(jqXHR.responseText);
			}
	  });
     }
   }
}
//取消
function onCancel() {
    CloseWindow("cancel");
}
function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
var row = null;
function setData(params){
	row = params;
}

var saveSplit = baseUrl + "com.hsapi.repair.repairService.crud.saveSplitCar.biz.ext";
function onOk()
{
    var guest = basicInfoForm.getData();
    guest.guestType = "01020103";
    var car = {}
	car.id = row.id;
	car.carNo = row.carNo;
	if(yes==0){
		nui.mask({
	        el : document.body,
		    cls : 'mini-mask-loading',
		    html : '保存中...'
	    });
		nui.ajax({
			url : saveSplit,
			type : "post",
			data : JSON.stringify({
	        	guest:guest,
	        	car:car,
	        	action:"add",
				token: token
			}),
	        success : function(data)
		        {
		        	nui.unmask(document.body);
		            data = data||{};
		            if(data.errCode == "S")
		            {
		                showMsg("拆分成功","S");
		                onCancel();
		            }
		            else{
		                showMsg(data.errMsg||"拆分失败","E");
		            }
		        },
		        error : function(jqXHR, textStatus, errorThrown) {
		            //  nui.alert(jqXHR.responseText);
		        	nui.unmask(document.body);
		            console.log(jqXHR.responseText);
		            showMsg("网络出错","E");
		        }
		    });
	}
   
}

