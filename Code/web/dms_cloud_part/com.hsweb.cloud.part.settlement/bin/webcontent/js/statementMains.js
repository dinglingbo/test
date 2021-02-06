var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var companyUrl = apiPath + sysApi + "/"+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
var rightGridUrl = baseUrl+"/com.hsapi.cloud.part.settle.svr.queryPJStatementList.biz.ext";
var innerOrderUrl =  baseUrl+"/com.hsapi.cloud.part.invoicing.svr.queryBillOrders.biz.ext";

var editFormOrderDetail =null;
var innerOrderGrid =null;
var orgidsEl =null; 
var orgids="";
var rightGrid =null;
var searchBeginDate = null;
var searchEndDate = null;
var enterTypeIdHash = {1:"采购订单",2:"销售订单",3:"采购退货",4:"销售退货",5:"调拨申请",6:"调拨受理",7:"调出退回",8:"调入退回"};

var brandHash = {};
var brandList = [];
var storehouse = null;
var storeHash={};

var billTypeIdHash = {};
var settTypeIdHash = {};
var billTypeIdList = [];
var settTypeIdList = [];
var billTypeIdEl = null;
var settleTypeIdEl = null;



$(document).ready(function(v) {

	
	orgidsEl = nui.get("orgids");
	getCompany();
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);  
    
    innerOrderGrid = nui.get("innerOrderGrid");
    editFormOrderDetail = document.getElementById("editFormOrderDetail");
    innerOrderGrid.setUrl(innerOrderUrl);

   
    
    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    
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
    
    quickSearch(2);
});


