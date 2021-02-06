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
var SignHash = {
	    "0":"否",
	    "1":"是"
	};





$(document).ready(function(v) {
	
	

	grid=nui.get("discountGrid");
	grid.setUrl(gridUrl);
	grid.load({
		params:initList,
	});		
});




//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
	var editor = e.editor;
	editor.validate();
	if (editor.isValid() == false) {
		if (e.field == "packageDiscountRate") {
			e.value=1;
		}else if(e.field == "itemDiscountRate") {
			e.value=1;
		}else if(e.field == "partDiscountRate") {
			e.value=1;
		}
	}	
}

//保存积分设置
var discountFormUrl = baseUrl + "com.hsapi.system.confi.paramSet.saveDiscount.biz.ext";
function saveDiscount(){
	var s=grid.getData();
	var form1=new nui.Form("#discountForm");
	var formData=form1.getData();
	var pointBring=formData.pointBring;
	var pointUse=formData.pointUse;
	var discountArea=formData.discountArea;
	var strs= new Array(); //定义一数组 
	var request={};
	strs=pointBring.split(","); //字符分割 
	formData.integralBillAdd=0;
	formData.integralWashAdd=0;
	formData.integralRetailAdd=0;
	formData.integralClaimsAdd=0;
	formData.integralBillReduce=0;
	formData.integralWashReduce=0;
	formData.integralRetailReduce=0;
	formData.integralClaimsReduce=0;
	formData.discountRangeBill=0;
	formData.discountRangeWash=0;
	formData.discountRangeRetail=0;
	formData.discountRangeClaims=0;
	for (i=0;i<strs.length ;i++ ) 
	{ 
		if(strs[i]=='1') formData.integralBillAdd=1;
		else if(strs[i]=='2') formData.integralWashAdd=1;
		else if(strs[i]=='3') formData.integralRetailAdd=1;
		else if(strs[i]=='4') formData.integralClaimsAdd=1;
	} 
	
	strs=pointUse.split(","); //字符分割 
	for (i=0;i<strs.length ;i++ ) 
	{ 
		if(strs[i]=='1') formData.integralBillReduce=1;
		else if(strs[i]=='2') formData.integralWashReduce=1;
		else if(strs[i]=='3') formData.integralRetailReduce=1;
		else if(strs[i]=='4') formData.integralClaimsReduce=1;
	}
	strs=discountArea.split(","); //字符分割 
	for (i=0;i<strs.length ;i++ ) 
	{ 
		if(strs[i]=='1') formData.discountRangeBill=1;
		else if(strs[i]=='2') formData.discountRangeWash=1;
		else if(strs[i]=='3') formData.discountRangeRetail=1;
		else if(strs[i]=='4') formData.discountRangeClaims=1;
	}
	
	request={
		a:s,
		b:formData
	};
	nui.ajax({
		url:discountFormUrl,
		type:"post",
		data:{
			params:request
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
