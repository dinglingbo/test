/**
 * Created by Administrator on 2018/2/1.
 */
var bearUrl = apiPath + saleApi + "/"; 
/*var DateList = [{id:"0",name:"上市日期"},{id:"1",name:"入库日期"}];*/
var statusList = [{id:"0",name:"联系人"},{id:"1",name:"联系电话"},{id:"2",name:"车架号（VIN）"}];
var inventory = [{id:"0",name:"否"},{id:"1",name:"是"}];
var rightGridUrl = bearUrl+"sales.inventory.queryCheckEnter.biz.ext";
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comSearchGuestId = null;
var frameColorIdList = []//车身颜色
var interialColorIdList = []//内饰颜色
$(document).ready(function(v){
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    comSearchGuestId = nui.get("searchGuestId");
    searchBeginDate.setValue(getMonthStartDate());
    searchEndDate.setValue(getMonthEndDate());
	var dictDefs ={"frameColorId":"DDT20130726000003","interialColorId":"10391"};
	initDicts(dictDefs, function(){
		getStorehouse(function(data) {
			getAllPartBrand(function(data) {
		 	 	frameColorIdList = nui.get('frameColorId').getData();
 	 			interialColorIdList = nui.get('interialColorId').getData();
 	 			quickSearch(4);
			});
			
		});
	});
    rightGrid.on("drawcell", function (e) {      
        switch (e.field) {
            case "carLock":
            	 e.cellHtml = inventory[e.value].name;
                break;
            case "frameColorId":
            	e.cellHtml = setColVal('frameColorId', 'customid', 'name', e.value);
               break;
            case "interialColorId":
            	e.cellHtml = setColVal('interialColorId', 'customid', 'name', e.value);
               break;
            default:
                break;
        }
    });
});
function getSearchParam(){
    var params = {};
    params.carModelName = nui.get("carModelName").getValue();
	params.endDate = addDate(searchEndDate.getValue(),1);
	params.startDate = searchBeginDate.getFormValue();
	params.billStatus = 1;
    return params;
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
    currType = type;
    doSearch(params);
}
function onSearch(){
	var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{

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
			quickSearch(4);
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

var saveUrl = bearUrl
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
				quickSearch(4);
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
		showMsg("请选择一条库存","W");
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
			quickSearch(4);
		}
	});
}
