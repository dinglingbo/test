var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.queryMainPartList.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"车架号(VIN)"},{id:"2",name:"联系人名称"},{id:"3",name:"手机号"}];
var brandList = [];
var brandHash = {};
var servieTypeList = [];
var servieTypeHash = {};
var advancedMore = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var editFormDetail = null;
var innerPartGrid = null;
var mainTabs = null;
var settleWin = null;
var orgidsEl = null;

$(document).ready(function ()
{
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
    var date = new Date();
    var sdate = new Date();
    sdate.setMonth(date.getMonth()-3);
    endDateEl.setValue(date);
    beginDateEl.setValue(sdate);
    editFormDetail = document.getElementById("editFormDetail");
    innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getRpsPartUrl);
    
    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
    
    mainTabs = nui.get("mainTabs");
	settleAccountGrid = nui.get("settleAccountGrid");
	settleWin = nui.get("settleWin");
    mainGrid.on("drawcell", function (e) {
    	var record = e.record;
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if(e.field == "isSettle"){
            if(e.value == 1){
                e.cellHtml = "已结算";
            }else{
                e.cellHtml = "未结算";
            }
        }else if(e.field == "contactMobile"){
        	var value = e.value
        	value = "" + value;
        	var reg=/(\d{3})\d{4}(\d{4})/;
        	var value = value.replace(reg, "$1****$2");
        	//e.cellHtml = value;
        	if(e.value){
        		if(record.openId>0){
            		e.cellHtml = "<span id='wechatTag' class='fa fa-wechat fa-lg'></span>"+value;
            	}else{
            		e.cellHtml = "<span  id='wechatTag1' class='fa fa-wechat fa-lg'></span>"+value;
            	}
        	}else{
        		e.cellHtml="";
        	}
        }else if(e.field == "orgid"){
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
        	
        }
    });

    innerPartGrid.on("drawcell", function (e) {
        var record = e.record;
        switch (e.field) {
            case "partName":
                var cardDetailId = record.cardDetailId||0;
                if(cardDetailId>0){
                    e.cellHtml = e.value + "<font color='red'>(预存)</font>";
                }
                break;
            case "rate":
                var value = e.value||"";
                if(value){
                    e.cellHtml = e.value + '%';
                }
                break;
            default:
                break;
        }
    });  
    
    var filter = new HeaderFilter(mainGrid, {
        columns: [
            { name: 'contactName' },
	        { name: 'mtAdvisor' },
            { name: 'carModel' },
            { name: 'carNo' },
            {name: 'serviceCode'}
        ],
        callback: function (column, filtered) {
        },

        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
	    	}
        	return value;
        }
    });
    quickSearch(4);
});
var statusHash = {
    "0" : "草稿",
    "1" : "待出库",
    "2" : "已出库",
    "3" : "待结算",
    "4" : "已结算",
    "5" : "全部"
    
};

function clear(){
    advancedSearchForm.setData([]); 
    beginDateEl.setValue(getMonthStartDate());
    endDateEl.setValue(addDate(getMonthEndDate(), 1));
}
function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = mainGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";

    innerPartGrid.setData([]);
    
    var serviceId = row.id;
    innerPartGrid.load({
    	serviceId:serviceId,
        token: token
    });
}
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    beginDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}
function onSearch()
{
    var params = {};
   /* var value = nui.get("carNo-search").getValue()||"";
    value = value.replace(/\s+/g, "");
    if(!value){
        showMsg("请输入查询条件!","W");
        return;
    }*/
//    var menunamestatus = nui.get("menunamestatus");
//    var title = menunamestatus.getText();
//    switch (title) {
//    case "草稿":
//    	params.status = 0;
//        break;
//    case "待出库":
//        params.status = 1;  //报价
//        break;
//    case "已出库":
//        params.status = 2;  //施工
//        break;
//    case "待结算":
//    	params.isSettle = 0;
//        break;
//    case "已结算":
//        params.status = 2;
//        params.isSettle = 1;
//        break;
//    default:
//        break;
//  }
    doSearch(params);
}
function doSearch(params) {
    var gsparams = getSearchParam();
//    gsparams.status = params.status;
//    gsparams.isSettle = params.isSettle;
   
    //销售
    gsparams.billTypeId = 3;
    
    mainGrid.load({
        token:token,
        params: gsparams
    },function(){
    	mergeCells();
    });
}
function getSearchParam() {
    var params = {};
    params.soutDate = beginDateEl.getFormValue();
    params.eoutDate = addDate(endDateEl.getValue(),1);
    params.partCode = nui.get("partCode").getValue();
    params.partName = nui.get("partName").getValue();
    params.isSettle=1;
    
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.vin = typeValue;
    }else if(type==2){
        params.name = typeValue;
    }else if(type==3){
        params.mobile = typeValue;
    }
    
    return params;
}

