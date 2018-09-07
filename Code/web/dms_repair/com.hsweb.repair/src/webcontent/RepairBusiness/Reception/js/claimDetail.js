var mtAdvisorIdEl = null;
var serviceTypeIdEl = null;
var memList = [];
$(document).ready(function () {
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	mtAdvisorIdEl.on("valueChanged",function(e){
	        var text = mtAdvisorIdEl.getText();
	        nui.get("mtAdvisor").setValue(text);
    });
	initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
    });
	
	serviceTypeIdEl = nui.get("serviceTypeId");
	initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
        servieTypeList.forEach(function(v) {
            servieTypeHash[v.id] = v;
        });
    });
});

