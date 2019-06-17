/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPchsOrderMain.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPjPchsOrderDetailChkList.biz.ext";
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
var billStatusIdEl = null;
var gprows = null;
var mainTabs = null;
var sellOrderGridUrl = baseUrl + "com.hsapi.cloud.part.invoicing.ordersettle.queryNotSettlePchsRtnOrderMainList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var sellOrderGrid = null;
var editFormSellOutDetail = null;
var innerSellOutGrid = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var billStatusHash = {
    "0":"草稿",
    "1":"待发货",
    "2":"待收货",
    "4":"已入库",
    "5":"已退回",
    "6":"已关闭"
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
var billStatusIdList = [
    {id:0,name:"草稿"},
    {id:1,name:"待发货"},
    {id:2,name:"待收货"},
    {id:4,name:"已入库"},
    {id:5,name:"已退回"},
    {id:6,name:"已关闭"}
];
$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    searchServiceId = nui.get("serviceId");
    searchServiceMan = nui.get("serviceMan");
    comSearchGuestId = nui.get("searchGuestId");
    searchAccountSign = nui.get("accountSign");
    billStatusIdEl = nui.get("billStatusId");
    billStatusIdEl.setData(billStatusIdList);

    mainTabs = nui.get("mainTabs");

    innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
    editFormPchsEnterDetail = document.getElementById("editFormPchsEnterDetail");
    innerPchsEnterGrid.setUrl(innerPchsGridUrl);

    searchBeginDate.setValue(getNowStartDate());
    searchEndDate.setValue(addDate(getNowEndDate(), 1));
    nui.get('serviceId').focus();
    sellOrderGrid = nui.get("sellOrderGrid");
    innerSellOutGrid = nui.get("innerSellOutGrid");
    sellOrderGrid.setUrl("sellOrderGridUrl");
    editFormSellOutDetail = document.getElementById("editFormSellOutDetail");
    innerSellOutGrid.setUrl(innerSellGridUrl);

    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    
    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, function(){
        var billTypeIdList = nui.get("billTypeId").getData();
        var settTypeIdList = nui.get("settleTypeId").getData();
        billTypeIdList.forEach(function(v)
        {
            billTypeIdHash[v.customid] = v;
        });
        settTypeIdList.forEach(function(v)
        {
            settTypeIdHash[v.customid] = v;
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
    });
    
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;
        
        if((keyCode==13))  {  
        	onSearch();
        }
        if((keyCode==27))  {  
        	onCancel();
        }
     
    }

});
function setInitData(params){
    billStatusIdEl.setValue(2);
    comSearchGuestId.setValue(params.guestId);
    comSearchGuestId.setText(params.guestName);
    var tabs = mainTabs.getTabs();
    var type = params.type;
    if(type == 'order'){
		mainTabs.updateTab(tabs[0], {visible:true,title:""});
	}else if(type == 'sell'){
        mainTabs.updateTab(tabs[1], {visible:true,title:""});
        mainTabs.activeTab(tabs[1]);
	}else{
        mainTabs.updateTab(tabs[0], {visible:true});
        mainTabs.updateTab(tabs[1], {visible:true});
    }

    onSearch();
}
function getSearchParam(){
    var params = {};

    params.serviceId = searchServiceId.getValue().replace(/\s+/g, "");
    params.serviceMan = searchServiceMan.getValue().replace(/\s+/g, "");
    params.guestId = comSearchGuestId.getValue();
    
    params.endDate = searchEndDate.getFormValue();
    params.startDate = searchBeginDate.getFormValue();
    params.billStatusId = billStatusIdEl.getValue();
    //待收货
    if(params.billStatusId==2){
    	params.billStatusId =null;
    	params.billStatusIdList ='2,3';
    }
    return params;
}
function onSearch(){
    var tab = mainTabs.getActiveTab();
    var params = {};
    if(tab.name == "pchsOrderTab"){
        params = getSearchParam();	
    }else if(tab.name == "sellOrderTab"){
        params = getSearchParam();	
    }

    doSearch(params);
}
function doSearch(params)
{
    var tab = mainTabs.getActiveTab();
    if(tab.name == "pchsOrderTab"){
        params.sortField = "a.audit_date";
        params.sortOrder = "desc";
        params.notFinished = 0;
        params.orderTypeId = 1;
        rightGrid.load({
            params:params,
            token: token
        });	
    }else if(tab.name == "sellOrderTab"){
        var p = {};
        p.sAuditDate = searchBeginDate.getFormValue();
        p.eAuditDate = addDate(searchEndDate.getValue(), 1);
        p.serviceId = searchServiceId.getValue().replace(/\s+/g, "");
        p.orderMan = searchServiceMan.getValue().replace(/\s+/g, "");
        p.guestId = comSearchGuestId.getValue();
        p.orderTypeId = 2;
        p.isOut = 1;
        p.isFinished = billStatusIdEl.getValue();
        p.sortField = "a.audit_date";
        p.sortOrder = "desc";
        sellOrderGrid.load({
            params:p,
            token: token
        });
    }
}
var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
//        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
			var params = {
                isSupplier: 1,
                guestType:'01020202'
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
//                  e.cellHtml = partBrandIdHash[e.value].name||"";
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
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "billStatusId":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
            break;  
        case "operateBtn":
            e.cellHtml = '<a style="color:blue" onClick="javascript:updatePchsStatus()">标记入库</span>';
        break;
        default:
            break;
    }
}
function onSellDrawCell(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
        	  if(partBrandIdHash[e.value])
              {
//                  e.cellHtml = partBrandIdHash[e.value].name||"";
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
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "isFinished":
            if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
            break;
        case "operateBtn":
                e.cellHtml = '<a style="color:blue" onClick="javascript:updateSellStatus()">标记入库</span>';
        default:
            break;
    }
}
function ontopTabChanged(e){
	var tab = e.tab;
	var name = tab.name;

    if(name == "pchsOrderTab"){
        billStatusHash = {
            "0":"草稿",
            "1":"待发货",
            "2":"待收货",
            "4":"已入库",
            "5":"已退回",
            "6":"已关闭"
        };
        billStatusIdList = [
            {id:0,name:"草稿"},
            {id:1,name:"待发货"},
            {id:2,name:"待收货"},
            {id:4,name:"已入库"},
            {id:5,name:"已退回"},
            {id:6,name:"已关闭"}
        ];
        billStatusIdEl.setData(billStatusIdList);
    }else if(name == "sellOrderTab"){
        billStatusHash = {
            "0":"未入库",
            "1":"已入库"
        };
        billStatusIdList = [
            {id:0,name:"未入库"},
            {id:1,name:"已入库"}
        ];
        billStatusIdEl.setData(billStatusIdList);
        billStatusIdEl.setValue(0);
    }
	
}
function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.id;
    
    //将editForm元素，加入行详细单元格内
    var td = rightGrid.getRowDetailCellEl(row);

    td.appendChild(editFormPchsEnterDetail);
    editFormPchsEnterDetail.style.display = "";

    var params = {};
    params.mainId = mainId;
    innerPchsEnterGrid.load({
        params:params,
        token: token
    }); 
}
function onSellShowRowDetail(e) {
    var row = e.record;
    var mainId = row.id;
    
    //将editForm元素，加入行详细单元格内
    var td = sellOrderGrid.getRowDetailCellEl(row);

    td.appendChild(editFormSellOutDetail);
    editFormSellOutDetail.style.display = "";

    var params = {};
    params.mainId = mainId;
    innerSellOutGrid.load({
        params:params,
        token: token
    }); 
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
var resultData = {};
function onOk()
{
    var tab = mainTabs.getActiveTab();
	var name = tab.name;

    if(name == "pchsOrderTab"){
        var node = rightGrid.getSelected();
        if(node)
        {
        
            resultData = {
                orderMainId:node.id,
                orderServiceId:node.serviceId,
                billTypeId:node.billTypeId,
                taxSign:node.taxSign,
                taxRate:node.taxRate,
                enterDate:node.orderDate,
                orderMan:node.orderMan,
                settleTypeId:node.settleTypeId,
                guestId:node.guestId,
                fullName:node.fullName,
                type:"pchs"
            };
            //  return;
            CloseWindow("ok");
        }
    }else if(name == "sellOrderTab"){
        var node = sellOrderGrid.getSelected();
        if(node)
        {
           
            resultData = {
                orderMainId:node.id,
                orderServiceId:node.serviceId,
                billTypeId:node.billTypeId,
                taxSign:node.taxSign,
                taxRate:node.taxRate,
                enterDate:node.orderDate,
                orderMan:node.orderMan,
                settleTypeId:node.settleTypeId,
                guestId:node.guestId,
                fullName:node.guestFullName,
                type:"sell"
            };
            //  return;
            CloseWindow("ok");
        }
    }
}
function getData(){
    return resultData;
}
var upUrl = baseUrl + "com.hsapi.cloud.part.invoicing.ordersettle.updatePchsOrderStatus.biz.ext";
function updatePchsStatus(){
    var row = rightGrid.getSelected();
    if(row && row.id){
        nui.confirm("是否标记此记录为已入库?", "友情提示", function(action) {
            if (action == "ok") {
                nui.mask({
                    el : document.body,
                    cls : 'mini-mask-loading',
                    html : "处理中..."
                });

                nui.ajax({
                    url : upUrl,
                    type : "post",
                    data : JSON.stringify({
                        mainId : row.id,
                        billStatusId : 4,
                        token: token
                    }),
                    success : function(data) {
                        nui.unmask(document.body);
                        data = data || {};
                        if (data.errCode == "S") {
                            showMsg("操作成功!","S");
                            var newRow = {billStatusId:4};
                            rightGrid.updateRow(row,newRow);
                            
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
}
var usUrl = baseUrl + "com.hsapi.cloud.part.invoicing.ordersettle.updateSellOrderFinish.biz.ext";
function updateSellStatus(){
    var row = sellOrderGrid.getSelected();
    if(row && row.id){
        nui.confirm("是否标记此记录为已入库?", "友情提示", function(action) {
            if (action == "ok") {
                nui.mask({
                    el : document.body,
                    cls : 'mini-mask-loading',
                    html : "处理中..."
                });

                nui.ajax({
                    url : usUrl,
                    type : "post",
                    data : JSON.stringify({
                        mainId : row.id,
                        isFinished : 1,
                        token: token
                    }),
                    success : function(data) {
                        nui.unmask(document.body);
                        data = data || {};
                        if (data.errCode == "S") {
                            showMsg("操作成功!","S");
                            var newRow = {isFinished:1};
                            sellOrderGrid.updateRow(row,newRow);
                            
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
}