function carNoSearch(){
	onSearch();
}

function mergeCells(){//动态合并行
	var dataAll = mainGrid.getData();
       var arr = new Array;
        for(var i = 0 ; i < dataAll.length ;i ++){
    		if(arr.indexOf(dataAll[i].id) == -1){
    			arr[arr.length] = dataAll[i].id;
    		}
        }
        var brr = new Array;
       		for(var i = 0 ; i < arr.length ; i ++){
       			var row = mainGrid.findRow(function(row){
       				if(arr[i] == row.id){
       					var index = mainGrid.indexOf(row);
       					brr[i] = index;
       				}
       			});    
       		}
	var cells = [];
	for(var i = 0 ; i < arr.length;i ++){
		 var index = brr[i];
		 index = parseInt(index);
		 if(i == 0){
			 cells[0] = { rowIndex: 0, columnIndex: 1, rowSpan: index + 1, colSpan: 0 };
			 cells[1] = { rowIndex: 0, columnIndex: 2, rowSpan: index + 1, colSpan: 0 };
			 cells[2] = { rowIndex: 0, columnIndex: 3, rowSpan: index + 1, colSpan: 0 };
			 cells[3] = { rowIndex: 0, columnIndex: 4, rowSpan: index + 1, colSpan: 0 };
			 cells[4] = { rowIndex: 0, columnIndex: 5, rowSpan: index + 1, colSpan: 0 };
			 cells[5] = { rowIndex: 0, columnIndex: 6, rowSpan: index + 1, colSpan: 0 };
			 cells[6] = { rowIndex: 0, columnIndex: 7, rowSpan: index + 1, colSpan: 0 };
			 cells[7] = { rowIndex: 0, columnIndex: 8, rowSpan: index + 1, colSpan: 0 };
			 cells[8] = { rowIndex: 0, columnIndex: 9, rowSpan: index + 1, colSpan: 0 };
			 cells[9] = { rowIndex: 0, columnIndex: 10, rowSpan: index + 1, colSpan: 0 };
			 cells[10] = { rowIndex: 0, columnIndex: 11, rowSpan: index + 1, colSpan: 0 };
		 }else{
		 	 var last = brr[i-1];
		 	 last = parseInt(last);
		 	 var one = brr[i];
		 	 one = parseInt(one);
		 	 cells[11*i+0] = { rowIndex: last + 1, columnIndex: 1, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[11*i+1] = { rowIndex: last + 1, columnIndex: 2, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[11*i+2] = { rowIndex: last + 1, columnIndex: 3, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[11*i+3] = { rowIndex: last + 1, columnIndex: 4, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[11*i+4] = { rowIndex: last + 1, columnIndex: 5, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[11*i+5] = { rowIndex: last + 1, columnIndex: 6, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[11*i+6] = { rowIndex: last + 1, columnIndex: 7, rowSpan: one - last, colSpan: 0 }; 
		 	 cells[11*i+7] = { rowIndex: last + 1, columnIndex: 8, rowSpan: one - last, colSpan: 0 };
		 	 cells[11*i+8] = { rowIndex: last + 1, columnIndex: 9, rowSpan: one - last, colSpan: 0 };
		 	 cells[11*i+9] = { rowIndex: last + 1, columnIndex: 10, rowSpan: one - last, colSpan: 0 };
		 	cells[11*i+10] = { rowIndex: last + 1, columnIndex: 11, rowSpan: one - last, colSpan: 0 };
		 	 
		 }
	}
	mainGrid.mergeCells(cells);
}


function onExport(){
	var detail = nui.clone(mainGrid.getData());
//多级
	exportMultistage(mainGrid.columns)
//单级
       //exportNoMultistage(rightGrid.columns)
	for(var i=0;i<detail.length;i++){
/*		detail[i].status=statusHash[detail[i].status]

		detail[i].billTypeId=billTypeIdList[detail[i].billTypeId].name;
        if(detail[i].isSettle== 1){
        	detail[i].isSettle = "已结算";
        }else{
        	detail[i].isSettle = "未结算";
        }

		if(detail[i].isCollectMoney==1){
			detail[i].isCollectMoney="√";
		}else{
			detail[i].isCollectMoney="";
		}*/
	}
	if(detail && detail.length > 0){
//多级表头类型
		setInitExportData( detail,mainGrid.columns,"销售开单明细表导出");
//单级表头类型  与上二选一
//setInitExportDataNoMultistage( detail,rightGrid.columns,"已结算工单明细表导出");
	}
	
}