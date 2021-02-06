/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryAccountList.biz.ext";

var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var searchBeginDate = null;
var searchEndDate = null;
var comSearchGuestId = null;
var auditSignEl = null;
var mainGrid = null;
var list = null;
var accountList = null;
var accountTypeHash = {};
var auditSignHash = {
    "0":"否",
    "1":"是"
};
var auditSignList = [
    {id:0,text:"未审"},
    {id:1,text:"已审"}
];
$(document).ready(function(v)
{
	advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");

    mainGrid = nui.get("mainGrid");
    mainGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    comSearchGuestId = nui.get("searchGuestId");
    auditSignEl = nui.get("auditSign");

    searchBeginDate.setValue(getNowStartDate());
    searchEndDate.setValue(addDate(getNowEndDate(), 1));
    
    nui.get("rpSettleDate").setValue(now);

    getInComeExpenses(function(data) {
        list = data.list;
        nui.get("elBillTypeId").setData(list);
        
        getAccountList(function(data) {
            accountList = data.settleAccount;
            nui.get("elBalaAccountId").setData(accountList);
            
            getSettleType(function(data) {
                var d = data.list || [];
                d.filter(function(v)
                {
                    accountTypeHash[v.customid] = v;
                    return true;
                });
                
                doSearch();
                
            });
            
        });
    }); 

});
var querySettleTypeUrl = baseUrl
        + "com.hsapi.cloud.part.baseDataCrud.query.querySettleType.biz.ext";
