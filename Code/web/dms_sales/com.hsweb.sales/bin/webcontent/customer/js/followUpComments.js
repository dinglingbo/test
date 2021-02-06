var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
//var queryUrl = apiPath + saleApi + "/com.hsapi.sales.svr.custormer.queryGuestList.biz.ext";
var queryUrl = apiPath + saleApi +"/com.hsapi.sales.svr.custormer.queryGuestCome.biz.ext";
var saveBathUrl = apiPath + saleApi + "/com.hsapi.sales.svr.custormer.saveGuestComeBath.biz.ext";
var queryScoutUrl = apiPath + saleApi + "/com.hsapi.sales.svr.custormer.queryScoutList.biz.ext";
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
	       var record = e.record;
	      if (field == 'sex') {
	           e.cellHtml = (value == 0 ? '女' : '男');
	       } else if (field == 'comeTypeId') {
	           e.cellHtml = setColVal('comeTypeId', 'customid', 'name', e.value);
	       } else if (field == 'frameColorId') {
	           e.cellHtml = setColVal('frameColorId', 'customid', 'name', e.value);
	       } else if (field == 'interialColorId') {
	       	   e.cellHtml = setColVal('interialColorId', 'customid', 'name', e.value);
	       } else if (field == 'status') {
	           e.cellHtml =statusHash[e.value];
	       }else if (field == 'source') {
	          	e.cellHtml = setColVal('source', 'customid', 'name', e.value);
	       }else if(e.field == "orgid"){
	        	for(var i=0;i<currOrgList.length;i++){
	        		if(currOrgList[i].orgid==e.value){
	        			e.cellHtml = currOrgList[i].shortName;
	        		}
	        	}
	     }else if(e.field == "scoutRemark"){
	     
         	e.cellStyle = "background:rgb(54, 244, 226)";
         
	     }
	});
	
	//rgb(54, 209, 244)
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
	           e.cellHtml = setColVal('scoutModeId', 'customid', 'name', e.value);
	       } else if (field == 'status') {
	           e.cellHtml = setColVal('status', 'customid', 'name', e.value);
	       } else if (field == 'source') {
	       	e.cellHtml = setColVal('source', 'customid', 'name', e.value);
	       } else if (field == 'isUsabled') {
	    	   e.cellHtml = setColVal('isUsabled', 'customid', 'name', e.value);
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
    
    if(status==0){//待今日跟进
    	gsparams.statusList = 1;
		gsparams.nextScoutDateStart = nui.formatDate(new Date(), 'yyyy-MM-dd');
		gsparams.nextScoutDateEnd = addDate(gsparams.nextScoutDateStart,1);
		gsparams.nextScoutDateStart = gsparams.nextScoutDateStart + ' 00:00:00';
		gsparams.nextScoutDateEnd = gsparams.nextScoutDateEnd + ' 00:00:00';
    }else if(status==2){//超期未跟进
    	gsparams.statusList = 1;
    	gsparams.nextScoutDate = nui.formatDate(new Date(), 'yyyy-MM-dd');
    	gsparams.nextScoutDate = gsparams.nextScoutDate + ' 00:00:00';
    }else if(status==1){//今日归档，查询修改日期是今天的，并且status是等于1的
    	gsparams.modifyDateStart = nui.formatDate(new Date(), 'yyyy-MM-dd');
		gsparams.modifyDateEnd = addDate(gsparams.modifyDateEnd,1);
		gsparams.modifyDateStart = gsparams.modifyDateStart + ' 00:00:00';
		gsparams.modifyDateEnd = gsparams.modifyDateEnd + ' 00:00:00';
		gsparams.status = 1;
    }else if(status==3){//所有需跟进，查询不是终止跟进的记录
    	gsparams.statusList = 1;
    	gsparams.scoutStatus = "060702";
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
        case 3:
            status = 3;  //施工
            queryname = "所有需跟进";
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

function guestInfo(){
	var row = mainGrid.getSelected();
	if(row){
		nui.open({
			url : webPath + contextPath + "/sales/customer/addGuest.jsp?token=" + token,
			title : "编辑客户资料",
			width : 900,
			height : 460,
			allowDrag : true,
			allowResize : true,
			onload : function() {
				var iframe = this.getIFrameEl();
	            iframe.contentWindow.queryData(row.guestId);//显示该显示的功能
			},
			ondestroy : function(action) {
				doSearch();
			}
		});
	}else{
		showMsg("请选择一条记录!","W");
		return;
	}
	  
}

function giftInfo(){
	var row = mainGrid.getSelected();
	
	if(row){
		row.show = 1;
		if(row.id !="" && row.id !=null){
			nui.open({
				url: webPath + contextPath + '/sales/customer/guestComeGift.jsp',
				title: '精品加装',
				width: 1200,
				height: 500,
				onload: function () {
				var iframe = this.getIFrameEl();
				iframe.contentWindow.setData(row);
				},
				ondestroy: function (action) {
				var iframe = this.getIFrameEl();
				
			    }
			 });
		}else{
			showMsg("请先保存来访登记!","W");
			return;
		}
	}else{
		showMsg("请选择一条记录!","W");
		return;
	}
}

function buyCarCount(){
	var row = mainGrid.getSelected();
	if(row){
		row.show = 1;
		if(row.id !="" && row.id !=null){
			nui.open({
				url: webPath + contextPath + '/sales/sales/caCalculation.jsp',
				title: '购车预算',
				width: 1000,
				height: 600,
				onload: function () {
				   var iframe = this.getIFrameEl();
				   iframe.contentWindow.setShowSave(row);
				},
				ondestroy: function (action) {
				   var iframe = this.getIFrameEl();
			    }
			 });
		}else{
			showMsg("请先保存来访登记!","W");
			return;
		}
	}else{
		showMsg("请选择一条记录!","W");
		return;
	}
}

