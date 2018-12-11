var tabs = null;
var mainGrid1 = null;
var params = {};
var form = null;
var grid1 = null;
var grid2 = null;
var baseUrl = apiPath + repairApi + "/";
var mainGrid2 = null;
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"项目",
	    "3":"配件"
};
$(document).ready(function () {
    mainGrid1 = nui.get("mainGrid1");
    form = new nui.Form("#editForm1");
    grid1 = nui.get("grid1");
    grid2 = nui.get("grid2");
    grid1.setUrl(baseUrl+"com.hsapi.repair.baseData.query.queryCardTimesByGuestId.biz.ext");
    grid2.setUrl(baseUrl+"com.hsapi.repair.baseData.query.queryCardByGuestId.biz.ext");
    mainGrid1.setUrl(baseUrl+"com.hsapi.repair.repairService.query.querySettleList.biz.ext");
    mainGrid2 = nui.get("mainGrid2");

        grid2.on("load",function(e){
        	var data = e.data;
        	for(var i = 0;i<data.length;i++){
        		data[i].balaAmt=data[i].totalAmt-data[i].useAmt;
        		grid2.updateRow(data[i],i);
        	}
        });
        nui.get("carNo").focus();
        document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
      
      var tip = new nui.ToolTip();
      tip.set({
          target: document,
          selector: '#carModel .mini-textbox-input',
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
      
      grid1.on("drawcell", function (e) {
          switch (e.field) {
              case "prdtType":
            	  e.cellHtml = prdtTypeHash[e.value];
            	  break;
              default:
                  break;
          }
      });
});

//取消
function onCancel() {
    CloseWindow("cancel");
}
//关闭窗口
function CloseWindow(action) {
    if (action == "close" && form.isChanged()) {
        if (confirm("数据被修改了，是否先保存？")) {
            saveData();
        }
    }
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}

function SetData(params){
	nui.get("carId").setValue(params.carId);
	nui.get("guestId").setValue(params.guestId);
	
	var json = {
			carId : nui.get("carId").value
    };
	nui.ajax({
        url: baseUrl+"com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext",
        type : "post",
        data : {
        	params:json,
        	token:token
        },
        async:false,
        success: function (text) {
            var list = nui.decode(text.list);
            form.setData(list[0]);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            showMsg("网络出错", "E");
        }
    });
    var pa = {
    		guestId:params.guestId,
    		token:token
    };
    grid1.load({p:pa});
    mainGrid1.load({params:pa});

    grid2.load({guestId:params.guestId});
    nui.ajax({
        url: baseUrl+"com.hsapi.repair.repairService.svr.getGuestCarContactInfoById.biz.ext",
        type : "post",
        data : {
        	guestId : params.guestId
        },
        success: function (data) {
        	var contactList = data.contactList||[{}];
            var form1 = new nui.Form("#editForm4");
            form1.setData(contactList[0]);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            showMsg("网络出错", "E");
        }
    });
   
}

