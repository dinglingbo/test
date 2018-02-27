/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var saveUrl = baseUrl + "com.hsapi.system.employee.employeeMgr.employeeEdit.biz.ext";
var fromUrl = baseUrl + "com.hsapi.system.employee.employeeMgr.employeeQuery.biz.ext";

nui.parse();

var sexlist = [{id: 1, name: '男'}, {id: 0, name: '女'}]; //[{id:0, name:"女"}, {id:1, name:"男"}];
var dimissionlist = [{id:0, name:"在职"}, {id:1, name:"离职"}];

function SetData(data) {
	if (!data.empid) return;
	
    nui.ajax({
        url:fromUrl + "?params/empid=" + data.empid,
        type:"post",        
        success:function(data)
        {
            nui.unmask();
            data = data || {};
            
            if (data.length <= 0) return;
            
        	var form = new nui.Form("#basicInfoForm");
            form.setData(data.rs[0]);            
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });	
}

var requiredField = {
    name:"姓名",
    //post_id:"职务",
    tel:"电话"
};

function save(action) {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();
    
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	emp:data,
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            nui.alert(data.errMsg);
            
            if (data.errCode == 'S' && action != 'new') {
            	if (window.CloseOwnerWindow){
            		return window.CloseOwnerWindow('OK');
                } else {
                    window.close();
                }
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function close() {
	if (window.CloseOwnerWindow){
		return window.CloseOwnerWindow('OK');
    } else {
        window.close();
    }
}