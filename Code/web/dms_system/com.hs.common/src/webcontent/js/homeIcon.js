
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
var number = 1;//第几个div
$(document).ready(function () {
    tree = nui.get("tree1"); 
    loadTree();//加载标准项目

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
        		address:e.row.linkActione
        }
        for(var i=0;i<iconList.length;i++){
        	if(iconList[i].iconId==e.row.menuPrimeKey){
            	showMsg("存在相同菜单","W");
            	return;
        	}
        }
        iconList.push(temp);
        addDiv(number,e.row.menuName);
        number++;
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
/*<div class="item item3 dads-children dad-draggable-area" data-dad-id="3" data-dad-position="3">	*/

//生成 div
function addDiv(number,name){
	var html="";
	html+='<div class="item item'+number+' dads-children dad-draggable-area" data-dad-id="'+number+'" data-dad-position="'+number+'" style="background-color: #1faeff;">';		
	html+='		<i class="fa fa-wrench fa-4x  fa-inverse"></i>';
	html+='		<span>'+name+'</span> ';
	html+='</div>';
	$("#demo").append(html);
	//$.parser.parse($("#demo").parent());
	$('#demo').dad();
}

function save(){
	var smalls = document.getElementById('demo').getElementsByTagName('span');
	for(var i = 0;i<smalls.length;i++){
		for(var j=0;j<iconList.length;j++){
			if(smalls[i].innerHTML==iconList[j].name){
				iconList[j].iconOrder = i;
			}
		}
	}
	
}
