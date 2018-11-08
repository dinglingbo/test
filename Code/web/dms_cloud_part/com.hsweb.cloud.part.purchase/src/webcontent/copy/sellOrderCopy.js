/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var bottomInfoForm = null;
var leftGrid = null;
var rightGrid = null;
var formJson = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var mainTabs = null;
var billmainTab = null;
var partInfoTab = null;
var fastPartEntryEl = null;
var FStoreId = null;

//单据状态
var AuditSignList = [
  {
      customid:'0',
      name:'未审'
  },
  {
      customid:'1',
      name:'已审'
  },
  {
      customid:'2',
      name:'已过账'
  },
  {
      customid:'3',
      name:'已取消'
  }
];
var AuditSignHash = {
  "0":"未审",
  "1":"已审",
  "2":"已过账",
  "3":"已取消"
};
$(document).ready(function(v)
{
	leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    //bottomInfoForm = new nui.Form("#bottomForm");
    fastPartEntryEl = nui.get("fastPartEntry");

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    gsparams.auditSign = 0;

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");

    mainTabs = nui.get("mainTabs");
    billmainTab = mainTabs.getTab("billmain");
    partInfoTab = mainTabs.getTab("partInfoTab");
    document.getElementById("formIframe").src=webPath + contextPath + "/common/embedJsp/containBottom.jsp";
    //document.getElementById("formIframePart").src=webPath + contextPath + "/common/embedJsp/containPartInfo.jsp";
    //document.getElementById("formIframeStock").src=webPath + contextPath + "/common/embedJsp/containStock.jsp";
    //document.getElementById("formIframePchs").src=webPath + contextPath + "/common/embedJsp/containPchsAdvance.jsp";


    $("#guestId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var storeId = nui.get("storeId");
            storeId.focus();
        }
    });
    $("#storeId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var billTypeId = nui.get("billTypeId");
            billTypeId.focus();
        }
    });
    $("#billTypeId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var settleTypeId = nui.get("settleTypeId");
            settleTypeId.focus();
        }
    });
    $("#settleTypeId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });
    $("#remark").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            fastPartEntryEl.focus();
        }
        
    });
    $("#fastPartEntry").bind("keydown", function (e) {
        //新增一条明细
        var event=e||window.e;
        var keyCode=event.keyCode||event.which;
        if(keyCode==13){
            var value = fastPartEntryEl.getValue();
            if(!value) return;
            addInsertRow(fastPartEntryEl.getValue());
        }
        
    });

    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;
      
        if((keyCode==78)&&(event.altKey))  {  //新建
            add();  
        } 
      
        if((keyCode==83)&&(event.altKey))  {   //保存
            save();
        } 
      
        if((keyCode==80)&&(event.altKey))  {   //打印
            onPrint();
        } 
     
    }

    //绑定表单
    //var db = new nui.DataBinding();
    //db.bindForm("basicInfoForm", leftGrid);
    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, null);
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        if(storehouse && storehouse.length>0){
            FStoreId = storehouse[0].id;
        }else{
            isNeedSet = true;
        }
        nui.get("storeId").setData(storehouse);
        /*var dictIdList = [];
        dictIdList.push('DDT20130703000008');//票据类型
        dictIdList.push('DDT20130703000035');//结算方式
        getDictItems(dictIdList,function(data)
        {
            if(data && data.dataItems)
            {
                var dataItems = data.dataItems||[];
                var billTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000008")
                    {
                        return true;
                    }
                });
                nui.get("billTypeId").setData(billTypeIdList);
                var settTypeIdList = dataItems.filter(function(v)
                {
                    if(v.dictid == "DDT20130703000035")
                    {
                        return true;
                    }
                });
                nui.get("settleTypeId").setData(settTypeIdList);
               
            }
        });*/
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    gsparams.auditSign = 0;
    quickSearch(0);
});
//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
    return "sell";
}
function getParentStoreId(){
    return FStoreId;
}
function loadMainAndDetailInfo(row)
{
    if(row) {    
       basicInfoForm.setData(row);
       //bottomInfoForm.setData(row);
       nui.get("guestId").setText(row.guestFullName);

       var row = leftGrid.getSelected();
       if(row.auditSign == 1) {
            document.getElementById("basicInfoForm").disabled=true;
            setBtnable(false);
            setEditable(false);
       }else {
            document.getElementById("basicInfoForm").disabled=false;
            setBtnable(true);
            setEditable(true);
       }
        
       //序列化入库主表信息，保存时判断主表信息有没有修改，没有修改则不需要保存
       formJson = nui.encode(basicInfoForm.getData());

       //加载销售订单明细表信息
       var mainId = row.id;
       loadRightGridData(mainId);
   }else {
        //form.reset();
        //grid_details.clearRows();
   }
}
function ontopTabChanged(e){
    var tab = e.tab;
    var name = tab.name;
    var url = tab.url;
    if(!url){
        if(name == "partInfoTab"){
            mainTabs.loadTab(webPath + contextPath + "/common/embedJsp/containPartInfo.jsp", tab);
        }else if(name == "partStockInfoTab"){
            mainTabs.loadTab(webPath + contextPath + "/common/embedJsp/containStock.jsp", tab);
        }else if(name == "purchaseAdvanceTab"){
            mainTabs.loadTab(webPath + contextPath + "/common/embedJsp/containPchsAdvance.jsp", tab);
        }else if(name == "billmain"){
            var guestId = nui.get("guestId");
            if(!guestId){
                guestId.focus();
            }else{
                fastPartEntryEl.focus();
            }
        }
    }
    
}
var partPriceUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.pricemanage.getSellDefaultPrice.biz.ext";
function getPartPrice(params){
    var price = 0;
    nui.ajax({
        url : partPriceUrl,
        type : "post",
        async: false,
        data : {
            params: params,
            token: token
        },
        success : function(data) {
            var errCode = data.errCode;
            if(errCode == "S"){
                var priceRecord = data.priceRecord;
                if(priceRecord.sellPrice){
                    price = priceRecord.sellPrice;
                }
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    return price;
}
function addInsertRow(value) {    
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        nui.alert("请先选择客户再添加配件!");
        return;
    }
    var params = {partCode:value};
    var part = getPartInfo(params);
    var storeId = nui.get("storeId").getValue();
    var taxSign = nui.get("taxSign").getValue();
    var taxRate = nui.get("taxRate").getValue();
    if(part){
        params.partId = part.id;
        params.guestId = guestId;
        var price = getPartPrice(params);
        var newRow = {
            partId : part.id,
            comPartCode : part.code,
            comPartName : part.name,
            comPartBrandId : part.partBrandId,
            comApplyCarModel : part.applyCarModel,
            comUnit : part.unit,
            orderQty : 1,
            storeId : storeId,
            comOemCode : part.oemCode,
            comSpec : part.spec,
            taxSign : taxSign,
            taxRate : taxRate,
            partCode : part.code,
            partName : part.name,
            fullName : part.fullName,
            systemUnitId : part.unit,
            enterUnitId : part.unit
        };
        rightGrid.addRow(newRow);
        rightGrid.beginEditCell(newRow, "orderQty");
    }
}
var partInfoUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.paramcrud.queryPartInfoByParam.biz.ext";
function getPartInfo(params){
    var part = null;
    nui.ajax({
        url : partInfoUrl,
        type : "post",
        async: false,
        data : {
            params: params,
            token: token
        },
        success : function(data) {
            var partlist = data.partlist;
            if(partlist && partlist.length>0){
                //如果只返回一条数据，直接添加；否则切换到配件选择界面按输入的条件输出
                if(partlist.length==1){
                    part = partlist[0];
                }else{
                    mainTabs.activeTab(partInfoTab);
                    mainTabs.getTabIFrameEl(partInfoTab).contentWindow.initData(params.partCode);
                }
                
            }else{
                //清空行数据
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    return part;
}
function onLeftGridSelectionChanged(){    
   var row = leftGrid.getSelected(); 
   
   loadMainAndDetailInfo(row);
} 
function onRightGridSelectionChanged(){    
    var row = rightGrid.getSelected(); 
   
    if(row){
    }else{
        row = {};
        row.guestId = null;
        row.partId = null;
        row.storeId = null;
    }
    row.guestId = nui.get('guestId').getValue();

    document.getElementById("formIframe").contentWindow.setInitEmbedParams(row);
}
function loadRightGridData(mainId)
{
    editPartHash={};
    var params = {};
    params.mainId = mainId;
    rightGrid.load({
        params:params,
        token:token
    });
}
function onLeftGridDrawCell(e)
{
    switch (e.field){
        case "auditSign":
            if(AuditSignHash && AuditSignHash[e.value])
            {
                e.cellHtml = AuditSignHash[e.value];
            }
            break;
    }
}
var currType = 2;
function quickSearch(type){
    var params = {};
    var querysign = 1;
    var queryname = "本日";
    var querytypename = "未审";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            querysign = 1;
            gsparams.startDate = getNowStartDate();
            gsparams.endDate = addDate(getNowEndDate(), 1);
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            querysign = 1;
            gsparams.startDate = getPrevStartDate();
            gsparams.endDate = addDate(getPrevEndDate(), 1);
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            querysign = 1;
            gsparams.startDate = getWeekStartDate();
            gsparams.endDate = addDate(getWeekEndDate(), 1);
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            querysign = 1;
            gsparams.startDate = getLastWeekStartDate();
            gsparams.endDate = addDate(getLastWeekEndDate(), 1);
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            querysign = 1;
            gsparams.startDate = getMonthStartDate();
            gsparams.endDate = addDate(getMonthEndDate(), 1);
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            querysign = 1;
            gsparams.startDate = getLastMonthStartDate();
            gsparams.endDate = addDate(getLastMonthEndDate(), 1);
            break;
        case 6:
            params.auditSign = 0;
            querytypename = "未审";
            querysign = 2;
            gsparams.auditSign = 0;
            break;
        case 7:
            params.auditSign = 1;
            querytypename = "已审";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 8:
            params.postStatus = 1;
            break;
        case 9:
            querytypename = "全部";
            querysign = 2;
            gsparams.auditSign = null;
            break;
        default:
        	params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querytypename = "未审";
            gsparams.startDate = getNowStartDate();
            gsparams.endDate = addDate(getNowEndDate(), 1);
            gsparams.auditSign = 0;
            break;
    }
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);
    }else if(querysign == 2){
            var menunametype = nui.get("menunametype");
            menunametype.setText(querytypename);
    }
    doSearch(gsparams);
}
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam(){
	var params = {};
    params = gsparams;
    params.guestId = nui.get("searchGuestId").getValue();
    return params;
}
function setBtnable(flag)
{
    if(flag)
    {
        //nui.get("addPartBtn").enable();
        //nui.get("editPartBtn").enable();
        //nui.get("deletePartBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("auditBtn").enable();
        //nui.get("printBtn").enable();
    }
    else
    {
        //nui.get("addPartBtn").disable();
        //nui.get("editPartBtn").disable();
        //nui.get("deletePartBtn").disable();
        nui.get("saveBtn").disable();
        nui.get("auditBtn").disable();
        //nui.get("printBtn").disable();
    }
}
function setEditable(flag)
{
    if(flag)
    {
        document.getElementById("fd1").disabled = false;
    }
    else
    {
        document.getElementById("fd1").disabled = true;
    }
}
function doSearch(params) 
{
	//目前没有区域销售订单，采退受理  params.enterTypeId = '050101';
	leftGrid.load({
		params : params,
        token : token
	}, function() {
		//onLeftGridRowDblClick({});
        var data = leftGrid.getData().length;
        if(data <= 0){
            basicInfoForm.reset();
            rightGrid.clearRows();
            
            setBtnable(false);
            setEditable(false);
            
        }else {
            var row = leftGrid.getSelected();
            if(row.auditSign == 1) {
                document.getElementById("basicInfoForm").disabled=true;
                setBtnable(false);
                setEditable(false);
            }else {
                document.getElementById("basicInfoForm").disabled=false;
                setBtnable(true);
                setEditable(true);
            }
        }
	});
}
function advancedSearch()
{
    advancedSearchWin.show();
//    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }else{
        sOrderDate.setValue(getWeekStartDate());
        eOrderDate.setValue(addDate(getWeekEndDate(), 1));
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var i;
    //订货日期
    if(searchData.sOrderDate)
    {
        searchData.sOrderDate = searchData.sOrderDate.substr(0,10);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eOrderDate;
        searchData.eOrderDate = addDate(date, 1);
        searchData.eOrderDate = searchData.eOrderDate.substr(0,10);
    }
    //创建日期
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
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = searchData.sAuditDate.substr(0,10);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        searchData.eAuditDate = searchData.eAuditDate.substr(0,10);
    }
    //供应商
    if(searchData.guestId)
    {
        params.guestId = nui.get("guestId").getValue();
    }
    //订单单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    advancedSearchFormData = advancedSearchForm.getData();
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel()
{
//    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function checkNew() 
{
    var rows = leftGrid.findRows(function(row){
        if(row.serviceId == "新销售订单") return true;
    });
    
    return rows.length;
}

function add()
{
    mainTabs.activeTab(billmainTab);

    if(checkNew() > 0) 
    {
        nui.alert("请先保存数据！");
        return;
    }

    var formJsonThis = nui.encode(basicInfoForm.getData());
    var len = rightGrid.getData().length;

    if(formJson != formJsonThis && len > 0)
    {
        nui.confirm("您正在编辑数据,是否要继续?", "友情提示",
            function (action) { 
                if (action == "ok") {

                    setBtnable(true);
                    setEditable(true);

                    basicInfoForm.reset();
                    rightGrid.clearRows();
                    
                    var newRow = { serviceId: '新销售订单', auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新销售订单");
                    nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
                    nui.get("taxRate").setValue(0.17);
                    nui.get("taxSign").setValue(1);
                    nui.get("orderDate").setValue(new Date());
                    nui.get("orderMan").setValue(currUserName);
                    
                    var guestId = nui.get("guestId");
                    guestId.focus();

                }else {
                    return;
                }
            }
        );
    }else{
        setBtnable(true);
        setEditable(true);

        basicInfoForm.reset();
        rightGrid.clearRows();
        
        var newRow = { serviceId: '新销售订单', auditSign: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新销售订单");
        nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
        nui.get("taxRate").setValue(0.17);
        nui.get("taxSign").setValue(1);
        nui.get("orderDate").setValue(new Date());
        nui.get("orderMan").setValue(currUserName);
        
        var guestId = nui.get("guestId");
        guestId.focus();
    }

    
}
function setTaxSign(billTypeId){
    switch (billTypeId) {
    case '010101':
        taxSign = 0;
        taxRate = 0.07;
        break;
    case '010102':
        taxSign = 1;
        taxRate = 0.07;
        break;
    case '010103':
        taxSign = 1;
        taxRate = 0.17;
        break;
    default:
        taxSign = 0;
        taxRate = 0.07;
        break;
    }
    nui.get("taxRate").setValue(taxRate);
    nui.get("taxSign").setValue(taxSign);
    // 税率改变后需要更新明细数据的含税价格和不含税价格
}
function onBillTypeIdChanged(e) 
{
    var billTypeId = e.value;
    var taxSign = 0;
    var taxRate = 0;
    switch (billTypeId)
    {
        case '010101':
            taxSign = 0;
            taxRate = 0.07;
            break;
        case '010102':
            taxSign = 1;
            taxRate = 0.07;
            break;
        case '010103':
            taxSign = 1;
            taxRate = 0.17;
            break;
        default:
            taxSign = 0;
            taxRate = 0.07;
            break;
    }
    nui.get("taxRate").setValue(taxRate);
    nui.get("taxSign").setValue(taxSign);
    //税率改变后需要更新明细数据的含税价格和不含税价格
    //calcTaxPriceInfo(taxSign, taxRate);
}
function calcTaxPriceInfo(taxSign, taxRate)
{
    rightGrid.findRow(function(row){
        var orderQty = row.orderQty;
        var orderPrice = row.orderPrice;
        var orderAmt = row.orderAmt;
        var noTaxPrice = 0;
        var noTaxAmt = 0;
        var taxPrice = 0;
        var taxAmt = 0;

        if (taxSign == 0) { //收据
            noTaxAmt = orderAmt;
            noTaxPrice = (orderQty > 0 ? orderAmt / orderQty : 0);
            orderPrice = (orderQty > 0 ? orderAmt / orderQty : 0);
            taxAmt = orderAmt * (1.0 + parseFloat(taxRate));
            taxPrice = orderQty > 0 ? (orderAmt / orderQty) * (1.0 + parseFloat(taxRate)) : 0;
        } else {
            taxAmt = orderAmt;
            taxPrice = (orderQty > 0 ? orderAmt / orderQty : 0);
            orderPrice = (orderQty > 0 ? orderAmt / orderQty : 0);
            noTaxAmt = orderAmt / (1.0 + parseFloat(taxRate));
            noTaxPrice = orderQty > 0 ? (orderAmt / orderQty) / (1.0 + parseFloat(taxRate)) : 0;
        }

        var newRow = {orderPrice: orderPrice, noTaxAmt: noTaxAmt, noTaxPrice: noTaxPrice, 
                      taxAmt: taxAmt, taxPrice: taxPrice, taxSign: taxSign, taxRate: taxRate};
        rightGrid.updateRow(row, newRow);
    });
}
function removeChanges(added, modified, removed, all) {
    for(var i=0; i<added.length; i++) {
    
       var val = added[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }
    
    for(var i=0; i<modified.length; i++) {
    
       var val = modified[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }
    
    for(var i=0; i<removed.length; i++) {
    
       var val = removed[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }

    return all;
}
function getMainData()
{
    var data = basicInfoForm.getData();
    //汇总明细数据到主表
    data.isFinished = 0;
    data.auditSign = 0;
    data.billStatusId = '';
    data.noTaxAmt = 0;
    data.notEnterAmt = 0;
    data.notEnterQty = 0;
    data.orderAmt = 0;
    data.orderItem = 0;
    data.orderQty = 0;
    data.printTimes = 0;
    data.taxAmt = 0;
    data.taxDiff = 0;
    var list = rightGrid.getData();
    for(var i=0;i<list.length;i++)
    {
        var tmp = list[i];
        data.noTaxAmt += parseFloat(tmp.noTaxAmt);
        data.notEnterAmt += parseFloat(tmp.orderAmt);
        data.notEnterQty += parseFloat(tmp.orderQty);
        data.orderAmt += parseFloat(tmp.orderAmt);
        data.orderQty += parseFloat(tmp.orderQty);
        data.taxAmt += parseFloat(tmp.taxAmt);
    }
    data.taxDiff = data.taxAmt - data.noTaxAmt;

    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd hh:MM') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    return data;
}
var requiredField = {
    guestId : "客户",
    orderDate : "订单日期",
	billTypeId : "票据类型",
    settleTypeId : "结算方式",
    taxRate : "开票税点",
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.savePjSellOrder.biz.ext";
function save() {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			nui.alert(requiredField[key] + "不能为空!");
			return;
		}
	}

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            nui.alert("此单已审核!");
            return;
        } 
    }else{
        return;
    }
    

    data = getMainData();
   
    /*var enterDetailAdd = rightGrid.getChanges("added")||[];
    var enterDetailUpdate = [];
    for(var key in editPartHash)
    {
        if(typeof editPartHash[key] == 'object')
        {
            enterDetailUpdate.push(editPartHash[key]);
        }
    }
    var enterDetailDelete = rightGrid.getChanges("removed")||[];
    enterDetailDelete = enterDetailDelete.filter(function(v)
    {
        return v.detailId;
    });*/

    var sellOrderDetailAdd = rightGrid.getChanges("added");
    var sellOrderDetailUpdate = rightGrid.getChanges("modified");
    var sellOrderDetailDelete = rightGrid.getChanges("removed");
    var sellOrderDetailList = rightGrid.getData();
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			sellOrderMain : data,
			sellOrderDetailAdd : sellOrderDetailAdd,
			sellOrderDetailUpdate : sellOrderDetailUpdate,
			sellOrderDetailDelete : sellOrderDetailDelete,
            sellOrderDetailList : sellOrderDetailList,
            token : token
		}),
		success : function(data) {
            nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				nui.alert("保存成功!","",function(e){
                    fastPartEntryEl.focus();
                });
				//onLeftGridRowDblClick({});
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);

                    
                }
			} else {
				nui.alert(data.errMsg || "保存失败!");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var supplier = null;	
function selectSupplier(elId)
{
	supplier = null;
    nui.open({
        targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title: "客户资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
        	if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
               
                supplier = data.customer;
                var value = supplier.id;
                var text = supplier.fullName;
                var billTypeIdV = supplier.billTypeId;
                var settTypeIdV = supplier.settTypeId;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

                if(elId == 'guestId') {
                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text};
                    leftGrid.updateRow(row,newRow);

                    nui.get("billTypeId").setValue(billTypeIdV);
                    nui.get("settleTypeId").setValue(settTypeIdV);

                    setTaxSign(billTypeIdV);
                }
            }
        }
    });
}
function onRightGridDraw(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
            if(brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        case "stockOutQty":
            if(e.value > 0)
            {
                e.cellHtml = '<a style="color:red;">' + e.value + '</a>';
            }
            break;
        case "operateBtn":
            e.cellHtml = '<span class="icon-remove" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';/*'<span class="icon-add" onClick="javascript:addPart()" title="添加行">&nbsp;&nbsp;&nbsp;&nbsp;</span>' +
                        ' <span class="icon-remove" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';*/
            break;
        default:
            break;
    }
}
//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;
    
    editor.validate();
    if (editor.isValid() == false) {
        nui.alert("请输入数字！");
        e.cancel = true;
    }else {
        var newRow = {};
        if (e.field == "orderQty") {
            var orderQty = e.value;
            var orderPrice = record.orderPrice;
            var noTaxPrice = record.noTaxPrice;
            var taxPrice = record.taxPrice;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                orderQty = 0;
            }else if(e.value < 0) {
                e.value = 0;
                orderQty = 0;
            }
            
            var orderAmt = orderQty * orderPrice;
            var noTaxAmt = orderQty * noTaxPrice; 
            var taxAmt = orderQty * taxPrice;                    
                                
            newRow = { orderAmt: orderAmt, noTaxAmt: noTaxAmt, taxAmt: taxAmt};
            rightGrid.updateRow(e.row, newRow);
            
            //record.enteramt.cellHtml = enterqty * enterprice;
        }else if (e.field == "orderPrice") {
            var orderQty = record.orderQty;
            var orderPrice = e.value;
            var taxSign = record.taxSign;
            var taxRate = record.taxRate;
            var noTaxPrice = 0;
            var taxPrice = 0;
            
            if (taxSign == 0) { //收据
                noTaxPrice = orderPrice;
                taxPrice = orderPrice * (1.0 + parseFloat(taxRate));
            } else {
                taxPrice = orderPrice;
                noTaxPrice = orderPrice / (1.0 + parseFloat(taxRate));
            }
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                orderPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                orderPrice = 0;
            }
            
            var orderAmt = orderQty * orderPrice;
            var noTaxAmt = orderQty * noTaxPrice; 
            var taxAmt = orderQty * taxPrice;  
                           
            newRow = { orderAmt: orderAmt, noTaxAmt: noTaxAmt, taxAmt: taxAmt, noTaxPrice: noTaxPrice, taxPrice: taxPrice};
            rightGrid.updateRow(e.row, newRow);

            if(orderPrice){
                rightGrid.commitEditRow(row);
                mainTabs.activeTab(billmainTab);
                fastPartEntryEl.focus();
            }
            
        }else if (e.field == "orderAmt") {
            var orderQty = record.orderQty;
            var orderAmt = e.value;
            var taxSign = record.taxSign;
            var taxRate = record.taxRate;
            var noTaxPrice = 0;
            var taxPrice = 0;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                orderAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                orderAmt = 0;
            }
            
            //e.cellHtml = enterqty * enterprice;
            var orderPrice = orderAmt*1.0/orderQty;

            if (taxSign == 0) { //收据
                noTaxPrice = orderPrice;
                taxPrice = orderPrice * (1.0 + parseFloat(taxRate));
            } else {
                taxPrice = orderPrice;
                noTaxPrice = orderPrice / (1.0 + parseFloat(taxRate));
            }

            var noTaxAmt = orderQty * noTaxPrice; 
            var taxAmt = orderQty * taxPrice;  
                          
            if(orderQty) {
                newRow = { orderPrice: orderPrice, noTaxAmt: noTaxAmt, taxAmt: taxAmt, noTaxPrice: noTaxPrice, taxPrice: taxPrice};
                rightGrid.updateRow(e.row, newRow);
            }
            
        }
    }
}
function selectPart(callback,checkcallback)
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.cloud.part.common.partSelectView.flow",
        title: "配件选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({},callback,checkcallback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function addDetail(part)
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            nui.alert(requiredField[key] + "不能为空!");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            nui.alert("此单已审核!");
            return;
        } 
    }else{
        return;
    }

    if(!guestId){
        nui.alert("请先选择客户再添加配件!");
        return;
    }

    nui.open({
        targetWindow: window,
        url: "com.hsweb.cloud.part.common.detailQPAPopOperate.flow",
        title: "销售数量金额", width: 430, height:210,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            part.storeId = nui.get("storeId").getValue();
            part.guestId = nui.get("guestId").getValue();
            iframe.contentWindow.setData({
                part:part,
                priceType : "sellOut"
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var enterDetail = {};
                enterDetail.partId = data.id;
                enterDetail.comPartCode = data.code;
                enterDetail.comPartName = data.name;
                enterDetail.comPartBrandId = data.partBrandId;
                enterDetail.comApplyCarModel = data.applyCarModel;
                enterDetail.comUnit = data.unit;
                enterDetail.orderQty = data.qty;
                enterDetail.orderPrice = data.price;
                enterDetail.orderAmt = data.amt;
                enterDetail.remark = data.remark;
                enterDetail.storeId = data.storeId;
                enterDetail.comOemCode = data.oemCode;
                enterDetail.comSpec = data.spec;
                enterDetail.partCode = data.code;
                enterDetail.partName = data.name;
                enterDetail.fullName = data.fullName;
                enterDetail.systemUnitId = data.unit; 
                enterDetail.enterUnitId = data.unit;

                rightGrid.addRow(enterDetail);
            }
        }
    });
}
function addPart() {
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

	selectPart(function(data) {
		var part = data.part;
		addDetail(part);
	},function(data) {
        var part = data.part;
        var partid = part.id;
        var rtn = checkPartIDExists(partid);
        return rtn;
    });
}
function checkPartIDExists(partid){
    var row = rightGrid.findRow(function(row){
        if(row.partId == partid) {
            return true;
        }
        return false;
    });
    
    if(row) 
    {
        return "配件编码："+row.comPartCode+"在销售订单列表中已经存在，是否继续？";
    }
    
    return null;
    
}
var editPartHash = {
};
function deletePart(){
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

    var part = rightGrid.getSelected();
    if(!part)
    {
        return;
    }
    if(part.detailId && editPartHash[part.detailId])
    {
        delete editPartHash[part.detailId];
    }
    rightGrid.removeRow(part,true);
}
function checkRightData()
{
    var msg = '';
    var rows = rightGrid.findRows(function(row){
        if(row.orderQty){
            if(row.orderQty <= 0) return true;
        }else{
            return true;
        }
        if(row.orderPrice){
            if(row.orderPrice <= 0) return true;
        }else{
            return true;
        }
        if(row.orderAmt){
            if(row.orderAmt <= 0) return true;
        }else{
            return true;
        }
        
        if(row.storeId){
        }else{
            return true;
        }
    });
    
    if(rows && rows.length > 0){
        msg = "请完善销售配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
}
function checkStockOutQty(){
    var msg = '';
    var rows = rightGrid.findRows(function(row){
        if(row.stockOutQty > 0){
            return true;
        }
    });
    
    if(rows && rows.length > 0){
        var comPartCode = rows[0].comPartCode;
        msg = "配件：" + comPartCode + "缺货，不能审核！";
    }
    return msg;
}
var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjSellOrder.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            nui.alert(requiredField[key] + "不能为空!");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            nui.alert("此单已审核!");
            return;
        } 
    }else{
        return;
    }

    //审核时，数量，单价，金额，仓库不能为空
    var msg = checkStockOutQty();
    if(msg){
        nui.alert(msg);
        return;
    }
    //审核时，判断是否存在缺货信息
    var msg = checkRightData();
    if(msg){
        nui.alert(msg);
        return;
    }

    data = getMainData();

    var sellOrderDetailAdd = rightGrid.getChanges("added");
    var sellOrderDetailUpdate = rightGrid.getChanges("modified");
    var sellOrderDetailDelete = rightGrid.getChanges("removed");
    var sellOrderDetailList = rightGrid.getData();
    if(sellOrderDetailList.length <= 0) {
        nui.alert("销售明细为空，不能审核！");
        return;
    }
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);


    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '审核中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            sellOrderMain : data,
            sellOrderDetailAdd : sellOrderDetailAdd,
            sellOrderDetailUpdate : sellOrderDetailUpdate,
            sellOrderDetailDelete : sellOrderDetailDelete,
            sellOrderDetailList : sellOrderDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("审核成功!");
                //onLeftGridRowDblClick({});
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                }
            } else {
                nui.alert(data.errMsg || "审核失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onDrawSummaryCell(e)
{
    var rows = e.data;//rightGrid.getData();
    if (e.field == "orderAmt") { 
        var orderAmt = 0;
        for (var i = 0; i < rows.length; i++) {
            orderAmt += parseFloat(rows[i].orderAmt);
        }
        nui.get("orderAmt").setValue(orderAmt);
    }
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.pny = e.value;
    params.isClient = 1;
    setGuestInfo(params);
}
var getGuestInfo = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params)
{
    nui.ajax({
        url:getGuestInfo,
        data: {params: params, token: token},
        type:"post",
        success:function(text)
        {
            if(text)
            {
                var supplier = text.suppliers;
                if(supplier && supplier.length>0) {
                    var data = supplier[0];
                    var value = data.id;
                    var text = data.fullName;
                    var el = nui.get('guestId');
                    el.setValue(value);
                    el.setText(text);

                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text};
                    leftGrid.updateRow(row,newRow);

                    var billTypeIdV = data.billTypeId;
                    var settTypeIdV = data.settTypeId;

                    nui.get("billTypeId").setValue(billTypeIdV);
                    nui.get("settleTypeId").setValue(settTypeIdV);

                    setTaxSign(billTypeIdV);
                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);

                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: null};
                    leftGrid.updateRow(row,newRow);

                    nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
                    nui.get("taxRate").setValue(0.17);
                    nui.get("taxSign").setValue(1);
                }
            }
            else
            {
                var el = nui.get('guestId');
                el.setValue(null);
                el.setText(null);

                var row = leftGrid.getSelected();
                var newRow = {guestFullName: null};
                leftGrid.updateRow(row,newRow);
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onPrint() {
    var row = leftGrid.getSelected();
    if (row) {

        nui.open({

            url : "com.hsweb.cloud.part.purchase.sellOrderPrint.flow?ID="
                    + row.id,// "view_Guest.jsp",
            title : "销售订单打印",
            width : 900,
            height : 600,
            onload : function() {
                var iframe = this.getIFrameEl();
                // iframe.contentWindow.setInitData(storeId, 'XSD');
            }
        });
    }

}