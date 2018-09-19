/**
 * Created by Administrator on 2018/4/27.
 */
var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryPackage.biz.ext";
var grid = null;
var sti = "";
var resultData = {};
var servieTypeHash = {};
var servieTypeList = [];
var tempGrid = null;
var callback = null;
var delcallback = null;
var ckcallback = null;
var isChooseClose = 1;//默认选择后就关闭窗体
$(document).ready(function(v) {
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
	
	grid.on("beforeload",function(e){
        e.data.token = token;
	});
	
	var formData = new nui.Form("#queryform").getData(false, false);
	grid.load(formData);
	
	
	initServiceType("serviceTypeId",function(data) {
	    servieTypeList = nui.get("serviceTypeId").getData();
	    servieTypeList.forEach(function(v) {
	        servieTypeHash[v.id] = v;
	    });
	 });
	
	//双击
	grid.on("rowdblclick",function(e){
		edit();
	});
	tempGrid = nui.get("tempGrid");
	//左边菜单删除
	tempGrid.on("cellclick",function(e){ 
		var field=e.field;
		var row = e.row;
        if(field=="check" ){
            //if(e.row.check==1){
			//}else{}
			//删除所选记录
			delcallback && delcallback(row,function(){
				tempGrid.removeRow(row);
			});
			tempGrid.removeRow(row);
        }
    });
	
	

});

function getDataAll(){
	var row = grid.getSelecteds();
	return row;
}
// 选择
function edit() {
	if(nui.get("expense").value){
		CloseWindow("ok");
	}else{
		var row = grid.getSelected();
		if (row){	
			if(ckcallback){
				var rs = ckcallback(row);
				if(rs){
					showMsg("此套餐已添加,请返回查看!","W");
					return;
				}else{
					if(callback){
						nui.mask({
							el: document.body,
							cls: 'mini-mask-loading',
							html: '处理中...'
						});
			
						callback(row,function(data){
							if(data){
								data.check = 1;
								tempGrid.addRow(data);
							}
						},function(){
							nui.unmask(document.body);
						})
					}
				}
			}else{
				if(callback){
					callback(row,function(data){
						if(data){
							data.check = 1;
							tempGrid.addRow(data);
						}
					});
				}
			}
			resultData.package1 = row;
			if(isChooseClose == 1){
				CloseWindow("ok");
			}
			
		} else {
			nui.alert("请选择一个套餐", "W");
		}
	}
}

function CloseWindow(action) {
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		window.close();
}

// 重新刷新页面
function refresh() {
	var form = new nui.Form("#queryform");
	var json = form.getData(false, false);
	json.isDisabled = 0;
	grid.load(json);// grid查询
	nui.get("update").enable();
}

// 查询
function search() {

	var form = new nui.Form("#queryform");
	var json = form.getData(false, false);
	json.isDisabled = 0;
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
	var hash = new Array("按原价比例", "按折后价比例", "按产值比例", "固定金额");
	switch (e.field) {
	case "useRange":
		e.cellHtml = e.value == 1 ? "连锁" : "本店";
		break;
	case "isShare":
		e.cellHtml = e.value == 1 ? "是" : "否";
		break;
	case "isDisabled":
		e.cellHtml = e.value == 1 ? "禁用" : "启用";
		break;
	default:
		break;
	}
	if (e.field == "serviceTypeId") {
        if (servieTypeHash && servieTypeHash[e.value]) {
            e.cellHtml = servieTypeHash[e.value].name;
        }
	}
}

function getData() {
	return resultData;
}
function setData(data) {
	list = data.list || [];
	nui.get("selectBtn").show();
}

function setViewData(ck, delck, cck){
	
	isChooseClose = 0;
	callback = ck;
	delcallback = delck;
	ckcallback = cck;
	grid.setWidth("70%");
	tempGrid.setStyle("display:inline");
	document.getElementById("splitDiv").style.display="";
}

//查看详情
function look() {
	var row = grid.getSelected();
	if (row) {
		nui.open({
			url : webPath + contextPath
			+ "/repair/DataBase/Card/packageDetail.jsp?token=" + token,
			title : "套餐详情",
			width : 900,
			height : 580,
			onload : function() {
				var iframe = this.getIFrameEl();
				var data = {
						"row":row,
						"servieTypeHash":servieTypeHash
						};
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

function setValueData(){
	grid.showColumn("checkcolumn");
	nui.get("expense").setValue(6);
}
