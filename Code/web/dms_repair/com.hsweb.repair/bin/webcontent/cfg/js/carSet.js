/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;


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






$(document).ready(function(v) {
	
	
	getProvince(function(data) {
	        list = data.rs;
	        nui.get("provinceId").setData(list);

	    });

});


	


	
var queryUrl = baseUrl + "com.hs.common.region.getRegin.biz.ext";
function getProvince(callback) {

    nui.ajax({
        url : queryUrl,
        data : {
        	parentId:provinceCode,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.rs) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
           console.log(jqXHR.responseText);
        }
    });
}




/*
repairStoreForm
汽车电子健康档案上传设置
*
*
*/
var repairStoreFormUrl = baseUrl + "com.hsapi.system.confi.paramSet.saveRepairStore.biz.ext";
function repairStoreFormSet(){
	var form1=new nui.Form("#repairStoreForm");
	var formData=form1.getData();
	nui.ajax({
		url:repairStoreFormUrl,
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
