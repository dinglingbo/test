var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryTimesCardDetail.biz.ext";
var gridUrl1 = apiPath + repairApi
+ "/com.hsapi.repair.baseData.crud.syncTimesCard.biz.ext";
var tab = null;
var form = null;
var timesCardDetail = null;
var g = null;
$(document).ready(function(v) {
	tab = nui.get("tab");
	form = new nui.Form("#dataform1");
	form.setChanged(false);
});

var requiredField = {
	name : "计次卡名称:",
	sellAmt : "销售价格",
	totalAmt : "总价值",
	periodValidity : "有效期",
	salesDeductValue : "提成值"
};

var tcd = {
	times : "次数 :",
	qty : "工时/数量 ",
	oldPrice : "原价",
	sellPrice : "销价 ",
	oldAmt : "原销售金额 ",
	sellAmt : "现销售金额 "
};

function onOk() {
	var yz = "^[0-9]*[1-9][0-9]*$";
	var zz = new RegExp(yz);
	g = nui.get("#timesCardDetail");
	var data1 = g.getData();
	var data = form.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!", "W");

			return;
		}

	}
	for ( var key in tcd) {
		for (var i = 0; i < data1.length; i++) {
			if (!data1[i][key] || $.trim(data1[i][key]).length == 0) {
				showMsg(tcd[key] + "不能为空!", "W");
				return;
			}

			if (!zz.exec(data1[i][key])) {
				showMsg(tcd[key] + "必须为数字!", "W");

				return;
			}
		}
	}
	saveData();
}

function setData(data) {
	// 跨页面传递的数据对象，克隆后才可以安全使用
	var json = nui.clone(data);
	// 如果是点击编辑类型页面
	if (json.id != null) {
		form.setData(json);
		form.setChanged(false);
	}
	// 计次卡明细查询
	var json1 = nui.encode({
		"timesCard" : json
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

function saveData() {
	g = nui.get("#timesCardDetail");
	form.validate();
	if (form.isValid() == false)
		return;
	g.validate();
	if (g.isValid() == false)
		return;
	var pchsOrderDetailAdd = g.getChanges("added");
	var pchsOrderDetailUpdate = g.getChanges("modified");
	var pchsOrderDetailDelete = g.getChanges("removed");
	var data = form.getData(false, true);
	var time = nui.get("timesCardDetail").getData();
	var json = nui.encode({
		"timesCard" : data,
		"timesCardDetail" : time,
		"pchsOrderDetailAdd" : pchsOrderDetailAdd,
		"pchsOrderDetailUpdate" : pchsOrderDetailUpdate,
		"pchsOrderDetailDelete" : pchsOrderDetailDelete,
		token : token
	});

	nui.ajax({
		url : gridUrl1,
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
		document.getElementById('y').innerHTML = "元";
	} else {

		document.getElementById('y').innerHTML = "%";
	}
}

function addDetail() {
	nui.open({
		targetWindow : window,
		url : webPath + partDomain
				+ "/com.hsweb.part.common.partSelectView.flow?token=" + token,
		title : "配件选择",
		width : 1000,
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
				+ "/repair/DataBase/Card/packageList.jsp?token=" + token,
		title : "本店套餐",
		width : 1000,
		height : 600,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var list = [];
			var params = {
				list : list
			};
			// params.list = rightItemGrid.getData();
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				data = data || {};
				var part = data.package1;

				if (part) {
					var prdtId = part.id;
					var prdtName = part.name;
					var prdtType = 1;
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

function selectItem(callback) {
	nui.open({
		targetWindow : window,
		url : webPath + partDomain
				+ "/com.hsweb.repair.DataBase.RepairItemMain.flow?token="
				+ token,
		title : "维修工时",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var list = [];
			var params = {
				list : list
			};
			// params.list = rightItemGrid.getData();
			iframe.contentWindow.setData(params);
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData();
				data = data || {};
				var part = data.item;

				if (part) {
					var prdtId = part.id;
					var prdtName = part.name;
					var prdtType = 2;
					var itemTime = part.itemTime;
					var grid = nui.get("timesCardDetail");
					var newRow = {
						prdtId : prdtId,
						prdtName : prdtName,
						prdtType : prdtType,
						prdtTypeName : prdtType,
						qty :itemTime
					};
					grid.addRow(newRow);
				}
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
/*
 * function addItem() {
 * 
 * selectItem(function(data) { var item = data.item; var packageItem = { itemId :
 * item.id, itemCode : item.code, itemName : item.name, itemTime :
 * item.itemTime, itemKind : item.itemKind, itemKindName : item.itemKindName,
 * unitPrice : item.unitPrice, amt : item.amt };
 * rightItemGrid.addRow(packageItem); }); }
 */
