var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryTimesCardDetail.biz.ext";
var tab = null;
var form = null;
var form2 = null;
var timesCardDetail = null;
var g = null;
var set = null;
var input = null;
//页面标签加载完之后执行，但是修改的数据还没有设置
$(document).ready(function(v) {
	tab = nui.get("tab");
	form = new nui.Form("#dataform1");
	form2 = new nui.Form("#dataform2");
	form.setChanged(false);
	
    set = mini.get("setMonth");
    input = mini.get("inputMonth");
    timesCardDetail = nui.get("timesCardDetail");
    //编辑开始前发生
    timesCardDetail.on("cellbeginedit",function(e){
    	if(type =="VIEW"){
    		e.cancel = true;
    	}
    });
});



var type = null;
function setData(data) {
	// 跨页面传递的数据对象，克隆后才可以安全使用
	var json = nui.clone(data);
	// 如果是点击编辑类型页面
	if (json.id != null) {
		
		if(json.periodValidity==-1){
			json.periodValidity = "";
			input.disable();
			set.setValue(true);
		}
		form.setData(json);
		form.setChanged(false);
	}
	if(json && json.type){
		type = json.type;
	}
	// 计次卡明细查询
	var json1 = nui.encode({
		"timesCard" : json,
		token:token
	});
	nui.ajax({
		url : gridUrl,
		type : 'POST',
		data : json1,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.exception == null) {
				g = nui.get("#timesCardDetail");
				g.setData(returnJson.timesCardDetail);
			} else {
				nui.alert("获取明细失败", "系统提示", function(action) {
					if (action == "ok" || action == "close") {
						// CloseWindow("saveFailed");
					}
				});
			}
		}
	});

}

function gridAddRow(datagrid) {
	var grid = nui.get(datagrid);
	grid.addRow({});
}

function gridRemoveRow(datagrid) {
	g = nui.get("#timesCardDetail");
	var rows = g.getSelecteds();
	if (rows.length > 0) {
		g.removeRows(rows, true);
	}
}

function setGridData(datagrid, dataid) {
	var grid = nui.get(datagrid);
	var grid_data = grid.getChanges();
	nui.get(dataid).setValue(grid_data);
}



function onReset() {
	form.reset();
	form.setChanged(false);
}

function onCancel() {
	CloseWindow("cancel");
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function updateError(e) {

	if (nui.get('x').getValue() == "3") {
		document.getElementById('y').innerHTML = "元";
	} else {

		document.getElementById('y').innerHTML = "%";
	}
}


/*
 * 看保存的逻辑流时怎么样的，如果没有值，是否赋值了-1
 * */
function changed(e){
	
	if(set.checked){	
		//把输入框的值清除掉
		 input.setValue("");
		 input.disable();
	}else{
		 
		 input.enable();
	}
	
}

function disableEle(){
	
	var controls=mini.getChildControls(form);
	for(var i=0,length=controls.length;i<length;i++){
	       controls[i].setReadOnly(true);
	}
}



function selectCustomer() {
    openCustomerWindow(function (v) {
       
    	contactorName = mini.get("contactorName");	
       var  main = form2.getData();
        main.guestId = v.guestId;
        main.contactorName = v.guestFullName;
        contactorName.setText(v.guestFullName);
        form2.setData(main);
       // $("#contactorName").setValue(v.guestFullName);
    });
}

function openCustomerWindow(callback) {
    nui.open({
        url: "com.hsweb.RepairBusiness.Customer.flow",
        title: "客户选择", width: 800, height: 450,
        onload: function () {
        },
        ondestroy: function (action) {
            if ("ok" == action) {
                var iframe = this.getIFrameEl();
                //调用子界面的方法，返回子界面的数据
                var data = iframe.contentWindow.getData();
                var guest = data.guest;
                callback && callback(guest);
            }
        }
    });
}


function onDrawCell(e) {
	var hash = new Array("套餐", "工时", "配件");
	switch (e.field) {
	case "prdtType":
		e.cellHtml = hash[e.value - 1];
		break;
	}
}

var payType = {
		'020101':'现金',
		'020102':'刷卡',
	    '020104':'微信/支付宝'		
}

var payMeth = apiPath + repairApi + "/com.hsapi.repair.repairService.settlement.receiveCardTimes.biz.ext";
function payOk(){
	
	var data = form2.getData();
	
	var rpbCard = form.getData();
	
	if(data.contactorName){
		
		
		
		var cardTimes ={
				guestId:data.guestId,
				guestName:data.contactorName,
				cardId:rpbCard.id,
				cardName:rpbCard.name,
				periodValidity:rpbCard.periodValidity,
				salesDeductType:rpbCard.salesDeductType,
				remark:rpbCard.remark,
				salesDeductValue:rpbCard.salesDeductValue,
				sellAmt:rpbCard.sellAmt,
				totalAmt:rpbCard.totalAmt,
				useRemark:rpbCard.useRemark
		};
		//整理数据
		 var payAmt = rpbCard.sellAmt;
		 var json = nui.encode({
			"payAmt":payAmt,
			"payType":data.payType,
		     "cardTimes":cardTimes,
		     token:token
		 });
		//提示框 
		//判断客户有没有选择
		nui.confirm("你确定以"+payType[data.payType]+"结算方式结算吗？", "友情提示", function(action) {
			if (action == "ok") {
				nui.mask({
					el : document.body,
					cls : 'mini-mask-loading',
					html : '处理中...'
				});
				
				  nui.ajax({
				        url : payMeth,
				        type : 'POST',
				        data : json,
				        cache : false,
				        contentType : 'text/json',
				        success : function(text) {		
				        	nui.unmask(document.body);
				        	 var returnJson = nui.decode(text);
				              if (returnJson.errCode == "S") {
				            	  nui.alert("结算成功", "系统提示", function(action) {
				                      if (action == "ok" || action == "close") {
				                          // CloseWindow("saveFailed");
				                      }
				                  });
				              }
				                  //CloseWindow("saveSuccess");
				               else {
				                  nui.alert("结算失败:"+returnJson.errMsg, "系统提示", function(action) {
				                      if (action == "ok" || action == "close") {
				                          // CloseWindow("saveFailed");
				                      }
				                  });
				        }
				        					        	
				        }				        	  
				 });
				
			} else {
				return;
			}
		});
		

		
	}else{
		nui.alert("请选择客户", "提示");
		
	}	
	
}

function saveOn(){
	
	
	
	//判断客户有没有选择
	var data = form.getData();
	if(data.contactorName){
		//要把数据对应好，才能保存
		//基本数据
		
		
	}else{
		
	}	
	
	
}

