var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryCard.biz.ext";
var sysnUrl = webPath + partDomain + "/repair/DataBase/Card/cardSync.jsp";
var tab = null;
var form = null;
var timesCardDetail = null;
$(document).ready(function(v) {
	tab = nui.get("tab");
	form = new nui.Form("#dataform1");
	timesCardDetail = new nui.Form("#timesCardDetail");
	form.setChanged(false);
	timesCardDetail.setChanged(false);
});

function onOk() {
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
	//form.validate();
	//if (form.isValid() == false)
	//return;
	//setGridData("timesCardDetail", "timesCard");
	var data = form.getData(false, true);
	var time = nui.get("timesCardDetail").getData();
	alert(time[0].times);
	var json = nui.encode({"timesCard":data,"timesCardDetail":time});

	$.ajax({
		url : "com.hsapi.repair.baseData.crud.syncTimesCard.biz.ext",
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
		document.getElementById('y').style.display = 'block';
		document.getElementById('b').style.display = 'none';
	} else {
		document.getElementById('b').style.display = 'block';
		document.getElementById('y').style.display = 'none';
	}
}

function addDetail() {
	nui.open({
		targetWindow : window,
		url : webPath + partDomain
				+ "/com.hsweb.part.common.partSelectView.flow?token=" + token,
		title : "配件选择",
		width : 900,
		height : 500,
		allowDrag : true,
		allowResize : false,
		onload : function() {
			var iframe = this.getIFrameEl();
			var list = [];
			var params = {
				list : list
			};
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				data = data || {};
				var part = data.part;

				if (part) {
					var prdtId = part.id;
					var prdtName = part.name;
					var prdtType = 3;
					var grid = nui.get("timesCardDetail");
					var newRow = {
						prdtId : prdtId,
						prdtName : prdtName,
						prdtType : prdtType
					};
					grid.addRow(newRow);
				}

			}
		}
	});
}

// 本店套餐录入
function selectPackage() {

	nui.open({
		targetWindow : window,
		url : webPath + partDomain
		+ "/com.hsweb.repair.common.rpbPackageSelect.flow?token=" + token,
		title : "本店套餐",
		width : 1000,
		height : 600,
		allowResize : false,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {};
			iframe.contentWindow.setData(params, function(data, callback) {
				console.log(data);
				var _package = {};
				var tmpPkg = data.package;
				_package.serviceId = maintain.id;
				_package.packageId = tmpPkg.id;
				_package.packageName = tmpPkg.name;
				_package.packageTypeId = tmpPkg.type;
				_package.receTypeId = "04150101";
				_package.pkgamt = tmpPkg.amount;
				_package.amt = tmpPkg.amount;
				_package.detailAmt = tmpPkg.amount;
				_package.subtotal = tmpPkg.amount;
				_package.amt4s = tmpPkg.total;
				_package.differAmt = 0;
				_package.costAmt = 0;
				_package.discountAmt = 0;
				_package.rate = 0;
				_package.status = 0;
				_package.isDisabled = 0;
				var tmpItemList = data.itemList;
				var itemList = tmpItemList.map(function(v) {
					return {
						itemId : v.itemId,
						itemCode : v.itemCode,
						itemName : v.itemName,
						itemIsNeed : 1,
						receTypeId : _package.receTypeId,
						serviceId : _package.serviceId,
						itemKind : v.itemKind,
						itemTime : v.itemTime,
						unitPrice : v.unitPrice,
						pkgitemamt : v.amt,
						amt : v.amt,
						rate : 0,
						discountAmt : 0,
						subtotal : v.amt,
						status : 0
					}
				});
				var tmpPartList = data.partList;
				var partList = tmpPartList.map(function(v) {
					return {
						receTypeId : _package.receTypeId,
						serviceId : _package.serviceId,
						partId : v.partId,
						partCode : v.partCode,
						partName : v.partName,
						partIsNeed : 1,
						qty : v.qty,
						unit : v.unit,
						unitPrice : v.unitPrice,
						amt : v.amt,
						rate : 0,
						discountAmt : 0,
						subtotal : v.amt,
						status : 0
					};
				});
				var par = {
					pkg : _package,
					itemList : itemList,
					partList : partList
				};
				savePackage(par, function(data) {
					data = data || {};
					if (data.errCode == "S") {
						callback && callback({
							info : "本店套餐录入成功",
							close : true
						});
						loadPackageGridData();
					} else {
						callback && callback({
							info : data.errMsg || "本店套餐录入失败",
							close : false
						});
					}
				});
			});
		},
		ondestroy : function(action) {
		}
	});
}

function selectItem(callback) {
	nui.open({
		targetWindow : window,
		url : webPath + partDomain
				+ "/com.hsweb.repair.DataBase.RepairItemMain.flow?token="
				+ token,
		title : "维修项目",
		width : 930,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {};
			params.list = rightItemGrid.getData();
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				callback && callback(data);
			}
		}
	});
}
function addItem() {

	selectItem(function(data) {
		var item = data.item;
		var packageItem = {
			itemId : item.id,
			itemCode : item.code,
			itemName : item.name,
			itemTime : item.itemTime,
			itemKind : item.itemKind,
			itemKindName : item.itemKindName,
			unitPrice : item.unitPrice,
			amt : item.amt
		};
		rightItemGrid.addRow(packageItem);
	});
}
