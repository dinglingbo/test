/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + repairApi + "/";
var rightGridUrl = apiPath + repairApi+"/com.hsapi.repair.baseData.query.queryGuestType.biz.ext";

var rightGrid = null;
var nameEl = null;

var statusHash = {"0":"启用","1":"禁用"};
var dataList = [{id:"0",name:"启用"},{id:"1",name:"禁用"}];
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    
    nameEl = nui.get("name");

    rightGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "isDisabled":
                if(statusHash && statusHash[e.value])
                {
                    e.cellHtml = statusHash[e.value];
                }
                break;
            default:
                break;
        }
    });
    
    rightGrid.on("rowdblclick", function(e) {
		var row = rightGrid.getSelected();
		var rowc = nui.clone(row);
		if (!rowc)
			return;
		editGuestType();

	});
    
    rightGrid.on("rowclick", function(e) {
    	var row = rightGrid.getSelected();
        
        if(row){
            if(row.orgid != currOrgId) {
            	nui.get("editBtn").disable();
            }else {
            	nui.get("editBtn").enable();
            }
        }

	});
    
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下

        if ((keyCode == 13)) { // Enter
            onSearch();
        }
    }
    onSearch();
});
function getSearchParam(){
    var params = {};
   
    params.name = nameEl.getValue();
    return params;
}
function onSearch(){
	var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
    rightGrid.load({
        params:params,
        token:token
    });
}
function addOrEdit(row){
    nui.open({
		// targetWindow: window,,
		url : webPath+contextPath+"/repair/cfg/guestType.jsp?token="+token,
		title : "客户级别设置",
		width : 600,
		height : 500,
		allowDrag : true,
		allowResize : false,
		onload : function() {
            var iframe = this.getIFrameEl();
            var r = nui.clone(row);
			iframe.contentWindow.setInitData(r);
		},
		ondestroy : function(action) {
			if (action == 'ok') {
				onSearch();
			}
		}
	});
}
function addGuestType(){
    var row = {};
    addOrEdit(row);
}
function editGuestType(){
    var row = rightGrid.getSelected();
    
    if(row){
        if(row.orgid != currOrgId) {
        	parent.showMsg("此级别不能修改!","W");
        	return;
        }else {
        	addOrEdit(row);
        }
    }else{
        parent.showMsg("请选择一条记录!","W");
    }
}