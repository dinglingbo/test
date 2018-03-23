/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryRPAccountList.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOutDetailList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var rpRightGrid = null;
var rRightGrid = null;
var pRightGrid = null;
var qRightGrid = null;
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
var mainTabs = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var billStatusHash = {
    "0":"未审",
    "1":"已审",
    "2":"已过账",
    "3":"已取消"
};
var settleStatusHash = {
    "0":"未结算",
    "1":"部分结算",
    "2":"已结算"
};
var balanceList = [
    {id:0,text:"未对"},
    {id:1,text:"已对"},
    {id:2,text:"全部"}
];
$(document).ready(function(v)
{
    rpRightGrid = nui.get("rpRightGrid");
    rRightGrid = nui.get("rRightGrid");
    pRightGrid = nui.get("pRightGrid");
    qRightGrid = nui.get("qRightGrid");
    rpRightGrid.setUrl(rightGridUrl);
    rRightGrid.setUrl(rightGridUrl);
    pRightGrid.setUrl(rightGridUrl);
    qRightGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    searchServiceId = nui.get("serviceId");
    comSearchGuestId = nui.get("searchGuestId");
    mainTabs = nui.get("mainTabs");

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
          //      nui.get("settType").setData(settTypeIdList);
                var enterTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000064")
                    {
                        enterTypeIdHash[v.customid] = v;
                        return true;
                    }
                });
                //quickSearch(currType);
            }
        });
    });
});
function getSearchParam(){
    var params = {};

    params.billServiceId = searchServiceId.getValue();
    params.guestId = comSearchGuestId.getValue();
    
    params.sCreateDate = searchEndDate.getValue();
    params.eCreateDate = searchBeginDate.getValue();
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
            params.sCreateDate = getNowStartDate();
            params.eCreateDate = addDate(getNowEndDate(), 1);
            var queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sCreateDate = getPrevStartDate();
            params.eCreateDate = addDate(getPrevEndDate(), 1);
            var queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sCreateDate = getWeekStartDate();
            params.eCreateDate = addDate(getWeekEndDate(), 1);
            var queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sCreateDate = getLastWeekStartDate();
            params.eCreateDate = addDate(getLastWeekEndDate(), 1);
            var queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sCreateDate = getMonthStartDate();
            params.eCreateDate = addDate(getMonthEndDate(), 1);
            var queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sCreateDate = getLastMonthStartDate();
            params.eCreateDate = addDate(getLastMonthEndDate(), 1);
            var queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.sCreateDate = getYearStartDate();
            params.eCreateDate = getYearEndDate();
            var queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.sCreateDate = getPrevYearStartDate();
            params.eCreateDate = getPrevYearEndDate();
            var queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.sCreateDate);
    searchEndDate.setValue(params.eCreateDate);
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
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rpRightGrid.load({
                params:params,
                token: token
            });
            break;
        case "pRightTab":
            params.billDc = -1;
            pRightGrid.load({
                params:params,
                token: token
            });
            break;
        case "rRightTab":
            params.billDc = 1;
            rRightGrid.load({
                params:params,
                token: token
            });
            break;
        case "qRightTab":
            qRightGrid.load({
                params:params,
                token: token
            });
            break;
        default:
            break;
    }

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
    if(searchData.sCreateDate)
    {
        searchData.sCreateDate = searchData.sCreateDate.substr(0,10);
    }
    if(searchData.eCreateDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        searchData.eCreateDate = searchData.eCreateDate.substr(0,10);
    }
    //审核日期
    if(searchData.sBalanceDate)
    {
        searchData.sBalanceDate = searchData.sBalanceDate.substr(0,10);
    }
    if(searchData.eBalanceDate)
    {
        var date = searchData.eBalanceDate;
        searchData.eBalanceDate = addDate(date, 1);
        searchData.eBalanceDate = searchData.eBalanceDate.substr(0,10);
    }
    //供应商
    if(searchData.guestId)
    {
        params.guestId = nui.get("guestId").getValue();
    }
    //订单单号
    if(searchData.billServiceIdList)
    {
        var tmpList = searchData.billServiceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.billServiceIdList = tmpList.join(",");
    }
    if(searchData.balanceSign){
        if(searchData.balanceSign == 2){
            searchData.balanceSign = null;
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
        targetWindow: window,
        url: "com.hsweb.part.common.supplierSelect.flow",
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

function onDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
            if(partBrandIdHash && partBrandIdHash[e.value])
            {
                e.cellHtml = partBrandIdHash[e.value].name;
            }
            break;
        case "billTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        case "billStatus":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
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
        case "settleStatus":
            if(settleStatusHash && settleStatusHash[e.value])
            {
                e.cellHtml = settleStatusHash[e.value];
            }
            break;
        default:
            break;
    }
}
function onrpRightGridDrawCell(e){
    switch (e.field)
    {
        case "billTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        case "amt1":
            var row = e.row;
            if(row.billDc == 1) {
                e.cellHtml = row.rpAmt;
            }else{
                e.cellHtml = 0;
            }
            break;
        case "amt4":
            var row = e.row;
            if(row.billDc == 1) {
                e.cellHtml = row.charOffAmt;
            }else{
                e.cellHtml = 0;
            }
            break;
        case "amt11":
            var row = e.row;
            if(row.billDc == -1) {
                e.cellHtml = row.rpAmt;
            }else{
                e.cellHtml = 0;
            }
            break;
        case "amt14":
            var row = e.row;
            if(row.billDc == -1) {
                e.cellHtml = row.charOffAmt;
            }else{
                e.cellHtml = 0;
            }
            break;
        case "settleStatus":
            if(settleStatusHash && settleStatusHash[e.value])
            {
                e.cellHtml = settleStatusHash[e.value];
            }
            break;
        default:
            break;
    }
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.billMainId;
    
    //将editForm元素，加入行详细单元格内
    var rightGrid = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }

    var td = rightGrid.getRowDetailCellEl(row);
    var billTypeId = row.billTypeId;

    switch (billTypeId)
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
        default:
            break;
    }
}
function doBalance(){
    var rightGrid = null;
    var firstRow = {};
    var guestId = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
    var msg = checkAuditRow(1);
    if(msg){
        nui.alert(msg);
        return;
    }
        
    var rows = rightGrid.getSelecteds();
    var s = rows.length;
    if(s > 0){
        auditWin.show();

        var rtn = getRPAmount(rows);
        var guestName = rows[0].guestName;
        document.getElementById('balanceGuestName').innerHTML="对账单位："+guestName;
        document.getElementById('balanceBillCount').innerHTML="对账单据数："+s;
        document.getElementById('pAmt').innerHTML=rtn.pAmount;
        document.getElementById('rAmt').innerHTML=rtn.rAmount;

    }else{
        nui.alert("请选择单据！");
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
            var dc = row.billDc;
            if(dc == -1) {
                pAmount += row.rpAmt;
            }else{
                rAmount += row.rpAmt;
            }
        }
    }
    var rtnMsg = {};
    rtnMsg.pAmount = pAmount;
    rtnMsg.rAmount = rAmount;
    return rtnMsg;
}
function balanceCancel(){
    document.getElementById('balanceGuestName').innerHTML="对账单位：";
    document.getElementById('balanceBillCount').innerHTML="对账单据数：";
    document.getElementById('pAmt').innerHTML=0;
    document.getElementById('rAmt').innerHTML=0;
    auditWin.hide();
}
function checkAuditRow(flag){
    var rightGrid = null;
    var firstRow = {};
    var guestId = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
    var rows = rightGrid.getSelecteds();
    var msg = "";
    var s = rows.length;
    if(s > 0){
        for(var i=0; i<s; i++){
            var row = rows[i];
            if(i == 0){
                firstRow = row;
                guestId = firstRow.guestId;
            }else{
                var rowGuestId = row.guestId;
                if(guestId != rowGuestId){
                    return "请选择相同结算单位的单据!";
                }
            }
        }

        for(var i=0; i<s; i++){
            var row = rows[i];
            var balanceSign = row.balanceSign;
            var billServiceId = row.billServiceId;
            if(balanceSign == flag && balanceSign == 1) {
                msg += "业务单据："+billServiceId+ "已对账；</br>";
            }else if(balanceSign == flag && balanceSign == 0) {
                msg += "业务单据："+billServiceId+ "未对账；</br>";
            }
        }
    }else{
        msg = "请选择单据!";
    }

    return msg;
}
var balanceAuditUrl = baseUrl+"com.hsapi.cloud.part.settle.rpsettle.balanceRPAccount.biz.ext";
function balanceOK(){
    var rightGrid = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
    var rows = rightGrid.getSelecteds();
    var remark = null;
    var s = rows.length;
    if(s > 0){

        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据处理中...'
        });

       nui.ajax({
            url : balanceAuditUrl,
            type : "post",
            data : JSON.stringify({
                billList : rows,
                token : token
            }),
            success : function(data) {
                nui.unmask(document.body);
                data = data || {};
                if (data.errCode == "S") {
                    nui.alert("对账成功!");

                    balanceCancel();
                    rightGrid.reload();
                    
                } else {
                    nui.alert(data.errMsg || "对账失败!");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        }); 

    }else{
        nui.alert("请选择单据！");
        return;
    }
}
var billUnAuditUrl = baseUrl+"com.hsapi.cloud.part.settle.rpsettle.unBalanceRPAccount.biz.ext";
function doUnBalance(){

    var msg = checkAuditRow(0);
    if(msg){
        nui.alert(msg);
        return;
    }

    var rightGrid = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
        
    var rows = rightGrid.getSelecteds();
    var remark = null;
    var s = rows.length;
    if(s > 0){

        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据处理中...'
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
                    nui.alert("取消对账成功!");

                    rightGrid.reload();
                    
                } else {
                    nui.alert(data.errMsg || "取消对账失败!");
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                // nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
            }
        }); 

    }else{
        nui.alert("请选择单据！");
        return;
    }
}
function OnrpRightGridCellBeginEdit(e){
    var column = e.column;
    var editor = e.editor;
    var row = e.row;
    if(row.billDc == 1){
        if (column.field == "amt12" || column.field == "amt13") {
            e.cancel = true;
        }
    }else{
        if (column.field == "amt2" || column.field == "amt3") {
            e.cancel = true;
        }
    }


}
function checkSettleRow(){
    var rightGrid = null;
    var firstRow = {};
    var guestId = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
    var rows = rightGrid.getSelecteds();
    var msg = "";
    var s = rows.length;
    if(s > 0){
        for(var i=0; i<s; i++){
            var row = rows[i];
            if(i == 0){
                firstRow = row;
                guestId = firstRow.guestId;
            }else{
                var rowGuestId = row.guestId;
                if(guestId != rowGuestId){
                    return "请选择相同结算单位的单据!";
                }
            }
        }

        for(var i=0; i<s; i++){
            var row = rows[i];
            var balanceSign = row.balanceSign;
            var billServiceId = row.billServiceId;
            if(name == "rpRightTab"){
                var amt1 = row.amt1||0;
                var amt2 = row.amt2||0;
                var amt3 = row.amt3||0;
                var amt4 = row.amt4||0;
                var amt11 = row.amt11||0;
                var amt12 = row.amt12||0;
                var amt13 = row.amt13||0;
                var amt14 = row.amt14||0;
                if(amt1+amt2+amt3+amt4+amt11+amt12+amt13+amt14<=0){
                    msg += "请填写业务单据："+billServiceId+ "的结算金额；</br>";
                }
            }else{
                var nowAmt = row.nowAmt || 0;
                var nowVoidAmt = row.nowVoidAmt || 0;
                if(nowAmt+nowVoidAmt<=0){
                    msg += "请填写业务单据："+billServiceId+ "的结算金额；</br>";
                }
            }
        }
    }else{
        msg = "请选择单据!";
    }

    return msg;
}
function doSettle(){
    var msg = checkSettleRow();
    if(msg){
        nui.alert(msg);
        return;
    }
    
    var rightGrid = null;
    var firstRow = {};
    var guestId = null;
    var tab = mainTabs.getActiveTab();
    var name = tab.name;
    switch (name)
    {
        case "rpRightTab":
            rightGrid = rpRightGrid;
            break;
        case "pRightTab":
            rightGrid = pRightGrid;
            break;
        case "rRightTab":
            rightGrid = rRightGrid;
            break;
        case "qRightTab":
            rightGrid = qRightGrid;
            break;
        default:
            break;
    }
        
    var rows = rightGrid.getSelecteds();
    var s = rows.length;
    if(s > 0){
        auditWin.show();

        var rtn = getRPAmount(rows);
        var guestName = rows[0].guestName;
        document.getElementById('balanceGuestName').innerHTML="对账单位："+guestName;
        document.getElementById('balanceBillCount').innerHTML="对账单据数："+s;
        document.getElementById('pAmt').innerHTML=rtn.pAmount;
        document.getElementById('rAmt').innerHTML=rtn.rAmount;

    }else{
        nui.alert("请选择单据！");
        return;
    }
}