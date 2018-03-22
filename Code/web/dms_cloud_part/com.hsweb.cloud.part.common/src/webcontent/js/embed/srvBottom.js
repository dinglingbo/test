
var mainTabs = null;
var stockselect = null;    //库存明细
var pchsRecord = null;       //采购记录
var sellRecord = null;       //销售记录
var guestPrice = null;      //客户销价
var rtnRecord = null;       //退货记录
var partInfo = null;        //配件基础资料
var mainrow = null;
var gparams = {};
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
    document.getElementById("bottomFormIframeOutableRecord").src=webPath + cloudPartDomain + "/common/embedJsp/containBottomOutableRecord.jsp";
    document.getElementById("bottomFormIframePchsRecord").src=webPath + cloudPartDomain + "/common/embedJsp/containBottomPchsRecord.jsp";
    document.getElementById("bottomFormIframeSellRecord").src=webPath + cloudPartDomain + "/common/embedJsp/containBottomSellRecord.jsp";
    document.getElementById("bottomFormIframeRtnRecord").src=webPath + cloudPartDomain + "/common/embedJsp/containBottomPchsRtnRecord.jsp";
    document.getElementById("bottomFormIframePartInfo").src=webPath + cloudPartDomain + "/common/embedJsp/containBottomPartInfo.jsp";

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
	params.storeId = row.storeId;
	params.partId = row.partId;
	params.guestId= row.guestId;
	gparams = nui.clone(params);
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
    var params = {};
    if(!gparams.partId) gparams.partId=0;
    if(!gparams.guestId) gparams.guestId=0;
    if(!gparams.storeId) gparams.storeId=0;
	switch (name)
    {
        case "stockselect":
            if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                document.getElementById("bottomFormIframeStock").contentWindow.doSearch(gparams);
            }
            break;
        case "outableRecord":
            if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
            	params.partId=gparams.partId;
                document.getElementById("bottomFormIframeOutableRecord").contentWindow.doSearch(params);
            }
        	break;
        case "pchsRecord":
            if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
            	params.partId=gparams.partId;
                document.getElementById("bottomFormIframePchsRecord").contentWindow.doSearch(params);
            }
            break;
        case "sellRecord":
            if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                params.partId=gparams.partId;
                document.getElementById("bottomFormIframeSellRecord").contentWindow.doSearch(params);
            }
            break;
        case "guestPrice":
            if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                params.partId=gparams.partId;
                params.guestId=gparams.guestId;
                document.getElementById("bottomFormIframeSellRecord").contentWindow.doSearch(params);
            }
            break;
        case "rtnRecord":
            if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                params.partId=gparams.partId;
                document.getElementById("bottomFormIframeRtnRecord").contentWindow.doSearch(params);
            }
            break;
        case "partInfo":
            if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                params.partId=gparams.partId;
                document.getElementById("bottomFormIframePartInfo").contentWindow.doSearch(params);
            }
            break;
        default:
            break;
    }
}