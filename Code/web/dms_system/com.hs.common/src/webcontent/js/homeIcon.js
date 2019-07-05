
var baseUrl = apiPath + saleApi + "/";
var iconList = [];

var treeUrl = apiPath + sysApi + "/com.hsapi.system.tenant.permissions.getMenuData.biz.ext";
var isDisArr = [{id:'',text:'全部'},{id:0,text:'启用'},{id:1,text:'禁用'}];
var grid = null;
var tree = null;
var carBrandId = null;
var carSeriesId = null;
var fullName = null;
var arr = {};
$(document).ready(function () {
    grid = nui.get("grid1");

    tree = nui.get("tree1"); 
    loadTree();//加载标准项目



    grid.on('drawcell', function (e) {
        var value = e.value;
        var field = e.field;
        if (field == 'operateBtn') {
			e.cellHtml = '<span class="fa fa-arrow-up" onClick="javascript:goUp()" title="添加行">&nbsp;&nbsp;</span>'+
						' <span class="fa fa-arrow-down" onClick="javascript:goDown()" title="删除行">&nbsp;&nbsp;</span>'+
						 ' <span class="fa fa-close" onClick="javascript:deleteR()" title="删除行"></span>';
        }        
    });

    //"nodedblclick":节点双击时发生
    tree.on("nodedblclick",function(e)
    {
        var children = e.row.children;
        if(children){
        	showMsg("请选择菜单","W");
        	return;
        }
        var temp = {
        		name:e.row.menuName,
        		iconId:e.row.menuPrimeKey,
        		//linkResId:e.row.linkResId,
        		address:e.row.linkActione,
        		iconOrder : iconList.length
        }
        iconList.push(temp);
        grid.setData(iconList);
    });
});



function setData(iconList) {
	iconList = iconList||[];
	grid.setData(iconList);
}

function loadTree(){
//  tree.setUrl(hotUrl);
	nui.ajax({
		url : treeUrl,
		type : 'POST',
		data : "",
		cache : false,
		contentType : 'text/json',
		success : function(text) {
				var data =JSON.parse(JSON.stringify(text.treeNodes).replace(/childrenMenuTreeNodeList/g,"children"));
				tree.loadData(data||[]);
				//tree.loadData(data||[]);
		}
	 });
    
}

function goUp(){
	var row = grid.getSelected();
	if(row.iconOrder!=0){
		grid.moveUp(row);
	}
}

function goDown(){
	var row = grid.getSelected();
	if(row.iconOrder!=iconList.length){
		grid.moveDown(row);
	}
}
