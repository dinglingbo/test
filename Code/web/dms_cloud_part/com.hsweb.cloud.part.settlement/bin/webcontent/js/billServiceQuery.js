/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryRPBill.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOutDetailList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var comServiceId = null;
var comSearchGuestId = null;
var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
var editFormSellOutDetail = null;
var innerSellOutGrid = null;
var editFormSellRtnDetail = null;
var innerSellRtnGrid = null;
var auditWin = null;
var gprows = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var billStatusHash = {
    "0":"未审核",
    "1":"已审核",
    "2":"已过账",
    "3":"已取消"
};
var accountList = [
    {id:0,text:"未审核"},
    {id:1,text:"已审核"},
    {id:2,text:"全部"}
];
var accountSignHash = {
    "0":"未审核",
    "1":"已审核"
};
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    searchServiceId = nui.get("serviceId");
    searchServiceMan = nui.get("serviceMan");
    //comSearchGuestId = nui.get("searchGuestId");
    searchAccountSign = nui.get("accountSign");

    innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
    editFormPchsEnterDetail = document.getElementById("editFormPchsEnterDetail");
    innerPchsEnterGrid.setUrl(innerPchsGridUrl);

    innerPchsRtnGrid = nui.get("innerPchsRtnGrid");
    editFormPchsRtnDetail = document.getElementById("editFormPchsRtnDetail");
    innerPchsRtnGrid.setUrl(innerSellGridUrl);

    innerSellOutGrid = nui.get("innerSellOutGrid");
    editFormSellOutDetail = document.getElementById("editFormSellOutDetail");
    innerSellOutGrid.setUrl(innerSellGridUrl);

    innerSellRtnGrid = nui.get("innerSellRtnGrid");
    editFormSellRtnDetail = document.getElementById("editFormSellRtnDetail");
    innerSellRtnGrid.setUrl(innerPchsGridUrl);

    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    auditWin = nui.get("auditWin");

    searchBeginDate.setValue(getNowStartDate());
    searchEndDate.setValue(addDate(getNowEndDate(), 1));

    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
     //   nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
        var dictIdList = [];
        dictIdList.push('DDT20130703000008');//票据类型
        dictIdList.push('DDT20130703000035');//结算方式
        dictIdList.push('DDT20130703000064');//入库类型
        getDictItems(dictIdList,function(data)
        {
            if(data && data.dataItems)
            {
                var dataItems = data.dataItems||[];
                var billTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000008")
                    {
                        billTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
          //      nui.get("billTypeId").setData(billTypeIdList);
                var settTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000035")
                    {
                        settTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
            }
        });
    });

    getItemType(function(data) {
        var list = data.list || [];
        list.filter(function(v)
        {
            enterTypeIdHash[v.code] = v;
            return true;
        });

    });
});
var queryItemTypeUrl = baseUrl
        + "com.hsapi.cloud.part.settle.svr.queryFibInComeExpenses.biz.ext";
