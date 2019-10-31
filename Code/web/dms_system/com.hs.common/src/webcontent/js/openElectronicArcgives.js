/**
 * Created by steven on 2018/1/31.
 */

baseUrl = apiPath + sysApi + "/";;
var saveUrl = baseUrl + "com.hsapi.system.tenant.tenant.saveCompany.biz.ext";
var company = {};
$(document).ready(function(v) {
    provinceEl = nui.get("provinceId");
    cityEl = nui.get("cityId");
    countyEl = nui.get("countyId");
    streetAddressEl = nui.get("streetAddress");
    addressEl = nui.get("address");

    getRegion(null,function(data) {
        provinceHash = data.rs || [];
        provinceEl.setData(provinceHash);

    });
    nui.get("code").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	closeWindow("cal");
        }
      };

		

});



function SetInitData(data) {
	company = data;
}

var requiredField = {
	companyname : "维修企业名称",
	companypassword : "维修企业登录密码",
	companyunifiedsocialcreditidentifier : "维修企业统一社会代码",
	companyaddress : "维修企业地址",
	companypostalcode : "维修企业邮政编码",
	companyeconomicategory : "维修企业经济类型",
	companycategory : "维修企业经营业务类别",
	companylinkmanname : "维修企业联系人姓名",
	companylinkmantel:"维修企业联系人电话",
	companysuperintendentname:"维修企业负责人姓名",
	companysupereintendenttel:"维修企业负责人电话",
	companybusinessscope:"维修企业经营范围",
	companyoperationstate:"维修企业经营状态",
	companyadministrativedivisioncode:"维修企业注册区域编码",
	companyemail:"维修企业注册邮箱",
	support:"接入支持服务商"
};
function save(action) {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();
    var data1 = form.getData();
    var provinceId = 0;
    for ( var key in requiredField) {
    	if(key == "provinceId"){
    		provinceId = data[key];
    	}
        if (!data[key] || $.trim(data[key]).length == 0) {
        	if(key == "cityId" && (provinceId==81 || provinceId==82) ){
        		continue;
        	}
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    /*data.cityId = "";
    data.provinceId = "";
    data.countyId = "";*/
    
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
   
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	comd:data,
        	token: token
        }),
        success:function(data)
        {
            
           
            if (data.errCode == 'S' && action != 'new') {
            	if (window.CloseOwnerWindow){
            		 closeWindow("ok");
                } else {
                	 closeWindow("cal");
                }
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
        	  nui.unmask();
            closeWindow("cal");
        }
    });
}

function close() {
	if (window.CloseOwnerWindow){
		return window.CloseOwnerWindow('OK');
    } else {
        window.close();
        return ;
    }
}
function Oncancel(){
 	closeWindow("cal");
	
}


function onMobileValidation(e) {
	if(e.value=="" || e.value==null){ return;}
	if (e.isValid) {
        var pattern = /^0\d{2,3}-\d{7,8}$/; ///0\d{2}-\d{7,8}/;
        if (pattern.test(e.value) == false) {
            e.errorText = "必须是电话，如：028-2580344";
            e.isValid = false;
        }
    }
}





