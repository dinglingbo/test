/**
 * Created by Administrator on 2018/8/8.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl
		+ "com.hsapi.part.invoice.query.queryPjSellOrderMainDetailList.biz.ext";
var queryInfoForm = null;
var periodValidity = null;
$(document).ready(function(v) {
	
	queryInfoForm = new nui.Form("#queryInfoForm").getData(false, false);

	grid = nui.get("grid");
	
	grid.load(queryInfoForm);
	grid.setUrl(gridUrl);
	grid.on("drawcell", onDrawCell);
	getNowFormatDate();
	
	onSearch();
	document.getElementById("fastPartForConsumable_view0").src=webPath + contextPath + "/manage/inOutManage/common/fastPartForConsumable_view0.jsp";
	 
});

function getSearchParams() {
	var params = {};
	params.sCreateDate = nui.get("sCreateDate").getValue().substr(0, 10);
	params.eCreateDate = nui.get("eCreateDate").getValue().substr(0, 10);
	params.orderMan = nui.get('orderMan').getValue();
	return params;
}
function onSearch() {
	var params = getSearchParams();

	doSearch(params);
}
function doSearch(params) {
	params.orderTypeId = 5;
	grid.load({
		token : token,
		params : params
	});
}
function getNowFormatDate() {
	var date = new Date();
	var seperator1 = "-";
	var seperator2 = ":";
	var month = date.getMonth() + 1;
	var strDate = date.getDate();
	if (month >= 1 && month <= 9) {
		month = "0" + month;
	}
	if (strDate >= 0 && strDate <= 9) {
		strDate = "0" + strDate;
	}

	var sCreateDate = date.getFullYear() + seperator1 + month + seperator1
			+ "01";
	var eCreateDate = date.getFullYear() + seperator1 + month + seperator1
			+ strDate;
	nui.get('sCreateDate').setValue(sCreateDate);
	nui.get('eCreateDate').setValue(eCreateDate);
}

function getPart() {
	nui.open({
		url:webPath + partDomain +"/com.hsweb.part.manage.fastPartForConsumable.flow?token"+token,
		title: "领料", width: 1000, height: 600,
		allowDrag : true,
        allowResize : true,
		onload: function(){
		},
		ondestroy: function(action){
			if(action == 'ok'){
				var iframe = this.getIFrameEl();
				grid.reload();
			}
		}
	});
}


function getMainData() {
    var data = grid.getSelected();
    // 汇总明细数据到主表
    data.isFinished = 0;
    data.auditSign = 0;
    data.billStatusId = 0;
    data.printTimes = 0;
    data.orderTypeId = 5;

    if (data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss')
                + '.0';// 用于后台判断数据是否在其他地方已修改
        // data.versionNo = format(data.versionNo, 'yyyy-MM-dd HH:mm:ss');
    }

    if(!data.billTypeId){
        data.billTypeId = "010103";
    }

    grid.findRow(function(row){
        var partId = row.partId;
        var partCode = row.comPartCode;
        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
            enterGrid.removeRow(row);
        }
    });

    return data;
}
function getModifyData(data, addList, delList){
    var arr = [];
    if(data==addList) return arr;
    for(var i=0; i<addList.length; i++) {
    
       var val = addList[i];
       for(var j=0; j<data.length; j++) {
        
           if(data[j] == val)
           data.splice(j, 1);
        }
    }
            
    for(var i=0; i<delList.length; i++) {
    
       var val = delList[i];
       for(var j=0; j<data.length; j++) {
        
           if(data[j] == val)
           data.splice(j, 1);
        }
    }

    return data;
}
function order(){
    var data = grid.getData();
    var flagSign = 0; 
    var flagStr = "提交中...";
    var flagRtn = "提交成功!";
    orderEnter(flagSign, flagStr, flagRtn);
}

function orderToEnter(){
    //如果是内部订单，直接入库时需要判断 bill_status_id = 2（待收货）
    var data = grid.getData();
    var isInner = data.isInner||0;
    var billStatusId = data.billStatusId||0;
    //if(isInner == 0 && billStatusId == 0){
        var flagSign = 1; 
        var flagStr = "入库中...";
        var flagRtn = "入库成功!";
        orderEnter(flagSign, flagStr, flagRtn);     

}

function checkRightData() {
	var row=grid.getSelected();
    var msg = '';
    var rows = grid.findRows(function(row) {
        if(row.partId){  
            if (row.orderQty) {
                if (row.orderQty <= 0)
                    return true;
            } else {
                return true;
            }
            if (row.orderPrice) {
                if (row.orderPrice <= 0)
                    return true;
            } else {
                return true;
            }
            if (row.orderAmt) {
                if (row.orderAmt <= 0)
                    return true;
            } else {
                return true;
            }

            if (row.storeId) {
            } else {
                return true;
            }
        }
    });

    if (rows && rows.length > 0) {
        msg = "请完善退货配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
}
//归库
var enterUrl = baseUrl
+ "com.hsapi.part.invoice.crud.auditPjSellOrderRtn.biz.ext";
function orderEnter(flagSign, flagStr, flagRtn) {

    var row = grid.getSelected();
    if (row) {
        if (row.auditSign == 1) {
            showMsg("此单已入库!","W");
            return;
        }
    } else {
        return;
    }

    // 审核时，数量，单价，金额，仓库不能为空
    var msg = checkRightData();
    if (msg) {
        showMsg(msg,"W");
        return;
    }

    var str = "提交";
    if(flagSign == 1){
        str = "入库";
    }

    nui.confirm("是否确定"+str+"?", "友情提示", function(action) {
        if (action == "ok") {

            data = getMainData();

            //由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
            var detailData = grid.getData();

            var pchsOrderDetailAdd = grid.getChanges("added");
            var pchsOrderDetailUpdate = grid.getChanges("modified");
            var pchsOrderDetailDelete = grid.getChanges("removed");
            var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
            nui.mask({
                el : document.body,
                cls : 'mini-mask-loading',
                html : flagStr
            });

            nui.ajax({
                url : enterUrl,
                type : "post",
                data : JSON.stringify({
                    pchsOrderMain : data,
                    pchsOrderDetailAdd : pchsOrderDetailAdd,
                    pchsOrderDetailUpdate : pchsOrderDetailUpdate,
                    pchsOrderDetailDelete : pchsOrderDetailDelete,
                    operateFlag : flagSign,
                    token: token
                }),
                success : function(data) {
                    nui.unmask(document.body);
                    data = data || {};
                    if (data.errCode == "S") {
                        showMsg(str+"成功!","S");
                        // onLeftGridRowDblClick({});
                        var pjPchsOrderMainList = data.pjPchsOrderMainList;
         
                    } else {
                        showMsg(data.errMsg || (str+"失败!"),"W");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    // nui.alert(jqXHR.responseText);
                    console.log(jqXHR.responseText);
                }
            });

        } else {
            return;
        }
    });

}