function getCompany(){
	var params = {};
	nui.ajax({
        url: companyUrl,
        type: 'post',
        async:false,
        data: nui.encode({
        	params: params,
            token: token
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
            	var orgList =data.companyList;
            	orgidsEl = nui.get("orgids");
                orgidsEl.setData(data.companyList);
                orgList.forEach(function(v){
                	orgids =orgids+v.orgid+","
                });
                orgids = orgids.substring(0,orgids.length-1);
            }else {
            	orgidsEl = nui.get("orgids");
                orgidsEl.setData([]);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
	});
}

function getSearchParam(){
    var params = {};

    params.sAuditDate = searchBeginDate.getFormValue();
    params.eAuditDate = searchEndDate.getFormValue();
    params.guestName =nui.get('guestName').getValue().replace(/\s+/g, "");
    params.orgid =nui.get('orgids').getValue();
    if(!params.orgid){
    	params.orgid =null;
    }
    params.auditSign =1;
    params.settleTypeId = '020502';
    params.tenantId =currTenantId;
    return params;
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
    var queryname = "全部";
    switch (type)
    {
	    case -1:
	        params.sCreateDate =  null;
	        params.eCreateDate = null;
	        var queryname = "全部";
	        break;
        case 0:
        	params.today = 1;
            params.sAuditDate = getNowStartDate();
            params.eAuditDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.sAuditDate = getPrevStartDate();
            params.eAuditDate = addDate(getPrevEndDate(), 1);
            var queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.sAuditDate = getWeekStartDate();
            params.eAuditDate = addDate(getWeekEndDate(), 1);
            var queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.sAuditDate = getLastWeekStartDate();
            params.eAuditDate = addDate(getLastWeekEndDate(), 1);
            var queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.sAuditDate = getMonthStartDate();
            params.eAuditDate = addDate(getMonthEndDate(), 1);
            var queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.sAuditDate = getLastMonthStartDate();
            params.eAuditDate = addDate(getLastMonthEndDate(), 1);
            var queryname = "上月";
            break;
        case 6:
            params.thisYear = 1;
            params.sAuditDate = getYearStartDate();
            params.eAuditDate = getYearEndDate();
            var queryname = "本年";
            break;
        case 7:
            params.lastYear = 1;
            params.sAuditDate = getPrevYearStartDate();
            params.eAuditDate = getPrevYearEndDate();
            var queryname = "上年";
            break;
        default:
            break;
    }
    searchBeginDate.setValue(params.sAuditDate);
    searchEndDate.setValue(params.eAuditDate);
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
	if(currIsMaster !=1){
		showMsg("总部才可查看","W");
		return;
	}
	rightGrid.load({
        params:params,
        token: token
    });
}

function onRightGridDraw(e)
{
    switch (e.field)
    {
     
        case "voidAmt":
            if(!e.value)
            {
                e.cellHtml = 0;
            }
            break;
       
        default:
            break;
    }
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
        case "partBrandId":
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
        default:
            break;
    }
}

function onShowRowDetail(e) {
    var row = e.record;
    var mainId = row.billMainId;
    var billMainId =row.id;
    
    //将editForm元素，加入行详细单元格内
    var td = rightGrid.getRowDetailCellEl(row);
    
	td.appendChild(editFormOrderDetail);
	editFormOrderDetail.style.display = "";

	var params = {};
	params.billMainId = billMainId;
	innerOrderGrid.load({
		params:params,
		token: token
	});
  
}

function onExport(){
	

	var detail = rightGrid.getSelecteds();
	if(detail && detail.length > 0){
		var partHash =getPartHash();
		setInitExportData(detail,partHash);
	}else{
		showMsg("请添加对账明细!","W");
	}
}
function getPartHash(){
	var partHash={};
	var detail = rightGrid.getSelecteds();
	var billMainIds="";
	var partList=[];
	for(var i=0;i<detail.length;i++){
		
		billMainIds = billMainIds +detail[i].id+","
		
	}
	$.ajaxSettings.async = false;
	if(billMainIds !=""){		
		billMainIds =billMainIds.substring(0,billMainIds.length-1);
		$.post(innerOrderUrl+"?params/billMainIds="+billMainIds+"&token="+token,{},function(text){
			partList =text.data; 
			
		});
	}
	
	partHash.partList=partList;
	return partHash;
}
function setInitExportData(detail,partHash){
	var partList = partHash.partList;
	
	var tableExportContent =  $("#tableExportContent");
	tableExportContent.empty();
	
	//单据
	var tds = '<td  colspan="1" align="left">[guestName]</td>' +
			  "<td  colspan='1' align='left'>[serviceId]</td>" +
			  "<td  colspan='1' align='left'>[rpAmt]</td>" +
			  "<td  colspan='1' align='left'>[voidAmt]</td>" +
			  "<td  colspan='1' align='left'>[trueRpAmt]</td>" +
			  "<td  colspan='1' align='left'>[rAmt]</td>" +
			  "<td  colspan='1' align='left'>[pAmt]</td>" +
			  "<td  colspan='1' align='left'>[stateMan]</td>" +
			  "<td  colspan='1' align='left'>[auditDate]</td>" +
			  "<td  colspan='1' align='left'>[remark]</td>" ;
	//配件
	var tdsp ='<td  colspan="1" align="left">[partCode]</td>' +
			  '<td  colspan="1" align="left">[fullName]</td>' +
			  "<td  colspan='1' align='left'>[oemCode]</td>" +
			  "<td  colspan='1' align='left'>[partBrand]</td>" +
			  "<td  colspan='1' align='left'>[carModel]</td>" +
			  "<td  colspan='1' align='left'>[unit]</td>" +
			  "<td  colspan='1' align='left'>[qty]</td>" +
			  "<td  colspan='1' align='left'>[price]</td>" +
			  "<td  colspan='1' align='left'>[amt]</td>" +
			  "<td  colspan='1' align='left'>[remark]</td>" ;
	for(var i=0;i<detail.length;i++){
		var row = detail[i];
		var tr0 = $("<tr></tr>");
		var tds0='<td colspan="1" align="center">往来单位</td>'+ 
				 '<td colspan="1" align="center">对账单号</td>'+ 
				 '<td colspan="1" align="center">对账金额</td>'+
				 '<td colspan="1" align="center">优惠金额</td>'+
				 '<td colspan="1" align="center">应结金额</td>'+
				 '<td colspan="1" align="center">应收金额</td>'+
				 '<td colspan="1" align="center">应付金额</td>'+
				 '<td colspan="1" align="center">业务员</td>'+
				 '<td colspan="1" align="center">审核日期</td>'+
				 '<td colspan="1" align="center">备注</td>';
		tr0.append(tds0);
		var tr1 =$("<tr></tr>");
		var tds1='<td colspan="1" align="center">配件编码</td>'+ 
				 '<td colspan="1" align="center">配件名称</td>'+
				 '<td colspan="1" align="center">OE码</td>'+
				 '<td colspan="1" align="center">品牌</td>'+
				 '<td colspan="1" align="center">品牌车型</td>'+
				 '<td colspan="1" align="center">单位</td>'+
				 '<td colspan="1" align="center">数量</td>'+
				 '<td colspan="1" align="center">单价</td>'+
				 '<td colspan="1" align="center">金额</td>'+
				 '<td colspan="1" align="center">备注</td>';
		tr1.append(tds1);
		tableExportContent.append(tr0);
		var tr = $("<tr></tr>");
		tr.append(tds.replace("[guestName]", row.guestName?row.guestName:"")
					 .replace("[serviceId]", row.serviceId?row.serviceId:"")
		             .replace("[rpAmt]", row.rpAmt?row.rpAmt:"")
		             .replace("[voidAmt]", row.voidAmt?row.voidAmt:0)
		             .replace("[trueRpAmt]", row.trueRpAmt?row.trueRpAmt:"")
		             .replace("[rAmt]", row.rAmt?row.rAmt:0)
		             .replace("[pAmt]", row.pAmt?row.pAmt:0)
		             .replace("[stateMan]", row.stateMan?row.stateMan:"")
		             .replace("[auditDate]", row.auditDate?format(row.auditDate, 'yyyy-MM-dd HH:mm:ss'):"")
		             .replace("[remark]", row.remark?row.remark:""));
		      
		tableExportContent.append(tr);
		tableExportContent.append(tr1);
		
		
		for(var j =0;j<partList.length;j++){
			var partRow =partList[j];
			if(partRow.billMainId ==row.id){
				var trp = $("<tr></tr>");
				trp.append(tdsp.replace("[partCode]", partRow.partCode?partRow.partCode:"")
							   .replace("[fullName]", partRow.fullName?partRow.fullName:"")
				               .replace("[oemCode]", partRow.oemCode?partRow.oemCode:"")
				               .replace("[partBrand]",partRow.partBrandName?partRow.partBrandName:"")
				               .replace("[carModel]", partRow.carModel?partRow.carModel :"")
				               .replace("[unit]", partRow.unit?partRow.unit:"")  
				               .replace("[qty]",partRow.orderQty?partRow.orderQty:"")
				               .replace("[price]",partRow.orderPrice?partRow.orderPrice:"")
			                   .replace("[amt]",partRow.orderAmt?partRow.orderAmt:"")
				               .replace("[remark]",partRow.remark?partRow.remark:""));
				tableExportContent.append(trp);
			}
		}
				
		
	}
//	 var serviceId = main.serviceId?main.serviceId:"";
     method5('tableExcel',"月结对账单",'tableExportA');

}
