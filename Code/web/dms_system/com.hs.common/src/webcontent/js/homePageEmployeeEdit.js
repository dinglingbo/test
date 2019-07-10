/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var repairUrl = apiPath + repairApi + "/";
var saveUrl = baseUrl + "com.hsapi.system.tenant.employee.saveEmployee.biz.ext";//"com.hsapi.system.employee.employeeMgr.employeeSave.biz.ext";
var fromUrl = baseUrl + "com.hsapi.system.tenant.employee.queryEmployee.biz.ext";
var sex;
var isShowOwnBill = null; 
var isAllowRemind = null;
var isservicelist = [{id: 0, name: '否'}, {id: 1, name: '是'}];
var basicInfoForm = null;
var form1 = null;
var wechatCodeUrl = webPath + contextPath + '/common/images/wechatCode.jpg';
var rmp = {};
$(document).ready(function(v) {
	isShowOwnBill=nui.get("isShowOwnBill");
	isAllowRemind=nui.get("isAllowRemind");
    isShowOwnBill.setData(isservicelist);
    
    document.getElementById("wechatServiceCode").src = wechatCodeUrl;
    document.getElementById("wechatCode").src = wechatCodeUrl;
	isAllowRemind.setData(isservicelist);

    basicInfoForm = new nui.Form('#basicInfoForm');
    from1=basicInfoForm.getData();
    nui.get("tel").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	 closeWindow("cal");
        }
      };
});

function onempid(e) {
    if (e.isValid) {
        if ( e.value.length >=11 ) {
            e.errorText = "必须输入不大于11位数字";
            e.isValid = false;
        }
    }
}
function SetInitData(data) {
	if (!data.empid) return; 
	emp = data;
	basicInfoForm.setData(data);

}

var requiredField = {
    tel:"电话"
};

function save(action) {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();
    emp.isShowOwnBill = data.isShowOwnBill;
    emp.isAllowRemind = data.isAllowRemind;
    emp.tel = data.tel;
    emp.birthday = data.birthday;
    emp.urgencyPerson = data.urgencyPerson;
    emp.urgencyPersonPhone = data.urgencyPersonPhone;
    emp.wechat = data.wechat;  
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }
    form.validate();
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
        	emp:emp,
        	token: token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if (data.errCode == 'S' && action != 'new') {
                showMsg(data.errMsg,"S");
            	if (window.CloseOwnerWindow){
            		 closeWindow("ok");
                } else {
                	 closeWindow("cal");
                }
            }else{
                showMsg(data.errMsg,"W");
                //basicInfoForm.setData([]); 
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



function onMobileValidation(e)
{
    if (e.isValid) {
        var pattern = /^1(3|5|6|7|8|9)\d{9}$/;;
        if (e.value.length != 11 || pattern.test(e.value) == false) {
            e.errorText = "必须输入正确的手机号码";
            e.isValid = false;
        }
    }
}

function updatePassWord(){
	nui.open({
		url: webPath + contextPath +  "/coframe/rights/user/update_password.jsp",
		title:"修改密码",
		width: "370px",
		height: "200px"
	});
}

function showCode() {
    $("#cover").show();
}
function hideCode() {
    $("#cover").hide();
}