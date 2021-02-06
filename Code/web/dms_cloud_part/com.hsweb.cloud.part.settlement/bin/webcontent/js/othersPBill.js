/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryRPAccountList.biz.ext";

var searchBeginDate = null;
var searchEndDate = null;
var comSearchGuestId = null;
var auditSignEl = null;
var mainGrid = null;
var list = [];
var billTypeIdHash = {};
var auditSignHash = {
    "0":"否",
    "1":"是"
};
var settleStatusHash = {
    "0":"未结算",
    "1":"部分结算",
    "2":"已结算"
};

var settleStatusList = [
    {id:4,text:"全部"},
    {id:0,text:"未结算"},
    {id:1,text:"部分结算"},
    {id:2,text:"已结算"}
];
var auditSignList = [
    {id:0,text:"未审"},
    {id:1,text:"已审"}
];
$(document).ready(function(v)
{

    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    comSearchGuestId = nui.get("searchGuestId");
    auditSignEl = nui.get("auditSign");

    searchBeginDate.setValue(getNowStartDate());
    searchEndDate.setValue(addDate(getNowEndDate(), 1));

    getInComeExpenses(function(data) {
        var tlist = data.list;
        for (var i = 0; i < tlist.length; i++) {
            if (tlist[i].id != 205 && tlist[i].id != 206 
            		&& tlist[i].id != 213 && tlist[i].id != 245 && tlist[i].id != 246
            		&& tlist[i].id != 340 && tlist[i].id != 341 && tlist[i].id != 342
            		&& tlist[i].id != 343 && tlist[i].id != 344 && tlist[i].id != 345
            		&& tlist[i].id != 346 && tlist[i].id != 347) {
                list.push(tlist[i]);
            }
        }
            
        //billTypeListEl.setUrl(list);
        nui.get("elBillTypeId").setData(list);
        list.forEach(function(v)
        {
            if(v && v.id)
            {
            	billTypeIdHash[v.id] = v;
            }
        });
        
        doSearch();
    });


});
function OnrpMainGridCellBeginEdit(e){
    var field=e.field; 
    var editor = e.editor;
    var row = e.row;
    if(field=="billTypeId"){
         editor.setData(list);
    }
    if(row.auditSign == 1){
        e.cancel = true;
    }
}
var queryUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getInComeExpenses(callback) {
    var params = {itemTypeId : -1, isMain: 0};
    nui.ajax({
        url : queryUrl,
        data : {
            params: params,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function doSearch() {
    var params = {};
    params.billDc = -1;
    params.auditSign = auditSignEl.getValue();
    params.rpTypeId = 2;
    params.guestId = comSearchGuestId.getValue();
    params.billTypeId = nui.get("elBillTypeId").getValue();
    params.remark = nui.get("elRemark").getValue();
    
    params.sCreateDate = searchBeginDate.getFormValue();
    params.eCreateDate = searchEndDate.getFormValue();
    
    params.settleStatus = nui.get("settleStatus").getValue();
    if(params.settleStatus == 4){
    	params.settleStatus =null;
    }

    mainGrid.load({
        params: params,
        pageSize: 1000,
        token : token
    });
}
//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    
    editor.validate();
    if (editor.isValid() == false) {
    	 showMsg("请输入数字！","W");
//        nui.alert("请输入数字！");
        e.cancel = true;
    }
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "settleStatus":
            if(settleStatusHash && settleStatusHash[e.value])
            {
                e.cellHtml = settleStatusHash[e.value];
            }
            break;
        case "auditSign":
            if(auditSignHash && auditSignHash[e.value])
            {
                e.cellHtml = auditSignHash[e.value];
            }
            break;
        default:
            break;
    }
}
function onbillTypeChange(e){
    var se = e.selected;
    var billTypeCode = se.code;
    var row = mainGrid.getSelected();
    var newRow = {billTypeCode: billTypeCode};
    mainGrid.updateRow(row, newRow);

}
function addGuest(){
    var supplier = null;
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.cloud.part.common.supplierSelect.flow",
        title: "选择往来单位", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
               
                supplier = data.supplier;
                if(supplier){
                    var guestId = supplier.id;
                    var fullName = supplier.fullName;
                    var shortName  = supplier.shortName;
                    var code = supplier.code;

                    var newRow = {guestId: guestId, guestName: fullName, billDc: -1, rpTypeId: 2};
                    mainGrid.addRow(newRow);
                }
                
            }
        }
    });
}
function deleteGuest(){
    var record = mainGrid.getSelected();
    if(record.auditSign == 1) return;
    if(!record)
    {
        return;
    }
    mainGrid.removeRow(record,true);
}
var saveUrl = baseUrl
        + "com.hsapi.cloud.part.settle.svr.saveInitRpBill.biz.ext";
