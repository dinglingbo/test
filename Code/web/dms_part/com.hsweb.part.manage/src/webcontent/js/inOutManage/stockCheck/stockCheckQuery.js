/**
 * Created by Administrator on 2018/2/1.
 */
var baseUrl = apiPath +partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.query.queryPjStockCheckMainDetailList.biz.ext";
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
var orgidsEl = null;
$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("load", function () {
        rightGrid.mergeColumns(["serviceId"]);
    });
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
 	comPartNameAndPY = nui.get("partNameAndPY");
	comPartCode = nui.get("partCode");
	comServiceId = nui.get("serviceId");
	comSearchGuestId = nui.get("searchGuestId");
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }

    //console.log("xxx");
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // F9
            onSearch();
        }
    }
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

    quickSearch(currType);
});
function getSearchParam(){
    var params = {};
    /*var outableQtyGreaterThanZero = nui.get("outableQtyGreaterThanZero").getValue();
    if(outableQtyGreaterThanZero == 1)
    {
        params.outableQtyGreaterThanZero = 1;
    }*/
    params.serviceId = comServiceId.getValue();
	params.partCode = comPartCode.getValue();
	params.partNameAndPY = comPartNameAndPY.getValue();
	params.guestId = comSearchGuestId.getValue();
	params.endDate = searchEndDate.getValue();
	params.startDate = addDate(searchBeginDate.getValue(),1);
	 var orgidsElValue = orgidsEl.getValue();
	    if(orgidsElValue==null||orgidsElValue==""){
	    	 params.orgids =  currOrgs;
	    }else{
	    	params.orgid=orgidsElValue;
	    }

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
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.startDate);
    searchEndDate.setValue(addDate(params.endDate,-1));
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
	params.sortField = "audit_date";
	params.sortOrder = "desc";
    rightGrid.load({
        params:params,
        token:token
    },function(){
        rightGrid.mergeColumns(["serviceId"]);
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
        searchData.guestId = nui.get("btnEdit2").getValue();
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
    /*if(searchData.outableQtyGreaterThanZero == 0)
    {
        delete searchData.outableQtyGreaterThanZero;
    }*/
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "客户资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1,
                guestType:'01020102'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
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
	    case "serviceId":
			e.cellHtml ='<a href="##" onclick="edit()">'+e.value+'</a>';
			break;
	    case "partBrandId":
	    	 if(partBrandIdHash[e.value])
             {
//                 e.cellHtml = partBrandIdHash[e.value].name||"";
             	if(partBrandIdHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' weight=' '/><br> "+partBrandIdHash[e.value].name||"";
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
        case "dc":
            if(e.value == -1)
            {
                e.cellHtml = '<a style="color:red;">盘亏</a>';
            }
            if(e.value == 0)
            {
                e.cellHtml = '无盈亏';
            }
            if(e.value == 1)
            {
                e.cellHtml = '<a style="color:orange;">盘盈</a>';
            }
            break;
        case  "orgid":
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName || "";
        		}
        	}
    	break; 

        default:
            break;
    }
}

function edit(){
    var row = rightGrid.getSelected();
    if(!row) return; 
    var item={};
    item.id = "6400";
    item.text = "盘点单详情";
    item.url = webPath + contextPath + "/com.hsweb.part.manage.stockCheck.flow";
    item.iconCls = "fa fa-file-text";
    //window.parent.activeTab(item);
    var params = row; 
    window.parent.activeTabAndInit(item,params);
}

function onExport(){
	

	var detail = rightGrid.getData();
	
	for(var i=0;i<detail.length;i++){
		for(var j in storehouseHash) {
			if(detail[i].storeId ==storehouseHash[j].id ){
				detail[i].storeId=storehouseHash[j].name;
			}
		}
		for(var j in partBrandIdHash) {
			if(detail[i].partBrandId ==partBrandIdHash[j].id ){
				detail[i].partBrandId=partBrandIdHash[j].name;
			}
		}		
		if(detail[i].dc==""){
			detail[i].dc="无盈亏";
		}else if(detail[i].dc==1){
			detail[i].dc="盘盈";
		}else if(detail[i].dc==-1){
			detail[i].dc="盘亏";
		}
	}
	if(detail && detail.length > 0){
		setInitExportData( detail);
	}
	
}

