var gridUrl = apiPath + repairApi
		+ "/com.hsapi.repair.baseData.crud.queryTimesCard.biz.ext";
var sysnUrl = webPath + contextPath + "/com.hsweb.repair.DataBase.timesCardSysn.flow?token"+token;
var grid = null;
var xyguest = null;
var xs = 0;
var assistant = 0;
$(document).ready(function(v) {
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
	var formData = new nui.Form("#queryform").getData(false, false);
	grid.load({
		formData:formData,
		token:token
	});
	
/*	if(currIsMaster=="1"){
		nui.get('addBtn').setVisible(true);
		nui.get('updateBtn').setVisible(true);
	}else{
		nui.get('addBtn').setVisible(false);
		nui.get('updateBtn').setVisible(false);
	}*/
	grid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        //获取到配件ID
    	var pid = record.pid||0;
        switch (e.field) {
            case "orgid":
                var value = e.value||"";
                if(value==currOrgId){
                    e.cellHtml = "本店";
                }else {
                	e.cellHtml = "";
                }
                break;
            default:
                break;
        }
        
    });
	
	grid.on("rowdblclick",function(e){
		if(assistant==1){
			onBuy();
		}else{
			edit();
		}

	});
	nui.get("cardName").focus();
	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		

		if ((keyCode == 27)) { // ESC
			CloseWindow('cancle');
		}
	}
	
});

// 新增
function add() {
/*	if(currIsMaster != "1"){
		showMsg("请向总部申请计次卡定义!","W");
		return;
	}*/
	nui.open({
		url : sysnUrl,
		title : "新增计次卡",
		width : 890,
		height : 600,
		onload : function() {
			var iframe = this.getIFrameEl();
			var data = {
				pageType : "add"
			};// 传入页面的json数据
			// iframe.contentWindow.setData(data);
			data.type = 'add';
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
/*	if(currIsMaster != "1"){
		showMsg("请向总部申请计次卡定义!","W");
		return;
	}*/
	var row = grid.getSelected();
	if (row) {
		nui.open({
			url : sysnUrl,
			title : "修改计次卡",
			width : 900,
			height : 600,
			onload : function() {
				var iframe = this.getIFrameEl();
				var data = row;
				data.type = 'EDIT';
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
		showMsg("请选中一条记录!", "W");
	}
}

// 重新刷新页面
function refresh() {
	var form = new nui.Form("#queryform");
	var json = form.getData(false, false);
	grid.load(json);// grid查询
	nui.get("updateBtn").enable();
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
	var row = grid.getSelected();
	if(!row) return;
	var orgid = row.orgid||0
	if(currOrgId == orgid){
		nui.get('updateBtn').setVisible(true);
		
	}else{
		nui.get('updateBtn').setVisible(false);
	}
	if(xs==1){
		mini.get("updateBtn").setVisible(false);
		mini.get("addBtn").setVisible(false);
		mini.get("onBuy").setVisible(true);
	}
}
function onDrawCell(e) {
	var hash = new Array("按原价比例", "按折后价比例", "按产值比例", "固定金额");
	switch (e.field) {
	case "isShare":
		e.cellHtml = e.value == 1 ? "是" : "否";
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
	case "periodValidity":
		e.cellHtml = e.value == -1 ? "永久有效" : e.value;
		break;
	default:
		break;
	}
}

function setStely(){
	 xs = 1;
	mini.get("updateBtn").setVisible(false);
	mini.get("addBtn").setVisible(false);
	mini.get("onBuy").setVisible(true);
}

function lookCardTimes(){
	var row = grid.getSelected();
	if (row) {
		nui.open({
			url : sysnUrl,
			title : "查看详情",
			width : 900,
			height : 580,
			onload : function() {
				var iframe = this.getIFrameEl();
				var data = row;
				data.type = 'VIEW';
				// 直接从页面获取，不用去后台获取
				iframe.contentWindow.disableHtml();
				iframe.contentWindow.setData(data);
			},
			ondestroy : function() {
				var iframe = this.getIFrameEl();
			}
		});
	} else {
		nui.alert("请选中一条记录", "提示");
	}
}

//打开计次卡储值卡页面
var action = null;
var buyUrl =webPath + contextPath + "/com.hsweb.frm.manage.cardSettlement.flow?token"+token;
function onBuy(){
	var row = grid.getSelected();
	row.jsAmt = row.sellAmt;//结算金额，便于结算界面结算，储值卡计次卡结算金额字段不一样
	if (row) {
		nui.open({
			url : buyUrl,
			title : "购买次卡",
			width :"100%",
			height : "100%",
			onload : function() {
				var iframe = this.getIFrameEl();
				//var data = row;
				var data ={
						xyguest:xyguest,
						row:row,
						settlementUrl:1
				} 
				//把数据传到子页面
				iframe.contentWindow.setData(data);
			},
	        ondestroy:function(action){
	            if(action == "ok"){
	                showMsg("结算成功!","S");
	            }else if(action == "onok"){
	            	showMsg("转预结算成功!","S");
	            }else{
	                if(data.errCode){
	                    showMsg("结算失败!","W");
	                    return;
	                }
	            }
	    }
		});
	} else {
		nui.alert("请选中一条记录", "提示");
	}
	
}

function CloseWindow(action) {
	if (action == "close") {
		return window.CloseOwnerWindow("saveSuccess");
	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function setData(data)
{
	xyguest= data;
	assistant = 1;//判断是主页面还是open页面。用于双击触发事件
}

function setInitData(params){
	if(params.id==1862){
		setStely();
		params=null;
		assistant=1;
	}
	
}
//取消
function onCancel() {
	CloseWindow("cancel");
}
