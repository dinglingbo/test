/**
 * Created by steven on 2018/1/31.
 */

baseUrl = apiPath + sysApi + "/";;
var saveUrl = baseUrl + "com.hsapi.system.employee.comCompany.comCompanySave.biz.ext";

var sex;
var isservice;
nui.parse();
var isservicelist = [{id: 1, name: '是'}, {id: 0, name: '否'}];
var sexlist = [{id: 1, name: '女'}, {id: 0, name: '男'}]; //[{id:0, name:"女"}, {id:1, name:"男"}];
var dimissionlist = [{id:0, name:"在职"}, {id:1, name:"离职"}];

$(document).ready(function(v) {
	

});
function SetInitData(data) {
	
	
    		var form = new nui.Form("#basicInfoForm");
    	
            form.setData(data);    

}


function save(action) {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();
    data.cityId = "";
    data.provinceId = "";
    data.countyId = "";
    
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	com:data,
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