function setInitExportData( detail){

    var tds = '<td  colspan="1" align="left">[serviceId]</td>' +
        "<td  colspan='1' align='left'>[createDate]</td>" +
        "<td  colspan='1' align='left'>[orderMan]</td>" +
        "<td  colspan='1' align='left'>[storeId]</td>" +
        "<td  colspan='1' align='left'>[comPartCode]</td>" +       
        "<td  colspan='1' align='left'>[comPartName]</td>" +
        
        "<td  colspan='1' align='left'>[comOemCode]</td>" +
        "<td  colspan='1' align='left'>[partBrandId]</td>" +
        "<td  colspan='1' align='left'>[applyCarModel]</td>" +
        
        "<td  colspan='1' align='left'>[enterUnitId]</td>" +
        "<td  colspan='1' align='left'>[sysQty]</td>" +
        "<td  colspan='1' align='left'>[trueQty]</td>"+
        "<td  colspan='1' align='left'>[exhibitQty]</td>"+
        "<td  colspan='1' align='left'>[exhibitPrice]</td>"+
        "<td  colspan='1' align='left'>[exhibitAmt]</td>"+      
        "<td  colspan='1' align='left'>[dc]</td>" +
        "<td  colspan='1' align='left'>[detailRemark]</td>" +
        "<td  colspan='1' align='left'>[auditor]</td>" +
        "<td  colspan='1' align='left'>[auditDate]</td>" +                     
        "<td  colspan='1' align='left'>[partId]</td>";
        
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.id){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[serviceId]", detail[i].serviceId?detail[i].serviceId:"")
                         .replace("[createDate]", nui.formatDate(detail[i].createDate?detail[i].createDate:"",'yyyy-MM-dd HH:mm'))
                         .replace("[orderMan]", detail[i].orderMan?detail[i].orderMan:"")
                         .replace("[storeId]", detail[i].storeId?detail[i].storeId:"")
                         .replace("[comPartCode]", detail[i].comPartCode?detail[i].comPartCode:"")
                         //.replace("[collectMoneyDate]", nui.formatDate(detail[i].collectMoneyDate?detail[i].collectMoneyDate:"",'yyyy-MM-dd HH:mm'))
                         
                         .replace("[comPartName]", detail[i].comPartName?detail[i].comPartName:"")                       
                         .replace("[comOemCode]", detail[i].comOemCode?detail[i].comOemCode:"")
                         .replace("[partBrandId]", detail[i].partBrandId?detail[i].partBrandId:"") 
                         
                         .replace("[applyCarModel]", detail[i].applyCarModel?detail[i].applyCarModel:"")                        
                         .replace("[enterUnitId]", detail[i].enterUnitId?detail[i].enterUnitId:"")
                         .replace("[sysQty]", detail[i].sysQty?detail[i].sysQty:"")
                         
                         .replace("[trueQty]", detail[i].trueQty?detail[i].trueQty:"")
                         .replace("[exhibitQty]", detail[i].exhibitQty?detail[i].exhibitQty:"")
                         .replace("[exhibitPrice]", detail[i].exhibitPrice?detail[i].exhibitPrice:"")
                         .replace("[exhibitAmt]", detail[i].exhibitAmt?detail[i].exhibitAmt:"")
                         
                         .replace("[dc]", detail[i].dc?detail[i].dc:"")  
                         .replace("[detailRemark]", detail[i].detailRemark?detail[i].detailRemark:"")                         
                         .replace("[auditor]", detail[i].auditor?detail[i].auditor:"")
                         .replace("[auditDate]", nui.formatDate(detail[i].auditDate?detail[i].auditDate:"",'yyyy-MM-dd HH:mm'))                          
                         .replace("[partId]", detail[i].partId?detail[i].partId:""));
            tableExportContent.append(tr);
        }
    }

 
    method5('tableExcel',"盘点单明细表导出",'tableExportA');
}