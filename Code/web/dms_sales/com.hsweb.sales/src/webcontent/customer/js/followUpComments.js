var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
//var queryUrl = apiPath + saleApi + "/sales.custormer.queryGuestList.biz.ext";
var queryUrl = apiPath + saleApi +"/sales.custormer.queryGuestCome.biz.ext";
var saveBath = apiPath + saleApi + "/sales.custormer.saveGuestComeBath.biz.ext";
var mainGrid = null;
var statusHash = {
		"0":"草稿",
	    "1":"归档",
	    "2":"转销售",
	    "3":"作废"
}
$(document).ready(function ()
{
	/*levelOfIntent = nui.get("levelOfIntent");
	specialCareId = nui.get("specialCareId");
	intentLevelId = nui.get("intentLevelId");
	saleAdvisorIdEl = nui.get("saleAdvisorId");
	guestComeForm = new nui.Form("#guestComeForm");*/
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);
	 //车身颜色
	 initDicts({
		 frameColorId:"DDT20130726000003",
		 interialColorId:"10391",
		 comeTypeId:'DDT20130731000003',
		 specialCare:"DDT20130703000049",
		 intentLevel:"DDT20130703000050",
		 source:GUEST_SOURCE
     },function(data){
     });
	
	initMember("saleAdvisorId",function(){
		nui.get("saleAdvisorId").setValue(currEmpId);
	    //nui.get("saleAdvisor").setValue(currUserName);
    });
	
	mainGrid.on('drawcell', function(e){
	       var value = e.value;
	       var field = e.field;
	      if (field == 'sex') {
	           e.cellHtml = (value == 0 ? '女' : '男');
	       } else if (field == 'comeTypeId') {
	           e.cellHtml = setColVal('comeTypeId', 'id', 'name', e.value);
	       } else if (field == 'frameColorId') {
	           e.cellHtml = setColVal('frameColorId', 'id', 'name', e.value);
	       } else if (field == 'interialColorId') {
	       	   e.cellHtml = setColVal('interialColorId', 'id', 'name', e.value);
	       } else if (field == 'status') {
	           e.cellHtml =statusHash[e.value];
	       }else if (field == 'source') {
	          	e.cellHtml = setColVal('source', 'id', 'name', e.value);
	       }else if(e.field == "orgid"){
	        	for(var i=0;i<currOrgList.length;i++){
	        		if(currOrgList[i].orgid==e.value){
	        			e.cellHtml = currOrgList[i].shortName;
	        		}
	        	}
	     }
	});
	
	doSearch();
});

function getSearchParam() {
    var params = {};
    var saleAdvisorId = nui.get("saleAdvisorId").getValue();
    params.saleAdvisorId = saleAdvisorId;
   /* var fullName = nui.get("name-search").getValue();
    params.fullName = fullName;
    var mobile = nui.get("mobile-search").getValue();
    params.mobile = mobile;*/
    //scoutStatus,跟踪状态
    return params;
}

function doSearch() {
    var gsparams = getSearchParam();
    mainGrid.load({
        token:token,
        params: gsparams
    });
}



