/**
 * Created by Administrator on 2018/4/27.
 */
var saveDataUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.syncCard.biz.ext";
var form = null;
var set = null;
var input = null;
$(document).ready(function(v) {
    input = mini.get("inputMonth");
	 set = mini.get("setMonth");
	form = new nui.Form("#dataform1");
});
var requiredField = {
	name : "会员卡名称",
	rechargeAmt : "充值金额",
	giveAmt : "赠送金额",
	packageRate : "套餐优惠率",
	partRate : "配件优惠率",
	itemRate : "工时优惠率",
	periodValidity : "有效期",
	salesDeductValue : "提成值"
};
function changed(e){
	
	if(set.checked){	
		//把输入框的值清除掉
		 input.setValue("");
		 input.disable();
	}else{
		 
		 input.enable();
	}
	
}
function onOk() {
	var data = form.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			if( key == "periodValidity" && set.checked ){
				//跳过本次循环，执行下一次循环,把有效期赋值为-1
				input.setValue("-1");
				continue;
			}
			showMsg(requiredField[key] + "不能为空!", "W");

			return;
		}
	}
	saveData();
}

function gridAddRow(datagrid) {
	var grid = nui.get(datagrid);
	grid.addRow({});
}

function gridRemoveRow(datagrid) {
	var grid = nui.get(datagrid);
	var rows = grid.getSelecteds();
	if (rows.length > 0) {
		grid.removeRows(rows, true);
	}
}

function setGridData(datagrid, dataid) {
	var grid = nui.get(datagrid);
	var grid_data = grid.getChanges();
	nui.get(dataid).setValue(grid_data);
}



function saveData() {
	form.validate();
	if (form.isValid() == false)
		return;
	var data = form.getData(false, true);
	// var json = nui.encode(data);//变成json格式
	var param = {
		card : data,
		token:token
	}
	var json = nui.encode(param);
	nui.ajax({
		url : saveDataUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.exception == null) {
				CloseWindow("saveSuccess");
			} else {
				nui.alert("保存失败", "系统提示", function(action) {
					if (action == "ok" || action == "close") {
						// CloseWindow("saveFailed");
					}
				});
			}
		}
	});
}

function onReset() {
	form.reset();
	form.setChanged(false);
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

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
}

function updateError(e) {

	if (nui.get('x').getValue() == "3") {
		document.getElementById('y').innerHTML = "元";
	} else {

		document.getElementById('y').innerHTML = "%";
	}
}
//验证充值金额和赠送金额
function vaild(e){
	var reg=/^\d+(\.\d{1,2})?$/;
	var rechargeAmt=document.getElementsByName('rechargeAmt')[0].value;
	if(!reg.test(rechargeAmt)){
		e.errorText="请输入大于0且小数点后最多两位的数";
		e.isValid=false;
	}
	
}

function vaild2(e){
	var reg=/^\d+(\.\d{1,2})?$/;
	var giveAmt=document.getElementsByName('giveAmt')[0].value;
	if(!reg.test(giveAmt)){
		e.errorText="请输入大于0且小数点后最多两位的数";
		e.isValid=false;
	}
}