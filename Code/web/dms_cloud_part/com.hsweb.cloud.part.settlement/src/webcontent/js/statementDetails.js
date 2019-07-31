var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var companyUrl = apiPath + sysApi + "/"+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.settle.svr.queryStatementDetails.biz.ext";
var innerPchsGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var orgidsEl =null;
var orgids="";
var rightGrid =null;
var searchBeginDate = null;
var searchEndDate = null;
var enterTypeIdHash = {1:"采购订单",2:"销售订单",3:"采购退货",4:"销售退货"};

var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var editFormPchsRtnDetail = null;
var innerPchsRtnGrid = null;
var editFormSellOutDetail = null;
var innerSellOutGrid = null;
var editFormSellRtnDetail = null;

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
    
    innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
    editFormPchsEnterDetail = document.getElementById("editFormPchsEnterDetail");
    innerPchsEnterGrid.setUrl(innerPchsGridUrl);

    innerPchsRtnGrid = nui.get("innerPchsRtnGrid");
    editFormPchsRtnDetail = document.getElementById("editFormPchsRtnDetail");
    innerPchsRtnGrid.setUrl(innerSellGridUrl);
    
    innerSellOutGrid = nui.get("innerSellOutGrid");
    editFormSellOutDetail = document.getElementById("editFormSellOutDetail");
    innerSellOutGrid.setUrl(innerSellGridUrl);
    
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
    
    quickSearch(-1);
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
	rightGrid.load({
        params:params,
        token: token
    });
}

function onRightGridDraw(e)
{
    switch (e.field)
    {
     
        case "typeCode":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value];
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
    
    //将editForm元素，加入行详细单元格内
    var td = rightGrid.getRowDetailCellEl(row);
    var rpDc = row.rpDc;    

    switch (rpDc)
    {
        case -1:
            td.appendChild(editFormPchsEnterDetail);
            editFormPchsEnterDetail.style.display = "";

            var params = {};
            params.mainId = mainId;
            innerPchsEnterGrid.load({
                params:params,
                token: token
            });
            break;
        case 1:
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
        default:
            break;
    }
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
function setInitExportData(detail,partHash){
	var pchList = partHash.pchList;
	var sellList = partHash.sellList;
	
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
//	 var serviceId = main.serviceId?main.serviceId:"";
     method5('tableExcel',"月结对账单",'tableExportA');

}
