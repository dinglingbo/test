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
var list = null;
var provinceCode = null;
$(document).ready(function(v) {
	   getProvince(function(data) {
	        list = data.rs;
	        nui.get("provinceId").setData(list);

	    });


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
        	comd:data,
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
	
	function onProvinceChange(e){
	    var se = e.selected;
	    provinceCode = se.code;
	  
	    getProvince(function(data) {
	    	  nui.get("cityId").setData(data.rs);
	    });
	}
	