var baseUrl = apiPath + repairApi + "/";
var queryMaintainUrl = baseUrl+"com.hsapi.repair.repairService.timersettle.queryMaintain.biz.ext";
var datagrid1 = null;
$(document).ready(function(v){
	datagrid1 = nui.get("datagrid1");
	datagrid1.setUrl(queryMaintainUrl);
	datagrid1.load({
        token:token
    });
});