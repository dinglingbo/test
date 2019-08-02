
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.dispatchQyeryMaintainList.biz.ext";
var mainGrid = null;
var mtAdvisorIdEl = null;
var rightGrid = null;
var workList=[];
var prdtTypeHash = {
	"1" : "套餐",
	"2" : "项目",
	"3" : "配件"
};
var statusHash = {
	"0" : "等待施工",
	"1" : "作业中",
	"2" : "中断",
	"3" : "已完工"	
}
$(document).ready(function() {
	//是否显示预结算
	mainGrid = nui.get("mainGrid");
	rightGrid = nui.get("rightGrid");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	mainGrid.setUrl(mainGridUrl);
	initTearm();
	rightGrid.on("drawcell",function(e) {
		var record = e.record;
		if (e.field == "status") {
			var status = record.status;
			if(status == 2) {
				e.cellHtml = record.stopReason;
        	}else {
            	e.cellHtml = statusHash[e.value];
            }
		} else if (e.field == "boxBrandId") {
			if (brandHash && brandHash[e.value]) {
				e.cellHtml = brandHash[e.value].name;
			}
		} 
	});
   /* mainGrid.on("selectionchanged",function(){
    	SelectionChanged();
	});*/
	
	/*getMtadvisor(function(text){
    	mtAdvisorIdEl.setData(text.data);
    });
	mainGrid.on("rowdblclick", function(e) {
		edit();
	});

	document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;
		if ((keyCode == 27)) { // ESC
			advancedSearchWin.hide();
		}
		;
	};
	mainGrid.on("rowclick", function(e) {
		var record = e.record;
	    if(record.status>1){
	    	nui.get("deletBtn").setVisible(false); 
	    }else{
	    	nui.get("deletBtn").setVisible(true); 
	    }
		 
	});*/
	doSearch();

});

function doSearch() {
	var gsparams ={};
	gsparams.mtAuditorId = nui.get("mtAdvisorId").getValue();
    var carNo = nui.get("carNo-search").getValue();
    gsparams.carNo = carNo;
    gsparams.memberGroupId = nui.get("memberGroupId").getValue();
	gsparams.isDisabled = 0;
	gsparams.balaAuditSign = 0;
	mainGrid.load({
		token : token,
		params : gsparams
	});
}

function initTearm(){
   nui.ajax({
        url:baseUrl +"com.hsapi.repair.baseData.team.queryWorkTeam.biz.ext",
        type:"post",
        async:false,
        data:JSON.stringify({
        	token: token
        }),
        success:function(data)
        {
        	
        	var TearmObj=data.list;
        	var work=nui.get('memberGroupId');
        	for(var i=0;i<TearmObj.length;i++){
        		var data ={
        				id:TearmObj[i].id,
        				name:TearmObj[i].name
        		}
        		workList.push(data);
        		work.setData(workList);
        	}
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
        }
    });	
}

function selectionChanged() {
    var row = mainGrid.getSelected();
    if(row){
    	nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '加载中...'
        });
    	nui.ajax({
            url:baseUrl +"com.hsapi.repair.baseData.query.queryAllRpsItemByServiceId.biz.ext",
            type:"post",
            async:false,
            data:JSON.stringify({
            	serviceId:row.id,
            	token: token
            }),
            success:function(data)
            {
            	var itemList = data.rpsItem;
            	if(itemList.length>0){
            		rightGrid.setData(itemList);
            	}else{
            		rightGrid.setData([]);
            	}
            	nui.unmask(document.body);
            },
            error:function(jqXHR, textStatus, errorThrown){
            	nui.unmask(document.body);
                console.log(jqXHR.responseText);
            }
        });
    }
}
