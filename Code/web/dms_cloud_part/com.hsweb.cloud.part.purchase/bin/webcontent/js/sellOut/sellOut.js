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

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    gsparams.isOut = 0;

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");

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

    gsparams.isOut = 0;
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
       if(row.isOut == 1) {
            setBtnable(false);
       }else {
            setBtnable(true);
       }
       document.getElementById("basicInfoForm").disabled=false;
       setEditable(false);
        
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
    var querytypename = "未出库";
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
            params.isOut = 0;
            querytypename = "未出库";
            querysign = 2;
            gsparams.isOut = 0;
            break;
        case 7:
            params.isOut = 1;
            querytypename = "已出库";
            querysign = 2;
            gsparams.isOut = 1;
            break;
        case 8:
            params.postStatus = 1;
            break;
        default:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querytypename = "未出库";
            gsparams.startDate = getNowStartDate();
            gsparams.endDate = addDate(getNowEndDate(), 1);
            gsparams.isOut = 0;
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
        nui.get("unAuditBtn").enable();
        nui.get("auditBtn").enable();
        nui.get("selectSupplierBtn").enable();
        //nui.get("printBtn").enable();
    }
    else
    {
        nui.get("unAuditBtn").disable();
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
    params.auditSign = 1;
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
            if(row.isOut == 1) {
                setBtnable(false);
            }else {
                setBtnable(true);
            }
            document.getElementById("basicInfoForm").disabled=false;
            setEditable(false);
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
        searchData.sOrderDate = formatDate(searchData.sOrderDate);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eOrderDate;
        searchData.eOrderDate = addDate(date, 1);
//        searchData.eOrderDate = searchData.eOrderDate.substr(0,10);
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
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/(^\s*)|(\s*$)/g, "")+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
  //去除空格
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/(^\s*)|(\s*$)/g, "");
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
    switch (e.field)
    {
        case "comPartBrandId":
        	if(brandHash[e.value])
            {
//                e.cellHtml = brandHash[e.value].name||"";
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
        case "stockOutQty":
            if(e.value > 0)
            {
                e.cellHtml = '<a style="color:red;">' + e.value + '</a>';
            }
            break;
        default:
            break;
    }
}
var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditSellOrderToOutTran.biz.ext";
function audit()
{

    var row = leftGrid.getSelected();
    if(row){
        if(row.isOut == 1) {
            showMsg("此单已出库!","W");
            return;
        } 
    }else{
        return;
    }

    var data = basicInfoForm.getData();
    var mainId = data.id;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '审核中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            mainId : mainId,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("审核成功!","S");
                var newRow = {isOut: 1};
                leftGrid.updateRow(row, newRow);

                setBtnable(false);
                
            } else {
                showMsg(data.errMsg || "审核失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var unAuditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.unAuditSellOrderToOut.biz.ext";
function unAudit()
{

    var row = leftGrid.getSelected();
    if(row){
        if(row.isOut == 1) {
            showMsg("此单已出库!","W");
            return;
        } 
    }else{
        return;
    }

    var data = basicInfoForm.getData();
    var mainId = data.id;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '返单中...'
    });

    nui.ajax({
        url : unAuditUrl,
        type : "post",
        data : JSON.stringify({
            mainId : mainId,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("返单成功!","S");
                leftGrid.removeRow(row, true);

                setBtnable(false);
                
            } else {
                showMsg(data.errMsg || "审核失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onPrint() {
    var row = leftGrid.getSelected();
    if (row) {

        var orderTypeId = row.orderTypeId;
        if(orderTypeId == 2){
            nui.open({

                url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.sellOrderOutPrint.flow?ID="
                        + row.id+"&printMan="+currUserName,// "view_Guest.jsp",
                title : "销售单打印",
                width : 900,
                height : 600,
                onload : function() {
                    var iframe = this.getIFrameEl();
                    // iframe.contentWindow.setInitData(storeId, 'XSD');
                }
            });
        }else if(orderTypeId == 3){
            nui.open({

                url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.pchsOrderRtnPrint.flow?ID="
                        + row.id+"&printMan="+currUserName,// "view_Guest.jsp",
                title : "采购退货打印",
                width : 900,
                height : 600,
                onload : function() {
                    var iframe = this.getIFrameEl();
                    // iframe.contentWindow.setInitData(storeId, 'XSD');
                }
            });
        }


    }

}

