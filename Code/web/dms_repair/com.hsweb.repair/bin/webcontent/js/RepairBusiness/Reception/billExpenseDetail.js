var packageGrid = null;
var itemGrid = null;
var partGrid = null;
var sellForm = null;
var receiveGrid = null;
var payGrid = null;
var fserviceId = 0;
var plist = [];
var rlist = [];
var mtAmtEl = null;
var amountEl = null;
var onetInAmt = 0;
var netInAmt = 0;
var printMain = {};//用于打印
var webBaseUrl = webPath + contextPath + "/";
var partBaseUrl = apiPath + partApi + "/";
var baseUrl = apiPath + repairApi + "/";
var expenseUrl = apiPath + repairApi + '/com.hsapi.repair.repairService.svr.getRpsExpense.biz.ext';
$(document).ready(function(v) {
	receiveGrid = nui.get("receiveGrid");
	payGrid = nui.get("payGrid");

	receiveGrid.setUrl(expenseUrl);
	payGrid.setUrl(expenseUrl);

	var params = {isMain:0};
	svrInComeExpenses(params,function(data) {
		var list = data.list||{};
		for(var i = 0; i<list.length; i++){
			var obj = list[i];
			if(obj.itemTypeId==1){
				rlist.push(obj);
			}else if(obj.itemTypeId==-1){
				plist.push(obj);
			}
		}
    });

	receiveGrid.on("drawcell",function(e)
    {
		var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        if(e.field == "optBtn")
        {
			var s = '<a class="optbtn" href="javascript:addReceiveRow(\'' + uid + '\')">新增</a>'
				  + ' <a class="optbtn" href="javascript:deleteReceiveRow(\'' + uid + '\')">删除</a>';
			
			e.cellHtml = s;
        }
        /*if(e.field == "guestName"){
        	var s = '<a href="javascript:onGuestValueChanged()" title="批量设置施工员" style="text-decoration:none;">&nbsp;&nbsp;<span class="fa fa-edit fa-lg"></span></a>';
        	if(e.value){
        		e.cellHtml = e.value + s;
        	}else{
        		e.cellHtml =  s;
        	}
        	
        }*/
	});
	payGrid.on("drawcell",function(e)
    {
		var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        if(e.field == "optBtn")
        {
			var s = '<a class="optbtn" href="javascript:addPayRow(\'' + uid + '\')">新增</a>'
				  + ' <a class="optbtn" href="javascript:deletePayRow(\'' + uid + '\')">删除</a>';
			
			e.cellHtml = s;
        }
       
	});
	
	receiveGrid.on("cellcommitedit",function(e){
		var editor = e.editor;
		var record = e.record;
		
		editor.validate();
		if (editor.isValid() == false) {
			showMsg("请输入数字!","W");
			e.cancel = true;
		}else{
			var value = e.value;
			if(value<0){
				showMsg("金额不能小于0!","W");
				e.cancel = true;
			}

			if (e.field == "amt") {
				var amt = e.value;
				var newRow = {
					amt : amt
				};
				receiveGrid.updateRow(e.row, newRow);
			}
		}
	});

	payGrid.on("cellcommitedit",function(e){
		var editor = e.editor;
		var record = e.record;
		
		editor.validate();
		if (editor.isValid() == false) {
			showMsg("请输入数字!","W");
			e.cancel = true;
		}else{
			var value = e.value;
			if(value<0){
				showMsg("金额不能小于0!","W");
				e.cancel = true;
			}
		}
	});
	
	nui.get("onOk").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
});
function onbillRTypeChange(e){
    var se = e.selected;
    var billTypeCode = se.code;
    var row = receiveGrid.getSelected();
    var newRow = {typeCode: billTypeCode};
    receiveGrid.updateRow(row, newRow);

}
function onbillPTypeChange(e){
    var se = e.selected;
    var billTypeCode = se.code;
    var row = payGrid.getSelected();
    var newRow = {typeCode: billTypeCode};
    payGrid.updateRow(row, newRow);

}
function setData(params){
	var serviceId = params.serviceId||0;
	printMain = params.main||{};//用于打印
	fserviceId = serviceId;
	
	receiveGrid.load({
		serviceId: fserviceId,
		dc: 1,
		token: token
	},function(rs){
		var result = rs.result||{};
		var errCode = result.errCode||"";
		if(errCode=='S'){
			var data = result.data||[];
			if(data && data.length>0){
			}else{
				var row = {};
				receiveGrid.addRow(row);
			}
		}
	});

	payGrid.load({
		serviceId: fserviceId,
		dc: -1,
		token: token
	},function(rs){
		var result = rs.result||{};
		var errCode = result.errCode||"";
		if(errCode=='S'){
			var data = result.data||[];
			if(data && data.length>0){
			}else{
				var row = {};
				payGrid.addRow(row);
			}
		}
	});

	// var row = {};
	// receiveGrid.addRow(row);
	// payGrid.addRow(row);

}
function addReceiveRow(row_uid){
	var row = {};
	receiveGrid.addRow(row);
}
function deleteReceiveRow(row_uid){
    var data = receiveGrid.getData();
    var row = receiveGrid.getRowByUID(row_uid);
    var id = row.id;
    if(data && data.length==1){
		row = data[0];
		receiveGrid.removeRow(row);
		
		var newRow = {};
		receiveGrid.addRow(newRow);
    }else{
		receiveGrid.removeRow(row);
	}
}
function addPayRow(row_uid){
	var row = {};
	payGrid.addRow(row);
}
function deletePayRow(row_uid){
    var data = payGrid.getData();
    var row = payGrid.getRowByUID(row_uid);
    var id = row.id;
    if(data && data.length==1){
		row = data[0];
		payGrid.removeRow(row);

		var newRow = {};
		payGrid.addRow(newRow);
    }else{
		payGrid.removeRow(row);
	}
}
var resultData = {};
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
//取消
function onCancel() {
    CloseWindow("cancel");
}
function adjustData(data){
	var rlist = [];
	for(var i=0; i<data.length; i++){
		var obj = data[i];
		if(obj.typeId && obj.amt){
			rlist.push(obj);
		}
	}

	return rlist;
}
function onOk(){
	var rs = checkGrid();
	if(rs.rmsg || rs.pmsg){
		if(rs.rmsg){
			showMsg(rs.rmsg,"W");
			return;
		}
		if(rs.pmsg){
			showMsg(rs.pmsg,"W");
			return;
		}
	}
	
	var receiveData = receiveGrid.getData();
	var payData = payGrid.getData();

	receiveData = adjustData(receiveData);
	payData = adjustData(payData);

	var json = {
		serviceId:fserviceId,
		receiveData:receiveData,
		payData:payData
	}

	nui.mask({
        el : document.body,
	    cls : 'mini-mask-loading',
	    html : '保存中...'
    });
	nui.ajax({
		url : baseUrl + "com.hsapi.repair.repairService.settlement.saveExpense.biz.ext" ,
		type : "post",
		data : json,
        cache : false,
        contentType : 'text/json',
		success : function(data) {
			nui.unmask(document.body);
			if(data.errCode=="S"){
				showMsg("保存成功","S");
			}else{
				nui.alert(data.errMsg,"提示");
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});	
}
function checkGrid(){
	var rrows = receiveGrid.findRows(function(row){
		var amt = row.amt||0;
		var typeId = row.typeId;
		if(amt > 0 && typeId == null){
			return true;
		}
	});

	var rs = {};
	rs.rmsg = "";
	rs.pmsg = "";
	if(rrows && rrows.length>0){
		rs.rmsg = "请选择收入项目!";
		return rs;
	}
	
	var prows = payGrid.findRows(function(row){
		var amt = row.amt||0;
		var typeId = row.typeId;
		if(amt > 0 && typeId == null){
			return true;
		}
	});

	if(prows && prows.length>0){
		rs.pmsg = "请选择费用科目!";
		return rs;
	}

	return rs;
}

var getGuestInfo = partBaseUrl+"com.hsapi.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params)
{
    nui.ajax({
        url:getGuestInfo,
        data: {params: params, token: token},
        type:"post",
        success:function(text)
        {
            if(text)
            {
                var supplier = text.suppliers;
                if(supplier && supplier.length>0) {
                    var data = supplier[0];
                    var value = data.id;
                    var text = data.fullName;
                    var el = nui.get('guestId');
                    el.setValue(value);
                    el.setText(text);
                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);
                }
            }
            else
            {
                var el = nui.get('guestId');
                el.setValue(null);
                el.setText(null);
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
        }
    });
}


function onGuestValueChanged(e)
{
	
    var record = e.record;
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.guestName = record.guestName;
    params.expense = 1;
    record.type = 1;
    selectSupplier(params,record);
}

function selectGuest(){
	var row = receiveGrid.getSelected();
	if(row){
		var params = {};
	    params.guestName = row.guestName;
	    params.expense = 1;
	    row.type = 1;
	    selectSupplier(params,row);
	}else{
		showMsg("请选择一条记录!","W");
		return;
	}
}

function selectGuest1(){
	var row = payGrid.getSelected();
	if(row){
		var params = {};
	    params.guestName = row.guestName;
	    params.expense = 1;
	    row.type = 2;
	    selectSupplier(params,row);
	}else{
		showMsg("请选择一条记录!","W");
		return;
	}
}

function onGuestValueChanged1(e)
{
	var record = e.record;
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.guestName = record.guestName;
    //控制供应商选择界面根据输入的值查询
    params.expense = 1;
    record.type = 2;
    selectSupplier(params,record);
}
var supplier = null;    
function selectSupplier(params,row)
{
	 /*nui.get("serviceId").setValue("新对账单");
     nui.get("createDate").setValue(new Date());
     nui.get("stateMan").setValue(currUserName);*/
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title: "往来单位", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
               
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                row.guestName = text;
                row.guestId = value;
                if(row.type == 1){
                	receiveGrid.updateRow(row);
                }
                if(row.type == 2){
                	payGrid.updateRow(row);
                }
            }
        }
    });
}

