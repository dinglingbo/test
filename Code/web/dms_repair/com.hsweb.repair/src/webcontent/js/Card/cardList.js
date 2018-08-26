/**
 * Created by Administrator on 2018/4/27.
 */
var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryCard.biz.ext";
var sysnUrl = webPath + contextPath + "/repair/DataBase/Card/cardSync.jsp?token="+token;
var grid = null;
$(document).ready(function(v) {
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
	var formData = new nui.Form("#queryform").getData(false, false);
	grid.load({
		formData:formData,
		token:token
	});
});

// 新增
function add() {
	nui.open({
		url : sysnUrl,
		title : "新增储值卡",
		width : 650,
		height : 480,
		onload : function() {
			var iframe = this.getIFrameEl();
			var data = {
				pageType : "add"
			};// 传入页面的json数据
			iframe.contentWindow.setData(data);

		},
		ondestroy : function(action) {// 弹出页面关闭前
			if (action == "saveSuccess") {
				grid.reload();
			}
		}
	});
}

// 编辑
function edit() {
	var row = grid.getSelected();
	if (row) {
		nui.open({
			url : sysnUrl,
			title : "修改储值卡",
			width : 650,
			height : 480,
			onload : function() {
				var iframe = this.getIFrameEl();
				var data = row;
				// 直接从页面获取，不用去后台获取
				iframe.contentWindow.setData(data);
			},
			ondestroy : function(action) {
				if (action == "saveSuccess") {
					grid.reload();
				}
			}
		});
	} else {
		nui.alert("请选中一条记录", "提示");
	}
}

// 重新刷新页面
function refresh() {
	var form = new nui.Form("#queryform");
	var json = form.getData(false, false);
	grid.load(json);// grid查询
	nui.get("update").enable();
}

// 查询
function search() {

	var form = new nui.Form("#queryform");
	var json = form.getData(false, false);
	grid.load(json);// grid查询
}

// 重置查询条件
function reset() {
	var form = new nui.Form("#queryform");// 将普通form转为nui的form
	form.reset();
}

// enter键触发查询
function onKeyEnter(e) {
	search();
}

// 当选择列时
function selectionChanged() {
	var rows = grid.getSelecteds();
	if (rows.length > 1) {
		nui.get("update").disable();
	} else {
		nui.get("update").enable();
	}
}

function onDrawCell(e) {
	//var hash = new Array("原价比例(%)", "折后价比例(%)", "产值比例(%)", "固定金额(元)");
	var hash = {"1":"原价比例(%)","2":"折后价比例(%)","3":"产值比例(%)","4":"固定金额(元)"};
	switch (e.field) {
	case "useRange":
		e.cellHtml = e.value == 1 ? "连锁" : "本店";
		break;
	case "canModify":
		e.cellHtml = e.value == 1 ? "是" : "否";
		break;
	case "packageRate":
		e.cellHtml = e.value + "%";
		break;
	case "itemRate":
		e.cellHtml = e.value + "%";
		break;
	case "partRate":
		e.cellHtml = e.value + "%";
		break;
	case "salesDeductType":
		e.cellHtml = hash[e.value];
		break;
	case "status":
		e.cellHtml = e.value == 1 ? "禁用" : "启用";
		break;
/*	case "periodValidity":
		e.cellHtml = e.value == -1 ? "永久有效" :e.periodValidity ;
		break;*/
	default:
		break;
	}
	if(e.field=="periodValidity"){
		if( e.value == -1){
			e.cellHtml="永久有效";
		}
	}
}
