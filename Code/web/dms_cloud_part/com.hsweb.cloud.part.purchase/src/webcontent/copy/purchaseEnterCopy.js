/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterDetailList.biz.ext";
var orderGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPchsOrderMain.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPjPchsOrderDetailChkList.biz.ext";
var advancedSearchWin = null;
var advancedMorePartWin = null;
var advancedAddWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var bottomInfoForm = null;
var leftGrid = null;
var rightGrid = null;
var advancedAddForm = null;
var formJson = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var gsparams = {};
var sEnterDate = null;
var eEnterDate = null;
var mainTabs = null;
var billmainTab = null;
var notEnterOrderTab = null;
var purchaseAdvanceTab = null;
var orderGrid = null;
var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var orderBeginDate = null;
var orderEndDate = null;
var orderServiceId = null;
var orderServiceMan = null;
var morePartGrid = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldRow = null;
var isInit = false;

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
    advancedMorePartWin = nui.get("advancedMorePartWin");
    advancedAddWin = nui.get("advancedAddWin");
    morePartGrid = nui.get("morePartGrid");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    advancedAddForm  = new nui.Form("#advancedAddForm");
    //bottomInfoForm = new nui.Form("#bottomForm");
    innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
    editFormPchsEnterDetail = document.getElementById("editFormPchsEnterDetail");
    innerPchsEnterGrid.setUrl(innerPchsGridUrl);

    orderGrid = nui.get("orderGrid");
    orderGrid.setUrl(orderGridUrl);
    orderBeginDate = nui.get("orderBeginDate");
    orderEndDate = nui.get("orderEndDate");
    orderServiceId = nui.get("orderServiceId");
    orderServiceMan = nui.get("orderServiceMan");

    orderBeginDate.setValue(addDate(getNowEndDate(), -7));
    orderEndDate.setValue(getNowEndDate());

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    gsparams.auditSign = 0;

    sEnterDate = nui.get("sEnterDate");
    eEnterDate = nui.get("eEnterDate");

    mainTabs = nui.get("mainTabs");
    billmainTab = mainTabs.getTab("billmain");
    notEnterOrderTab = mainTabs.getTab("notEnterOrderTab");
    purchaseAdvanceTab = mainTabs.getTab("purchaseAdvanceTab");
    //document.getElementById("formIframePart").src=webPath + contextPath + "/common/embedJsp/containPartInfo.jsp";
    //document.getElementById("formIframeStock").src=webPath + contextPath + "/common/embedJsp/containStock.jsp";
    //document.getElementById("formIframePchs").src=webPath + contextPath + "/common/embedJsp/containPchsAdvance.jsp";
    
    $("#guestId").bind("keydown", function (e) {
        /*if (e.keyCode == 13) {
            var orderMan = nui.get("orderMan");
            orderMan.focus();
        }*/
        if (e.keyCode == 13) {
            addNewRow(true);
        }
    });

    $("#orderMan").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });
    $("#remark").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            addNewRow(true);
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
var partPriceUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.pricemanage.getPchsDefaultPrice.biz.ext";
function getPartPrice(params){
    var price = 0;
    var shelf = null;
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
                if(priceRecord.pchsPrice){
                    price = priceRecord.pchsPrice;
                }
                if(priceRecord.shelf){
                    shelf = priceRecord.shelf;
                }
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    var dInfo = {price: price, shelf: shelf};

    return dInfo;
}
function addInsertRow(value,row) {    
    var params = {partCode:value};
    var part = getPartInfo(params);
    if(part){
        params.partId = part.id;
        params.storeId = FStoreId;
        var dInfo = getPartPrice(params);
        var price = dInfo.price;
        var shelf = dInfo.shelf;
        var newRow = {
            partId : part.id,
            comPartCode : part.code,
            comPartName : part.name,
            comPartBrandId : part.partBrandId,
            comApplyCarModel : part.applyCarModel,
            comUnit : part.unit,
            enterQty : 1,
            enterPrice : price,
            enterAmt : price,
            storeShelf : shelf,
            storeId : FStoreId,
            comOemCode : part.oemCode,
            comSpec : part.spec,
            partCode : part.code,
            partName : part.name,
            fullName : part.fullName,
            systemUnitId : part.unit,
            enterUnitId : part.unit
        };

        if(row){
            rightGrid.updateRow(row,newRow);
            //rightGrid.beginEditCell(row, "enterQty");
            rightGrid.beginEditCell(row, "comUnit");
        }else{
            rightGrid.addRow(newRow);
            //rightGrid.beginEditCell(newRow, "enterQty");
            rightGrid.beginEditCell(row, "comUnit");
        }

        return true;
        
    }else{
        var newRow = {};
        if(row){
            rightGrid.updateRow(row,newRow);
            rightGrid.beginEditCell(row, "comPartCode");
        }
        return true;
    }

    return false;
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
                    advancedMorePartWin.show();
                    morePartGrid.setData(partlist);
                }
                
            }else{
                //清空行数据
                nui.alert("没有搜索到配件信息!","提示",function(){
                    var row = rightGrid.getSelected();
                    rightGrid.removeRow(row);
                    addNewRow(false);
                });
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    return part;
}
//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
    return "purchase";
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
       var data = basicInfoForm.getData();
        data.enterAmt = data.enterAmt||0;
       formJson = nui.encode(basicInfoForm.getData());

       //加载采购入库明细表信息
       var mainId = row.id;
       var mainId = row.id;
        if(!mainId){
            mainId = -1;
        }
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
        if(name == "purchaseAdvanceTab"){
            mainTabs.loadTab(webPath + contextPath + "/common/embedJsp/containPchsAdvance.jsp", tab);
        }else if(name == "billmain"){
            var data = rightGrid.getChanges();
            if(data && data.length > 0) {
                addNewRow(true);
            }else{
                add();
            }
        }else if(name == "sellOrderTab"){
            mainTabs.loadTab(webPath + contextPath + "/purchase/purchaseEnter/sellOrderReceive_view0.jsp", tab);
        }
    }else{
        if(name == "billmain"){
            var data = rightGrid.getChanges();
            if(data && data.length > 0) {
                addNewRow(true);
            }else{
                add();
            }
            
        }
    }
    
}
function onLeftGridBeforeDeselect(e)
{
    var row = leftGrid.getSelected(); 
    if(row.serviceId == '新采购入库'){

        leftGrid.removeRow(row);
    }
}
function onLeftGridSelectionChanged(e)
{    
   var row = leftGrid.getSelected(); 
   
   if(row){
        loadMainAndDetailInfo(row);
   }
   
} 
function loadRightGridData(mainId)
{
    editPartHash={};
    var params = {};
    params.mainId = mainId;
    rightGrid.load({
        params:params,
        token:token
    },function(){
        //第一次进入需要新增
        if(!isInit){
            add();
        }
        isInit = true;
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
    params.enterTypeId = '050101';
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
            querysign = 2;
            gsparams.auditSign = 0;
            break;
        case 7:
            params.auditSign = 1;
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 8:
            params.postStatus = 1;
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
    gsparams.enterTypeId = '050101';
    doSearch(gsparams);
}
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    param.enterTypeId = '050101';
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
        nui.get("saveBtn").enable();
        nui.get("auditBtn").enable();
    }
    else
    {
        nui.get("saveBtn").disable();
        nui.get("auditBtn").disable();
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
    params.enterTypeId = '050101';
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

        //第一次进入需要新增
        /*if(!isInit){
            add();
        }
        isInit = true;*/
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
        sEnterDate.setValue(getWeekStartDate());
        eEnterDate.setValue(addDate(getWeekEndDate(), 1));
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var i;
    searchData.enterTypeId = '050101';
    //订货日期
    if(searchData.sEnterDate)
    {
        searchData.sEnterDate = searchData.sEnterDate.substr(0,10);
    }
    if(searchData.eEnterDate)
    {
        var date = searchData.eEnterDate;
        searchData.eEnterDate = addDate(date, 1);
        searchData.eEnterDate = searchData.eEnterDate.substr(0,10);
    }
    //创建日期
    if(searchData.sCreateDate)
    {
        searchData.sCreateDate = formatDate(searchData.sCreateDate);
    }
    if(searchData.eCreateDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = formatDate(searchData.sAuditDate);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        
    }
    //供应商
    if(searchData.guestId)
    {
        params.guestId = nui.get("guestId").getValue();
    }
    //采购单号
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
        if(row.serviceId == "新采购入库") return true;
    });
    
    return rows.length;
}

