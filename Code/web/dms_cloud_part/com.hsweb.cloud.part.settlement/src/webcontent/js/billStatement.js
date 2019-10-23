/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryPJStatementList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.getPJStatementDetailById.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var innerAllotEnterGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.getAllotApplyDetail.biz.ext";
var innerAllotOutGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.getAllotAcceptDetailById.biz.ext";
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
var storeHash={};
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];
var billTypeIdEl = null;
var settleTypeIdEl = null;
var guestIdEl = null;

var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
var editFormSellOutDetail = null;
var innerSellOutGrid = null;
var editFormSellRtnDetail = null;
var innerSellRtnGrid = null;
var editFormAllotEnterDetail = null;
var innerAllotEnterGrid = null;
var editFormAllotOutDetail = null;
var innerAllotOutGrid = null;
var guestIdEl=null;
//单据状态
var AuditSignList = [
  {
      customid:'0',
      name:'未审'
  },
  {
      customid:'1',
      name:'已审'
  }
];
var AuditSignHash = {
  "0":"未审",
  "1":"已审"
};
var accountSignHash = {
    "0":"未对账",
    "1":"已对账"
};
var enterTypeIdHash = {1:"采购订单",2:"销售订单",3:"采购退货",4:"销售退货",
                       5:"调拨申请",6:"调拨受理",7:"调出退回",8:"调入退回"};

