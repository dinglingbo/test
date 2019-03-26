var basicInfoForm = null;
var webBaseUrl = webPath + contextPath + "/";
$(document).ready(function()
{
	
	basicInfoForm = new nui.Form("#basicInfoForm");
	//nui.get("name").focus();
	
	nui.get("mobile").focus();
    document.onkeyup=function(event){
		var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下
        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
});

var yes = null;
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
								var iframe = this.getIFrameEl();
								var data = iframe.contentWindow.setData(list);
							},
							ondestroy : function(action) {
								if (action == "ok") {
									yes = 1;
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
var row = null;
function setData(params){
	row = params;
}
