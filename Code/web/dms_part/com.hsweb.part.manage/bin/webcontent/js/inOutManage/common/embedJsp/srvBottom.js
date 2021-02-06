
var mainTabs = null;
var stockselect = null;    //库存明细
var pchsRecord = null;       //采购记录
var sellRecord = null;       //销售记录
var guestPrice = null;      //客户销价
var rtnRecord = null;       //退货记录
var partInfo = null;        //配件基础资料
var mainrow = null;
var gparams = {};
var tabList = null;
var stockselectTab = null;
var outableRecordTab = null;
var pchsRecordTab = null;
var sellRecordTab = null;
var guestPriceTab = null;
var rtnRecordTab = null;
var partInfoTab = null;
var chainStockTab = null;
$(document).ready(function(v) {
	mainTabs = nui.get("mainTabs");
    tabList = mainTabs.getTabs();
	stockselectTab =  mainTabs.getTab("stockselect");
    outableRecordTab = mainTabs.getTab("outableRecord");
	pchsRecordTab =  mainTabs.getTab("pchsRecord");
	sellRecordTab =  mainTabs.getTab("sellRecord");
	guestPriceTab =  mainTabs.getTab("guestPrice");
	rtnRecordTab =  mainTabs.getTab("rtnRecord");
	partInfoTab =  mainTabs.getTab("partInfo");
    chainStockTab =  mainTabs.getTab("chainStock");

    //mainTabs.updateTab(stockselectTab, {url: webPath + contextPath + "/common/embedJsp/containBottomStock.jsp"});


    /*document.getElementById("bottomFormIframeStock").src=webPath + contextPath + "/common/embedJsp/containBottomStock.jsp";
    document.getElementById("bottomFormIframeOutableRecord").src=webPath + contextPath + "/common/embedJsp/containBottomOutableRecord.jsp";
    document.getElementById("bottomFormIframePchsRecord").src=webPath + contextPath + "/common/embedJsp/containBottomPchsRecord.jsp";
    document.getElementById("bottomFormIframeSellRecord").src=webPath + contextPath + "/common/embedJsp/containBottomSellRecord.jsp";
    document.getElementById("bottomFormIframeRtnRecord").src=webPath + contextPath + "/common/embedJsp/containBottomPchsRtnRecord.jsp";
    document.getElementById("bottomFormIframePartInfo").src=webPath + contextPath + "/common/embedJsp/containBottomPartInfo.jsp";
*/
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

    if(parent && parent.confirmType){
        var type = parent.confirmType();
        if(type) {
            if(type == 'pchs'){
                //库存明细 采购记录 销售记录  
                mainTabs.updateTab(stockselectTab, {visible:true});
                mainTabs.updateTab(outableRecordTab, {visible:true});
                mainTabs.updateTab(pchsRecordTab, {visible:true});
                mainTabs.updateTab(partInfoTab, {visible:true});
            }else{
                mainTabs.updateTab(stockselectTab, {visible:true});
                mainTabs.updateTab(sellRecordTab, {visible:true});
                //mainTabs.updateTab(guestPriceTab, {visible:true});
                mainTabs.updateTab(partInfoTab, {visible:true});
            }
        }else {
            mainTabs.updateTab(stockselectTab, {visible:true});
            mainTabs.updateTab(sellRecordTab, {visible:true});
            //mainTabs.updateTab(guestPriceTab, {visible:true});
            mainTabs.updateTab(partInfoTab, {visible:true});
        }
        
    }

});
function setInitEmbedParams(row){
	var params = {};
	params.storeId = row.storeId;
	params.partId = row.partId;
	params.guestId= row.guestId;

    if(row.type && row.type == "pchs"){
        params.storeId = null;
        params.guestId = null;

/*        mainTabs.updateTab(stockselectTab, {visible:true});
        mainTabs.updateTab(outableRecordTab, {visible:true});
        mainTabs.updateTab(pchsRecordTab, {visible:true});
        mainTabs.updateTab(partInfoTab, {visible:true});*/
    }else{
/*        mainTabs.updateTab(stockselectTab, {visible:true});
        mainTabs.updateTab(sellRecordTab, {visible:true});
        mainTabs.updateTab(guestPriceTab, {visible:true});
        mainTabs.updateTab(partInfoTab, {visible:true});*/
    }

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
function onMainTabLoad(e){
    //用于第一次加载完成后，如果已经加载过，此事件不会再触发
    var tab = e.tab;
    var name = tab.name;
    var params = {};
    if(!gparams.partId) gparams.partId=0;
    //if(!gparams.guestId) gparams.guestId=0;
    //if(!gparams.storeId) gparams.storeId=0;
    switch (name)
    {
        case "stockselect":
            mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(gparams);
            
            break;
        case "outableRecord":
            gparams.guestId=null;
            mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(gparams);
            break;
        case "pchsRecord":
            gparams.guestId=null;
            mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(gparams);
            break;
        case "sellRecord":
            gparams.guestId=null;
            mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(gparams);
            break;
        case "guestPrice":
            mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(gparams);
            break;
        case "rtnRecord":
            mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(gparams);
            break;
        case "partInfo":
            mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(gparams);
            break;
        case "chainStock":
            mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(gparams);
            break;
        default:
            break;
    }
}
function showTabInfo(){
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
    var url = tab.url;
    var params = {};
    if(!gparams.partId) gparams.partId=0;
    //if(!gparams.guestId) gparams.guestId=0;
    //if(!gparams.storeId) gparams.storeId=0;
	switch (name)
    {
        case "stockselect":
            /*if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                document.getElementById("bottomFormIframeStock").contentWindow.doSearch(gparams);
            }*/
            gparams.guestId=null;
            stockselectTab =  mainTabs.getTab("stockselect");
            if(!url){
                //mainTabs.updateTab(stockselectTab, {url: webPath + contextPath + "/common/embedJsp/containBottomStock.jsp"});
                //mainTabs.reloadTab(stockselectTab);
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomStock.jsp?token="+token, stockselectTab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(gparams);
            }            
            
            break;
        case "outableRecord":
            /*if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
            	params.partId=gparams.partId;
                document.getElementById("bottomFormIframeOutableRecord").contentWindow.doSearch(params);
            }*/
            gparams.guestId=null;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomOutableRecord.jsp?token="+token, outableRecordTab);
            }else{
                mainTabs.getTabIFrameEl(outableRecordTab).contentWindow.doSearch(gparams);
            }
            
        	break;
        case "pchsRecord":
            /*if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
            	params.partId=gparams.partId;
                document.getElementById("bottomFormIframePchsRecord").contentWindow.doSearch(params);
            }*/
            gparams.guestId=null;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomPchsRecord.jsp?token="+token, pchsRecordTab);
            }else{
                mainTabs.getTabIFrameEl(pchsRecordTab).contentWindow.doSearch(gparams);  
            }
            
            break;
        case "sellRecord":
            /*if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                params.partId=gparams.partId;
                document.getElementById("bottomFormIframeSellRecord").contentWindow.doSearch(params);
            }*/
            gparams.guestId=null;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomSellRecord.jsp?token="+token, sellRecordTab);
            }else{
                mainTabs.getTabIFrameEl(sellRecordTab).contentWindow.doSearch(gparams);
            }
            
            break;
        case "guestPrice":
            /*if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                params.partId=gparams.partId;
                params.guestId=gparams.guestId;
                document.getElementById("bottomFormIframeSellRecord").contentWindow.doSearch(params);
            }*/
            if(!url){
                mainTabs.updateTab(guestPriceTab, {url: null});
                mainTabs.reloadTab(guestPriceTab);
            }
            //mainTabs.getTabIFrameEl(guestPriceTab).contentWindow.doSearch(gparams);
            break;
        case "rtnRecord":
            /*if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                params.partId=gparams.partId;
                document.getElementById("bottomFormIframeRtnRecord").contentWindow.doSearch(params);
            }*/
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomPchsRtnRecord.jsp?token="+token, rtnRecordTab);
            }else{
                mainTabs.getTabIFrameEl(rtnRecordTab).contentWindow.doSearch(gparams); 
            }
            
            break;
        case "partInfo":
            /*if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                params.partId=gparams.partId;
                document.getElementById("bottomFormIframePartInfo").contentWindow.doSearch(params);
            }*/
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomPartInfo.jsp?token="+token, partInfoTab);
            }else{
                mainTabs.getTabIFrameEl(partInfoTab).contentWindow.doSearch(gparams);
            }
            break;
        case "chainStock":
            /*if(document.getElementById("bottomFormIframeStock").contentWindow.doSearch){
                params.partId=gparams.partId;
                document.getElementById("bottomFormIframePartInfo").contentWindow.doSearch(params);
            }*/
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomChainStock.jsp?token="+token, chainStockTab);
            }else{
                mainTabs.getTabIFrameEl(chainStockTab).contentWindow.doSearch(gparams);
            }
            break;
        default:
            break;
    }
}