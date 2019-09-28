var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var partCode = "A";//记录点击的那个a标签
var partName = "";//选中的品牌名称
var partId = "";//选择的品牌iD
$(document).ready(function(v){
	getPartBrandLetter("A");
});

function setData(type){}

function getPartBrandLetter(letter){
	document.getElementById("part").innerHTML = "";
	document.getElementById(partCode).style.background = "#e6e6e6";
	partCode = letter;
	document.getElementById(letter).style.background = "#00BFFF";
	var queryPartBrandUrl = baseUrl +"com.hsapi.system.dict.dictMgr.queryPartBrandParams.biz.ext";
	var params = {
			firstCodeCh : letter
			//name : document.getElementById("brandName").value
	};
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});
	nui.ajax({
		url : queryPartBrandUrl,
		type : "post",
		aynsc:false,
		data : {
			params:params,
			token:token
		},
		success : function(data) {		
			nui.unmask(document.body);
			var list = data.list;
			var num = 0;
			if (data.errCode == "S") {
				for(var i =0;i<list.length;i++){
					if(list[i].imageUrl=="" || list[i].imageUrl==null){					
						addDiv(num,list[i].name,webPath + contextPath +"/baseDataPart/img/brandDefault.jpg",list[i].id);
					}else{
						addDiv(num,list[i].name,list[i].imageUrl,list[i].id);
					}
				}
				
			}else{
				showMsg("查询失败","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

function getPartBrandName(){
	document.getElementById("part").innerHTML = "";
	var queryPartBrandUrl = baseUrl +"com.hsapi.system.dict.dictMgr.queryPartBrandParams.biz.ext";
	var params = {
			name : document.getElementById("brandName").value
	};
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});
	nui.ajax({
		url : queryPartBrandUrl,
		type : "post",
		aynsc:false,
		data : {
			params:params,
			token:token
		},
		success : function(data) {		
			nui.unmask(document.body);
			var list = data.list;
			var num = 0;
			if (data.errCode == "S") {
				for(var i =0;i<list.length;i++){
					if(list[i].imageUrl=="" || list[i].imageUrl==null){					
						addDiv(num,list[i].name,webPath + contextPath +"/baseDataPart/img/brandDefault.jpg",list[i].id);
					}else{
						addDiv(num,list[i].name,list[i].imageUrl,list[i].id);
					}
				}
				
			}else{
				showMsg("查询失败","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
//生成 div
function addDiv(number,name,img,id){
	var html="";
	if(number%6==0&&number!=0){
		html=html+"<br/>"
	}
	html+='<li id="'+id+'" onclick="choosePart('+"'"+name+"'"+','+"'"+id+"'"+')">';
	html+='	<a style="background-color: #fff;" clsaa="partA" href="javascript:void(0)" >';
//	html+=`<a style="background-color: #fff;" clsaa="partA" href="javascript:void(0)" onclick="choosePart($(name),$(id))">`;
	html+='		<img src="'+img+'" width="100" height="100">';
	html+='		<font>'+name+'</font>';
	html+='	</a>';
	html+='</li>';
	$("#part").append(html);
}

function choosePart(name,id){
	document.getElementById("selectmodels").innerHTML = name;
	partName = name;
	if(partId!=""){		
		document.getElementById(partId).classList.remove("xz");
	}
	partId = id;
	document.getElementById(partId).classList.add("xz");

}
function getData (){
	var part={
		name:partName,
		id : partId
	};
	return part;
}

function onCancel(e) {
	if(partName==""){
		showMsg("请选择品牌！","W");
		return;
	}
    CloseWindow("ok");
}
function CloseWindow(action) {
    //if (action == "close" && form.isChanged()) {
    //    if (confirm("数据被修改了，是否先保存？")) {
    //        return false;
    //    }
    //}
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}