function save(){
    var data = mainGrid.getData();

    if(data && data.length <= 0) return;

    var rows = mainGrid.findRow(function(row){
        var billTypeId = row.billTypeId;
        if(billTypeId){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
    	showMsg("请选择收支项目后再保存!","W");
//        nui.alert("请选择收支项目后再保存!");
        return;
    }

    var rpAdd = mainGrid.getChanges("added");
    var rpUpdate = mainGrid.getChanges("modified");
    var rpDelete = mainGrid.getChanges("removed");
    var rpAddList = [];
    var rpUpdateList = [];
    if(rpAdd){
        for(var i=0; i<rpAdd.length; i++){
            var temp = rpAdd[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            rpAddList.push(temp);
        }

    }

    if(rpUpdate){
        for(var i=0; i<rpUpdate.length; i++){
            var temp = rpUpdate[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            rpUpdateList.push(temp);

        }

    }
    
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            rpAdd: rpAddList,
            rpUpdate: rpUpdateList,
            rpDelete: rpDelete
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
            	showMsg("保存成功!","S");
//                nui.alert("保存成功!");
                
                doSearch();
            } else {
            	showMsg(data.errMsg || "保存失败!","E");
//                nui.alert(data.errMsg || "保存失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });

    
}
var auditUrl = baseUrl
        + "com.hsapi.cloud.part.settle.svr.auditInitRpBill.biz.ext";
function audit(){
    var rpAdd = mainGrid.getChanges("added");
    if(rpAdd && rpAdd.length > 0){
    	showMsg("请先保存数据再审核!","W");
//        nui.alert("请先保存数据再审核!");
        return;
    }

    var rpUpdate = mainGrid.getChanges("modified");
    if(rpUpdate && rpUpdate.length > 0){
    	showMsg("请先保存数据再审核!","W");
//        nui.alert("请先保存数据再审核!");
        return;
    }

    var rpDelete = mainGrid.getChanges("removed");
    if(rpDelete && rpDelete.length > 0){
    	showMsg("请先保存数据再审核!","W");
//        nui.alert("请先保存数据再审核!");
        return;
    }

    var data = mainGrid.getSelecteds();
    if(data.length<=0){
    	showMsg("请选择要审核的数据!","W");
    	return;
    }
    for(var i=0;i<data.length;i++){
    	if(data[i].auditSign==1){
    		showMsg("数据已审核","W");
    		return;
    	}
    }
    if(data.length<=0){
    	showMsg("请选择要审核的数据!","W");
    	return;
    }
    for(var i=0;i<data.length;i++){
    	if(data[i].auditSign==1){
    		showMsg("数据已审核","W");
    		return;
    	}
    }
    var dataList = [];
    if(data){
        for(var i=0; i<data.length; i++){
            var temp = data[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            dataList.push(temp);
        }

    }
    
    nui.confirm("是否确定审核?", "友情提示", function(action) {
		if (action == "ok") {
			if(data) {
		        nui.mask({
		            el : document.body,
		            cls : 'mini-mask-loading',
		            html : '审核中...'
		        });

		        nui.ajax({
		            url : auditUrl,
		            type : "post",
		            data : JSON.stringify({
		                rpBill: dataList
		            }),
		            success : function(data) {
		                nui.unmask(document.body);
		                data = data || {};
		                if (data.errCode == "S") {
		                	showMsg("审核成功","S");
		                    
		                    doSearch();
		                } else {
		                	showMsg(data.errMsg || "审核失败!","E");
		                }
		            },
		            error : function(jqXHR, textStatus, errorThrown) {
		                console.log(jqXHR.responseText);
		            }
		        });
		    }
		} else {
			return;
		}
		
	});

    
}
function refresh(){
    doSearch();
}
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.cloud.part.common.supplierSelect.flow",
        title: "结算单位资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

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

function onExport(){
	var detail = nui.clone(mainGrid.getData());
	//多级
	//exportMultistage(rightGrid.columns);
	//单级
	exportNoMultistage(mainGrid.columns)
	for(var i=0;i<detail.length;i++){
		if(billTypeIdHash[detail[i].billTypeId]){
			detail[i].billTypeId = billTypeIdHash[detail[i].billTypeId].name;
		}
		if(detail[i].auditSign == 1){
			detail[i].auditSign = "是";
		}else {
			detail[i].auditSign = "否";
		}
		
		if(settleStatusHash[detail[i].settleStatus]){
			detail[i].settleStatus=settleStatusHash[detail[i].settleStatus];
		}
		
		
	}
	if(detail && detail.length > 0){
		//多级表头类型
		//setInitExportData( detail,rightGrid.columns,"采购入库明细表");
		//单级表头类型 与上二选一
		setInitExportDataNoMultistage( detail,mainGrid.columns,"其他应付单");
	}
}