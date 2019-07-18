var baseUrl = apiPath + sysApi + "/";
var repairUrl = apiPath + repairApi + "/";
var saveUrl = baseUrl + "com.primeton.tenant.comTenant.saveCustomer.biz.ext";
var sexlist = [{id: 1, name: '男'}, {id: 0, name: '女'}];
var basicInfoForm = null;
var sex = null;
var requiredField = {
	    name:"姓名"

	};

$(document).ready(function(v) {
	sex=nui.get("sex");
	sex.setData(sexlist);
    basicInfoForm = new nui.Form('#basicInfoForm');
});

function save() {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();
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
        	customer:data,
        	token: token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if (data.errCode == 'S') {
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

function setData(data){
	basicInfoForm.setData(data);
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