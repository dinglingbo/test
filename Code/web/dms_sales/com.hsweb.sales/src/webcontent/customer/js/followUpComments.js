var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
//var queryUrl = apiPath + saleApi + "/sales.custormer.queryGuestList.biz.ext";
var queryUrl = apiPath + saleApi +"/sales.custormer.queryGuestCome.biz.ext";
var saveBathUrl = apiPath + saleApi + "/sales.custormer.saveGuestComeBath.biz.ext";
var queryScoutUrl = apiPath + saleApi + "/sales.custormer.queryScoutList.biz.ext";
var mainGrid = null;
var datagrid = null;
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
	datagrid = nui.get("datagrid");
	mainGrid.setUrl(queryUrl);
	 //车身颜色
	 initDicts({
		 frameColorId:"DDT20130726000003",
		 interialColorId:"10391",
		 comeTypeId:'DDT20130731000003',
		 specialCare:"DDT20130703000049",
		 intentLevel:"DDT20130703000050",
		 source:GUEST_SOURCE,
		 scoutModeId :"DDT20130703000021",//跟进方式
	     status:"DDT20130703000081",//跟进状态,scout_status
		 source:GUEST_SOURCE,
		 isUsabled:"DDT20130703000022" 
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
	
	
	mainGrid.on("select",function(e){
    	var row = e.record;
    	if(row.id){
    		var json = nui.encode({
   			 comeId:row.id,
   			 token:token
   		    });
    		nui.mask({
    	        el: document.body,
    	        cls: 'mini-mask-loading',
    	        html: '加载中...'
    	    });
    		nui.ajax({
    			url : queryScoutUrl,
    			type : 'POST',
    			data : json,
    			cache : false,
    			contentType : 'text/json',
    			success : function(text) {
    				datagrid.setData(text.list);
    				nui.unmask(document.body);
    			}
    		 });
    	}
    });
	
	datagrid.on('drawcell', function (e) {
	       var value = e.value;
	       var field = e.field;
	       var record = e.record;
	       var uid = record._uid;
	       if (field == 'scoutModeId') {
	           e.cellHtml = setColVal('scoutModeId', 'id', 'name', e.value);
	       } else if (field == 'status') {
	           e.cellHtml = setColVal('status', 'id', 'name', e.value);
	       } else if (field == 'source') {
	       	e.cellHtml = setColVal('source', 'id', 'name', e.value);
	       } else if (field == 'isUsabled') {
	    	   e.cellHtml = setColVal('isUsabled', 'id', 'name', e.value);
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
    gsparams.statusList = 1;
    if(status==0){//待今日跟进
		gsparams.nextScoutDateStart = nui.formatDate(new Date(), 'yyyy-MM-dd');
		gsparams.nextScoutDateEnd = addDate(gsparams.nextScoutDateStart,1);
		gsparams.nextScoutDateStart = gsparams.nextScoutDateStart + ' 00:00:00';
		gsparams.nextScoutDateEnd = gsparams.nextScoutDateEnd + ' 00:00:00';
    }else if(status==2){//超期未跟进
    	gsparams.nextScoutDate = nui.formatDate(new Date(), 'yyyy-MM-dd');
    	gsparams.nextScoutDate = gsparams.nextScoutDate + ' 00:00:00';
    }
    mainGrid.load({
        token:token,
        params: gsparams
    });
}
var status = 0;
function quickSearch(type) {
    var queryname = "待今日跟进";
    switch (type) {
        case 0:
    	   status = 0;  //报价
          queryname = "待今日跟进";
          break;
        case 1:
            status = 1;  //报价
            queryname = "今日归档";
            break;
        case 2:
            status = 2;  //施工
            queryname = "超期未跟进";
            //document.getElementById("advancedMore").style.display='block';
            break;
        default:
            break;
    }
    var menunamestatus = nui.get("menunamedate");
    menunamestatus.setText(queryname);
    doSearch();
}

function saveBath(){
   var saveList = mainGrid.getChanges("modified");
   for(var i = 0;i<saveList.length;i++){
	   if(saveList[i].nextVisitDate){
		   saveList[i].nextVisitDate = format(saveList[i].nextVisitDate, 'yyyy-MM-dd HH:mm:ss');
	   }
	   if(saveList[i].comeDate){
		   saveList[i].comeDate = format(saveList[i].comeDate, 'yyyy-MM-dd HH:mm:ss');
	   }
   }
   if(saveList.length>0){
	   var json = nui.encode({
           guestComeList:saveList,
		    token:token
	    });
		nui.mask({
		   el: document.body,
		   cls: 'mini-mask-loading',
		   html: '保存中...'
		});
		nui.ajax({
			url : saveBathUrl,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				if(text.errCode=="S"){
					doSearch();
					showMsg("保存成功!","S");
				}else{
					showMsg("保存失败!","E");
				}
				nui.unmask(document.body);
			}
		}); 
   } 
}

