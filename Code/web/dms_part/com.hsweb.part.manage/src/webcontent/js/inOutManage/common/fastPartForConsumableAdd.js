var form=null;
var resultData = {};
var mtAdvisorIdEl = null;
var brandHash = {};
var brandList = [];
var params={};
var data={};
var repairApiUrl = apiPath + repairApi + "/";
$(document).ready(function(){
	form=new nui.Form('#form');

    mtAdvisorIdEl = nui.get("mtAdvisorId");

    initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
    });


    mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
//        nui.get("mtAdvisor").setValue(text);
    });



});


function onOk()
{
	form.validate();
    if (form.isValid() == false) return;
    var node = form.getData();
    var req=/^\d*$/;
    
    if (!req.test(node.outQty)){
	   showMsg("请输入整数");
    }
//    if(node)
//    {
//        resultData = {
//        	data:node
//        };
//        //  return;
//        CloseWindow("ok");
//    }
    partToOut();


}
function getData(){
    return resultData;
}

function SetData(params) {
	params = nui.clone(params);
    if(params.data!=null){
        form.setData(params.data);        
    }
    nui.get('outQty').setValue(1);
    
    data=params.data;
    
 

//    nui.get('mtAdvisorId').setValue(currEmpId);
//    nui.get('mtAdvisorId').setText(currUserName);
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

//出库
var partToOutUrl = repairApiUrl+ "com.hsapi.repair.repairService.work.repairOut.biz.ext";
function partToOut() {
	
	if(onAdvancedAddOk()==false){
		return;
	}
	data.outQty=resultData.outQty ;
	data.pickMan=resultData.pickMan ;

	var stockQty = data.stockQty;
	var preOutQty = data.preOutQty || 0;
	if (data.outQty > stockQty - preOutQty) {
		showMsg("出库数量超出此批次可出库数量", "W");
		return;
	}
	var billTypeId = "050207";
	var partNameId = '0';
	var pickType = '0';
	data.outQty=form.getData().outQty;
	data.pickMan=form.getData().pickMan;
	data.remark=form.getData().remark;
	var sellUnitPrice = data.enterPrice;
	var sellAmt = data.outQty * sellUnitPrice;
	if(data.rootId==0){
		data.rootId=data.id;
	}
	var data1 = {
		enterPrice : data.enterPrice,
		unit : data.enterUnitId,
		partId : data.partId,
		partCode : data.partCode,
		partName : data.partName,
		billTypeId : billTypeId,
		partNameId : partNameId,
		partFullName : data.fullName,
		pickType : pickType,
		preOutQty : data.preOutQty,
		sourceId : data.sourceId,
		stockAmt : data.stockAmt,
		stockQty : data.stockQty,
		storeId : data.storeId,
		sellUnitPrice : sellUnitPrice,
		sellAmt : sellAmt,
		remark : data.remark,
		outQty : data.outQty,
		pickMan : data.pickMan,
		rootId	: data.rootId
	};

	var list = [];
	list.push(data1);
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '出库中...'
	});

	nui.ajax({
		url : partToOutUrl,
		type : "post",
		data : JSON.stringify({
			data : list,
			billTypeId : billTypeId,
			token : token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("出库成功!", "S");
			    CloseWindow("ok");

			} else {
				showMsg(data.errMsg || "出库失败!", "W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {

			console.log(jqXHR.responseText);
		}
	});
}

function onAdvancedAddOk() {
	
	data.outQty=form.getData().outQty;
	data.pickMan=form.getData().pickMan;
	data.remark=form.getData().remark;
	for ( var key in requiredField) {
		if (!data[key] || data[key].toString().trim().length == 0) {
			showMsg(requiredField[key] + "不能为空!", "W");
			if (key == "outQty") {
				var outQty = nui.get("outQty");
				outQty.focus();
			
			}
			if (key == "pickMan") {
				var pickMan = nui.get("pickMan");
				pickMan.focus();
			}
			if (key == "remark") {
				var remark = nui.get("remark");
				remark.focus();
			}

			return false;
		}
	}

}

var requiredField = {

		outQty : "出库数量",
		pickMan : "领料人",
		remark : "出库原因"

	};