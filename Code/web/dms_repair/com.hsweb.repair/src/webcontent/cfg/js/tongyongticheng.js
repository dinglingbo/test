var param = null;
var grid = null;
var baseUrl="http://127.0.0.1:8080/default/";
var gridUrl= apiPath + repairApi + "/com.hsapi.repair.baseData.brand.getBusinessType.biz.ext";
$(document).ready(function (v)
{
	doSearch();

});

function ontypeRenderer(e) {
	for (var i = 0, l = type.length; i < l; i++) {
		var g = type[i];
		if (g.id == e.value) return g.text;
	}
	return "";
}

function saveAll(){
	var i = grid.getChanges("added");
    var d = grid.getChanges("removed");
	var u = grid.getChanges("modified");
	for (var j = 0; j < u.length; j++) {
		u[j].salesDeductValue = parseFloat(u[j].salesDeductValue);
	}
	nui.ajax({
        url:  apiPath + repairApi+"/com.hsapi.repair.baseData.brand.saveBusinessDeduct.biz.ext",
        type: "post",
        cache: false,
        async: false,
        data: {
        	i : i,
        	u : u,
        	d : d
        },
        success: function(text) {
        	grid.setUrl(gridUrl);
        	grid.load({params:{type:2,token:token}});
        }
    });
}

function savePart(){
	var i = partGrid.getChanges("added");
    var d = partGrid.getChanges("removed");
	var u = partGrid.getChanges("modified");
	for (var j = 0; j < u.length; j++) {
		u[j].salesDeductValue = parseFloat(u[j].salesDeductValue);
	}
	nui.ajax({
        url:  apiPath + repairApi+"/com.hsapi.repair.baseData.brand.saveBusinessDeduct.biz.ext",
        type: "post",
        cache: false,
        async: false,
        data: {
        	i : i,
        	u : u,
        	d : d
        },
        success: function(text) {
        	partGrid.setUrl(gridUrl);
        	partGrid.load({params:{type:3,token:token}});
        }
    });
}
function doSearch(){
	grid = nui.get("grid");
	grid.setUrl(gridUrl);
	var params={
		type:2,
		token: token
	}
	grid.load({params:params});
	partGrid = nui.get('partGrid');
	partGrid.setUrl(gridUrl);
	if(partGrid){
		var params={
			type:3,
			token:token
		}
		partGrid.load({params:params});		
	}
}


//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;

    editor.validate();
    if (editor.isValid() == false) {
		parent.showMsg("请输入0到100的数!","W");
        e.cancel = true;
    } 
}