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
        case "buyCarUser":  
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/com.hsweb.repair.potentialCustomer.userOfCar.flow?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }     
            break;
        case "infoSourceTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/com.hsweb.repair.potentialCustomer.informationSource.flow?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }
            break;
        case "purposeTypeTab":
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/com.hsweb.repair.potentialCustomer.levelOfCustomer.flow?token="+token, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }
            break;
        case "visitorsTab": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/com.hsweb.repair.potentialCustomer.visitMode.flow?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "focusTab": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/com.hsweb.repair.potentialCustomer.considerations.flow?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        default:
            break;
    }
}