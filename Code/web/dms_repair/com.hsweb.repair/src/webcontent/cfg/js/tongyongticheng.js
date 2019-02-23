var param = null;
var grid = null;
var partGrid=null;
var baseUrl="http://127.0.0.1:8080/default/";
var gridUrl= apiPath + repairApi + "/com.hsapi.repair.baseData.brand.getBusinessType.biz.ext";
var servieTypeList=[];
var servieTypeHash={};

$(document).ready(function (v)
{
	grid = nui.get("grid");
	partGrid = nui.get('partGrid');
	grid.setUrl(gridUrl);
	partGrid.setUrl(gridUrl);

    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
	
    doSearch();
    grid.on("drawcell",function(e){
    	switch(e.field){
    		case "serviceTypeId":
    			if(servieTypeHash[e.value]){
    				e.cellHtml = servieTypeHash[e.value].name || "";
    			}
    			break;
    		default:
    			break;
    	}
    });
    partGrid.on("drawcell",function(e){
    	switch(e.field){
    		case "serviceTypeId":
    			if(servieTypeHash[e.value]){
    				e.cellHtml = servieTypeHash[e.value].name || "";
    			}
    			break;
    		default:
    			break;
    	}
    });
    	
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
	if(!grid.getData()[0].id){
		var i=grid.getData();
		var u=[];
	}
	/*for (var j = 0; j < u.length; j++) {
		u[j].salesDeductValue = parseFloat(u[j].salesDeductValue);
	}*/
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
	if(!partGrid.getData()[0].id ){
		var i=partGrid.getData();
		var u=[];
	}
	/*for (var j = 0; j < u.length; j++) {
		u[j].salesDeductValue = parseFloat(u[j].salesDeductValue);
	}*/
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

	var params={
		type:2,
		token: token
	};
	grid.load({params:params},function(){
		if(grid.data.length==0){
			var data=[];
			for(var i =0;i<servieTypeList.length;i++){
				data.push({ serviceTypeId:servieTypeList[i].id,
							type:2,
							orgid:currOrgId
						});
			}
			grid.setData(data);
		}
	});
	var params2={
		type:3,
		token:token
	};
	partGrid.load({params:params2},function(){
		if(partGrid.data.length==0){
			var data=[];
			for(var i =0;i<servieTypeList.length;i++){
				data.push({ serviceTypeId:servieTypeList[i].id,
							type:3,
							orgid:currOrgId
						});
			}
			partGrid.setData(data);
		}
	});		

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