var tabs = null;
var mainGrid1 = null;
var params = {};
var form = null; 
var datagrid1 = null;
var datagrid2 = null;
var datagrid3 = null;
var grid = null;
var grid1 = null;
var grid2 = null;
var visitHis = null;//回访记录
var baseUrl = apiPath + repairApi + "/";
var mainGrid2 = null;
var prdtTypeHash = {
	    "1":"套餐",
	    "2":"项目",
	    "3":"配件"
};
var serviceTypeList = [{},{ id: 1, text: '电销' }, { id: 2, text: '预约' }, { id: 3, text: '客户回访' }, { id: 4, text: '流失回访' }, { id: 5, text: '保养提醒' }, { id: 6, text: '商业险到期' }, { id: 7, text: '交强险到期' }, { id: 8, text: '驾照年审' }, { id: 9, text: '车辆年检' }, { id: 10, text: '生日' }];
var hisUrl = apiPath + crmApi+ "/com.hsapi.crm.svr.visit.queryCrmVisitRecordSql.biz.ext";//回访url
var queryOldMaintain = baseUrl
+"com.hsapi.repair.baseData.crud.queryOldMaintain.biz.ext";
var queryOldItemPart = baseUrl
+"com.hsapi.repair.baseData.crud.queryOldItemPart.biz.ext";
var grid3 = null;
var grid4 = null;
var servieTypeList = [];
var servieTypeHash = {};
var hash = {};
$(document).ready(function () {
	datagrid1 = nui.get("datagrid1");
	datagrid2 = nui.get("datagrid2");
	datagrid3 = nui.get("datagrid3");
	datagrid1.setUrl(queryOldMaintain);
    mainGrid1 = nui.get("mainGrid1");
    form = new nui.Form("#editForm1");
    visitHis = nui.get("visitHis");
    visitHis.setUrl(hisUrl);
    
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
              case "doTimes":
            	  var row = e.row;
                  var balaTimes = row.balaTimes || 0;
                  var canUseTimes = row.canUseTimes||0;
                  e.cellHtml = balaTimes - canUseTimes;
              default:
                  break;
          }
      });
      visitHis.on("drawcell", function (e) {
        if (e.field == "serviceType") {
            e.cellHtml = serviceTypeList[e.value].text;
        } else if(e.field == "visitMode"){//跟踪方式
            e.cellHtml = setColVal('visitMode', 'customid', 'name', e.value);
        }
    });
    initDicts({
        visitMode: "DDT20130703000021",//跟踪方式
          //carSpec:CAR_SPEC,//车辆规格
          //kiloType:KILO_TYPE,//里程类别
          //source:GUEST_SOURCE,//客户来源
          identity:IDENTITY //客户身份
      },function(){
    	  var identityList = nui.get("identity").getData();
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

function SetData(params) {
	nui.get("carId").setValue(params.carId);
	nui.get("guestId").setValue(params.guestId);
	
	nui.ajax({
        url: baseUrl+"com.hsapi.repair.repairService.report.queryCarByCarId.biz.ext",
        type : "post",
        data : {
        	carId:params.carId,
        	token:token
        },
        async:false,
        success: function (text) {
            var list = nui.decode(text.rpbCar);
            form.setData(list);
            searchOld(list.carNo||"");
            var carExtend = {};
            carExtend.lastComeKilometers = list.lastComeKilometers;
            carExtend.careDueMileage = list.careDueMileage;
            carExtend.careDueDate = list.careDueDate;
            nui.get("editForm2").setData(carExtend);
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
        	var guest = data.guest||[{}];
            var form1 = new nui.Form("#editForm4");
            form1.setData(guest);
        	var contactList = data.contactList||[{}];
            var form5 = new nui.Form("#editForm5");
            form5.setData(contactList[0]);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
            showMsg("网络出错", "E");
        }
    });
    // 回访记录根据联系人id查询
    if (params.contactorId) {
        var p = {
            guestId:params.contactorId,
            token:token
        };
        visitHis.load({ params:p });
    }
}


function searchOld(carNo){
	datagrid2.setData([]);
	datagrid3.setData([]);
	var params = {
			carNo:carNo
	}
	var json1 = {
			params:params,
			token:token
	}
	nui.ajax({
		url : queryOldMaintain,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			datagrid1.setData(text.oldMaintain);
					
		}
	});
}
function selectionChanged() {
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	var row = datagrid1.getSelected();
	var serviceCode = row.serviceCode;
	var params = {};
	params.serviceCode = serviceCode;
	var json1 = {
			params:	params
	};
	nui.ajax({
		url : queryOldItemPart,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			datagrid2.setData(text.oldPart);
			datagrid3.setData(text.oldItem);
		}
	});
}
