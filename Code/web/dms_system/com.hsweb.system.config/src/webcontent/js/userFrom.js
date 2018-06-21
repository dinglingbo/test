/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;
var storeUrl = baseUrl + "com.hsapi.system.confi.paramSet.getStoreList.biz.ext";
var gridUrl = baseUrl + "com.hsapi.system.confi.userFrom.getuserFrom.biz.ext";
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
var editWindow;
var typeList = [{ id: 1, name: "启用" },{ id: 0, name: "禁用" }];
var SignHash = {
	    "0":"禁用",
	    "1":"启用"
	};





$(document).ready(function(v) {
	
	editWindow = nui.get("editWindow");
	grid=nui.get("dgGrid");
	grid.setUrl(gridUrl);
	grid.load({
		
	});		

    grid.on("drawcell", function (e){
    	onDrawCell(e);
    });
});



function onDrawCell(e)  {
    switch (e.field)  {
        case "isDisabled":
            if(SignHash && SignHash[e.value]) {
                e.cellHtml = SignHash[e.value];
            }
            break;
       
        default:
            break;
    }
}















function editRow(num) {
	 	
	 
		var s=grid.getSelected();
		if(s==undefined){
			nui.alert("请选中一行");
			return ;
		}
		else if(s.orgid=='0'){
			nui.alert("不能修改系统参数");
			return ;
		}
		var form1=new nui.Form("#editform");
		form1.setData(s);
        editWindow.show();
     
}
function newRow(){
		var form1=new nui.Form("#editform");
		form1.setData('');
	 	editWindow.show();
}

function onCancel(){
	 var form1=new nui.Form("#editform");
	 form1.setData('');
	 editWindow.hide();
}



var saveUrl = baseUrl + "com.hsapi.system.confi.userFrom.saveuserForm.biz.ext";
function onOk(){
	 var form1=new nui.Form("#editform");
	 var formData=form1.getData();
	 nui.ajax({
			url:saveUrl,
			type:"post",
			data:{
				params:formData
			},
			success: function (data) {
	               if (data.errCode == "S"){
	            	    nui.alert("保存成功！");
	            		grid.reload();
	               	}
					else{
					 	nui.alert("保存失败！");
	               	}
	       
	           },
	           error: function (jqXHR, textStatus, errorThrown) {
	               nui.alert(jqXHR.responseText);
	           }
		
		});
	form1.setData('');
	editWindow.hide();

}


var stopUrl = baseUrl + "com.hsapi.system.confi.userFrom.startorstopUserForm.biz.ext";
function stopRow(is){
	 
	var s=grid.getSelected();
	if(s==undefined){
		nui.alert("请选中一行！");
		return ;
	}
	else if(s.isDisabled=='0'&&is=='1'){
		nui.alert("此条已被禁用！");
		return ;
	}
	else if(s.isDisabled=='1'&&is=='2'){
		nui.alert("此条已被启用！");
		return ;
	}
	else if(s.orgid=='0'){
		nui.alert("不能修改系统参数！");
		return ;
	}
	 nui.ajax({
			url:stopUrl,
			type:"post",
			data:{
				params:s
			},
			success: function (data) {
	               if (data.errCode == "S"){
	            	    nui.alert("保存成功！");
	            		grid.reload();
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
