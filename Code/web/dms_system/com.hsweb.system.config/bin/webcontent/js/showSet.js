/**
 * Created by steven on 2018/1/31.
 */
baseUrl = apiPath + sysApi + "/";;
var storeUrl = baseUrl + "com.hsapi.system.config.paramSet.getStoreList.biz.ext";



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
	
	
	getStoreList(function(data) {
		var storeList=[];
		storeList = data.data;
		nui.get("defaultStore").setData(storeList);
		
		
	});

});


/*
 * 
 * 获取仓库列表*/
var storeUrl = baseUrl + "com.hsapi.system.config.paramSet.getStoreList.biz.ext";
function getStoreList(callback){
    nui.ajax({
        url: storeUrl,
        type: 'post',
        data: nui.encode({
        }),
        cache: false,
        success: function (data) {
            if (data) {
             callback(data);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            nui.alert(jqXHR.responseText);
        }
	});
	
}








	
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
showForm
显示设置操作
*
*
*/
var showFormUrl=baseUrl + "com.hsapi.system.config.paramSet.saveShowSet.biz.ext";
function showFormSet(){
	
	var form1=new nui.Form("#showForm");
	var formData=form1.getData();
	var s=[{
		keyidId:"repair_careAlarm_default_show",
		keyidValue:formData.repair_careAlarm_default_show
		},{
		keyidId:"repair_service_default_show",
		keyidValue:formData.repair__service_default_show	
		},{
		keyidId:"repair_worklist_default_show",
		keyidValue:formData.repair__worklist_default_show	
		},{
		keyidId:"repair_settorder_print_show",
		keyidValue:formData.repair__settorder_print_show				
		},
		{
		keyidId:"repair_default_store",
		keyidValue:formData.defaultStore				
		}
		];
	nui.ajax({
		url:showFormUrl,
		type:"post",
		data:{
			params:s
		},
		success: function (data) {
               if (data.errCode == "S"){
               	nui.unmask(document.body);
               
               	nui.alert("保存成功！");
               	}
				else{
				nui.unmask(document.body);
				
               	nui.alert("保存失败！");
               	}
       
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
	
	});
}


