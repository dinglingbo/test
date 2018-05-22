var mainFrame = null

$(document).ready(function(v) {

	$("#query0").css("color","blue");
	document.getElementById("mainFrame").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
    /*if(parent && parent.setBottomInit){
    	mainrow = parent.setBottomInit();
    	if(mainrow && mainrow.showTool == -1){
    		//document.getElementById("bottomFormIframeStock").contentWindow.setToolBar('hide');
    	}
    }*/
    
});
function query_vin(type){
	switch (type)
    {
        case 0:
            document.getElementById("mainFrame").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break;
        case 1:
            document.getElementById("mainFrame").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.brandQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break;
        case 2:
            document.getElementById("mainFrame").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.partQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break;
        default:
        	document.getElementById("mainFrame").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break;
    }

    $("#query0").css("color","black");
    $("#query1").css("color","black");
    $("#query2").css("color","black");

    if($("#query"+type).length>0)
    {
        $("#query"+type).css("color","blue");
        $("#query"+type).css("font-weight","true");
    }
}