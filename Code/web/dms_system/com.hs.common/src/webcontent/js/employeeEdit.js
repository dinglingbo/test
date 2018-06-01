/**
 * Created by steven on 2018/1/31.
 */

baseUrl = apiPath + sysApi + "/";;
var saveUrl = baseUrl + "com.hsapi.system.employee.employeeMgr.employeeSaves.biz.ext";
var fromUrl = baseUrl + "com.hsapi.system.employee.employeeMgr.employeeQuerys.biz.ext";
var sex;
var isservice;
nui.parse();
var isservicelist = [{id: 1, name: '是'}, {id: 0, name: '否'}];
var sexlist = [{id: 1, name: '女'}, {id: 0, name: '男'}]; //[{id:0, name:"女"}, {id:1, name:"男"}];
var dimissionlist = [{id:0, name:"在职"}, {id:1, name:"离职"}];

$(document).ready(function(v) {
	isservice=nui.get("isArtificer");
	sex=nui.get("sex");
	sex.setData(sexlist);
	isservice.setData(isservicelist);

});
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
            nui.get("newand").setVisible(false);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });	
}

var requiredField = {
    name:"姓名",
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
        	token: token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            nui.alert(data.errMsg);
            
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

	function check(s){
		if(s==0){
			if(nui.get(check0).getValue()=='true')
				nui.get(integralDiscountMax).setValue('-1');
			}
		else if(s==1){
		if(nui.get(check1).getValue()=='true')
			nui.get(itemDiscountRate).setValue('-1');
		}
		else if(s==2){
			if(nui.get(check2).getValue()=='true')
				nui.get(partDiscountRate).setValue('-1');
			}
		else if(s==3){
			if(nui.get(check3).getValue()=='true')
				nui.get(freeDiscountMax).setValue('-1');
			}
		else if(s==4){
			if(nui.get(check4).getValue()=='true')
				nui.get(cashDiscountMax).setValue('-1');
			}
		}