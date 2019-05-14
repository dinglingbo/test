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
        case "carOutcolor": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_carOutcolor.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "carIncolor": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_carIncolor.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "carLevel": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_carLevel.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "carCountry": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_carCountry.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "structure": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_structure.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "useType": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_useType.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "sittingNum": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_sittingNum.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "displacement": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_displacement.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "intakeType": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_intakeType.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "driveType": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_driveType.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }   
            break;
        case "changeSpeed": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_proType.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        case "proType": 
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/repair/potentialCustomer/set_proType.jsp?token="+token, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch();
            }  
            break;
        default:
            break;
    }
}