var guestGrid = null;
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var queryGuestUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.crud.queryCustomerList.biz.ext";
var queryForm = null;
var sexTypeHash = {
	    "0":"男",
	    "1":"女",
	    "2":"未知"
};
$(document).ready(function()
{
	queryForm = new nui.Form("#queryForm");
	guestGrid = nui.get("#guestGrid");
	guestGrid.setUrl(queryGuestUrl);
	var params = {
			token:token
	}
	guestGrid.load({params:params});
	nui.get("mobile").focus();
	guestGrid.on("drawcell",function(e){
	    var record = e.record;
        var uid = record._uid;
         switch (e.field) {
             case "sex":
            	 e.cellHtml = sexTypeHash[e.value];
            	 break;
             default:
                 break;
        }
    });
    document.onkeyup=function(event){
		var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下
        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
      guestGrid.on("rowdblclick",function(e){
    	  onOk();
      })
});

//取消
function onCancel() {
    CloseWindow("cancel");
}
function CloseWindow(action) {
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
var cars = {};
var oldGuest = {};
function setData(rows,guest){
	cars = rows;
	oldGuest = guest;
}

var saveSplit = baseUrl + "com.hsapi.repair.repairService.crud.saveSplitCar.biz.ext";
function onOk()
{
	var guest = guestGrid.getSelected();
	if(guest){
		if(guest.id == oldGuest.id){
			showMsg("合并的客户相同，不用合并!","W");
			return;
		}
		var mobile = guest.mobile;
		 nui.confirm("是否合并到手机号为"+mobile+"的客户下？", "友情提示",function(action){
		       if(action == "ok"){
				    nui.mask({
				        el : document.body,
					    cls : 'mini-mask-loading',
					    html : '处理中...'
				    });
				    var remark = nui.get("remark").value;
					nui.ajax({
						url : saveSplit,
						type : "post",
						data : JSON.stringify({
				        	guest:guest,
				        	carList:cars,
				        	oldGuest:oldGuest,
				        	remark:remark,
							token: token
						}),
				        success : function(data)
					        {
					        	nui.unmask(document.body);
					            data = data||{};
					            if(data.errCode == "S")
					            {
					                showMsg("合并成功","S");
					                CloseWindow("ok");
					            }
					            else{
					                showMsg(data.errMsg||"合并失败","E");
					            }
					        },
					        error : function(jqXHR, textStatus, errorThrown) {
					            //  nui.alert(jqXHR.responseText);
					        	nui.unmask(document.body);
					            console.log(jqXHR.responseText);
					            showMsg("网络出错","E");
					        }
					 });
		     }else {
					return;
			 }
		});	
	}else{
		showMsg("请选择要合并的客户!","W");
	}
	
}

function onSearch(){
	var data = queryForm.getData();
	guestGrid.load({params:data});
}



