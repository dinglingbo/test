var baseUrl = window._rootSysUrl || "http://127.0.0.1:8080/default/";
var queryUrl = apiPath + saleApi +"/sales.custormer.queryGuestCome.biz.ext";
var saveScout = apiPath + saleApi + "/sales.custormer.saveGuestScout.biz.ext";
var queryScoutUrl = apiPath + saleApi + "/sales.custormer.queryScoutList.biz.ext";
var mainGrid = null;
var form = null;
var datagrid = null;
var statusHash = {
	"0":"草稿",
    "1":"归档",
    "2":"转销售",
    "3":"作废"
}
$(document).ready(function ()
{
	mainGrid = nui.get("rightGrid");
	mainGrid.setUrl(queryUrl);
	form = new nui.Form("#form");
	datagrid = nui.get("datagrid");
    initDicts({
      relationship:"DDT20140305000001",//关系阶段
      scoutModeId :"DDT20130703000021",//跟进方式
      status:"DDT20130703000081",//跟进状态,scout_status
	  source:GUEST_SOURCE,
	  frameColorId:"DDT20130726000003",
	  interialColorId:"10391",
	  isUsabled:"DDT20130703000022",
	  failReasonId:"DDT20130703000043"
	  },function(data){
   });
    initMember("saleAdvisorId",function(){
    });
	mainGrid.on('drawcell', function (e) {
       var value = e.value;
       var field = e.field;
       var record = e.record;
       var uid = record._uid;
      if (field == 'sex') {
           e.cellHtml = (value == 0 ? '女' : '男');
       } else if (field == 'relationship') {
           e.cellHtml = setColVal('relationship', 'id', 'name', e.value);
       } else if (field == 'scoutStatus') {
           e.cellHtml = setColVal('status', 'id', 'name', e.value);
       } else if (field == 'source') {
       	e.cellHtml = setColVal('source', 'id', 'name', e.value);
       } else if (field == 'frameColorId') {
    	   e.cellHtml = setColVal('frameColorId', 'id', 'name', e.value);
       } else if(e.field == "interialColorId"){
    	   e.cellHtml = setColVal('interialColorId', 'id', 'name', e.value);
       }else if(e.field == "isUsabled"){
    	   e.cellHtml = setColVal('isUsabled', 'id', 'name', e.value);
       }else if(e.field == "addOptBtn"){
    	   e.cellHtml = '<a href="javascript:addScout()" class="optbtn" >跟踪登记</a>'; 
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
    				nui.get("scoutRemark").setValue(row.scoutRemark);
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
	mainGrid.on("rowdblclick",function(e){
		edit();
	});
	doSearch();
	var data = []
	form.setData(data);
	nui.get("saleAdvisorId").setValue(currEmpId);
    nui.get("scoutDate").setValue(now);
    nui.get("recorder").setValue(currUserName);
});

function getSearchParam() {
    var params = {};
    var saleAdvisorId = nui.get("saleAdvisorId").getValue();
    params.saleAdvisorId = saleAdvisorId;
    var fullName = nui.get("fullName-search").getValue();
    params.fullName = fullName;
    var mobile = nui.get("mobile-search").getValue();
    params.mobile = mobile;
    var status = nui.get("qscoutstatus").getValue();
    if(status==0){//待今日跟进
    	params.nextScoutDateStart = nui.formatDate(new Date(), 'yyyy-MM-dd');
    	params.nextScoutDateEnd = addDate(params.nextScoutDateStart,1);
    	params.nextScoutDateStart = params.nextScoutDateStart + ' 00:00:00';
    	params.nextScoutDateEnd = params.nextScoutDateEnd + ' 00:00:00';
    }else if(status==1){//超期未跟进
    	params.nextScoutDate = nui.formatDate(new Date(), 'yyyy-MM-dd');
    	params.nextScoutDate = params.nextScoutDate + ' 00:00:00';
    }else if(status==2){//所有需要跟进(有疑问)
    	//params.nextScoutDate = 
    }else if(status==2){//重点跟进
    	params.scoutStatus = "DIT20130705000164";
    }
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

function save(){
	var row = mainGrid.getSelected();
	if(row){
		var comeId = row.id;
		var data = form.getData();
		var contactor = {};
		var guestScout = data;
		var saleAdvisor = nui.get("saleAdvisorId").text;
		guestScout.saleAdvisor = saleAdvisor;
		contactor.id = row.contactorId;
		contactor.relationship = data.relationship;
		if(guestScout.scoutDate) {
			guestScout.scoutDate = format(guestScout.scoutDate, 'yyyy-MM-dd HH:mm:ss');
		}
	    if(guestScout.nextOrderDate) {
	    	guestScout.nextOrderDate = format(guestScout.nextOrderDate, 'yyyy-MM-dd HH:mm:ss');
		}
		var json = nui.encode({
			 contactor:contactor,
			 guestScout:guestScout,
			 comeId:comeId,
			 token:token
		  });
		nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '保存中...'
	    });
		nui.ajax({
			url : saveScout,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				if(text.errCode=="S"){
					doSearch();
			    	showMsg("保存成功","S");
			    }else{
			    	showMsg("保存失败","E");
			    }
				nui.unmask(document.body);
			}
		 });
	}else{
		showMsg("请选择一条记录！","W");
		return;
	}
}

function addScout(){
	var row = mainGrid.getSelected();
	var data = []
	form.setData(data);
	nui.get("saleAdvisorId").setValue(currEmpId);
    nui.get("scoutDate").setValue(now);
    nui.get("recorder").setValue(currUserName);
    nui.get("scoutRemark").setValue(row.scoutRemark);
}
