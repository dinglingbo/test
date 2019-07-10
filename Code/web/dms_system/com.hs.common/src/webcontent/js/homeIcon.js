
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
var number = 0;//第几个div
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
        		address:e.row.linkAction
        }
        var smalls = document.getElementById('demo').getElementsByTagName('span');
        var tempIconList = [];//删除之后不能添加重复的
    	for(var i = 0;i<smalls.length;i++){
    		for(var j=0;j<iconList.length;j++){
    			if(smalls[i].innerHTML==iconList[j].name){
    				tempIconList[i] = iconList[j];
    			}
    		}
    	}
    	iconList = tempIconList;//提出删除的
        for(var i=0;i<iconList.length;i++){
        	if(iconList[i].iconId==e.row.menuPrimeKey){
            	showMsg("存在相同菜单","W");
            	return;
        	}
        }
        iconList.push(temp);
        number = smalls.length+1;
        addDiv(number,e.row.menuName);
        number++;
    });
});



function setData(icon) {
	iconList = icon||[];
    for(var i=0;i<iconList.length;i++){
    	for(var j=0;j<iconList.length;j++){
        	if(iconList[j].iconOrder==i){
            	addDiv(number,iconList[j].name);
            	number++;
        	}    		
    	}
    }
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
	if(number%6==0&&number!=0){
		html=html+"<br/>"
	}
	html+='<div class="item item'+number+' dads-children dad-draggable-area" data-dad-id="'+number+'" data-dad-position="'+number+'" style="background-color: #1faeff;    margin-top: 10px;border-radius: 12px;">';		
	html+='		<span>'+name+'</span> ';
	html+='</div>';
	$("#demo").append(html);
	//$.parser.parse($("#demo").parent());
	$('#demo').dad();
	var d = $('.jq22').dad();
	
	d.addDropzone('.dropzone', function(e){
		e.remove();
	});
}
var saveUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.svr.savehomePage.biz.ext";
function save(){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
	var smalls = document.getElementById('demo').getElementsByTagName('span');
	var newIconList = [];//新的列表，删除之后
	
	for(var i = 0;i<smalls.length;i++){
		for(var j=0;j<iconList.length;j++){
			if(smalls[i].innerHTML==iconList[j].name){
				newIconList[i] = iconList[j];
				newIconList[i].iconOrder = i;
			}
		}
	}
	var json = {
			homePage : 	newIconList,
			token : token
	};
	nui.ajax({
		url : saveUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			if(text.errCode=="S"){
				showMsg("保存成功","S")
				CloseWindow("ok");
			}
		}
	 });
	
}

function CloseWindow(action) {
	if (action == "close") {

	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}