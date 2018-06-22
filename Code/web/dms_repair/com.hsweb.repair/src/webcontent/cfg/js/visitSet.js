/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;

var initList=["维修","保养","美容","钣喷漆","轮胎","洗车","精品","零售","其他"];

var grid;
var time;
var person;
var provinceList=[];
var provinceHash={};
var cityList=[];
var cityHash={};
var queryForm;
var provinceCode;
nui.parse();
var productStatus;
var types;
var typeList = [{ id: 1, name: "工单" },{ id: 2, name: "洗车单" },{ id: 3, name: "零售单" },{ id: 4, name: "理赔单" }];

var showList = [{ id: 1, name: "启用" },{ id: 0, name: "禁用" }];




$(document).ready(function(v) {
	

});





/*
returnForm
回返操作
*
*
*/
var returnFormUrl = baseUrl + "com.hsapi.system.confi.paramSet.saveReturn.biz.ext";
function returnFormSet(){
	
	var form1=new nui.Form("#returnForm");
	var formData=form1.getData();
	nui.ajax({
		url:returnFormUrl,
		type:"post",
		data:{
			params:formData
		},
		success: function (data) {
               if (data.errCode == "S"){
            	    nui.alert("保存成功！");
               	}
				else{
				 	nui.alert("保存失败！");
               	}
       
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
	
	});
}