function getSettleType(callback) {
    nui.ajax({
        url : querySettleTypeUrl,
        data : {
            dictId: 'DDT20130703000031',
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
var queryUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getInComeExpenses(callback) {
    var params = {itemTypeId : 1, isMain: 0};
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
var queryAccountUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.queryFiSettleAccount.biz.ext";
function getAccountList(callback) {
    nui.ajax({
        url : queryAccountUrl,
        data : {
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.settleAccount) {
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
    params.rpDc = 1;
    params.auditSign = auditSignEl.getValue();
    params.accountTypeId = 2;
    params.guestId = comSearchGuestId.getValue();
    
    params.sCreateDate = searchBeginDate.getFormValue();
    params.eCreateDate = searchEndDate.getFormValue();

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
function OnrpMainGridCellBeginEdit(e){
    var field=e.field; 
    var editor = e.editor;
    var row = e.row;
    var column = e.column;
    var editor = e.editor;

    if(row.auditSign == 1){
        e.cancel = true;
    }

    if (column.field == "balaTypeCode") {
        var str = "accountId="+row.balaAccountId;
        var url = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryAccountSettleType.biz.ext?" + str;
        editor.setUrl(url);
    }
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "auditSign":
            if(auditSignHash && auditSignHash[e.value])
            {
                e.cellHtml = auditSignHash[e.value];
            }
            break;
        case "balaTypeCode":
            if(accountTypeHash && accountTypeHash[e.value])
            {
                e.cellHtml = accountTypeHash[e.value].name;
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
                //isSupplier: 1,
                //isClient: 0
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

                    var newRow = {guestId: guestId, guestName: fullName, rpDc: 1, accountTypeId: 2, settleType:"应收"};
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
        + "com.hsapi.cloud.part.settle.svr.saveQTAccountList.biz.ext";
function save(){
    var data = mainGrid.getData();

    if(data && data.length <= 0) return;

    var rows = mainGrid.findRow(function(row){
        var balaAccountId = row.balaAccountId;
        if(balaAccountId){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
    	showMsg("请选择结算账户后再保存!","W");
//        nui.alert("请选择结算账户后再保存!");
        return;
    }

    var rows = mainGrid.findRow(function(row){
        var balaTypeCode = row.balaTypeCode;
        if(balaTypeCode){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
    	showMsg("请选择结算账户对应的结算方式后再保存!","W");
//        nui.alert("请选择结算账户对应的结算方式后再保存!");
        return;
    }

    var rows = mainGrid.findRow(function(row){
        var billTypeId = row.billTypeId;
        if(billTypeId){
            return false;
        }else{
            return true;
        }
    });

    if(rows) {
    	showMsg("请选择费用科目后再保存!","W");
//        nui.alert("请选择费用科目后再保存!");
        return;
    }

    var accountAdd = mainGrid.getChanges("added");
    var accountUpdate = mainGrid.getChanges("modified");
    var accountDelete = mainGrid.getChanges("removed");

    var accountAddList = [];
    var accountUpdateList = [];
    if(accountAdd){
        for(var i=0; i<accountAdd.length; i++){
            var temp = accountAdd[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            accountAddList.push(temp);
        }

    }

    if(accountUpdate){
        for(var i=0; i<accountUpdate.length; i++){
            var temp = accountUpdate[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            accountUpdateList.push(temp);

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
            accountAdd: accountAddList,
            accountUpdate: accountUpdateList,
            accountDelete: accountDelete
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
        + "com.hsapi.cloud.part.settle.svr.auditQTAccountList.biz.ext";
function audit(){
    var rpAdd = mainGrid.getChanges("added");
    if(rpAdd && rpAdd.length > 0){
    	showMsg("请先保存数据再审核！","W");
//        nui.alert("请先保存数据再审核!");
        return;
    }

    var rpUpdate = mainGrid.getChanges("modified");
    if(rpUpdate && rpUpdate.length > 0){
    	showMsg("请先保存数据再审核！","W");
//        nui.alert("请先保存数据再审核!");
        return;
    }

    var rpDelete = mainGrid.getChanges("removed");
    if(rpDelete && rpDelete.length > 0){
    	showMsg("请先保存数据再审核！","W");
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
    var accountList = [];
    if(data){
        for(var i=0; i<data.length; i++){
            var temp = data[i];
            if(temp.createDate) {
                temp.createDate = format(temp.createDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            if(temp.operateDate) {
                temp.operateDate = format(temp.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
            temp.settleDate = nui.get("rpSettleDate").getValue();
            accountList.push(temp);
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
		                accountBill: accountList
		            }),
		            success : function(data) {
		                nui.unmask(document.body);
		                data = data || {};
		                if (data.errCode == "S") {
		                	showMsg("审核成功!","S");
		                	
		                	addVoucher(accountList);
		                    
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
function onAccountValueChanged(e){

    var r = mainGrid.getSelected();
    var newRow = {balaTypeCode:null};
    mainGrid.updateRow(r,newRow);

}
var voucherUrl = baseUrl+"com.hsapi.cloud.part.invoicing.ordersettle.generateKingExpense.biz.ext";
function addVoucher(data){
	nui.ajax({
		url : voucherUrl,
		type : "post",
		async:true,
		data : JSON.stringify({
			accountBill: data,
			dc: 1,
			settleDate: nui.get("rpSettleDate").getValue()
		}),
		success : function(data) {
			console.log(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }else{
		nui.get("sCreateDate").setValue(getWeekStartDate());
		nui.get("eCreateDate").setValue(addDate(getWeekEndDate(), 1));
	}
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    advancedSearchFormData = {};
    for(var key in searchData)
    {
        advancedSearchFormData[key] = searchData[key];
    }
    var i;
    if(searchData.sCreateDate)
    {
        searchData.sCreateDate = formatDate(searchData.sCreateDate);
    }
    if(searchData.eCreateDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        
    }
    //供应商
    if(searchData.guestId)
    {
    	searchData.guestId = nui.get("btnEdit2").getValue();
    }
    if(searchData.elBillTypeId)
    {
    	searchData.billTypeId = searchData.elBillTypeId;
    }
    if(searchData.elRemark)
    {
    	searchData.remark = searchData.elRemark;
    }
    if(searchData.elAuditSign)
    {
    	searchData.auditSign = searchData.elAuditSign;
    }
    if(searchData.elBalaAccountId)
    {
    	searchData.balaAccountId = searchData.elBalaAccountId;
    }
    if(searchData.elAuditor)
    {
    	searchData.auditor = searchData.elAuditor;
    }
    //订单单号
    if(searchData.billServiceIdList)
    {
        var tmpList = searchData.billServiceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            //tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        	tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.rpAccountIdList = tmpList.join(",");
    }
    /*for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
    }*/
    
    advancedSearchWin.hide();

    searchData.rpDc = 1;
    searchData.accountTypeId = 2;
    
    mainGrid.load({
        params: searchData,
        pageSize: 1000,
        token : token
    });
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}

var supplier = null;
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