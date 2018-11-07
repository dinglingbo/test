/**
 * Created by Administrator on 2018/5/5.
 */
var baseUrl = apiPath + frmApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl
		+ "com.hsapi.frm.setting.queryFiSettleAccount.biz.ext";
var mainGrid = null;
var disableEl = null;
var undisableEl = null;
$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);
	disableEl = nui.get("disable");
	undisableEl = nui.get("undisable");
	mainGrid.on("drawcell", function (e) {
        switch (e.field) {
            case "isDisabled":
                e.cellHtml = e.value == 1?"是":"否";
                break;
            case "isDefault":
                e.cellHtml = e.value == 1?"是":"否";
                break;
        }
                
	});
	
	doSearch();
});
function doSearch() {
	mainGrid.load({
		token : token
	});
}
var accountTypeList = [{ id: 1, text: '现金' }, { id: 2, text: '银行存款'}, { id: 3, text: '积分/卡券'}];
function onAccount(e) {
    for (var i = 0, l = accountTypeList.length; i < l; i++) {
        var g = accountTypeList[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}
/*var disableList = [{ id: 0, text: '否' }, { id: 1, text: '是'}];
var isDisabled = [{ id: 0, text: '是' }, { id: 1, text: '否'}]
function onRenderer(e) {
    for (var i = 0, l = disableList.length; i < l; i++) {
        var g = disableList[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}

function onisDisabled(e) {
    for (var i = 0, l = isDisabled.length; i < l; i++) {
        var g = isDisabled[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}*/

function refresh(){
	doSearch();
	showMsg("刷新成功","S");
}
var deleteUrl = baseUrl
		+ "com.hsapi.frm.setting.deleteFiSettleAccountById.biz.ext";
function deleteType(){
	var row = mainGrid.getSelected();
	if(row && row.id){
		var orgid = row.orgid;
		if(currOrgId != "0" && orgid == 0) {
			showMsg("此记录不能删除!","W");
			return;
		}
		nui.confirm("是否确定删除？", "友情提示",
        	function (action) { 
                if (action == "ok") {                 
                    nui.mask({
						el : document.body,
						cls : 'mini-mask-loading',
						html : '删除中...'
					});

					nui.ajax({
						url : deleteUrl,
						type : "post",
						data : JSON.stringify({
							id: row.id
						}),
						success : function(data) {
							nui.unmask(document.body);
							data = data || {};
							if (data.errCode == "S") {
								showMsg("删除成功!","S");
								doSearch();
							} else {
								showMsg(data.errMsg || "删除失败!","E");
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.log(jqXHR.responseText);
						}
					});
                }
            }
        );

		
	}else{
		showMsg("请选择记录!","W");
	}
}

//弹出界面新建后更新数据
function addNewRow(row){
	/*var indexArray = [];
	mainGrid.findRow(function(rowS){
		if(rowS.parentid == row.parentid){
			var index = mainGrid.indexOf(rowS);
			indexArray.push(index);
		}
	});
	var length = indexArray.length;
	if(length > 0) {
		mainGrid.addRow(row,indexArray[length-1]);
	}else{
		mainGrid.addRow(row);
	}*/
	
}
function showEditModal(row, newRow, type){
	var title = "新增账户";
	if(type == 'edit'){
		title = "修改账户";
	}

	nui.open({
		url: "com.hsweb.frm.arap.settleAccountEdit.flow",
		title: title,
		width: "500px",
		height: "285px",
        allowDrag:true,
        allowResize:false,
		onload: function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.SetData(row, newRow);
		},
		ondestroy: function() {
			doSearch();
		}
	});
}
function add(){
	var row = mainGrid.getSelected();
	var newRow = {};
	if(row){
		newRow.parentid = row.parentid;
	}

	showEditModal(newRow, newRow, 'add');

	
}
function edit(){
	var row = mainGrid.getSelected();
	if(!row) return;
	var newRow = {};

	var orgid = row.orgid;
	if(currOrgId != "0" && orgid == 0) {
		showMsg("此记录不能修改!","W");
		return;
	}

	showEditModal(row, newRow, 'edit');

}
var disableUrl = baseUrl
		+ "com.hsapi.frm.setting.updateFiSettleAccountDisabled.biz.ext";
function disablePlay(isDisabled){
	var row = mainGrid.getSelected();
	if(row && row.id){
		var orgid = row.orgid;
		if(currOrgId != "0" && orgid == 0) {
			showMsg("不能进行此操作!","W");
			return;
		}

		nui.mask({
			el : document.body,
			cls : 'mini-mask-loading',
			html : '修改中...'
		});

		nui.ajax({
			url : disableUrl,
			type : "post",
			data : JSON.stringify({
				id: row.id,
				isDisabled: isDisabled,
				token: token
			}),
			success : function(data) {
				nui.unmask(document.body);
				data = data || {};
				if (data.errCode == "S") {
					showMsg("操作成功!","S");
					doSearch();

					if(isDisabled == 0) {
						disableEl.setVisible(true);
						undisableEl.setVisible(false);
					}else if(isDisabled == 1){
						disableEl.setVisible(false);
						undisableEl.setVisible(true);
					}
				} else {
					showMsg(data.errMsg || "操作失败!","E");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			}
		});
	}else{
		showMsg("请选择记录!","W");
	}
}
function disable(){
	disablePlay(1);
}
function undisable(){
	disablePlay(0);
}
function onGridSelectedChange(e){
	var row = e.selected;
	var isdisabled = row.isDisabled;
	if(isdisabled == 0) {
		disableEl.setVisible(true);
		undisableEl.setVisible(false);
	}else if(isdisabled == 1){
		disableEl.setVisible(false);
		undisableEl.setVisible(true);
	}
}