var baseUrl = apiPath + sysApi + "/";
var mainTabs = null;

$(document).ready(function() {
    mainTabs = nui.get("mainTabs");

    mainTabs.on("activechanged",function(e){
        showTabInfo();
    });

});

function showTabInfo(){
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
    var url = tab.url;
    
	switch (name)
    {
        case "comParamsTab":  
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/config/comParamsSet.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }     
            break;
        case "businessTypeTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/cfg/businessType.jsp?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }
            break;
        case "guestTypeTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/cfg/guestTypeMgr_view0.jsp?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }
            break;
        case "guestSourceTab": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/cfg/guestSource.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "visitTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/cfg/visitSet.jsp?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();  
            }
            
            break;
        case "carSetTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/common/embedJsp/containSellOrderRecord.jsp?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }
            
        	break;
        case "carCheckModelTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/cfg/checkModelMgr.jsp?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }
            
            break;
        case "stockTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/config/stockParamsSet.jsp?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }
            
            break;
        case "basicDeductTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/config/basicDeductParamsSet.jsp?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }
            
            break;
        case "remindTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/cfg/remindParams.jsp?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }
            
            break;
        default:
            break;
    }
}