var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryTimesCardDetail.biz.ext";
var tab = null;
var form = null;
var timesCardDetail = null;
var g = null;
$(document).ready(function(v) {
	tab = nui.get("tab");
	form = new nui.Form("#dataform1");
	timesCardDetail = new nui.Form("#timesCardDetail");
	form.setChanged(false);
	timesCardDetail.setChanged(false);
});



    var requiredField = {
      name : "计次卡名称:",
      sellAmt : "销售价格",
      totalAmt : "总价值",
      periodValidity : "有效期",
      salesDeductValue : "提成值"
  };
function onOk(){
    var data = form.getData();
  for ( var key in requiredField) {
      if (!data[key] || $.trim(data[key]).length == 0) {
          showMsg(requiredField[key] + "不能为空!","W");

          return;
      }
  }
  saveData();
}


function setData(data){
	//跨页面传递的数据对象，克隆后才可以安全使用
	var json = nui.clone(data);
		//如果是点击编辑类型页面
		if (json.id!=null) {
			form.setData(json);
			form.setChanged(false);
		  }
	//计次卡明细查询
	 var json1 = nui.encode({"timesCard":json});
	$.ajax({
		url:gridUrl,
		type:'POST',
		data:json1,
		cache:false,
		contentType:'text/json',
		success:function(text){
		  var returnJson = nui.decode(text);
		  if(returnJson.exception == null){
			g = nui.get("#timesCardDetail");
			g.setData(returnJson.timesCardDetail);
		  }else{
			nui.alert("获取明细失败", "系统提示", function(action){
			  if(action == "ok" || action == "close"){
				//CloseWindow("saveFailed");
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
	//form.validate();
	//if (form.isValid() == false)
	//return;
	//setGridData("timesCardDetail", "timesCard");
	g = nui.get("#timesCardDetail");
	var pchsOrderDetailAdd = g.getChanges("added");
	var pchsOrderDetailUpdate = g.getChanges("modified");
	var pchsOrderDetailDelete = g.getChanges("removed");
	var data = form.getData(false, true);
	var time = nui.get("timesCardDetail").getData();
	var json = nui.encode({"timesCard":data,"timesCardDetail":time,"pchsOrderDetailAdd":pchsOrderDetailAdd,"pchsOrderDetailUpdate":pchsOrderDetailUpdate,"pchsOrderDetailDelete":pchsOrderDetailDelete});

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
		document.getElementById('y').innerHTML="元";
	} else {
		
		document.getElementById('y').innerHTML="%";
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
					var prdtTypeName = "配件";
					var grid = nui.get("timesCardDetail");
					var newRow = {
						prdtId : prdtId,
						prdtName : prdtName,
						prdtType : prdtType,
						prdtTypeName : prdtTypeName
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
			//params.list = rightItemGrid.getData();
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
					var prdtTypeName = "套餐";
					var grid = nui.get("timesCardDetail");
					var newRow = {
						prdtId : prdtId,
						prdtName : prdtName,
						prdtType : prdtType,
						prdtTypeName : prdtTypeName
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
		title : "维修项目",
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
			//params.list = rightItemGrid.getData();
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
					var prdtTypeName = "工时";
					var grid = nui.get("timesCardDetail");
					var newRow = {
						prdtId : prdtId,
						prdtName : prdtName,
						prdtType : prdtType,
						prdtTypeName : prdtType,
						prdtTypeName : prdtTypeName
					};
					grid.addRow(newRow);
				}
			}
		}
	});
}
/*function addItem() {

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
}*/
