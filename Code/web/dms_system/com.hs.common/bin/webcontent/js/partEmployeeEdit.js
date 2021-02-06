/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var saveUrl = baseUrl + "com.hsapi.system.tenant.employee.saveEmployee.biz.ext";//"com.hsapi.system.employee.employeeMgr.employeeSave.biz.ext";
var deptUrl = baseUrl + "com.hsapi.system.tenant.employee.queryDept.biz.ext";
//var fromUrl = baseUrl + "com.hsapi.system.employee.employeeMgr.employeeQuerys.biz.ext";
var sex;
var isservice;
var isservicelist = [{id: 1, name: '是'}, {id: 0, name: '否'}];
var sexlist = [{id: 1, name: '男'}, {id: 0, name: '女'}]; //[{id:0, name:"女"}, {id:1, name:"男"}];
var dimissionlist = [{id:0, name:"在职"}, {id:1, name:"离职"}];
var basicInfoForm = null;
var isCanBelowCost;
var isSalesman;
var isLimitCredit;
$(document).ready(function(v) {
	sex=nui.get("sex");
	isCanBelowCost =nui.get("isCanBelowCost");
	isSalesman =nui.get("isSalesman");
	isLimitCredit =nui.get("isLimitCredit");
	sex.setData(sexlist);
	isCanBelowCost.setData(isservicelist);
	isSalesman.setData(isservicelist);
	isLimitCredit.setData(isservicelist);
    basicInfoForm = new nui.Form('#basicInfoForm');
    
    
});

function SetInitData(data) {
	getDepartment(function() {
		basicInfoForm.setData(data)
	});
	if (!data.empid) return;
	;   
    /*nui.ajax({
        url:fromUrl + "?params/empid=" + data.empid,
        type:"post",        
        success:function(data)
        {
            nui.unmask();
            data = data || {};
            
            if (data.length <= 0) return;
            
        	var form = new nui.Form("#basicInfoForm");
            form.setData(data.rs[0]);    
            nui.get("newand").setVisible(false);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });	*/
}

function getDepartment(callback) {
	nui.ajax({
        url:deptUrl,
        type:"post",
        data:JSON.stringify({
        	token: token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode && data.errCode == 'S'){
                nui.get("deptId").setData(data.rs);
            }
            
            callback();
            
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
           
            closeWindow("cal");
            callback();
        }
    });
	
}

function ondeptchanged(e) {
	nui.get("kingCode").setValue(e.selected.kingCode);
}

var requiredField = {
    name:"姓名",
    tel:"电话",
    idcardno:"身份证号码"
};

function save(action) {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();
    
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            showMsg(requiredField[key]+"不能为空","W");
            return;
        }
    }

    if (form.isValid() == false) return;
  
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	emp:data,
        	token: token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode && data.errCode != 'S'){
                nui.alert(data.errMsg);
            }else{
                if (data.errCode == 'S' && action != 'new') {
                    if (window.CloseOwnerWindow){
                         closeWindow("ok");
                    } else {
                         closeWindow("cal");
                    }
                }else{
                    basicInfoForm.setData([]); 
                    nui.get("name").focus();
                }
            }
            
            
            
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
           
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

function onIDCardsValidation(e)
{
    if (e.isValid) {
        var pattern = /^[1-9][0-9]{5}(19[0-9]{2}|20[0-9]{2})(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])[0-9]{3}[0-9xX]$/;
        if (e.value.length != 18 || pattern.test(e.value) == false) {
            e.errorText = "必须输入正确的18位身份证号码";
            e.isValid = false;
        }
    }
}

function onMobileValidation(e)
{
    if (e.isValid) {
        var pattern = /^\d{11}$/;
        if (e.value.length != 11 || pattern.test(e.value) == false) {
            e.errorText = "必须输入正确的手机号码";
            e.isValid = false;
        }
    }
}

function onCredValidation(e){
	var pattern =/^(0|[1-9][0-9]*)(\.\d+)?$/;
	if(e.isValid){
		if(isLimitCredit.getValue()==0 && e.value>0){
			e.errorText = "没有限制开单额度的权限，不能设置额度";
            e.isValid = false;
		}
		if(isLimitCredit.getValue() ==1 &&  pattern.test(e.value) == false ){
			e.errorText = "必须输入正数";
            e.isValid = false;
		}
	}
}