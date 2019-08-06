
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.dispatchQyeryMaintainList.biz.ext";
var mainGrid = null;
var mtAdvisorIdEl = null;
var rightGrid = null;
var workList=[];
var advancedStopWin = null;
var stop_uid = null;
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
var billTypeIdList = [{name:"综合开单"},{name:"检查开单"},{name:"洗美开单"},{name:"销售开单"},{name:"理赔开单"},{name:"退货开单"},{name:"波箱开单"}];
$(document).ready(function() {
	//是否显示预结算
	mainGrid = nui.get("mainGrid");
	rightGrid = nui.get("rightGrid");
	mtAdvisorIdEl = nui.get("mtAdvisorId");
	advancedStopWin = nui.get("advancedStopWin");
	mainGrid.setUrl(mainGridUrl);
	initTearm();
	rightGrid.on("drawcell",function(e) {
		var record = e.record;
		var status = record.status;
		var uid = record._uid;
		if (e.field == "status") {
			if(status == 2) {
				e.cellHtml = record.stopReason;
        	}else {
            	e.cellHtml = statusHash[e.value];
            }
		}else if (e.field == "boxBrandId") {
			if (brandHash && brandHash[e.value]) {
				e.cellHtml = brandHash[e.value].name;
			}
		}else if(e.field == "itemOptBtn"){
        	var s = "";
        	if(status == 0){
                s =  ' <a class="optbtn" href="javascript:againWork(\'' + uid + '\')">重新派工</a>';
                s =  s + ' <a class="optbtn" href="javascript:startWork(\'' + uid + '\')">开始</a>';
                s =  s + ' <a class="optbtn" href="javascript:lookWork(\'' + uid + '\')">查看</a>';
            }else if(status == 1){
            	var stid = "stopWork" + record.id;
            	s =  ' <a class="optbtn" id="' + stid + '" '+'href="javascript:selectStopReason(\'' + uid + '\')">中断</a>';
            	/*s =  ' <a class="optbtn" id="stopWork" href="javascript:stopWork(\'' + uid + '\')">中断</a>';*/
                s =  s + ' <a class="optbtn" href="javascript:finishWork(\'' + uid + '\')">完成</a>';
                s =  s + ' <a class="optbtn" href="javascript:lookWork(\'' + uid + '\')">查看</a>';
            } else if(status == 2){
            	s =  ' <a class="optbtn" href="javascript:startWork(\'' + uid + '\')">开始</a>';
                s =  s + ' <a class="optbtn" href="javascript:lookWork(\'' + uid + '\')">查看</a>';
            }else if(status == 3){
            	 s =  s + ' <a class="optbtn" href="javascript:lookWork(\'' + uid + '\')">查看</a>';
            }
            e.cellHtml = s;
        }else if(e.field == "workTime"){
        	var s = "";
        	var workTime = record.workTime;
            if(workTime>0){
	        	var days = Math.floor(workTime / (24 * 3600)); // 计算出天数
	        	if(days>0){
	        		s = days + '天';
	        	}
	            var leavel = workTime % (24 * 3600); // 计算天数后剩余的时间
	            var hours = Math.floor(leavel / 3600); // 计算剩余的小时数
	            if(hours>0){
	            	s = s + hours + '小时';
	            }
	            var leavel2 = leavel % 3600; // 计算剩余小时后剩余的毫秒数
	            var minutes = Math.floor(leavel2 / 60); // 计算剩余的分钟数
	            if(minutes>0){
	            	s = s + minutes + '分';
	            }
	            e.cellHtml = s;
           }
        }else if(e.field == "stopTime"){
        	var s = "";
        	var stopTime = record.stopTime;
            if(stopTime>0){
	        	var days = Math.floor(stopTime / (24 * 3600)); // 计算出天数
	        	if(days>0){
	        		s = days + '天';
	        	}
	            var leavel = stopTime % (24 * 3600); // 计算天数后剩余的时间
	            var hours = Math.floor(leavel / 3600); // 计算剩余的小时数
	            if(hours>0){
	            	s = s + hours + '小时';
	            }
	            var leavel2 = leavel % 3600; // 计算剩余小时后剩余的毫秒数
	            var minutes = Math.floor(leavel2 / 60); // 计算剩余的分钟数
	            if(minutes>0){
	            	s = s + minutes + '分';
	            }
	            e.cellHtml = s;
           }
        }
	});
	mainGrid.on("drawcell",function(e) {
		var record = e.record;
		if (e.field == "billTypeId") {
        	e.cellHtml = billTypeIdList[e.value].name; 
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

function againWork(row_uid){
	var row = rightGrid.getRowByUID(row_uid);
	var mainRow = mainGrid.getSelected();
	var workers = row.workers;
	var itemList = {};
	itemList.id = row.id;
    var data = {};
    data = {
    	serviceId:mainRow.id,
    	workers:row.workers,
    	workersId:row.workerIds,
    	type:"item",
    	itemList:itemList,
    	dispatch:1
    };
     nui.open({
        url: webPath + contextPath + "/com.hsweb.repair.DataBase.Workers.flow?token="+token,
        title: '选择施工员',
        width: 600, height: 550,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action){
        	if(action=="ok"){
        		selectionChanged();
        	}
        }
    });
}

function startWork(row_uid){
	var row = rightGrid.getRowByUID(row_uid);
	var second = 0;
	if(row.status==0){
		second = 1;
	}else{
		second = 2;
	}
    if(row){
    	nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '保存中...'
        });
    	nui.ajax({
            url:baseUrl +"com.hsapi.repair.repairService.sureMt.updateItemDispatch.biz.ext",
            type:"post",
            async:false,
            data:JSON.stringify({
            	rpsItem:row,
            	status:1,
            	remark:"作业中",
            	second:second,
            	token: token
            }),
            success:function(data)
            {
            	if(data.errCode == "S"){
            		showMsg("开始成功","S");
            		selectionChanged();
            	}else{
            		showMsg("开始失败","E")
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

function selectStopReason(row_uid){
	var row = rightGrid.getRowByUID(row_uid);
	stop_uid = row_uid;
	if(advancedStopWin.visible){
    	FItemRow = {};
    	advancedStopWin.hide();
    	return;
    } 
	 var stid = "stopWork" + row.id;
	 var atEl = document.getElementById(stid);
    advancedStopWin.showAtEl(atEl, {xAlign:"outleft",yAlign:"middle"});
}

function stopWork(e){
	var row = rightGrid.getRowByUID(stop_uid);
    if(row){
    	nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '保存中...'
        });
    	var remak = "";
    	if(e==1){
    		remak = "等待客户答复";
    	}else if(e==2){
    		remak = "等待保险公司定损";
    	}else if(e==3){
    		remak = "等待配件";
    	}else if(e==4){
    		remak = "等待施工";
    	}else if(e==5){
    		remak = "等待洗车";
    	}
    	nui.ajax({
            url:baseUrl +"com.hsapi.repair.repairService.sureMt.updateItemDispatch.biz.ext",
            type:"post",
            async:false,
            data:JSON.stringify({
            	rpsItem:row,
            	status:2,
            	remark:remak,
            	token: token
            }),
            success:function(data)
            {
            	if(data.errCode == "S"){
            		showMsg("中断成功","S");
            		selectionChanged();
            	}else{
            		showMsg("中断失败","E")
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

function finishWork(row_uid){
	var row = rightGrid.getRowByUID(row_uid);
    if(row){
    	nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '保存中...'
        });
    	nui.ajax({
            url:baseUrl +"com.hsapi.repair.repairService.sureMt.updateItemDispatch.biz.ext",
            type:"post",
            async:false,
            data:JSON.stringify({
            	rpsItem:row,
            	status:3,
            	remark:"已完工",
            	token: token
            }),
            success:function(data)
            {
            	if(data.errCode == "S"){
            		showMsg("完成成功","S");
            		selectionChanged();
            	}else{
            		showMsg("完成失败","E")
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

document.onmousemove = function(e){
    if(advancedStopWin.visible){
        var mx = e.pageX;
        var my = e.pageY;
        var loc = "当前位置 x:"+e.pageX+",y:"+e.pageY
        var x = advancedStopWin.x;
        var y = advancedStopWin.y;
        if(x - mx > 20 || mx - x > 240){
        	advancedStopWin.hide();
            FItemRow = {};
            return;
        }
        if(y - my > 10 || my - y > 130){
        	advancedStopWin.hide();
            FItemRow = {};
            return;
        }
    }
}


function lookWork(row_uid){
	var row = rightGrid.getRowByUID(row_uid);
	var mainRow = mainGrid.getSelected();
    var  data = {
    	serviceId:mainRow.id,
    	itemId:row.id
    };
     nui.open({
        url: webPath + contextPath + "/repair/RepairBusiness/Reception/workDispatch/lookDispatch.jsp?token="+token,
        title: '查看调度',
        width: 500, height: 450,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(data);
        },
        ondestroy: function (action){
        	/*if(action=="ok"){
        		selectionChanged();
        	}*/
        }
    });
}