function getItemType(callback) {
    nui.ajax({
        url : queryItemTypeUrl,
        data : {
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
function getSearchParam(){
    var params = {};
    params.accountSign = searchAccountSign.getValue();
    if(searchAccountSign.getValue() == 2){
        params.accountSign = null;
    }

    params.serviceId = searchServiceId.getValue().replace(/\s+/g, "");
    params.serviceMan = searchServiceMan.getValue().replace(/\s+/g, "");
    //params.guestId = comSearchGuestId.getValue();
    
    params.endDate = searchEndDate.getFormValue();
    params.startDate = searchBeginDate.getFormValue();
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            var queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            var queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            var queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            var queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            var queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            var queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            var queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            var queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(params.endDate);
    currType = type;
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    doSearch(params);
}
function onSearch(){
    var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
    params.sortField = "auditDate";
    params.sortOrder = "desc";
    rightGrid.load({
        params:params,
        token: token
    });
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
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
    if(searchData.sBillDate)
    {
        searchData.sBillDate = formatDate(searchData.sBillDate);
    }
    if(searchData.eBillDate)
    {
        var date = searchData.eBillDate;
        searchData.eBillDate = addDate(date, 1);
//        searchData.eBillDate = searchData.eBillDate.substr(0,10);
    }
    //审核日期
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
        params.guestId = nui.get("btnEdit2").getValue();
    }
    //订单单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    if(searchData.accountSign){
        if(searchData.accountSign == 2){
            searchData.accountSign = null;
        }
    }
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
    }
    advancedSearchWin.hide();
    doSearch(searchData);
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
        title: "往来单位资料", width: 980, height: 560,
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

function onDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
        	if(partBrandIdHash[e.value])
            {
//                e.cellHtml = partBrandIdHash[e.value].name||"";
            	if(partBrandIdHash[e.value].imageUrl){
            		
            		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+partBrandIdHash[e.value].name||"";
            	}else{
            		e.cellHtml =partBrandIdHash[e.value].name||"";
            	}
            }
            else{
                e.cellHtml = "";
            }
            break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "billStatus":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
            break;
        case "enterTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        case "enterDayCount":
            var row = e.record;
            var enterTime = (new Date(row.enterDate)).getTime();
            var nowTime = (new Date()).getTime();
            var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
            e.cellHtml = dayCount+1;
            break;
        case "accountSign":
            if(accountSignHash && accountSignHash[e.value])
            {
                e.cellHtml = accountSignHash[e.value];
            }
            break;
        default:
            break;
    }
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.mainId;
    
    //将editForm元素，加入行详细单元格内
    var td = rightGrid.getRowDetailCellEl(row);
    var enterTypeId = row.enterTypeId;

    

    switch (enterTypeId)
    {
        case "050101":
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case "050102":
            td.appendChild(editFormSellRtnDetail);
            editFormSellRtnDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerSellRtnGrid.load({
                params:params,
                token: token
            });

            break;
        case "050201":
            td.appendChild(editFormPchsRtnDetail);
            editFormPchsRtnDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsRtnGrid.load({
                params:params,
                token: token
            });
            break;
        case "050202":
            td.appendChild(editFormSellOutDetail);
            editFormSellOutDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerSellOutGrid.load({
                params:params,
                token: token
            });
            break;
        case "050103":
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case "050203":
            td.appendChild(editFormSellOutDetail);
            editFormSellOutDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerSellOutGrid.load({
                params:params,
                token: token
            });
            break;
        case "050104":
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case "050204":
            td.appendChild(editFormSellOutDetail);
            editFormSellOutDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerSellOutGrid.load({
                params:params,
                token: token
            });
            break;
        default:
            break;
    }
}
function audit(){

    var msg = checkAuditRow(1);
    if(msg){
    	showMsg(msg,"W");
//        nui.alert(msg);
        return;
    }
        
    var rows = rightGrid.getSelecteds();
    var s = rows.length;
    if(s > 0){
        auditWin.show();

        var rtn = getRPAmount(rows);
        document.getElementById('billCount').innerHTML="审核单据数："+s;
        document.getElementById('pAmt').innerHTML=rtn.pAmount;
        document.getElementById('pAuditAmt').innerHTML=rtn.pAmount;
        document.getElementById('rAmt').innerHTML=rtn.rAmount;
        document.getElementById('rAuditAmt').innerHTML=rtn.rAmount;

    }else{
    	showMsg("请选择单据！","W");
//        nui.alert("请选择单据！");
        return;
    }
}
function getRPAmount(rows){
    var s = rows.length;
    var pAmount = 0;
    var rAmount = 0;
    if(s>0){
        for(var i=0; i<s; i++){
            var row = rows[i];
            var dc = row.dc;
            var enterTypeId = row.enterTypeId;
            if(dc == 1) {
                pAmount += row.billAmt;
            }else{
                rAmount += row.billAmt;
            }
        }
    }
    var rtnMsg = {};
    rtnMsg.pAmount = pAmount;
    rtnMsg.rAmount = rAmount;
    return rtnMsg;
}
function auditCancel(){
    document.getElementById('billCount').innerHTML="审核单据数：";
    document.getElementById('pAmt').innerHTML=0;
    document.getElementById('pAuditAmt').innerHTML=0;
    document.getElementById('rAmt').innerHTML=0;
    document.getElementById('rAuditAmt').innerHTML=0;
    auditWin.hide();
}
function checkAuditRow(flag){
    var m = "已审核";
    if(flag == 1){
        m = "已审核";
    }else{
        m = "未审核";
    }
    var rows = rightGrid.getSelecteds();
    var msg = "";
    var s = rows.length;
    if(s > 0){
        for(var i=0; i<s; i++){
            var row = rows[i];
            var accountSign = row.accountSign;
            var serviceId = row.serviceId;
            if(accountSign == flag) {
                msg += "业务单据："+serviceId+ m + "；</br>";
            }
        }
    }

    return msg;
}
var billAuditUrl = baseUrl+"com.hsapi.cloud.part.settle.rpsettle.auditBill.biz.ext";
function auditOK(){
    var rows = rightGrid.getSelecteds();
    var remark = null;
    var s = rows.length;
    if(s > 0){

        if(s>1){
            remark = "批量审核";
        }

        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '单据审核中...'
        });

       nui.ajax({
            url : billAuditUrl,
            type : "post",
            data : JSON.stringify({
                billList : rows,
                remark:remark,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                	 showMsg("单据审核成功!","S");
//                    nui.alert("单据审核成功!");

                    auditCancel();
                    rightGrid.reload();
                    
                } else {
                	showMsg(data.errMsg || "单据审核失败!","E");
//                    nui.alert(data.errMsg || "单据审核失败!");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        }); 

    }else{
    	showMsg("请选择单据！","W");
//        nui.alert("请选择单据！");
        return;
    }
}
var billUnAuditUrl = baseUrl+"com.hsapi.cloud.part.settle.rpsettle.unAuditBill.biz.ext";
function unAudit(){

    var msg = checkAuditRow(0);
    if(msg){
    	showMsg(msg,"W");
//        nui.alert(msg);
        return;
    }
        
    var rows = rightGrid.getSelecteds();
    var remark = null;
    var s = rows.length;
    if(s > 0){

        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '单据反审核中...'
        });

       nui.ajax({
            url : billUnAuditUrl,
            type : "post",
            data : JSON.stringify({
                billList : rows,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                	showMsg("单据反审核成功!","S");
//                    nui.alert("单据反审核成功!");

                    rightGrid.reload();
                    
                } else {
                	showMsg(data.errMsg || "单据反审核失败!","E");
//                    nui.alert(data.errMsg || "单据反审核失败!");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        }); 

    }else{
    	showMsg("请选择单据！","W");
//        nui.alert("请选择单据！");
        return;
    }
}