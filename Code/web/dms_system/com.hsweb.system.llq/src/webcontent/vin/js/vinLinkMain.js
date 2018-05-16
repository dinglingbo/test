var mainFrame = null

$(document).ready(function(v) {

	$("#query0").css("color","blue");
	document.getElementById("mainFrame").src=webPath + sysDomain + "/llq/vin/vinQuery.jsp";
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
            document.getElementById("mainFrame").src=webPath + sysDomain + "/llq/vin/vinQuery.jsp";
            break;
        case 1:
            document.getElementById("mainFrame").src=webPath + sysDomain + "/llq/brand/brandQuery.jsp";
            break;
        case 2:
            document.getElementById("mainFrame").src=webPath + sysDomain + "/llq/part/partQuery.jsp";
            break;
        default:
        	document.getElementById("mainFrame").src=webPath + sysDomain + "/llq/vin/vinQuery.jsp";
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