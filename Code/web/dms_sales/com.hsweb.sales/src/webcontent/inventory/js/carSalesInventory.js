/**
 * Created by Administrator on 2018/2/1.
 */
var bearUrl = apiPath + saleApi + "/"; 
var DateList = [{id:"0",name:"上市日期"},{id:"1",name:"入库日期"}];
var statusList = [{id:"0",name:"联系人"},{id:"1",name:"联系电话"},{id:"2",name:"车架号（VIN）"}];
var rightGridUrl = bearUrl+"sales.inventory.queryCheckEnter.biz.ext";
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
$(document).ready(function(v){
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    searchBeginDate.setValue(getMonthStartDate());
    searchEndDate.setValue(getMonthEndDate());
    rightGrid.load();
});
function getSearchParam(){


}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    var querystatusname = "所有";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;
        //草稿
        case 12:
        	params.billStatusId=0;
        	params.auditSign=0;
        	querysign = 2;
        	querystatusname = "草稿";
        	break;
        //待发货
        case 13:
        	params.billStatusId=1;
        	params.auditSign=1;
        	querysign = 2;
        	querystatusname = "待发货";
        	break;
        //待收货
        case 14:
        	params.billStatusId=2;
        	params.auditSign=1;
        	querysign = 2;
        	querystatusname = "待收货";
        	break;
        //已入库
        case 15:
        	params.billStatusId=4;
        	params.auditSign=1;
        	querysign = 2;
        	querystatusname = "已入库";
        	break;
        default:
        	querysign = 2;
        	querystatusname = "所有";
        	params.auditSign=-1;
            break;
    }
    
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(addDate(params.endDate,-1));
    nui.get('auditSign').setValue(params.auditSign);
    nui.get('billStatusId').setValue(params.billStatusId);
    currType = type;
    if(querysign == 1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 	
    }
    else if(querysign == 2){
    	var menubillstatus = nui.get("menubillstatus");
		menubillstatus.setText(querystatusname);
    }
    doSearch(params);
}
function onSearch(){

}
function doSearch(params){

}

var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1,
                guestType:'01020202'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
            }
        }
    });
}


function detection() {
	var row = rightGrid.getSelected();
	if(!row){		
		showMsg("请选择单据","W");
	}
	nui.open({
		url : webPath + contextPath
				+ "/sales/inventory/PDIdetection.jsp?token="
				+ token,
		title : "PDI检测",
		width : 800,
		height : 400,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(row);
		},
		ondestroy : function(action) {

		}
	});
}

function upload() {

	nui.open({
		url : webPath + contextPath
				+ "/com.hsweb.part.manage.carUpload.flow?token="
				+ token,
		title : "图片上传",
		width : 800,
		height : 400,
		allowDrag : true,
		allowResize : true,
		onload : function() {

		},
		ondestroy : function(action) {

		}
	});
}

var saveUrl = baseUrl
+ "sales.inventory.saveCarLock.biz.ext";
function edit() {
	var row = rightGrid.getSelected();
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			cssCheckEnter: row
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("操作成功!","S");
				
			} else {
				showMsg(data.errMsg || "操作异常!","W");
			}
		},
		ondestroy: function() {
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

function costAdjust(){
	var row = rightGrid.getSelected();
	if(!row){
		showMsg("请选择一条单据","W");
	}
	nui.open({
		url : webPath + contextPath
				+ "/sales/inventory/costAdjust.jsp?token="
				+ token,
		title : "成本调整",
		width : 300,
		height : 250,
		allowDrag : true,
		allowResize : true,
		onload : function() {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(row);
		},
		ondestroy : function(action) {

		}
	});
}
