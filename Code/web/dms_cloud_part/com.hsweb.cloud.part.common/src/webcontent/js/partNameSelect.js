/**
 * Created by Administrator on 2018/1/27.
 */

var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
//var gridUrl = baseUrl+"com.hsapi.part.common.svr.queryPartName.biz.ext"; 
//var  treeUrl = baseUrl+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";

var gridUrl = baseUrl+"com.hsapi.cloud.part.common.svr.queryPartName.biz.ext";
var treeUrl = baseUrl+"com.hsapi.cloud.part.common.svr.getPartTypeTree.biz.ext";

var grid = null;
var tree = null;
$(document).ready(function(v)
{
    grid = nui.get("grid1");
    grid.setUrl(gridUrl);
    grid.on("beforeload",function(e){
        e.data.token = token;
    });
    tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    tree.load({token:token});
//    tree.on("beforeload",function(e){
//        e.data.token = token;
//    });
    //console.log("xxx");
    nui.get('searchKey').focus();
    grid.on("rowdblclick", function(e) {
		var row = grid.getSelected();
		var rowc = nui.clone(row);
		if (!rowc)
			return;
		onOk();

	});
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;

        switch(keyCode){
            case 27:
            	window.CloseOwnerWindow("");
            break;
            case 13:
            	onSearch(); 
            break;
        }

        /*if((keyCode==83)&&(event.shiftKey))  {  
            onOk();  
        } 

        if((keyCode==67)&&(event.shiftKey))  { 
            onCancel();
        }  */
    }
});
function onDrawNode(e)
{
    var node = e.node;
    e.nodeHtml = node.code + " " + node.name;
}
function onNodeDblClick(e)
{
    var currTree = e.sender;
    var currNode = e.node;
    var level = currTree.getLevel(currNode);
    var list = [];
    var tmpNode = currNode;
    do{
        list[level] = tmpNode.id;
        tmpNode = currTree.getParentNode(tmpNode);
        level = currTree.getLevel(tmpNode);
    }while(tmpNode&&tmpNode.id);

    var cartypef = list[0]||"";
    var cartypes = list[1]||"";
    var cartypet = list[2]||"";

    var partName = {
        cartypef:cartypef,
        cartypes:cartypes,
        cartypet:cartypet
    };
    doSearch({
        partName:partName
    });
}
var partTypeHash = null;
function onPartGridDraw(e)
{
    if(!partTypeHash)
    {
        partTypeHash = {};
        var partTypeList = tree.getList();
        partTypeList.forEach(function(v)
        {
            partTypeHash[v.id] = v;
        });
    }

    switch (e.field)
    {
        case "isdisabled":
            e.cellHtml = e.value == 1?"禁用":"启用";
            break;
        case "cartypef":
        case "cartypes":
        case "cartypet":
            if(partTypeHash[e.value])
            {
                e.cellHtml = partTypeHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        default:
            break;
    }
}


function reloadData()
{
    if(grid)
    {
        grid.reload();
    }
}
function getSearchParams()
{
    var params = {};
    params.searchKey = nui.get("searchKey").getValue().replace(/\s+/g, "");
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
    grid.load(params);
}
var resultData = {};
function onOk()
{
    var node = grid.getSelected();
    if(node)
    {
        console.log(node);
        resultData = {
            partName:node
        };
        CloseWindow("ok");
    }

}
function getData(){
    return resultData;
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}

function addPartName(){
	
	var namestd =nui.get('searchKey').getValue().replace(/\s+/g, "");
	nui.open({
		url : webPath+ partDomain+ "/common/partNameAdd.jsp?token"+ token,
		title : "新增配件名称",
		width : 425,
		height : 300,
		allowDrag : false,
		allowResize : false,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {
				namestd : namestd
			};

			iframe.contentWindow.SetData(params);
		},
		ondestroy : function(action) {
			if (action == 'ok') {

				onSearch();
				morePartSearch();

			}
		}
	});
}