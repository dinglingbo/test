/**
 * Created by Administrator on 2018/2/1.
 */
var bearUrl = apiPath + saleApi + "/"; 
/*var DateList = [{id:"0",name:"上市日期"},{id:"1",name:"入库日期"}];*/
var statusList = [{id:"0",name:"联系人"},{id:"1",name:"联系电话"},{id:"2",name:"车架号（VIN）"}];
var carStatusList = [{id:"0",name:"订货未到"},{id:"1",name:"订货已到"},{id:"2",name:"入库退货"},{id:"3",name:"销售中"},{id:"4",name:"已销售"}];
var inventory = [{id:"0",name:"否"},{id:"1",name:"是"}];
var rightGridUrl = apiPath + frmApi+"/com.hsapi.frm.frmService.rpsettle.queryPayCarByGuestId.biz.ext";
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comSearchGuestId = null;
var enterTypeIdHash = {};
var enterTypeIdList = [];
$(document).ready(function(v){
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    comSearchGuestId = nui.get("searchGuestId");
    searchBeginDate.setValue(getMonthStartDate());
    searchEndDate.setValue(getMonthEndDate());
    
	getItemType(function(data) {
		enterTypeIdList = data.list || [];
		enterTypeIdList.filter(function(v) {
			enterTypeIdHash[v.id] = v;
		});
	});

	
    rightGrid.on("drawcell", function (e) {      
        switch (e.field) {
            case "carLock":
            	 e.cellHtml = inventory[e.value].name;
                break;
        	case "billTypeId":
        		if (enterTypeIdHash && enterTypeIdHash[e.value]) {
        			e.cellHtml = enterTypeIdHash[e.value].name;
        		}
        		break;
        	case "nowAmt":
        		e.cellStyle = 'background-color:#90EE90';
        		break;
            case "carStatus":
            	e.cellHtml = carStatusList[e.value].name;
               break;               
            default:
                break;
        }
    });
    quickSearch(currType);
});

var queryUrl =  apiPath + frmApi 
+ "/com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
function getItemType(callback) {
nui.ajax({
url : queryUrl,
data : {
	token : token
},
type : "post",
success : function(data) {
	if (data && data.list) {
		callback && callback(data);
	}
},
error : function(jqXHR, textStatus, errorThrown) {
	console.log(jqXHR.responseText);
}
});
}
function getSearchParam(){
    var params = {};
    params.guestName = nui.get("guestName").getValue();
	params.endDate = addDate(searchEndDate.getValue(),1);
	params.startDate = searchBeginDate.getFormValue();
	//params.billStatus = 1;
    return params;
}
var currType = 4;
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
        	params.carStatus=1;
        	querysign = 2;
        	querystatusname = "订货已到";
        	break;
        //待发货
        case 13:
        	params.carStatus=2;
        	querysign = 2;
        	querystatusname = "已退货";
        	break;
        //待收货
        case 14:
        	params.carStatus=3;
        	querysign = 2;
        	querystatusname = "销售中";
        	break;
        //已入库
        case 15:
        	params.carStatus=4;
        	querysign = 2;
        	querystatusname = "已销售";
        	break;
        default:
        	querysign = 2;
        	querystatusname = "所有";
        	params.auditSign=-1;
            break;
    }
    
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(addDate(params.endDate,-1));
    if(querysign==1){
    	var menunamedate = nui.get("menunamedate");
    	menunamedate.setText(queryname); 
    }else{
    	var menubillstatus = nui.get("menubillstatus");
    	menubillstatus.setText(querystatusname); 
    }

    currType = type;
    doSearch(params);
}
function onSearch(){
	var params = getSearchParam();
    doSearch(params);
}
function doSearch(params)
{
	params.isSettle=1;
	params.balaAmt=0;
    rightGrid.load({
        params:params,
        token:token
    },function(){
        rightGrid.mergeColumns(["serviceId"]);
    });
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
                isSupplier: 1
/*                guestType:'01020202'*/
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
		height : 500,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(row);
		},
		ondestroy : function(action) {
			quickSearch(4);
		}
	});
}


//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
	var editor = e.editor;
	var record = e.record;

	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!", "W");
		e.cancel = false;
	}
}


function onRGridbeforeselect(e) {
	var row = e.row;
		var row = e.row;
		var billDc = row.billDc;
		var newRow = {
			nowAmt : row.balaAmt
		};
		if (row.nowAmt) {
			newRow.nowAmt = row.balaAmt;
		} else {
			newRow.nowAmt = row.balaAmt;
		}
		rightGrid.updateRow(row, newRow);
}
function doSettle() {
	var rows = rightGrid.getSelecteds();
	var s = rows.length;
	if (s > 0) {
			nui.open({
		        url: webPath + contextPath +"/com.hsweb.frm.manage.preRefund.flow?token="+token,
		         width: "100%", height: "100%", 
		        onload: function () {
		            var iframe = this.getIFrameEl();
		            iframe.contentWindow.setData(rows);
		        },
				ondestroy : function(action) {// 弹出页面关闭前
					if (action == "ok") {
						showMsg("结算成功!", "S");
						rightGrid.reload();
					}
				}
		    });
	} else {
		showMsg("请选择单据!", "W");
		return;
	}
}