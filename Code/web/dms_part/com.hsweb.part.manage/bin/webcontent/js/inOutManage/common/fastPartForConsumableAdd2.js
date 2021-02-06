var form=null;
var resultData = {};
var mtAdvisorIdEl = null;
var mtAdvisorIdEl2=null;
var data={};
var returnRemark=null;
var repairApiUrl = apiPath + repairApi + "/";
$(document).ready(function(){
	form=new nui.Form('#form');
	nui.get('outQty').enabled=false;
    mtAdvisorIdEl = nui.get("mtAdvisorId");
   
    returnRemark=nui.get('returnRemark');
    
    initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
        mtAdvisorIdEl.focus();
    });


    mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
//        nui.get("mtAdvisor").setValue(text);
    });
;
    document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		

		if ((keyCode == 27)) { // ESC
			CloseWindow('cancle');
		}

	}
});


function onOk()
{
	form.validate();
    if (form.isValid() == false) return;
    var node = form.getData();
    if(node)
    {
        resultData = {
        	data:node
        };

    }
    if(node.mId){
    	closeWindow("ok");
    }
    else{
    	orderEnter();
    }

}
function getData(){
    return resultData;
}

function GetFormData(){
    var data = form.getData();
    return data;
}

function SetData(params) {
    var params = nui.clone(params);
    if(params.data!=null){
        form.setData(params.data);
    }
    data=params.data;
    if(data.mId){
    	nui.get('outQty').enabled=true;
    }
    nui.get('mtAdvisorId').setValue(currUserName); 
    nui.get('mtAdvisorId').setText(currUserName); 
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

//归库
var backUrl = repairApiUrl
		+ "com.hsapi.repair.repairService.work.repairOutRtn.biz.ext";
function orderEnter() {

	nui.confirm("是否确定归库?", "友情提示", function(action) {
		if (action == "ok") {

			data.partNameId = '0';
			data.pickType = '0';
			data.outQty=form.getData().outQty;
			data.returnMan=form.getData().returnMan;
			data.returnRemark=form.getData().returnRemark;
			var list = [];
			list.push(data);

			nui.mask({
				el : document.body,
				cls : 'mini-mask-loading',
				html : "归库中..."
			});

			nui.ajax({
				url : backUrl,
				type : "post",
				data : JSON.stringify({
					data : list,
					billTypeId : data.billTypeId,
					token : token
				}),
				success : function(data) {
					nui.unmask(document.body);
					data = data || {};
					if (data.errCode == "S") {
						showMsg("归库成功!", "S");
						CloseWindow("ok");
	
					} else {
						showMsg(data.errMsg || ("归库失败!"), "W");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});

		} else {
			return;
		}
	});

}

var requiredField = {

		outQty : "归库数量",
		returnMan : "归库人",
//		returnRemark : "归库原因"

	};
function onAdvancedAddOk() {
	
	if(onAdvancedAddOk()==false){
		return;
	}
	data.outQty=form.getData().outQty;
	data.returnMan=form.getData().returnMan;
	data.returnRemark=form.getData().returnRemark;
	for ( var key in requiredField) {
		if (!data[key] || data[key].toString().trim().length == 0) {
			showMsg(requiredField[key] + "不能为空!", "W");
			if (key == "outQty") {
				var outQty = nui.get("outQty");
				outQty.focus();
			
			}
			if (key == "returnMan") {
				var returnMan = nui.get("returnMan");
				returnMan.focus();
			}
//			if (key == "remark") {
//				var remark = nui.get("remark");
//				remark.focus();
//			}
			return false;
		}
	}

}