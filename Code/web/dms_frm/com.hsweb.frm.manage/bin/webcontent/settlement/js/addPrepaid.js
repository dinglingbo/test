var bearUrl  = apiPath +saleApi + "/";
var advancedSearchForm = null;
var plist = [];
var rlist = [];
var prepaid = {};//主页面传过来
$(document).ready(function(v){
	advancedSearchForm = new nui.Form("#advancedSearchForm");
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
		nui.get("payBillTypeList").setData(plist);
		nui.get("closedBillTypeList").setData(rlist);
    }); 
});

function setData(data){
		prepaid = data;
		if(data.type==-2){
			document.getElementById("closed").style.display="none";
			document.getElementById("pay").style.display="inline";
			document.getElementById("closedBillTypeList").style.display="none";
			document.getElementById("payBillTypeList").style.display="inline";
		}else if(data.type==2){
			document.getElementById("pay").style.display="none";
			document.getElementById("closed").style.display="inline";
			document.getElementById("payBillTypeList").style.display="none";
			document.getElementById("closedBillTypeList").style.display="inline";
		}
}

var requiredField = {
		guestId : "往来单位",
		billTypeId : "预收/预付项目"
	};
var saveFisRpAdvanceUrl = bearUrl+"com.hsapi.sales.svr.inventory.saveFisRpAdvance.biz.ext";
function onOk(){
	var data = advancedSearchForm.getData();
	if(prepaid.type==-2){
		data.billTypeId = nui.get("payBillTypeList").getValue();
		data.billDc = -2;
	}else if(prepaid.type==2){
		data.billTypeId = nui.get("closedBillTypeList").getValue();
		data.billDc = 2;		
	}
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			parent.showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
	}
	data.billTypeCode = data.billTypeId;

	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
    nui.ajax({
        url: saveFisRpAdvanceUrl,
        type:"post",
        async: false,
        data:{
        	fisRpAdvance:data,
        	token:token
        },
        cache: false,
        success: function (text) {
        	nui.unmask(document.body);
            var list = text.list;
            if(text.errCode=="S"){
            	parent.showMsg("保存成功","S");
            	onCancel();
            }else{
            	parent.showMsg("保存异常","W");
            }
        }
    });
}

function onCancel(){
	CloseWindow("ok");
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else
        window.close();
}

/*function onbillPTypeChange(e){
    var se = e.selected;
    var billTypeCode = se.code;
    var row = payGrid.getSelected();
    var newRow = {typeCode: billTypeCode};
    payGrid.updateRow(row, newRow);

}*/

var supplier = null;
function selectSupplier(elId) {
	supplier = null;
	nui.open({
		// targetWindow: window,,
		url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
		title : "供应商资料",
		width : 980,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			// var params = {
            //     isSupplier: 1,
            //     guestType:'01020202'
			// };
			var params = {
                isSupplier: 1,
                guestType :"01020201"
            };
            iframe.contentWindow.setGuestData(params);
		},
		ondestroy : function(action) {
			if (action == 'ok') {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();

				supplier = data.supplier;
				var value = supplier.id;
				var text = supplier.fullName;
				var billTypeIdV = supplier.billTypeId;
				var settTypeIdV = supplier.settTypeId;
				var el = nui.get(elId);
				el.setValue(value);
				el.setText(text);
				nui.get("guestName").setValue(text);
			}
		}
	});
}