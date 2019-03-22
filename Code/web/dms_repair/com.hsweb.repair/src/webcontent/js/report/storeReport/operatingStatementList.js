/**
* Created by Administrator on 2018年9月21日19:29:11
*/
var webBaseUrl = webPath + contextPath + "/";
var resId = "";
var treeNodes = {};
$(document).ready(function(v) {
	
	$("body").on("blur","input[name='amount']",function(){
		onChanged();
	});


});

function readyList(resId){
	var json = {
		resId: resId,
		token: token
	}
	nui.ajax({
		url : apiPath + sysApi + "/com.hsapi.system.tenant.permissions.getSameLevelMenuData.biz.ext",
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = text.treeNodes;
				treeNodes = text.treeNodes;
			var str="";
			var num=0;
			if(returnJson && returnJson.length>0) {
				for(var i = 0;i<returnJson.length;i++){
					if(i%5==0&&i==0){
						num++;
						str = "<div  id='menu"+num+"' class='demo'  style=''>"
						str = str+ "<div class='menu_pannel menu_pannel_bg'><a onclick=toOperating('"+returnJson[i].funccode +"')><i class='fa "+returnJson[i].iconCls+" fa-4x  fa-inverse'></i><p>"+returnJson[i].funcname+"</p> </a></div>"
					}else if(i%5==0){
						num++;
						str = str+"</div>"
						str = str+ "<div  id='menu"+num+"' class='demo'  style='margin-top:20px;'>"
						str = str+ "<div class='menu_pannel menu_pannel_bg'><a onclick=toOperating('"+returnJson[i].funccode +"')><i class='fa "+returnJson[i].iconCls+" fa-4x  fa-inverse'></i><p>"+returnJson[i].funcname+"</p> </a></div>"
					}else if(i==returnJson.length-1){
						var j=i%5+1;
						var ddiv ="";
						for(var x = 0;x<=j;x++){
							ddiv = ddiv+"<div></div>" 
						}
						str = str+ "<div class='menu_pannel menu_pannel_bg'><a onclick=toOperating('"+returnJson[i].funccode +"')><i class='fa "+returnJson[i].iconCls+" fa-4x  fa-inverse'></i><p>"+returnJson[i].funcname+"</p> </a></div>"
						str = str+ddiv;
						str = str+"</div>"
					}else{
						str = str+ "<div class='menu_pannel menu_pannel_bg'><a onclick=toOperating('"+returnJson[i].funccode +"')><i class='fa "+returnJson[i].iconCls+" fa-4x  fa-inverse'></i><p>"+returnJson[i].funcname+"</p> </a></div>"
					}
				}

				 
			}
			
			$("#tb").append(str);
		}
	});
}





//根据开单界面传递的车牌号查询未结算的工单
function setInitData(params){
	readyList(params.resId);
}

function toOperating(funccodeStr){
	for(var i =0;i<treeNodes.length;i++){
		if(treeNodes[i].funccode==funccodeStr){
			toOpen(treeNodes[i].funccode,treeNodes[i].funcname,treeNodes[i].funcactioin);
		}
	}
}

function toOpen(funccode,funcname,funcactioin){
    var item={};
    item.id = funccode;
    item.text = funcname;
    item.url = webPath + contextPath + funcactioin+"?token="+token
    item.iconCls = "fa fa-file-text";
    window.parent.activeTab(item);
}