function onPrint(){plist
	var source = printMain.source||0;
	var serviceId = printMain.serviceId||0;
	//收入类
    var receiveData  =  receiveGrid.getData();
    //若没有，则会获取到空白的第一行，所以要取消
    if(receiveData[0].typeId==null){
    	receiveData = [];
    }
	//支出类
    var payData = payGrid.getData();
    //若没有，则会获取到空白的第一行，所以要取消
    if(payData[0].typeId==null){
    	payData = [];
    }
    for(var i =0;i<receiveData.length;i++){
        for(var j =0;j<rlist.length;j++){
        	if(receiveData[i].typeId ==rlist[j].id){
        		receiveData[i].typeName = rlist[j].name;
        	}
        }
    }
    for(var i =0;i<payData.length;i++){
        for(var j =0;j<plist.length;j++){
        	if(payData[i].typeId ==plist[j].id){
        		payData[i].typeName = plist[j].name;
        	}
        }
    }

	var printName = currRepairSettorderPrintShow||currOrgName;
	var p = {
		serviceId : serviceId,
		serviceCode : printMain.serviceCode,
		comp : printName,
		partApiUrl:apiPath + partApi + "/",
		baseUrl: apiPath + repairApi + "/",
		sysUrl: apiPath + sysApi + "/",
		webUrl:webPath + contextPath + "/",
        bankName: currBankName,
        bankAccountNumber: currBankAccountNumber,
        currCompAddress: currCompAddress,
        currUserName :currUserName,
        currCompTel: currCompTel,
        currSlogan1: currSlogan1,
        currSlogan2: currSlogan2,
        currCompLogoPath: currCompLogoPath,
        currRepairBillMobileFlag:currRepairBillMobileFlag,
        currIsCanfreeCarnovin:currIsCanfreeCarnovin,
        name : "费用登记打印",
	    receiveData : receiveData,
	    payData : payData,
		token : token 
	};
	var sourceUrl = webPath + contextPath + "/repair/DataBase/Card/printExpenseDetail.jsp?token="+token;
	nui.open({
        url: sourceUrl,
        title: p.name + "打印",
		width: "100%",
		height: "100%",
        onload: function () {
            var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(p);
        },
        ondestroy: function (action){
        }
    });
	
}