function add()
{
    mainTabs.activeTab(billmainTab);

    if(isNeedSet){
        nui.alert("请先到仓库定义功能设置仓库!");
        return;
    }
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
                        
                        var newRow = { serviceId: '新采购入库', auditSign: 0};
                        leftGrid.addRow(newRow, 0);
                        leftGrid.clearSelect(false);
                        leftGrid.select(newRow, false);
                        
                        nui.get("serviceId").setValue("新采购入库");
                        nui.get("enterTypeId").setValue("050101");
                        nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
                        nui.get("createDate").setValue(new Date());
                        nui.get("orderMan").setValue(currUserName);
                        
                        addNewRow();

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
        
        var newRow = { serviceId: '新采购入库', auditSign: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新采购入库");
        nui.get("enterTypeId").setValue("050101");
        nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
        nui.get("createDate").setValue(new Date());
        nui.get("orderMan").setValue(currUserName);

        addNewRow();
        
        var guestId = nui.get("guestId");
        guestId.focus();
    }

}
function getMainData()
{
    var data = basicInfoForm.getData();
    //汇总明细数据到主表
    data.isFinished = 0;
    data.enterTypeId = '050101';
    data.auditSign = 0;
    data.billStatusId = '';
    data.printTimes = 0;

    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    rightGrid.findRow(function(row){
        var partId = row.partId;
        var partCode = row.comPartCode;
        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
            rightGrid.removeRow(row);
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
var requiredField = {
    guestId : "供应商",
    orderMan : "采购员",
    createDate : "入库日期",
	billTypeId : "票据类型",
    settleTypeId : "结算方式"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.savePjEnter.biz.ext";
function save() {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			nui.alert(requiredField[key] + "不能为空!");

            mainTabs.activeTab(billmainTab);
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

    //由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
    var detailData = rightGrid.getData();

    var enterDetailAdd = rightGrid.getChanges("added");
    var enterDetailUpdate = rightGrid.getChanges("modified");
    var enterDetailDelete = rightGrid.getChanges("removed");
    var enterDetailUpdate = getModifyData(detailData, enterDetailAdd, enterDetailDelete);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			enterMain : data,
			enterDetailAdd : enterDetailAdd,
			enterDetailUpdate : enterDetailUpdate,
			enterDetailDelete : enterDetailDelete,
            token : token
		}),
		success : function(data) {
            nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				nui.alert("保存成功!");
				//onLeftGridRowDblClick({});
                var pjEnterMainList = data.pjEnterMainList;
                if(pjEnterMainList && pjEnterMainList.length>0) {
                    var leftRow = pjEnterMainList[0];
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
        // targetWindow: window,
        url: webPath+contextPath+"com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1
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
        case "operateBtn":
            e.cellHtml = //'<span class="icon-remove" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
                         '<span class="fa fa-plus" onClick="javascript:addNewRow(true)" title="添加行">&nbsp;&nbsp;</span>' +
                         ' <span class="fa fa-close" onClick="javascript:deletePart()" title="删除行"></span>';
            break;
        default:
            break;
    }
}
function onCellEditEnter(e){
    var record = e.record;
    var cell = rightGrid.getCurrentCell();//行，列
    var orderPrice = record.enterPrice;
    if(cell && cell.length >= 2){
        var column = cell[1];
        if(column.field == "enterQty"){
            if(orderPrice){
                addNewKeyRow();
            }
        }else if(column.field == "enterPrice"){
            addNewKeyRow();
        }else if(column.field == "remark"){
            addNewKeyRow();
        }
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
        if (e.field == "enterQty") {
            var enterQty = e.value;
            var enterPrice = record.enterPrice;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                enterQty = 0;
            }else if(e.value < 0) {
                e.value = 0;
                enterQty = 0;
            }
            
            var enterAmt = enterQty * enterPrice;                    
                                
            newRow = { enterAmt: enterAmt};
            rightGrid.updateRow(e.row, newRow);
            
            //record.enteramt.cellHtml = enterqty * enterprice;
        }else if (e.field == "enterPrice") {
            var enterQty = record.enterQty;
            var enterPrice = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                enterPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                enterPrice = 0;
            }
            
            var enterAmt = enterQty * enterPrice;
                           
            newRow = { 
                enterAmt: enterAmt
            };
            rightGrid.updateRow(e.row, newRow);
            
        }else if (e.field == "enterAmt") {
            var enterQty = record.enterQty;
            var enterAmt = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                enterAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                enterAmt = 0;
            }
            
            var enterPrice = enterAmt*1.0/enterQty;
                          
            if(enterQty) {
                newRow = { enterPrice: enterPrice};
                rightGrid.updateRow(e.row, newRow);
            }
            
        }else if(e.field == "comPartCode"){
            oldValue = e.oldValue;
            oldRow = row;
            if(!e.value){
                nui.alert("请输入编码!","提示",function(){
                    var row = rightGrid.getSelected();
                    rightGrid.removeRow(row);
                    addNewRow(false);
                });

                return;
            }else{
                var rs = addInsertRow(e.value,row);
                if(!rs){
                    var newRow = {comPartCode: ""};
                    rightGrid.updateRow(row, newRow);
                    rightGrid.beginEditCell(row, "comPartCode");
                    return;
                }else{
                    //rightGrid.beginEditCell(row, "enterQty");
                }
            }
            

        }
    }
}
function selectPart(callback,checkcallback)
{
    nui.open({
        // targetWindow: window,
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
            //如果检测到有必填字段未填写，切换到主表界面
            mainTabs.activeTab(billmainTab);

            return;
        }
    }

    var row = leftGrid.getSelected();
    if (row) {
        if (row.auditSign == 1) {
            nui.alert("此单已审核!");
            return;
        }
    } else {
        return;
    }
    
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.detailQPAPopOperate.flow?token="+token,
        title: "入库数量金额", width: 430, height:230,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            part.storeId = FStoreId;
            part.enterTypeId = '050101';
            iframe.contentWindow.setData({
                part:part,
                priceType : "pchsIn"
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
                enterDetail.enterQty = data.qty;
                enterDetail.enterPrice = data.price;
                enterDetail.enterAmt = data.amt;
                enterDetail.remark = data.remark;
                enterDetail.storeId = data.storeId;
                enterDetail.comOemCode = data.oemCode;
                enterDetail.comSpec = data.spec;
                enterDetail.partCode = data.code;
                enterDetail.partName = data.name;
                enterDetail.fullName = data.fullName;
                enterDetail.systemUnitId = data.unit; 
                enterDetail.enterUnitId = data.unit;
                enterDetail.storeShelf = data.storeShelf;

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

    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        nui.alert("请选择供应商！");
        return;
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
        return "配件编码："+row.comPartCode+"在采购入库列表中已经存在，是否继续？";
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
        if(row.enterQty){
            if(row.enterQty <= 0) return true;
        }else{
            return true;
        }
        if(row.enterPrice){
            if(row.enterPrice <= 0) return true;
        }else{
            return true;
        }
        if(row.enterAmt){
            if(row.enterAmt <= 0) return true;
        }else{
            return true;
        }
        
        if(row.storeId){
        }else{
            return true;
        }
    });
    
    if(rows && rows.length > 0){
        msg = "请完善采购配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
}
var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjEnter.biz.ext";
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

    data = getMainData();

    //审核时，数量，单价，金额，仓库不能为空
    var msg = checkRightData();
    if(msg){
        nui.alert(msg);
        return;
    }

    //由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
    var detailData = rightGrid.getData();

    var enterDetailAdd = rightGrid.getChanges("added");
    var enterDetailUpdate = rightGrid.getChanges("modified");
    var enterDetailDelete = rightGrid.getChanges("removed");
    var enterDetailUpdate = getModifyData(detailData, enterDetailAdd, enterDetailDelete);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '审核中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            enterMain : data,
            enterDetailAdd : enterDetailAdd,
            enterDetailUpdate : enterDetailUpdate,
            enterDetailDelete : enterDetailDelete,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("审核成功!","",function(e){
                });
                //onLeftGridRowDblClick({});
                var pjEnterMainList = data.pjEnterMainList;
                if(pjEnterMainList && pjEnterMainList.length>0) {
                    var leftRow = pjEnterMainList[0];
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
    if (e.field == "enterAmt") { 
        var enterAmt = 0;
        for (var i = 0; i < rows.length; i++) {
            enterAmt += parseFloat(rows[i].enterAmt);
        }
        //nui.get("enterAmt").setValue(enterAmt);
    }
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.pny = e.value;
    params.isSupplier = 1;
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

            url : webPath+contextPath+"/com.hsweb.cloud.part.purchase.purchaseEnterPrint.flow?ID="
                    + row.id+"&token="+token,// "view_Guest.jsp",
            title : "采购入库打印",
            width : 900,
            height : 600,
            onload : function() {
                var iframe = this.getIFrameEl();
                // iframe.contentWindow.setInitData(storeId, 'XSD');
            }
        });
    }

}
function addOrderToEnter(node){

    mainTabs.activeTab(billmainTab);

    setBtnable(true);
    setEditable(true);

    basicInfoForm.reset();
    rightGrid.clearRows();
    
    var newRow = { serviceId: '新采购入库', auditSign: 0, guestFullName: node.fullName};
    leftGrid.addRow(newRow, 0);
    leftGrid.clearSelect(false);
    leftGrid.select(newRow, false);
    
    nui.get("serviceId").setValue("新采购入库");
    nui.get("codeId").setValue(node.id);
    nui.get("code").setValue(node.serviceId);
    nui.get("enterTypeId").setValue("050101");
    nui.get("billTypeId").setValue(node.billTypeId);  //010101  收据   010102  普票  010103  增票
    nui.get("settleTypeId").setValue(node.settleTypeId);
    nui.get("createDate").setValue(new Date());
    nui.get("orderMan").setValue(currUserName);
    
    var guestId = nui.get("guestId");
    guestId.setValue(node.guestId);
    guestId.setText(node.fullName);

    var params = {mainId: node.id};
    getOrderDetail(params);


    guestId.focus();



}
var orderDetailUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPjPchsOrderDetailChkList.biz.ext";
function getOrderDetail(params)
{
    params.notFinished = 0;
    nui.ajax({
        url:orderDetailUrl,
        data: {params: params, token: token},
        type:"post",
        async:false,
        success:function(text)
        {
            if(text)
            {
                var pjPchsOrderDetailList = text.pjPchsOrderDetailList;
                if(pjPchsOrderDetailList && pjPchsOrderDetailList.length>0) {
                    for(var i = 0; i<pjPchsOrderDetailList.length; i++){
                        var row = pjPchsOrderDetailList[i];

                        var enterDetail = {};
                        enterDetail.orderDetailId = row.id;
                        enterDetail.orderMainId = row.mainId;
                        enterDetail.partId = row.partId;
                        enterDetail.comPartCode = row.comPartCode;
                        enterDetail.comPartName = row.comPartName;
                        enterDetail.comPartBrandId = row.comPartBrandId;
                        enterDetail.comApplyCarModel = row.comApplyCarModel;
                        enterDetail.comUnit = row.comUnit;
                        enterDetail.enterQty = row.notEnterQty;
                        enterDetail.enterPrice = row.orderPrice;
                        enterDetail.enterAmt = parseFloat(row.notEnterQty) * parseFloat(row.orderPrice);
                        enterDetail.remark = row.remark;
                        enterDetail.storeId = row.storeId;
                        enterDetail.comOemCode = row.comOemCode;
                        enterDetail.comSpec = row.comSpec;
                        enterDetail.partCode = row.partCode;
                        enterDetail.partName = row.partName;
                        enterDetail.fullName = row.fullName;
                        enterDetail.systemUnitId = row.systemUnitId; 
                        enterDetail.enterUnitId = row.enterUnitId;
                        enterDetail.storeShelf = row.shelf;
                   
                        rightGrid.addRow(enterDetail);
                    }
                }
            }

        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

}
function onOrderDrawCell(e){
    switch (e.field)
    {
        case "comPartBrandId":
            if(brandHash && brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouse && storehouse[e.value])
            {
                e.cellHtml = storehouse[e.value].name;
            }
            break;
        default:
            break;
    }
}
function addNewRow(check){
    var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        return;
    }

    var rows = [];
    if(check){
        rows = rightGrid.findRows(function(row) {
            if (row.partId == null || row.partId == "" || row.partId == undefined)
                return true;
        });
    }

    var focusGuest = true;
    var guestId = data.guestId;
    if(guestId){
        focusGuest = false;
    }

    var newRow = {};
    if(rows && rows.length > 0){
        var row = rows[0];
        rightGrid.updateRow(row, newRow);
        if(focusGuest){
            var guestId = nui.get("guestId");
            guestId.focus();
        }else{
            rightGrid.beginEditCell(row, "comPartCode");
        }
    }else{
        rightGrid.addRow(newRow);
        if(focusGuest){
            var guestId = nui.get("guestId");
            guestId.focus();
        }else{
            rightGrid.beginEditCell(newRow, "comPartCode");
        }
    }
}
function addSelectPart(){
    var row = morePartGrid.getSelected();
    if(row){
        var params = {partCode:row.code};
        params.partId = row.id;
        params.storeId = FStoreId;
        var dInfo = getPartPrice(params);
        var price = dInfo.price;
        var shelf = dInfo.shelf;
                    
        var newRow = {
            partId : row.id,
            comPartCode : row.code,
            comPartName : row.name,
            comPartBrandId : row.partBrandId,
            comApplyCarModel : row.applyCarModel,
            comUnit : row.unit,
            enterQty : 1,
            enterPrice : price,
            enterAmt : price,
            storeId : FStoreId,
            storeShelf : shelf,
            comOemCode : row.oemCode,
            comSpec : row.spec,
            partCode : row.code,
            partName : row.name,
            fullName : row.fullName,
            systemUnitId : row.unit,
            enterUnitId : row.unit
        };

        if(rightGrid.getSelected()){
            rightGrid.updateRow(rightGrid.getSelected(),newRow);
        }else{
            rightGrid.addRow(newRow);
        }
        rightGrid.beginEditCell(rightGrid.getSelected(), "enterQty");

        advancedMorePartWin.hide();
        morePartGrid.setData([]);
    }else{
        nui.alert("请选择配件!");
        return;
    }
}
function onPartClose(){
    advancedMorePartWin.hide();
    morePartGrid.setData([]);

    var newRow = {comPartCode: oldValue};
    rightGrid.updateRow(oldRow, newRow);
    rightGrid.beginEditCell(oldRow, "comPartCode");
}
function OnrpMainGridCellBeginEdit(e){
    var field=e.field; 
    var editor = e.editor;
    var row = e.row;
    var column = e.column;
    var editor = e.editor;

    var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        e.cancel = true;
    }

}
function onOrderSearch(){
    var params = {};

    params.serviceId = orderServiceId.getValue();
    params.serviceMan = orderServiceMan.getValue();
    
    params.endDate = orderEndDate.getValue();
    params.startDate = orderBeginDate.getValue();

    params.sortField = "auditDate";
    params.sortOrder = "desc";
    params.notFinished = 0;
    orderGrid.load({
        params:params,
        token: token
    });
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.id;
    
    //将editForm元素，加入行详细单元格内
    var td = orderGrid.getRowDetailCellEl(row);

    td.appendChild(editFormPchsEnterDetail);
    editFormPchsEnterDetail.style.display = "";

    var params = {};
    params.mainId = mainId;
    innerPchsEnterGrid.load({
        params:params,
        token: token
    });

    
}
var resultData = {};
function onOrderOk()
{
    var data = rightGrid.getChanges();
    if(data && data.length>0){
        nui.confirm("您正在编辑数据,是否要继续?", "友情提示",
            function (action) { 
                if (action == "ok") {

                    var node = orderGrid.getSelected();
                    if(node){
                        addOrderToEnter(node);
                    }else{
                        nui.alert("请选择采购订单!");
                        return;
                    }

                }else {
                    return;
                }
            }
        );
    }else{
        var node = orderGrid.getSelected();
        if(node){
            addOrderToEnter(node);
        }else{
            nui.alert("请选择采购订单!");
            return;
        }
    }

}
function addMorePart(){
    var row = leftGrid.getSelected();
    if(row.auditSign == 1){
        nui.alert("此单已审核!");
        return;
    }

    var main = basicInfoForm.getData();
    if(!main.id){
        nui.alert("请先保存数据！");
        return;
    }
    var data = rightGrid.getChanges()||[];
    if (data.length>0) {
        nui.alert("请先保存数据！");
        return;
    }
    advancedAddForm.setData([]);
    advancedAddWin.show();
}

function onAdvancedAddOk(){
    var data = advancedAddForm.getData();
    var fastCodeList = nui.get("fastCodeList");
    fastCodeList.focus();
    if(data && data.fastCodeList) {
        var partList = [];
        var fastCodeList = data.fastCodeList;
        var tmpList = fastCodeList.split("\n");
        for (i = 0; i < tmpList.length; i++) {
            var partObj = {};
            partTmpList = tmpList[i].split("*")||[];
            if(partTmpList.length != 3){
                nui.alert("第"+(i+1)+"条录入信息格式有问题!");
                return;
            }

            partObj.partCode = partTmpList[0].replace(/\s+/g, "");
            partObj.orderQty = partTmpList[1];
            partObj.orderPrice = partTmpList[2];
            partList.push(partObj);
        }

        if(partList && partList.length>0){
            nui.mask({
                el : document.body,
                cls : 'mini-mask-loading',
                html : '处理中,请稍等...'
            });

            nui.ajax({
                url : baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.getPartInfoByCodes.biz.ext",
                type : "post",
                data : JSON.stringify({
                    list : partList,
                    type : 'enter',
                    storeId : FStoreId,
                    token: token
                }),
                success : function(data) {
                    nui.unmask(document.body);
                    data = data || {};
                    var rtnList = data.rtnList;
                    if (data.errCode == "S") {
                        addRtnList(rtnList);
                        var msg = data.errMsg;
                        if(msg){
                            nui.alert(msg,"",function(e){});
                        }
                        
                    } else {
                        nui.alert(data.errMsg || "添加数据失败!");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    // nui.alert(jqXHR.responseText);
                    console.log(jqXHR.responseText);
                }
            });
        }


    }else{
        nui.alert("请按格式输入信息!");
        return;
    }

    advancedAddWin.hide();
    advancedAddForm.setData([]);
}
function onAdvancedAddCancel(){
    advancedAddWin.hide();
    advancedAddForm.setData([]);
}
function addRtnList(partList){
    if(partList && partList.length>0){      
        var rows = [];
        for (var i = 0; i < partList.length; i++) {
            var part = partList[i];
            var orderQty = parseFloat(part.orderQty);
            var orderPrice = parseFloat(part.orderPrice);

            var newRow = {
                partId : part.partId,
                comPartCode : part.partCode,
                comPartName : part.partName,
                comPartBrandId : part.partBrandId,
                comApplyCarModel : part.applyCarModel,
                comUnit : part.unit,
                enterQty : orderQty,
                enterPrice : orderPrice,
                enterAmt : orderQty * orderPrice,
                storeId : FStoreId,
                storeShelf: part.shelf,
                comOemCode : part.oemCode,
                comSpec : part.spec,
                partCode : part.partCode,
                partName : part.partName,
                fullName : part.fullName,
                systemUnitId : part.unit,
                enterUnitId : part.unit
            };

            rows.push(newRow);
        }   

        rightGrid.addRows(rows);        
        
    }
}
function addNewKeyRow(){
    var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        e.cancel = true;
    }
    
    var rows = [];
    if(check){
        rows = rightGrid.findRows(function(row) {
            if (row.partId == null || row.partId == "" || row.partId == undefined)
                return true;
        });

    }

    var newRow = {};
    if(rows && rows.length > 0){
        var row = rows[0];

        rightGrid.cancelEdit(); 
        rightGrid.beginEditCell(row, "operateBtn");     

        
    }else{
        var newRow = {comPartCode:""};
        rightGrid.addRow(newRow);

        rightGrid.cancelEdit();
        //rightGrid.beginEditRow(newRow);   
        rightGrid.beginEditCell(newRow, "operateBtn");
        
    }

}