
var mainTabs = null;
var stockselect = null;    //库存明细
var pchsRecord = null;       //采购记录
var sellRecord = null;       //销售记录
var guestPrice = null;      //客户销价
var rtnRecord = null;       //退货记录
var partInfo = null;        //配件基础资料
var mainrow = null;
var gparams = null;
$(document).ready(function(v) {
	mainTabs = nui.get("mainTabs");
	var tabList = mainTabs.getTabs();
	var stockselectTab =  mainTabs.getTab("stockselect");
	var pchsRecordTab =  mainTabs.getTab("pchsRecord");
	var sellRecordTab =  mainTabs.getTab("sellRecord");
	var guestPriceTab =  mainTabs.getTab("guestPrice");
	var rtnRecordTab =  mainTabs.getTab("rtnRecord");
	var partInfoTab =  mainTabs.getTab("partInfo");


    document.getElementById("bottomFormIframeStock").src=webPath + cloudPartDomain + "/common/embedJsp/containBottomStock.jsp";
    document.getElementById("bottomFormIframePchsRecord").src=webPath + cloudPartDomain + "/common/embedJsp/containBottomPchsRecord.jsp";


    if(parent && parent.setBottomInit){
    	mainrow = parent.setBottomInit();
    	if(mainrow && mainrow.showTool == -1){
    		//document.getElementById("bottomFormIframeStock").contentWindow.setToolBar('hide');
    	}
    }
    

	//tabs.updateTab(tabdetailPage, { visible: false });
	if(parent && parent.confirmType){
		var type = parent.confirmType();
		if(type) {
			if(type == 'purchase'){
				//库存明细 采购记录 销售记录  
			}else if(type == 'sell'){

			}
		}
    }

});
function setInitEmbedParams(row){
	var params = {};
	params.storeId = row.storeId || 0;
	params.partId = row.partId || 0;
	params.guestId= row.guestId || 0;
	gparams = params;
	//document.getElementById("bottomFormIframeStock").contentWindow.doSearch(params);
	showTabInfo();
}
function setInitTab(type){
	if(type) {
		if(type == 'purchase'){
			var tabList = mainTabs.getTabs();
		}
	}
}
function showTabInfo(){
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
	gparams.storeId = gparams.storeId || 0;
	gparams.partId = gparams.partId || 0;
	gparams.guestId= gparams.guestId || 0;
	switch (name)
    {
        case "stockselect":
            document.getElementById("bottomFormIframeStock").contentWindow.doSearch(gparams);
            break;
        case "bottomFormIframeOutableRecord":
        	gparams.guestId = null;
        	gparams.storeId = null;
            document.getElementById("bottomFormIframeOutableRecord").contentWindow.doSearch(gparams);
        	break;
        case "pchsRecord":
        	gparams.guestId = null;
        	gparams.storeId = null;
            document.getElementById("bottomFormIframePchsRecord").contentWindow.doSearch(gparams);
            break;
        case "sellRecord":
            //console.log(gparams);
            break;
        case "guestPrice":
            //console.log(gparams);
            break;
        case "rtnRecord":
            //console.log(gparams);
            break;
        case "partInfo":
            //console.log(gparams);
            break;
        default:
            break;
    }
}