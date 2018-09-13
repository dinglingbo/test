var grid = null;
var newRow = null;
var invoiceTypeEl = null;
var form = null;
$(document).ready(function () {
	grid = nui.get("grid");
	form = new nui.Form("#form");
	newRow = {name : ""};
	grid.addRow(newRow , 0);
	var date = new Date();
	document.getElementById("right").value = format(date, "yyyy-MM-dd HH:ss:mm");
	grid.on("drawcell",function(e){
		var field = e.field;
		if(field == "action"){
			e.cellHtml = '<a class="optbtn" href="javascript:addRow()">新增</a>&nbsp;&nbsp;&nbsp;<a class="optbtn" href="javascript:remove()">删除</a>';
		}
	});
	
	invoiceTypeEl = nui.get("invoiceType");
	initServiceType("invoiceType",function(data) {
        servieTypeList = nui.get("invoiceType").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
});

function addRow(){//新增
	var row = grid.getSelected();
	var index = grid.indexOf(row);
	newRow = {name : ""};
	grid.addRow(newRow,index+1);
}

function remove(){//删除
	var data = grid.getData();
	if(data.length == 1){
		 showMsg("不能删除此行","W");
	}else{
		var row = grid.getSelected();
		grid.removeRow(row,false);
	}
}

function saveData(){//保存
	var data = form.getData();
	nui.ajax({
        url: "com.hsapi.frm.invoiceManagement.saveInvoice.biz.ext",
        type: "post",
        cache: false,
        data: {
        	 i: grid.getChanges("added"),
             d: grid.getChanges("removed"),
             u: grid.getChanges("modified"),
             data : data,
             main : nui.get("mainId").value
        },
        success: function(text) {
        	nui.get("mainId").setValue(text.mainId);
        	grid.load({mainId : text.mainId});
        	nui.get("state").setValue("1");
        }
    });
}
function checkValue(){//实时监听税率输出的值
	if (document.getElementById("rate").value < 0 || document.getElementById("rate").value > 100){
		document.getElementById("rate").value = "";
		showMsg("请输入0-100以内的数字","W");
	}else{
		if(/\D/.test(document.getElementById("rate").value)){
			showMsg('只能输入数字',"W");
			document.getElementById("rate").value = "";;
		}
	}
}
