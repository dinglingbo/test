/**
 * Created by Administrator on 2018/3/19.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var queryCarBrandSeriesTreeTUrl = baseUrl+"com.hsapi.repair.common.svr.queryCarBrandSeriesTreeT.biz.ext";
var partCode = "A";//记录点击的那个a标签
var carModelName = "";//选中的1级名称  奥迪
var carModelId = "";//选择的1级iD

var seriesName = "";//选中的二级名称
var seriesId = "";//选择的2级iD

var carModelNName = "";//选中的三级名称
var carModelNId = "";//选择的三级iD

var carModel = {};//返回给父页面的车型
var carModelList = [];
var type = "";//item项目传过来，可以不选择全部
$(document).ready(function(v)
{
	showcontrolpanel(0);//初始
	getCarBrandB("A");
});

function showcontrolpanel(level) {
	if(level == 0){
        $(".car_type_list").show();
        $(".car_type_pp").show();
        $(".car_type_yxz").hide();
	}else if (level == 2) {
        $(".car_type_pp").hide();
        $(".car_type_yxz").show();
        $(".car_type_list").hide();
        $("#dumaScrollAreaId_5").show();
        setheadstyle(2);
        $("#level2").show();
    } else if(level ==3) {
    	$("#dumaScrollAreaId_4").show();
    	$("#dumaScrollAreaId_5").hide();
    	$("#level3").show();
    	setheadstyle(2);
    } else if(level ==4) {
    	$("#level4").show();
    	setheadstyle(4);
    }else{

    }
}
function setheadstyle(level) {
    $(".car_type_menu>ul").attr("class", "c" + level);
}
//查车型1级，宝马
function getCarBrandB(letter){
	document.getElementById("carB").innerHTML = "";
	document.getElementById(partCode).style.background = "#e6e6e6";
	partCode = letter;
	document.getElementById(letter).style.background = "#00BFFF";

	var params = {
			firstCode : letter
			//name : document.getElementById("brandName").value
	};
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});
	nui.ajax({
		url : queryCarBrandSeriesTreeTUrl,
		type : "post",
		aynsc:false,
		data : {
			params:params,
			token:token
		},
		success : function(data) {		
			nui.unmask(document.body);
			var list = data.list;
			if (data.errCode == "S") {
				for(var i =0;i<list.length;i++){
					if(list[i].imageUrl=="" || list[i].imageUrl==null){					
						addDivB(list[i].nodeName,webPath + contextPath +"/baseDataPart/img/brandDefault.jpg",list[i].nodeId);
					}else{
						addDivB(list[i].nodeName,list[i].imageUrl,list[i].nodeId);
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
function addDivB(name,img,id){
	var html="";
	html+='<li id="'+id+'" style="background-color: white;" onclick="chooseCar('+"'"+name+"'"+','+"'"+id+"'"+',2)">';
	html+='	<a style="background-color: #fff;" clsaa="partA" href="javascript:void(0)" >';
//	html+=`<a style="background-color: #fff;" clsaa="partA" href="javascript:void(0)" onclick="choosePart($(name),$(id))">`;
	html+='		<img src="'+img+'" width="100" height="100">';
	html+='		<font>'+name+'</font>';
	html+='	</a>';
	html+='</li>';
	$("#carB").append(html);
}
//二级 系列  宝马二系
function getCarBrandC(id){

	var params = {
			nodeId : id
			//name : document.getElementById("brandName").value
	};
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});
	nui.ajax({
		url : queryCarBrandSeriesTreeTUrl,
		type : "post",
		aynsc:false,
		data : {
			params:params,
			token:token
		},
		success : function(data) {		
			nui.unmask(document.body);
			var list = data.list;
			if (data.errCode == "S") {
				for(var i =0;i<list.length;i++){
					if(list[i].imageUrl=="" || list[i].imageUrl==null){					
						addDivC(list[i].nodeName,list[i].nodeId);
					}else{
						addDivC(list[i].nodeName,list[i].nodeId);
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
function addDivC(name,id){
	var html="";
	html+='<dd id="'+id+'" style="background-color: white;" onclick="chooseCar('+"'"+name+"'"+','+"'"+id+"'"+',3)">';
	html+='	<a style="background-color: #fff;" clsaa="partA" href="javascript:void(0)" >';
	html+='		<font>'+name+'</font>';
	html+='	</a>';
	html+='</dd>';
	$("#carC").append(html);
}
//三级四级 车型  
function getCarBrandN(id){
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});
	nui.ajax({
		url : baseUrl+"com.hsapi.repair.common.common.getCarModelByBrandId.biz.ext",
		type : "post",
		aynsc:false,
		data : {
			brandId : carModelId,
			seriesId : id,
			pageSize : 100,
			token:token
		},
		success : function(data) {		
			nui.unmask(document.body);
			var list = data.list;
			carModelList = data.list;
				for(var i =0;i<list.length;i++){
					if(list[i].imageUrl=="" || list[i].imageUrl==null){					
						addDivN(list[i].carModel,list[i].id);
					}else{
						addDivN(list[i].carModel,list[i].id);
					}
				}
				
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

//生成 div
function addDivN(name,id){
	var html="";
	html+='<dd id="'+id+'" style="width: 348px;background-color: white;" onclick="chooseCar('+"'"+name+"'"+','+"'"+id+"'"+',4)">';
	html+='	<a style="background-color: #fff;" clsaa="partA" style="width: 338px;" href="javascript:void(0)" >';
	html+='		<font>'+name+'</font>';
	html+='	</a>';
	html+='</dd>';
	$("#carN").append(html);
}
function chooseCar(name,id,num){
	document.getElementById("level"+num+"Name").innerHTML = name;
	showcontrolpanel(num);
	if(num==2){
		carModelName = name;
		var ss=$("carB").children("li");
		if(carModelId!=""){	
			for(var i=0;i<ss.length;i++){
				if(ss[i].id==carModelId){				
					document.getElementById(carModelId).classList.remove("xz");
				}
			}
		}
		carModelId = id;
		document.getElementById(carModelId).classList.add("xz");
		getCarBrandC(id);
		carModel.carBrandName = carModelName;
		carModel.carBrandId = carModelId;
	}else if(num==3){
		seriesName = name;//选中的二级名称
		var ss=$("carC").children("li");
		if(seriesId!=""){	
			for(var i=0;i<ss.length;i++){
				if(ss[i].id==seriesId){				
					document.getElementById(seriesId).classList.remove("xz");
				}
			}
		}
		seriesId = id;//选择的2级iD
		document.getElementById(seriesId).classList.add("xz");
		getCarBrandN(id);
		
		carModel.carSeriesId = seriesId;
		carModel.carSeriesName = seriesName;
	}else if(num==4){
		carModelNName = name;//选中的三级名称
		var ss=$("carN").children("li");
		if(carModelNId!=""){
			for(var i=0;i<ss.length;i++){
				if(ss[i].id==carModelNId){				
					document.getElementById(carModelNId).classList.remove("xz");
				}
			}
		}
		carModelNId = id;//选择的三级iD
		document.getElementById(carModelNId).classList.add("xz");
		for(var i=0;i<carModelList.length;i++){
			if(id==carModelList[i].id){
				carModel = carModelList[i];
			}
		}
	}

	
}

function getData (){
	var data = {
			"carModel":carModel	
	}
	return data;
}

function onCancel(e) {
	if(type!="item"){		
		if(carModelNName==""){
			showMsg("请选择车型！","W");
			return;
		}
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

function uplevel(level){
	if(level==2){
        $(".car_type_list").show();
        $(".car_type_pp").show();
        $(".car_type_yxz").hide();
    	document.getElementById("carC").innerHTML = "";
    	document.getElementById("carN").innerHTML = "";
        $("#dumaScrollAreaId_5").hide();
        $("#level3").hide();
        $("#level4").hide();
		carModelNName = "";//选中的三级名称
		carModelNId = "";//选择的三级iD
	    setheadstyle(0);
	}else if(level==3){
        $(".car_type_pp").hide();
        $(".car_type_yxz").show();
        $(".car_type_list").hide();
    	document.getElementById("carN").innerHTML = "";
    	$("#dumaScrollAreaId_4").hide();
        $("#dumaScrollAreaId_5").show();       
        setheadstyle(1);
        $("#level3").hide();
        $("#level4").hide();
		carModelNName = "";//选中的三级名称
		carModelNId = "";//选择的三级iD
	}else if(level==4){
    	$("#level4").hide();
    	$("#dumaScrollAreaId_5").show();
    	document.getElementById("carN").innerHTML = "";
    	$("#dumaScrollAreaId_4").hide();
    	setheadstyle(2);
		carModelNName = "";//选中的三级名称
		carModelNId = "";//选择的三级iD
	}
}

function setData(typeUrl){
	type = typeUrl;
}