var balaTypeList=[{id:"1",name:"采购对账"},{id:"2",name:"销售对账"},{id:"3",name:"调入对账"},{id:"4",name:"调出对账"}];
$(document).ready(function(v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");

    innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
    editFormPchsEnterDetail = document.getElementById("editFormPchsEnterDetail");
    innerPchsEnterGrid.setUrl(innerPchsGridUrl);

    innerPchsRtnGrid = nui.get("innerPchsRtnGrid");
    editFormPchsRtnDetail = document.getElementById("editFormPchsRtnDetail");
    innerPchsRtnGrid.setUrl(innerSellGridUrl);

    innerAllotEnterGrid = nui.get("innerAllotEnterGrid");
    editFormAllotEnterDetail = document.getElementById("editFormAllotEnterDetail");
    innerAllotEnterGrid.setUrl(innerAllotEnterGridUrl);

    innerAllotOutGrid = nui.get("innerAllotOutGrid");
    editFormAllotOutDetail = document.getElementById("editFormAllotOutDetail");
    innerAllotOutGrid.setUrl(innerAllotOutGridUrl);
    
    sOrderDate =nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");
    
    guestIdEl=nui.get('guestId');
    guestIdEl.setUrl(getGuestInfo);
	guestIdEl.on("beforeload",function(e){
      
        var data = {};
        var params = {};
        var value = e.data.key;
        value = value.replace(/\s+/g, "");
        if(value.length<2){
            e.cancel = true;
            return;
        }
        var params = {};
    	params.pny = e.data.key.replace(/\s+/g, "");

        data.params = params;
        e.data =data;
        return;
            
       
        
    });
	innerSellOutGrid = nui.get("innerSellOutGrid");
    editFormSellOutDetail = document.getElementById("editFormSellOutDetail");
    innerSellOutGrid.setUrl(innerSellGridUrl);

/*  innerSellRtnGrid = nui.get("innerSellRtnGrid");
    editFormSellRtnDetail = document.getElementById("editFormSellRtnDetail");
    innerSellRtnGrid.setUrl(innerPchsGridUrl);*/

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    gsparams.auditSign = 0;

    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    sCreateDate = nui.get("sCreateDate");
    eCreateDate = nui.get("eCreateDate");
    guestIdEl = nui.get("guestId");

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs,function()
    {
        var billTypeIdList = billTypeIdEl.getData();
        var settTypeIdList = settleTypeIdEl.getData();
        billTypeIdList.filter(function(v)
        {
            billTypeIdHash[v.customid] = v;
            return true;
        });

        settTypeIdList.filter(function(v)
        {
            settTypeIdHash[v.customid] = v;
            return true;
        });

    });
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        if(storehouse && storehouse.length>0){
            FStoreId = storehouse[0].id;
            storehouse.forEach(function(v){
            	storeHash[v.id]=v;
            });
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
    quickSearch(8);

    $("#guestId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var voidAmt = nui.get("voidAmt");
            voidAmt.focus();
        }
    });

    $("#voidAmt").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });
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
       nui.get("guestId").setText(row.guestName);

       var row = leftGrid.getSelected();
       if(row.auditSign == 1) {
            setBtnable(false);

           document.getElementById("basicInfoForm").disabled=true;
           setEditable(false);
       }else {
            setBtnable(true);

           document.getElementById("basicInfoForm").disabled=false;
           setEditable(true);
       }
        
       //序列化入库主表信息，保存时判断主表信息有没有修改，没有修改则不需要保存
       formJson = nui.encode(basicInfoForm.getData());

       //加载销售订单明细表信息
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
function onLeftGridSelectionChanged(){    
   var row = leftGrid.getSelected(); 
   
   loadMainAndDetailInfo(row);
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
            params.auditSign = null;
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
        nui.get("addBillBtn").enable();
        nui.get("deleteBillBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("auditBtn").enable();
        nui.get("selectSupplierBtn").enable();
    }
    else
    {
        nui.get("addBillBtn").disable();
        nui.get("deleteBillBtn").disable();
        nui.get("saveBtn").disable();
        nui.get("auditBtn").disable();
        nui.get("selectSupplierBtn").disable();
        
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
    params.settleTypeId = "020502";
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
                setBtnable(false);
            }else {
                setBtnable(true);
            }
            document.getElementById("basicInfoForm").disabled=false;
            setEditable(true);
        }
    });
    //默认新增
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
    
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
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
function onRightGridDraw(e)
{
	var data= basicInfoForm.getData();
    switch (e.field)
    {
        case "comPartBrandId":
        	 if(brandHash[e.value])
             {
//                 e.cellHtml = brandHash[e.value].name||"";
             	if(brandHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
             	}else{
             		e.cellHtml = brandHash[e.value].name||"";
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
        case "typeCode":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value];
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storeHash && storeHash[e.value])
            {
                e.cellHtml = storeHash[e.value].name;
            }
            break;
        case "accountSign":
            if(accountSignHash && accountSignHash[e.value])
            {
                e.cellHtml = accountSignHash[e.value];
            }
            break;
            
        case "noStateAmt":
        	var rpAmt =parseFloat(e.record.rpAmt);
        	if(e.value<rpAmt && data.auditSign==0){
        		e.cellHtml = '<a style="color:red;">' + e.value + '</a>';
        	}
        default:
            break;
    }
}
var auditUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.auditPjStatement.biz.ext";
function audit()
{
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
        showMsg("请输入数字！","W");
        return;
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
        	showMsg("此单已审核!","W");
            return;
        } 
    }else{
        return;
    }

    var p =checkRightData();
    if (p && p.billServiceId) {
		var billServiceId = p.billServiceId;
		showMsg("业务单号:"+billServiceId+"的信息有误,请检查","W");
		return;
	}
    
    var f =checkBalaType();
    if(f==false){
    	return;
    }
    var data = getMainData();

    var stateDetailAdd = rightGrid.getChanges("added");
    for(var i=0;i<stateDetailAdd.length;i++){
    	stateDetailAdd[i].billDate=format(stateDetailAdd[i].billDate, 'yyyy-MM-dd HH:mm:ss');
    }
    var stateDetailUpdate = rightGrid.getChanges("modified");
    for(var i=0;i<stateDetailUpdate.length;i++){
    	stateDetailUpdate[i].billDate=format(stateDetailUpdate[i].billDate, 'yyyy-MM-dd HH:mm:ss');
    }
    var stateDetailDelete = rightGrid.getChanges("removed");
    for(var i=0;i<stateDetailDelete.length;i++){
    	stateDetailDelete[i].billDate=format(stateDetailDelete[i].billDate, 'yyyy-MM-dd HH:mm:ss');
    }
    var stateDetailList = rightGrid.getData();
    for(var i=0;i<stateDetailList.length;i++){
    	stateDetailList[i].billDate=format(stateDetailList[i].billDate, 'yyyy-MM-dd HH:mm:ss');
    }
    if(stateDetailList.length<=0){
        showMsg("请添加对账明细!","W");
        return;
    }

    stateDetailList = removeChanges(stateDetailAdd, stateDetailUpdate, stateDetailDelete, stateDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '审核中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            stateMain : data,
            stateDetailAdd : stateDetailAdd,
            stateDetailUpdate:stateDetailUpdate,
            stateDetailDelete : stateDetailDelete,
            stateDetailList : stateDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("审核成功!","S");                
                var leftRow = data.list[0];
                var row = leftGrid.getSelected();
                leftGrid.updateRow(row,leftRow);

                //保存成功后重新加载数据
                loadMainAndDetailInfo(leftRow);
              
                
            } else {
                showMsg(data.errMsg || "审核失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.billMainId;
    
    //将editForm元素，加入行详细单元格内
    var td = rightGrid.getRowDetailCellEl(row);
    var rpDc = row.rpDc;   
    var orderTypeId =row.typeCode; 

    switch (orderTypeId)
    {
        case "1":
        case "4":
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case "2":
        case "3":
        	//销售单
        	if(row.typeCode ==2){
        		td.appendChild(editFormSellOutDetail);
        		editFormSellOutDetail.style.display = "";

                var params = {};
                params.mainId = mainId;
                innerSellOutGrid.load({
                    params:params,
                    token: token
                });  
        	}else{
        		td.appendChild(editFormPchsRtnDetail);
                editFormPchsRtnDetail.style.display = "";

                var params = {};
                params.mainId = mainId;
                innerPchsRtnGrid.load({
                    params:params,
                    token: token
                });               
        	}
        	break;
        case "5":
        case "7":
            td.appendChild(editFormAllotEnterDetail);
            editFormAllotEnterDetail.style.display = "";

            innerAllotEnterGrid.load({
                mainId:mainId,
                token: token
            });
            break;
        case "6":
        case "8":
            td.appendChild(editFormAllotOutDetail);
            editFormAllotOutDetail.style.display = "";

            innerAllotOutGrid.load({
                mainId:mainId,
                token: token
            });
            break;
        default:
            break;
    }
}
var supplier = null;    
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title: "往来单位", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
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
                var shortName=supplier.shortName;
                var billTypeIdV = supplier.billTypeId;
                var settTypeIdV = supplier.settTypeId;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

                if(elId == 'guestId') {
                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text,guestName:shortName};
                    leftGrid.updateRow(row,newRow);

                }
            }
        }
    });
}
function checkNew() 
{
    var rows = leftGrid.findRows(function(row){
        if(row.serviceId == "新对账单") return true;
    });
    
    return rows.length;
}
function add()
{

    if(checkNew() > 0) 
    {
    	showMsg("请先保存数据！","W");
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
                    
                    var newRow = { serviceId: '新对账单', auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新对账单");
                    nui.get("createDate").setValue(new Date());
                    nui.get("stateMan").setValue(currUserName);
                    
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
        
        var newRow = { serviceId: '新对账单', auditSign: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新对账单");
        nui.get("createDate").setValue(new Date());
        nui.get("stateMan").setValue(currUserName);
        
        var guestId = nui.get("guestId");
        guestId.focus();
    }

    
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
    data.settleTypeId = "020502";
    //汇总明细数据到主表

    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }
    if(data.createDate){
    	data.createDate = format(data.createDate, 'yyyy-MM-dd HH:mm:ss'); 
    }
    return data;
}
var requiredField = {
    guestId : "往来单位",
    stateMan : "对账员",
    createDate : "对账日期",
    balaType :"对账类型"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.settle.svr.savePjStatement.biz.ext";
function save() {
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
    	showMsg("请输入数字！","W");
        return;
    }

    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
        	showMsg("此单已审核!","S");
            return;
        } 
    }else{
        return;
    }
    var p =checkRightData();
    if (p && p.billServiceId) {
		var billServiceId = p.billServiceId;
		showMsg("业务单号:"+billServiceId+"的信息有误,请检查","W");
		return;
	}
    var f =checkBalaType();
    if(f==false){
    	return;
    }
    
    data = getMainData();

    var stateDetailAdd = rightGrid.getChanges("added");
    for(var i=0;i<stateDetailAdd.length;i++){
    	stateDetailAdd[i].billDate=format(stateDetailAdd[i].billDate, 'yyyy-MM-dd HH:mm:ss');
    }
    
    var stateDetailUpdate = rightGrid.getChanges("modified");
    for(var i=0;i<stateDetailUpdate.length;i++){
    	stateDetailUpdate[i].billDate=format(stateDetailUpdate[i].billDate, 'yyyy-MM-dd HH:mm:ss');
    }
    var stateDetailDelete = rightGrid.getChanges("removed");
    for(var i=0;i<stateDetailDelete.length;i++){
    	stateDetailDelete[i].billDate=format(stateDetailDelete[i].billDate, 'yyyy-MM-dd HH:mm:ss');
    }
    var stateDetailList = rightGrid.getData();
    for(var i=0;i<stateDetailList.length;i++){
    	stateDetailList[i].billDate=format(stateDetailList[i].billDate, 'yyyy-MM-dd HH:mm:ss');
    }
    stateDetailList = removeChanges(stateDetailAdd, stateDetailUpdate, stateDetailDelete, stateDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            stateMain : data,
            stateDetailAdd : stateDetailAdd,
            stateDetailUpdate : stateDetailUpdate,
            stateDetailDelete : stateDetailDelete,
            stateDetailList : stateDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                var list = data.list;
                if(list && list.length>0) {
                    var leftRow = list[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);

                    
                }
            
                //onLeftGridRowDblClick({});
                
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function checkBalaType(){
	var balaType =nui.get('balaType').getValue();
	var data =rightGrid.getData();
	if(balaType ==1){
		for(var i=0;i<data.length;i++){
			if(data[i].typeCode !=1 || data[i].typeCode !=3){
				showMsg("明细的业务类型与对账类型不匹配","W");
				return false;
			}
		}
	}
	if(balaType ==2){
		for(var i=0;i<data.length;i++){
			if(data[i].typeCode !=2 || data[i].typeCode !=4){
				showMsg("明细的业务类型与对账类型不匹配","W");
				return false;
			}
		}
	}
	if(balaType ==3){
		for(var i=0;i<data.length;i++){
			if(data[i].typeCode !=5 || data[i].typeCode !=7){
				showMsg("明细的业务类型与对账类型不匹配","W");
				return false;
			}
		}
	}
	if(balaType ==4){
		for(var i=0;i<rows.length;i++){
			if(data[i].typeCode !=6 || data[i].typeCode !=8){
				showMsg("明细的业务类型与对账类型不匹配","W");
				return false;
			}
		}
	}
	return true;
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
//    var params = {};
//    params.pny = e.value;
//    setGuestInfo(params);
	var data = e.selected;
	var value = data.id;
    var text = data.fullName;

    var row = leftGrid.getSelected();
    var newRow = {guestName: text};
    leftGrid.updateRow(row,newRow);
    
    var data = rightGrid.getData();
    rightGrid.removeRows(data);
}

function checkRightData() {
	var msg = '';
	var amtArr =[];
	var rows = rightGrid.findRows(function(row) {
		if(row.billServiceId){
			if (row.voidAmt) {
				var rpAmt = parseFloat(row.rpAmt);
				if (row.voidAmt < 0){
					var newRow = {billServiceId: row.billServiceId};
					amtArr.push(newRow);
					return true;
				}
				if(row.voidAmt>rpAmt){
					var newRow = {billServiceId: row.billServiceId};
					amtArr.push(newRow);
					return true;
				}
			} 
			if (row.rpAmt) {
				var billAmt = parseFloat(row.billAmt);
	            var noStateAmt = parseFloat(row.noStateAmt);
				if (row.rpAmt < 0){
					var newRow = {billServiceId: row.billServiceId};
					amtArr.push(newRow);
					return true;
				}
				if(row.rpAmt>billAmt){
					var newRow = {billServiceId: row.billServiceId};
					amtArr.push(newRow);
					return true;
				}
				if(row.rpAmt>noStateAmt){
					var newRow = {billServiceId: row.billServiceId};
					amtArr.push(newRow);
					return true;
				}
			}
			
			
		}

	});

	var p = {};
	if(amtArr && amtArr.length>0){
		p.billServiceId = amtArr[0].billServiceId;
	}
	
	return p;
}

function onDrawSummaryCell(e)
{
    var rows = e.data;//rightGrid.getData();
    if (e.field == "voidAmt") { 
        var voidAmt = 0;
        for (var i = 0; i < rows.length; i++) {
        	voidAmt += parseFloat(rows[i].voidAmt*rows[i].rpDc);
        }
        var value =Math.abs(voidAmt)
        e.value=value;
        e.cellHtml =value;
    }
    
    if (e.field == "rpAmt") { 
        var rpAmt = 0;
        for (var i = 0; i < rows.length; i++) {
        	rpAmt += parseFloat(rows[i].rpAmt*rows[i].rpDc);
        }
        var value =Math.abs(rpAmt)
        e.value=value;
        e.cellHtml =value;
    }
}
function onCellCommitEdit(e){
	var editor = e.editor;
    var record = e.record;
    var row = e.row;
    
    editor.validate();
    if (editor.isValid() == false) {
    	showMsg("请输入数字！","W");
        e.cancel = true;
    }else {
        var newRow = {};
        if (e.field == "voidAmt") {
            var value = parseFloat(e.value);
            var rpAmt = parseFloat(record.rpAmt);
            
            if(e.value==null || e.value=='') {
                e.value = 0;
            }else if(e.value < 0) {
                e.value = 0;
                showMsg("请输入正整数","W");
                return;
            }else if(value>rpAmt){
        		showMsg("优惠金额不能大于对账金额","W");
        		return;
        	}
            var data =rightGrid.getData();
        	var voidAmt =0;
        	for(var i=0;i<data.length;i++){
        		var rpDc =data[i].rpDc;
        		if(data[i]==row){
        			voidAmt +=parseFloat(value*rpDc);
        		}else{
        			voidAmt+=parseFloat(data[i].voidAmt*rpDc);
        		}
        	}
        	
        	nui.get("voidAmt").setValue(Math.abs(voidAmt));
                     
            //record.enteramt.cellHtml = enterqty * enterprice;
        }else if (e.field == "rpAmt") {
        	var value = parseFloat(e.value);
            var billAmt = parseFloat(record.billAmt);
            var noStateAmt =parseFloat(record.noStateAmt);
            if(value>billAmt){
         		showMsg("对账金额不能大于单据金额","W");
         		return;
         	}
            if(value>noStateAmt){
            	showMsg("对账金额不能大于未单据金额","W");
         		return;
            }
            if(e.value==null || e.value=='') {
                e.value = 0;
            }else if(e.value < 0) {
                e.value = 0;
            }
            
            var rpAmt =0;
        	var data =rightGrid.getData();
        	for(var i=0;i<data.length;i++){
        		if(data[i]==row){
        			rpAmt +=parseFloat(value);
        		}else{
        			rpAmt +=parseFloat(data[i].rpAmt);
        		}
        		
        	}
        	nui.get("rpAmt").setValue(rpAmt);
        }
    }
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
                    var newRow = {guestName: text};
                    leftGrid.updateRow(row,newRow);

                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);

                    var row = leftGrid.getSelected();
                    var newRow = {guestName: null};
                    leftGrid.updateRow(row,newRow);
                }
            }
            else
            {
                var el = nui.get('guestId');
                el.setValue(null);
                el.setText(null);

                var row = leftGrid.getSelected();
                var newRow = {guestName: null};
                leftGrid.updateRow(row,newRow);
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addBill(){
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

    var guestId = guestIdEl.getValue();
    if(!guestId){
        showMsg("请选择往来单位!","W");
        return;
    }
    var balaType =nui.get("balaType").getValue();
    if(!balaType){
    	showMsg("请选择对账类型!","W");
    	return; 
    }
    if(balaType==1){
    	orderTypeIdList="1,3";
    }
    if(balaType ==2){
    	orderTypeIdList="2,4";
    }
    if(balaType==3){
    	orderTypeIdList="5,7";
    }
    if(balaType==4){
    	orderTypeIdList="6,8";
    }
    selectPart(guestId,orderTypeIdList,function(rows) {
        
        addDetail(rows);

    },function(serviceId) {
        var rtn = checkBillExists(serviceId);
        return rtn;
    });
}
function selectPart(guestId,orderTypeIdList,callback,checkcallback)
{
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.settlement.billServiceSelect.flow?token="+token,
        title: "业务单选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setInitData(guestId,orderTypeIdList,callback,checkcallback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function addDetail(rows)
{
    //var iframe = this.getIFrameEl();
    //var data = iframe.contentWindow.getData();
    for(var i=0; i<rows.length; i++){
        var row = rows[i];
        var newRow = {
            billMainId:row.mainId,
            billServiceId:row.serviceId,
            typeCode:row.orderTypeId,
            rpDc:row.dc,
            billAmt:row.billAmt||0,
            voidAmt:0,
            rpAmt : row.noStateAmt||0,
            noStateAmt :row.noStateAmt||0,
            billTypeId:row.billTypeId,
            settleTypeId:row.settleTypeId,
            orderMan:row.orderMan,
            billDate:row.auditDate,
            remark:row.remark,
            guestId : row.guestId,
            guestName :row.fullName
        };


        rightGrid.addRow(newRow);
        var voidAmt =parseFloat(nui.get('voidAmt').getValue())||0;
        var rpAmt =parseFloat(nui.get("rpAmt").getValue())||0;
        voidAmt +=parseFloat(newRow.voidAmt);
        rpAmt +=parseFloat(newRow.rpAmt);
        nui.get('voidAmt').setValue(voidAmt);
        nui.get('rpAmt').setValue(rpAmt);
    }

}
function checkBillExists(serviceId){
    var row = rightGrid.findRow(function(row){
        if(row.billServiceId == serviceId) {
            return true;
        }
        return false;
    });
    
    if(row) 
    {
        return "业务单"+row.billServiceId+"在对账列表中已经存在!";
    }
    
    return null;
    
}
function deleteBill(){
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

    var rows = rightGrid.getSelecteds();
    
    rightGrid.removeRows(rows);
    var data =rightGrid.getData();
    var voidAmt =0;
    var rpAmt =0;
    for(var i=0;i<data.length;i++){
    	voidAmt+=parseFloat(data[i].voidAmt);
    	rpAmt += parseFloat(data[i].rpAmt);
    }
    nui.get('voidAmt').setValue(voidAmt);
    nui.get('rpAmt').setValue(rpAmt);
   
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
            if(brandHash && brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name;
            }
            break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "enterTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value];
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storeHash && storeHash[e.value])
            {
                e.cellHtml = storeHash[e.value].name;
            }
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
function onLeftGridBeforeDeselect(e)
{
    var row = leftGrid.getSelected(); 
    if(row.serviceId == '新对账单'){

        leftGrid.removeRow(row);
    }
}

function checkNew() {
	var rows = leftGrid.findRows(function(row) {
		if (row.serviceId == "新对账单")
			return true;
	});

	return rows.length;
}

function onExport(){
	if (checkNew() > 0) {
		showMsg("请先保存数据！!","W");
		return;
	}
	var changes = rightGrid.getChanges();
	if(changes.length>0){
        var len = changes.length;
        var row = changes[0];
        if(len == 1 && !row.partId){
        }else{
		  showMsg("请先保存数据！!","W");
          return;  
        }
	}

	var main = leftGrid.getSelected();
	if(!main) return;

	var detail = nui.clone(rightGrid.getData());
	if(detail && detail.length > 0){
		var partHash =getPartHash();
		setInitExportData(main,detail,partHash);
	}else{
		showMsg("请添加对账明细!","W");
	}
}
function getPartHash(){
	var partHash={};
	var detail = nui.clone(rightGrid.getData());
	var pchMainIds ="";
	var sellMainIds ="";
	var pchList=[];
	var sellList=[];
	for(var i=0;i<detail.length;i++){
		if(detail[i].rpDc == -1){
			pchMainIds =pchMainIds +detail[i].billMainId+","
		}else{
			sellMainIds = sellMainIds +detail[i].billMainId+","
		}
		
	}
	$.ajaxSettings.async = false;
	if(pchMainIds !=""){		
		pchMainIds =pchMainIds.substring(0,pchMainIds.length-1);
		$.post(innerPchsGridUrl+"?params/mainIds="+pchMainIds+"&params/auditSign=1&token="+token,{},function(text){
			pchList =text.pjPchsOrderDetailList; 
			
		});
	}
	if(sellMainIds !=""){		
		sellMainIds =sellMainIds.substring(0,sellMainIds.length-1);
		$.post(innerSellGridUrl+"?params/mainIds="+sellMainIds+"&params/auditSign=1&token="+token,{},function(text){
			sellList =text.pjSellOrderDetailList;  	
			
		});
	}
	
	partHash.pchList=pchList;
	partHash.sellList = sellList;
	return partHash;
}
function setInitExportData(main,detail,partHash){
	var pchList = partHash.pchList;
	var sellList = partHash.sellList;
	document.getElementById("eServiceId").innerHTML = main.serviceId?main.serviceId:"";
	document.getElementById("eRemark").innerHTML = main.remark?main.remark:"";
	var tableExportContent =  $("#tableExportContent");
	tableExportContent.empty();
	
	//单据
	var tds = '<td  colspan="1" align="left">[guestName]</td>' +
			  '<td  colspan="1" align="left">[typeCode]</td>' +
			  "<td  colspan='1' align='left'>[billAmt]</td>" +
			  "<td  colspan='1' align='left'>[orderMan]</td>" +
			  "<td  colspan='1' align='left'>[billDate]</td>" +
			  "<td  colspan='1' align='left'>[remark]</td>" +
			  "<td  colspan='1' align='left'>[billServiceId]</td>" ;
	//配件
	var tdsp ='<td  colspan="1" align="left">[partCode]</td>' +
			  '<td  colspan="1" align="left">[fullName]</td>' +
			  "<td  colspan='1' align='left'>[oemCode]</td>" +
			  "<td  colspan='1' align='left'>[partBrand]</td>" +
			  "<td  colspan='1' align='left'>[carModel]</td>" +
			  "<td  colspan='1' align='left'>[unit]</td>" +
			  "<td  colspan='1' align='left'>[storeId]</td>" +
			  "<td  colspan='1' align='left'>[qty]</td>" +
			  "<td  colspan='1' align='left'>[price]</td>" +
			  "<td  colspan='1' align='left'>[amt]</td>" +
			  "<td  colspan='1' align='left'>[remark]</td>" ;
	for(var i=0;i<detail.length;i++){
		var row = detail[i];
		var tr0 = $("<tr></tr>");
		var tds0='<td colspan="1" align="center">往来单位</td>'+ 
				 '<td colspan="1" align="center">业务类型</td>'+
				 '<td colspan="1" align="center">金额</td>'+
				 '<td colspan="1" align="center">业务员</td>'+
				 '<td colspan="1" align="center">审核日期</td>'+
				 '<td colspan="1" align="center">备注</td>'+
				 '<td colspan="1" align="center">业务单号</td>';
		tr0.append(tds0);
		var tr1 =$("<tr></tr>");
		var tds1='<td colspan="1" align="center">配件编码</td>'+ 
				 '<td colspan="1" align="center">配件名称</td>'+
				 '<td colspan="1" align="center">OE码</td>'+
				 '<td colspan="1" align="center">品牌</td>'+
				 '<td colspan="1" align="center">品牌车型</td>'+
				 '<td colspan="1" align="center">单位</td>'+
				 '<td colspan="1" align="center">仓库</td>'+
				 '<td colspan="1" align="center">数量</td>'+
				 '<td colspan="1" align="center">单价</td>'+
				 '<td colspan="1" align="center">金额</td>'+
				 '<td colspan="1" align="center">备注</td>';
		tr1.append(tds1);
		tableExportContent.append(tr0);
		var tr = $("<tr></tr>");
		tr.append(tds.replace("[guestName]", row.guestName?row.guestName:"")
					 .replace("[typeCode]", row.typeCode? enterTypeIdHash[row.typeCode]:"")
		             .replace("[billAmt]", row.billAmt?row.billAmt:"")
		             .replace("[orderMan]", row.orderMan?row.orderMan:"")
		             .replace("[billDate]", row.billDate?format(row.billDate, 'yyyy-MM-dd HH:mm:ss'):"")
		             .replace("[remark]", row.remark?row.remark:"")
		             .replace("[billServiceId]", row.billServiceId?row.billServiceId:""));
		tableExportContent.append(tr);
		tableExportContent.append(tr1);
		
		//销售单
		if(row.typeCode==2){
			for(var j =0;j<sellList.length;j++){
				var sellHash =sellList[j];
				if(sellHash.mainId ==row.billMainId){
					var trp = $("<tr></tr>");
					trp.append(tdsp.replace("[partCode]", sellHash.showPartCode?sellHash.showPartCode:"")
								   .replace("[fullName]", sellHash.showFullName?sellHash.showFullName:"")
					               .replace("[oemCode]", sellHash.showOemCode?sellHash.showOemCode:"")
					               .replace("[partBrand]",sellHash.showBrandName?sellHash.showBrandName:"")
					               .replace("[carModel]", sellHash.showCarModel?sellHash.showCarModel :"")
					               .replace("[unit]", sellHash.comUnit?sellHash.comUnit:"")
					               .replace("[storeId]",storeHash[sellHash.storeId].name?storeHash[sellHash.storeId].name:"")
					               .replace("[qty]",sellHash.orderQty?sellHash.orderQty:"")
					               .replace("[price]",sellHash.showPrice?sellHash.showPrice:"")
				                   .replace("[amt]",sellHash.showAmt?sellHash.showAmt:"")
					               .replace("[remark]",sellHash.remark?sellHash.remark:""));
					tableExportContent.append(trp);
				}
			}
			
		}
		
		//其他类型
		else {
			//采购退货
			if(row.typeCode==3){
				for(var j =0;j<sellList.length;j++){
					var sellHash =sellList[j];
					if(sellHash.mainId ==row.billMainId){
						var trp = $("<tr></tr>");
						trp.append(tdsp.replace("[partCode]", sellHash.comPartCode?sellHash.comPartCode:"")
									   .replace("[fullName]", sellHash.fullName?sellHash.fullName:"")
						               .replace("[oemCode]", sellHash.comOemCode?sellHash.comOemCode:"")
						               .replace("[partBrand]",brandHash[sellHash.comPartBrandId].name?brandHash[sellHash.comPartBrandId].name:"")
						               .replace("[carModel]", sellHash.comApplyCarModel?sellHash.comApplyCarModel :"")
						               .replace("[unit]", sellHash.comUnit?sellHash.comUnit:"")
						               .replace("[storeId]",storeHash[sellHash.storeId].name?storeHash[sellHash.storeId].name:"")
						               .replace("[qty]",sellHash.orderQty?sellHash.orderQty:"")
						               .replace("[price]",sellHash.orderPrice?sellHash.orderPrice:"")
					                   .replace("[amt]",sellHash.orderAmt?sellHash.orderAmt:"")
						               .replace("[remark]",sellHash.remark?sellHash.remark:""));
						tableExportContent.append(trp);
					}
				}
			}else{
				for(var j =0;j<pchList.length;j++){
					var pchHash =pchList[j];
					if(pchHash.mainId ==row.billMainId){
						var trp = $("<tr></tr>");
						trp.append(tdsp.replace("[partCode]", pchHash.comPartCode?pchHash.comPartCode:"")
									   .replace("[fullName]", pchHash.fullName?pchHash.fullName:"")
						               .replace("[oemCode]", pchHash.comOemCode?pchHash.comOemCode:"")
						               .replace("[partBrand]",brandHash[pchHash.comPartBrandId].name?brandHash[pchHash.comPartBrandId].name:"")
						               .replace("[carModel]", pchHash.comApplyCarModel?pchHash.comApplyCarModel :"")
						               .replace("[unit]", pchHash.comUnit?pchHash.comUnit:"")
						               .replace("[storeId]",storeHash[pchHash.storeId].name?storeHash[pchHash.storeId].name:"")
						               .replace("[qty]",pchHash.orderQty?pchHash.orderQty:"")
						               .replace("[price]",pchHash.orderPrice?pchHash.orderPrice:"")
					                   .replace("[amt]",pchHash.orderAmt?pchHash.orderAmt:"")
						               .replace("[remark]",pchHash.remark?pchHash.remark:""));
						tableExportContent.append(trp);
					}
				}
			}
		}
			
	}
	 var serviceId = main.serviceId?main.serviceId:"";
     method5('tableExcel',"月结对账"+"-"+main.guestName+"-"+serviceId,'tableExportA');

}

var backAuditUrl =baseUrl+"com.hsapi.cloud.part.settle.svr.backAuditStatement.biz.ext";
function backAudit(){

	var data = getMainData();
	if(data.auditSign!=1){
		showMsg("订单未审，不能反审核","W");
		return;
	}
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '反审核中...'
    });

    nui.ajax({
        url : backAuditUrl,
        type : "post",
        data : JSON.stringify({
            id : data.id,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("反审核成功!","S");
                var leftRow = data.list[0];
                var row = leftGrid.getSelected();
                leftGrid.updateRow(row,leftRow);
                loadMainAndDetailInfo(leftRow);    
            } else {
                showMsg(data.errMsg || "反审核失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
