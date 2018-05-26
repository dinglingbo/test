var mainFrame = null
var brand = "";
var lastBrand = "";
var catchs = {};

$(document).ready(function(v) {
    query_vin(0);
	//$("#query0").css("color","blue");
	//document.getElementById("mainFrame").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
    /*if(parent && parent.setBottomInit){
    	mainrow = parent.setBottomInit();
    	if(mainrow && mainrow.showTool == -1){
    		//document.getElementById("bottomFormIframeStock").contentWindow.setToolBar('hide');
    	}
    }*/
    
});
function query_vin(type){
	$(".theIframe").hide();
    $("#mainFrame" + type).show();
    
    if(type==1 && brand != lastBrand){//定位指定品牌
        catchs[type] = null;
    }
    
    $("#query0").css("color","black");
    $("#query1").css("color","black");
    $("#query2").css("color","black");

    if($("#query"+type).length>0){
        $("#query"+type).css("color","blue");
        $("#query"+type).css("font-weight","true");
    }
    
    if(catchs[type]){
        return;
    }
    
    switch (type){
        case 0:
            document.getElementById("mainFrame0").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break;
        case 1:
            document.getElementById("mainFrame1").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.brandQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995&brand=" + brand;
            break;
        case 2:
            document.getElementById("mainFrame2").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.partQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break;
        /* default:
        	document.getElementById("mainFrame").src=webPath + sysDomain + "/com.hsweb.system.llq.vin.vinQuery.flow.ext?token=214e2f71-4237-4601-9a1a-538bf982b995";
            break; */
    }
    catchs[type] = 1;
}

function queryBrand(currBrand){
    brand = currBrand;
    query_vin(1);
    lastBrand = brand;
    brand = "";
}