var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var mainGrid = null;
var mainGridUrl = baseUrl + "com.hsapi.repair.repairService.svr.qyeryMaintainList.biz.ext";
var getRpsPartUrl = baseUrl + "com.hsapi.repair.repairService.svr.getRpsMainPart.biz.ext";
var beginDateEl = null;
var endDateEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"VIN码"},{id:"2",name:"客户名称"},{id:"3",name:"手机号"}];
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

$(document).ready(function ()
{
    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(mainGridUrl);
    beginDateEl = nui.get("sRecordDate");
    endDateEl = nui.get("eRecordDate");
    editFormDetail = document.getElementById("editFormDetail");
    innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getRpsPartUrl);
    
    mainTabs = nui.get("mainTabs");
	settleAccountGrid = nui.get("settleAccountGrid");
	settleWin = nui.get("settleWin");
    mainGrid.on("drawcell", function (e) {
        if (e.field == "status") {
            e.cellHtml = statusHash[e.value];
        }else if(e.field == "isSettle"){
            if(e.value == 1){
                e.cellHtml = "已结算";
            }else{
                e.cellHtml = "未结算";
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
    var statusList = "0,1,2,3";
    var p = {statusList:statusList};
    doSearch(p);
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
function quickSearch(type) {
    var params = {};
    switch (type) {
        case 0:
            params.status = 0;  //制单
            break;
        case 1:
            params.status = 1;  //施工
            break;
        case 2:
            params.status = 2;  //完工
            //document.getElementById("advancedMore").style.display='block';
            break;
        case 3:
            params.status = 2;  //待结算  is_settle
            params.isSettle = 0;
            break;
        case 4:
            params.isSettle = 1;
            //document.getElementById("advancedMore").style.display='block';
            break;
        default:
            break;
    }

    doSearch(params);
}
function onSearch()
{
    var params = {};
    var value = nui.get("carNo-search").getValue()||"";
    value = value.replace(/\s+/g, "");
    if(!value){
        showMsg("请输入查询条件!","W");
        return;
    }
    doSearch(params);
}
function doSearch(params) {
    var gsparams = getSearchParam();
    gsparams.status = params.status;
    gsparams.statusList = params.statusList;
    gsparams.isSettle = params.isSettle;
   
    //洗美
    //gsparams.billTypeId = 2;
    
    mainGrid.load({
        token:token,
        params: gsparams
    });
}
function getSearchParam() {
    var params = {};
    params.sRecordDate = beginDateEl.getValue();
    params.eRecordDate = endDateEl.getValue();
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.vin = typeValue;
    }else if(type==2){
        params.name = typeValue;
    }else if(type==3){
        params.tel = typeValue;
    }
    
    return params;
}

function addSell(){
    var part={};
    part.id = "4000";
    part.text = "销售-工单";
    part.url = webPath + contextPath + "/repair/RepairBusiness/Reception/sellBill.jsp?token="+token;
    part.iconCls = "fa fa-file-text";
    var params = {};
    window.parent.activeTabAndInit(part,params);

}
function editSell(){
    var row = mainGrid.getSelected();
    if(!row) return;
    var part={};
    part.id = "4000";
    part.text = "销售-工单";
    part.url = webPath + contextPath + "/repair/RepairBusiness/Reception/sellBill.jsp?token="+token;
    part.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = {
        id: row.id
    };
    window.parent.activeTabAndInit(part,params);
}
//根据开单界面传递的车牌号查询未结算的工单
function setInitData(params){
    var carNo = params.carNo||"";
    var type = params.type||""
    if(type=='view' && carNo != ""){
        var p = {
            carNoEqual: carNo,
            isSettle: 0
        };
        mainGrid.load({
            token:token,
            params: p
        });
    }
}
//转出库
var updOutUrl = baseUrl + "com.hsapi.repair.repairService.crud.UpdateMainStatusOut.biz.ext";
function out(){	
	var row = mainGrid.getSelected();
	if(row)
	{
		if(row.isSettle == 1){
	        showMsg("此单已结算!","W");
	        return;
	    }
		if(row.status==0){
			showMsg("此单需审核才能出库!","W");
	        return;
		}
		if(row.status==2){
			showMsg("此单已出库!","W");
	        return;
		}
		var json = nui.encode({
			"main" : row,
			token : token
		});
		
		nui.ajax({
			url : updOutUrl,
			type : 'POST',
			data : json,
			cache : false,
			contentType : 'text/json',
			success : function(text) {
				var returnJson = nui.decode(text);
				if (returnJson.errCode == "S") {
					b = 1;
					showMsg("出库成功");
					
					 mainGrid.load({
					        token:token
				   });
					 
				} else {
					showMsg("出库失败","W");
				}
					
			}
		});
		
	}
	else{
		showMsg("请选择工单", "W");
	}
}
//转结算
payUrl = webPath + contextPath + "/repair/RepairBusiness/Reception/partBillPay.jsp?token="+token;
function pay(){	
	var row = mainGrid.getSelected();
	if(row)
	{
		if(row.isSettle == 1){
	        showMsg("此单已结算!","W");
	        return;
	    }
		if(row.status != 2){
			 showMsg("此单未出库，不能结算!","W");
		     return;
		}
		nui.open({
			url:payUrl,
			width:"40%",
			height:"50%",
			//加载完之后
			onload: function(){	
			//把值传递到支付页面
		    var iframe = this.getIFrameEl();
		    iframe.contentWindow.getData(row);			
			},
		   ondestroy : function(action) {
			if (action == 'ok') {
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
	else{
		showMsg("请选择单据", "W");
	}
}



var updUrl = window._rootRepairUrl + "com.hsapi.repair.repairService.crud.updateMainStatus.biz.ext";
function finish(){

	var main = mainGrid.getSelected();
	var isSettle = main.isSettle||0;
    
    if(isSettle == 1){
        showMsg("此单已结算,不能审核!","W");
        return;
    }
	if(main.status==1){
		showMsg("此单已审核,不能重复审核!","W");
        return;
	} 
	
	var json = nui.encode({
		"main" : main,
		token : token
	});
	
	nui.ajax({
		url : updUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			if (returnJson.errCode == "S") {
				
				showMsg("审核成功");
				 mainGrid.load({
				        token:token
				    });
				
			} else {
				showMsg(returnJson.errMsg,"W");
			}
				
		}
	});
}


