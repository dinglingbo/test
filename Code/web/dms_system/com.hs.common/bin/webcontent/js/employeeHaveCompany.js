/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var repairUrl = apiPath + repairApi + "/";
var queryUrl = baseUrl + "com.hsapi.system.basic.organization.getCompanyAllWithPage.biz.ext";//"com.hsapi.system.employee.employeeMgr.employeeSave.biz.ext";
var moreOrgGrid = null;
var empId = null;
$(document).ready(function(v) {
	moreOrgGrid = nui.get("moreOrgGrid");
	moreOrgGrid.setUrl(queryUrl);
	
    nui.get("name").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	 //closeWindow("cal");
        	Oncancel();
        }
      };
      onSearch();
});

function onSearch(){
	var params = {};
	params.name = nui.get("name").getValue().replace(/\s+/g, "");
	params.code = nui.get("code").getValue().replace(/\s+/g, "");
	if(currTenantId==0){
		params.tenantId = 0;
	}
	moreOrgGrid.load({
		params:params,
		token : token
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
    //closeWindow("cancel");
	close();
}

function setDataSelect(row){
	empId = row.empid;
}
function addOrg(){
	var rows = moreOrgGrid.getSelecteds();
	if(rows.length>0){
		var json = nui.encode({
			intCompanyList:rows,
			empId:empId,
			token:token});
		 nui.mask({
	            el: document.body,
	            cls: 'mini-mask-loading',
	            html: '保存中...'
	    });
		$.ajax({
            url:apiPath + sysApi + "/com.hsapi.system.basic.organization.saveMyCompany.biz.ext",
            type:'POST',
            data:json,
            cache: false,
            contentType:'text/json',
            success:function(text){
              var returnJson = nui.decode(text);
              if(returnJson.errCode == 'S'){
            	  nui.unmask(document.body);
                  showMsg(returnJson.errMsg || "保存成功!", "S");
              }else{
            	  nui.unmask(document.body);
                  showMsg(returnJson.errMsg || "保存失败!", "E");
              }
            }
          });
	}else{
		nui.alert("请选择兼职门店!");
	}
}


