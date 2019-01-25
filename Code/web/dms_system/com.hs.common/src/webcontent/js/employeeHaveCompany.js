/**
 * Created by steven on 2018/1/31.
 */

var baseUrl = apiPath + sysApi + "/";
var repairUrl = apiPath + repairApi + "/";
var queryUrl = baseUrl + "com.hsapi.system.basic.organization.getCompanyAll.biz.ext";//"com.hsapi.system.employee.employeeMgr.employeeSave.biz.ext";
var moreOrgGrid = null;
$(document).ready(function(v) {
	moreOrgGrid = nui.get("moreOrgGrid");
	moreOrgGrid.setUrl(queryUrl);
	
    nui.get("name").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	 closeWindow("cal");
        }
      };
      onSearch();
});

function onSearch(){
	var params = {};
	params.name = nui.get("name").getValue();
	params.code = nui.get("code").getValue();
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