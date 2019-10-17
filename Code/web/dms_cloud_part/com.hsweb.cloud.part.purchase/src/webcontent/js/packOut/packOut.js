/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.getPjPackDetailByBillMainId.biz.ext";
var innerSellGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
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
var payTypeHash={};
var payTypeList=[];
var payTypeEl=null;
var billTypeIdEl = null;
var settleTypeIdEl = null;
var guestIdEl = null;
var receiveManEl = null;
var receiveManTelEl = null;
var addressEl = null;
var receiveCompNameEl = null;
var provinceIdEl = null;
var cityIdEl = null;
var countyIdEl = null;
var streetAddressEl = null;

var editFormSellOutDetail = null;
var innerSellOutGrid = null;
var guestIdEl=null;
var logisticsGuestIdEl=null;
var transitLogisticsIdEl=null;
var isWoodenList=[{id:'0',name:'否' }, { id:'1',name:'是' }];
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
var billStatusHash={
	"2"	 :"已出库",
	"3"	 :"已打包",
	"4"	 :"已发货",
	"5"	 :"已到货"
};
var enterTypeIdHash = {"050101":"采购入库","050102":"销售退货","050201":"采购退货","050202":"销售出库"};

$(document).ready(function(v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");

    innerSellOutGrid = nui.get("innerSellOutGrid");
    editFormSellOutDetail = document.getElementById("editFormSellOutDetail");
    innerSellOutGrid.setUrl(innerSellGridUrl);
    
    getProvinceAndCity(function(data) {
    	nui.get('destinationStation').setData(cityList);
    	nui.get('transferStation').setData(cityList);
    	nui.get('senderCity').setData(cityList);
	});
    
    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
//    gsparams.auditSign = 0;
    guestIdEl=nui.get('guestId');
    guestIdEl.setUrl(getGuestInfo);
    logisticsGuestIdEl=nui.get('logisticsGuestId');
    logisticsGuestIdEl.setUrl(getGuestInfo);
    transitLogisticsIdEl=nui.get("transitLogisticsId");
    transitLogisticsIdEl.setUrl(getGuestInfo);
    
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
    	params.icClient = 1;

        data.params = params;
        e.data =data;
        return; 
        
    });
	
	logisticsGuestIdEl.on("beforeload",function(e){
      
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
    	params.isSupplier = 1;
    	params.guestType='01020204',
    	params.isDisabled=0;
        data.params = params;
        e.data =data;
        return; 
        
    });
    
	transitLogisticsIdEl.on("beforeload",function(e){
	      
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
    	params.isSupplier = 1;
    	params.guestType='01020204',
    	params.isDisabled=0;
        data.params = params;
        e.data =data;
        return; 
        
    });
	
    billTypeIdEl = nui.get("billTypeId");
    settleTypeIdEl = nui.get("settleTypeId");
    payTypeEl =nui.get("payType");
    sCreateDate = nui.get("sCreateDate");
    eCreateDate = nui.get("eCreateDate");
    guestIdEl = nui.get("guestId");
    receiveManEl = nui.get("receiveMan");
    receiveManTelEl = nui.get("receiveManTel");
    addressEl = nui.get("address");
    receiveCompNameEl = nui.get("receiveCompName");
    provinceIdEl = nui.get("provinceId");
    cityIdEl = nui.get("cityId");
    countyIdEl = nui.get("countyId");
    streetAddressEl = nui.get("streetAddress");

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035","payType":"10221"};
    initDicts(dictDefs,function()
    {
        var billTypeIdList = billTypeIdEl.getData();
        var settTypeIdList = settleTypeIdEl.getData();
        var payTypeList = payTypeEl.getData();
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
        payTypeList.filter(function(v)
        {
        	payTypeHash[v.customid] = v;
            return true;
        });

    });
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        if(storehouse && storehouse.length>0){
            storehouse.forEach(function(v) {
                storeHash[v.id] = v;
            });
        }
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

//    gsparams.auditSign = 0;
    quickSearch(9);
});
//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
    return "sell";
}
function getParentStoreId(){
    return FStoreId;
}
//function loadMainAndDetailInfo(row)
//{
//    if(row) {    
//       basicInfoForm.setData(row);
//       //bottomInfoForm.setData(row);
//       nui.get("guestId").setText(row.guestName);
//       nui.get("logisticsGuestId").setText(row.logisticsName);
//
//       var row = leftGrid.getSelected();
//       if(row.auditSign == 1) {
////            setBtnable(false);
//
//           //document.getElementById("basicInfoForm").disabled=true;
////           setEditable(false);
//       }else {
////           setBtnable(true);
//
//           //document.getElementById("basicInfoForm").disabled=false;
////           setEditable(true);
//       }
//
//       getLogistics(row.guestId,function(data) {
//            var list = data.list || [];
//            receiveManEl.setData(list);
//
//        }); 
//        
//       //序列化入库主表信息，保存时判断主表信息有没有修改，没有修改则不需要保存
//       formJson = nui.encode(basicInfoForm.getData());
//
//       //加载销售订单明细表信息
//       var mainId = row.id;
//        if(!mainId){
//            mainId = -1;
//        }
//       loadRightGridData(mainId);
//   }else {
//        //form.reset();
//        //grid_details.clearRows();
//   }
//}
function onLeftGridSelectionChanged(){ 
   
   var rows = leftGrid.getSelecteds(); 
   if(rows.length<=0)return;
   if(rows.length==1){
	   nui.get("guestId").setText(null);
	   nui.get("logisticsGuestId").setText(null);
	   nui.get("transitLogisticsId").setText(null);
   }
   var billStatusId=rows[0].billStatusId;
   var guestId=rows[0].guestId;
   var billMainId=rows[0].id;
   var guestShortName =rows[0].guestShortName;
   
   
   var existGuestRows= rows.filter(function(v){
	   if(v.guestId !=guestId){
		   return true;
		  
	   }
   });
   
   var exitbillStatusId = rows.filter(function(v){
	   if(v.billStatusId !=billStatusId){
		   return true;		  
	   }
   });
  if(existGuestRows.length>0){
	  showMsg("客户不一致,不能一起勾选","W");
	  leftGrid.deselects(existGuestRows); 
	  return;
  }
  //已出库
   if(billStatusId==2){
	   setBtnable(true);
	   
	   if(exitbillStatusId.length>0){
			  showMsg("销售单状态不一致，不能一起勾选","W");
			  leftGrid.deselects(exitbillStatusId); 
			  return;
		  }
	   var amt=0;
	   for(var i=0;i<rows.length;i++){
		   amt+=rows[i].orderAmt;
	   }
	   nui.get("packMan").setValue(currUserName);
	   nui.get("senderAddress").setValue(currCompAddress);
	   nui.get("collectMoney").setValue(amt);
	   nui.get("valuationStatement").setValue(amt);
	   
//	   basicInfoForm.setData({});
	   setEditable(true);
	   if(rows.length==1){ 
//		   nui.get("createDate").setValue(new Date());
		   nui.get("guestId").setText(guestShortName);
		   nui.get("guestId").setValue(guestId);
		   setGuestLogistics(guestId,false);
	   }
	   rightGrid.clearRows();
	   addDetail(rows);
	  

   }
   else{
	   //已打包
	   if(billStatusId==3){
		   setBtnable(true);
		   loadRightGridData(billMainId);
	   }else{
		   if(exitbillStatusId.length>0){
				  showMsg("销售单状态不一致，不能一起勾选","W");
				  leftGrid.deselects(exitbillStatusId); 
				  return;
			  }
		   setBtnable(false);
		   loadRightGridData(billMainId);
	   }
	   
   }

} 
function loadRightGridData(billMainId)
{
    editPartHash={};
    var params = {};
  
    params.billMainId = billMainId;
    rightGrid.load({
        params:params,
        token:token
    },function(){
    	var data=rightGrid.getData();
    	var mainId=data[0].mainId;
    	loadMain(mainId);
    	var rows = leftGrid.getSelecteds(); 
    	var billStatusId=rows[0].billStatusId;
    	//已打包
    	if(billStatusId==3){
    		var addRows = rows.filter(function(v){
 			   if(v.billStatusId ==2){
 				   return true;		  
 			   }
 			   
 		   });
 		   if(addRows){ 
 			   addDetail(addRows);
 		   }
    	}
    });
}
var mainUrl=baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPJPackList.biz.ext";
function loadMain(mainId){
	var params={id: mainId,token:token};
	nui.ajax({
        url : mainUrl,
        type : "post",
        data :{params:params},
        success : function(data) {
            nui.unmask(document.body);
            data = data.list || {};
            var row=data[0];
            if(row){
            	basicInfoForm.setData(row);
                nui.get("guestId").setText(row.guestName);
                nui.get("logisticsGuestId").setText(row.logisticsName);
                nui.get("transitLogisticsId").setText(row.transitLogisticsName);
                if(row.auditSign==1){
                	setEditable(false);
                }else{
                	setEditable(true);
                }

            }
            
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
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
        case "billStatusId":
        	if(billStatusHash && billStatusHash[e.value])
            {
                e.cellHtml = billStatusHash[e.value];
            }
    }
}
var currType = 2;
function quickSearch(type){
    var params = {};
    var querysign = 1;
    var queryname = "本日";
    var querytypename = "所有";
    gsparams.isDiffOrder =1;
    gsparams.isNeedPack=1;
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
//        case 6:
//            params.auditSign = 0;
//            querytypename = "未审";
//            querysign = 2;
//            gsparams.auditSign = 0;
//            break;
//        case 7:
//            params.auditSign = 1;
//            querytypename = "已审";
//            querysign = 2;
//            gsparams.auditSign = 1;
//            break;
//        case 8:
//            params.postStatus = 1;
//            break;            
        case 9:
//        	params.billStatusIdList = "0,1,2,3";
        	querystatusname = "所有";
            querysign = 2;
            gsparams.auditSign=1;
            gsparams.billStatusId = null;
            gsparams.billStatusIdList="2,3,4,5";
            break;
        case 10:
//        	params.billStatusId = 0;
        	querystatusname = "已出库";
            querysign = 2; 
            gsparams.billStatusId = 2;
            gsparams.auditSign=1;
            break;
        case 11:
//        	params.billStatusId = 1;
        	querystatusname = "已打包";
            querysign = 2;
            gsparams.billStatusId = 3;
            gsparams.auditSign=1;
            break;
        case 12:
//        	params.billStatusId = 1;
        	querystatusname = "已发货";
            querysign = 2;
            gsparams.billStatusId = 4;
            gsparams.auditSign=1;
            break;
        case 13:
//        	params.billStatusId = 1;
        	querystatusname = "已到货";
            querysign = 2;
            gsparams.billStatusId = 5;
            gsparams.auditSign=1;
            break;
        default:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querystatusname = "所有";
            gsparams.startDate = getNowStartDate();
            gsparams.endDate = addDate(getNowEndDate(), 1);
//            gsparams.billStatusIdList = "0,1,2,3";
            break;
    }
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);
    }else if(querysign == 2){
            var menubillstatus = nui.get("menubillstatus");
            menubillstatus.setText(querystatusname);
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
//        nui.get("addBillBtn").enable();
        nui.get("deleteBillBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("auditBtn").enable();
    }
    else
    {
//        nui.get("addBillBtn").disable();
        nui.get("deleteBillBtn").disable();
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
            
//            setBtnable(false);
//            setEditable(false);

//            add();
            
        }else {
            var row = leftGrid.getSelected();
            if(row.auditSign == 1) {
//                setBtnable(false);
//                setEditable(false);
            }else {
                setBtnable(true);
                setEditable(true);
            }
            //document.getElementById("basicInfoForm").disabled=false;
            
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
        params.guestId = nui.get("guestId").getValue().replace(/\s+/g, "");
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
  //去除空格
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
        case "storeId":
            if(storehouse && storehouse[e.value])
            {
                e.cellHtml = storehouse[e.value].name;
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
var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.auditPjPack.biz.ext";
function audit()
{
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
        showMsg("请输入数字!","W");
        return;
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.billStatusId != 3) {
            showMsg("已打包状态才可发货!","W");
            return;
        } 
    }else{
        return;
    }

    var data = getMainData();

    var packDetailAdd = rightGrid.getChanges("added");
    var packDetailDelete = rightGrid.getChanges("removed");
    var packDetailList = rightGrid.getData();
    packDetailAdd = formatDetailDate(packDetailAdd);
    if(packDetailList.length<=0){
        showMsg("请添加发货明细!","W");
        return;
    }

    packDetailList = removeChanges(packDetailAdd, [], packDetailDelete, packDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '发货中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            packMain : data,
            packDetailAdd : packDetailAdd,
            packDetailDelete : packDetailDelete,
            packDetailList : packDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("发货成功!","S");
                leftGrid.reload();
//                var newRow = {auditSign: 1};
//                leftGrid.updateRow(row, newRow);

                setBtnable(false);
                
            } else {
                showMsg(data.errMsg || "发货失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

var arrivalUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.arrivalPjPack.biz.ext";
function arrival()
{
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
        showMsg("请输入数字!","W");
        return;
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.billStatusId != 4) {
            showMsg("已发货状态才可到货!","W");
            return;
        } 
    }else{
        return;
    }

    var data = getMainData();

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '到货中...'
    });

    nui.ajax({
        url : arrivalUrl,
        type : "post",
        data : JSON.stringify({
            packMain : data,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("确定到货成功!","S");
                leftGrid.reload();
                setBtnable(false);
                nui.get("arrivalBtn").disable();
                
            } else {
                showMsg(data.errMsg || "到货失败!","W");
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
    td.appendChild(editFormSellOutDetail);
    editFormSellOutDetail.style.display = "";

    var params = {};
    params.mainId = mainId;
    innerSellOutGrid.load({
        params:params,
        token: token
    });
}
var supplier = null;    
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title: "客户选择", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isClient:1
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
                    nui.get("guestName").setValue(text);

                    setGuestLogistics(value,false);

                }
            }
        }
    });
}
//function checkNew() 
//{
//    var rows = leftGrid.findRows(function(row){
//        if(row.serviceId == "新发货单") return true;
//    });
//    
//    return rows.length;
//}
//function add()
//{
//
//    if(checkNew() > 0) 
//    {
//        showMsg("请先保存数据!","W");
//        return;
//    }
//
//    var formJsonThis = nui.encode(basicInfoForm.getData());
//    var len = rightGrid.getData().length;
//
//    if(formJson != formJsonThis && len > 0)
//    {
//        nui.confirm("您正在编辑数据,是否要继续?", "友情提示",
//            function (action) { 
//                if (action == "ok") {
//
//                    setBtnable(true);
//                    setEditable(true);
//
//                    basicInfoForm.reset();
//                    rightGrid.clearRows();
//                    
//                    var newRow = { serviceId: '新发货单', auditSign: 0};
//                    leftGrid.addRow(newRow, 0);
//                    leftGrid.clearSelect(false);
//                    leftGrid.select(newRow, false);
//                    
//                    nui.get("serviceId").setValue("新发货单");
//                    nui.get("createDate").setValue(new Date());
//                    nui.get("packMan").setValue(currUserName);
//                    
//                    var guestId = nui.get("guestId");
//                    guestId.focus();
//
//                }else {
//                    return;
//                }
//            }
//        );
//    }else{
//        setBtnable(true);
//        setEditable(true);
//
//        basicInfoForm.reset();
//        rightGrid.clearRows();
//        
//        var newRow = { serviceId: '新发货单', auditSign: 0};
//        leftGrid.addRow(newRow, 0);
//        leftGrid.clearSelect(false);
//        leftGrid.select(newRow, false);
//        
//        nui.get("serviceId").setValue("新发货单");
//        nui.get("createDate").setValue(new Date());
//        nui.get("packMan").setValue(currUserName);
//        
//        var guestId = nui.get("guestId");
//        guestId.focus();
//    }
//
//    
//}
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
function formatDetailDate(added) {
    for(var i=0; i<added.length; i++) {
    
       for(var j=0; j<added.length; j++) {
            if(added[i].billDate) {
                added[i].billDate = format(added[i].billDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
            }
        }
    }

    return added;
}
function getMainData()
{
    var data = basicInfoForm.getData();
    //汇总明细数据到主表
    data.guestName=nui.get("guestId").getText();
    data.logisticsName=nui.get("logisticsGuestId").getText();
    data.transitLogisticsName=nui.get("transitLogisticsId").getText();
    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    return data;
}
var requiredField = {
    guestId : "客户",
    logisticsGuestId : "物流公司",
    logisticsNo : "物流单号",
    destinationStation :"目的站",
    payType :"付款方式",
//    settleTypeId : "结算方式",
    packItem :"总包数",
    isWooden :"是否钉木箱",
    receiveMan : "收货人",
    senderCity : "出发城市",
    packMan : "发货员",
    idNo  : "身份证号",
    senderPhone :"发件人电话",
    senderAddress :"发件人地址",
    packPayAmt : "运费"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.savePjPack.biz.ext";
function save() {
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false) {
        showMsg("请输入数字!","W");
        return;
    }

    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
        	if(key=="isWooden" && data[key]!==""){
        		continue;
        	}
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.billStatusId != 2 &&  row.billStatusId!=3) {
            showMsg("已出库、已打包状态才可打包!","W");
            return;
        } 
    }else{
        return;
    }
    

    data = getMainData();

    var packDetailAdd = rightGrid.getChanges("added");
    var packDetailDelete = rightGrid.getChanges("removed");
    var packDetailList = rightGrid.getData();
    packDetailAdd = formatDetailDate(packDetailAdd);
    packDetailList = removeChanges(packDetailAdd, [], packDetailDelete, packDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '打包中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            packMain : data,
            packDetailAdd : packDetailAdd,
            packDetailDelete : packDetailDelete,
            packDetailList : packDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("打包成功!","S");
                var list = data.list;
                if(list && list.length>0) {
                	leftGrid.reload();
//                    var leftRow = list[0];
//                    var row = leftGrid.getSelected();
//                    leftGrid.updateRow(row,leftRow);
//
//                    //保存成功后重新加载数据
//                    loadMainAndDetailInfo(leftRow);

                    
                }
                //onLeftGridRowDblClick({});
                
            } else {
                showMsg(data.errMsg || "打包失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
//    var params = {};
//    params.pny = e.value;
//    params.isSupplier = 1;
//    setGuestInfo(params);
	var data = e.selected;
	if (data) { 
		var id = data.id;
		var text = data.fullName;
		var value = data.id;
		nui.get("guestName").setValue(text);

        var row = leftGrid.getSelected();
        var newRow = {guestName: text};
        leftGrid.updateRow(row,newRow);

        setGuestLogistics(value,false);

    }
}

function onPayTypeValueChanged(e){
	var payType =nui.get('payType').getValue();
	var settleTypeId =nui.get('settleTypeId').getValue();
	
	//到付
	if(payType == "051301" && settleTypeId){
		nui.get("settleTypeId").setValue("");
		showMsg("到付不需要填写结算方式","W");
	}
}
function onSettleTypeValueChanged(e){
	var payType =nui.get('payType').getValue();
	//到付
	if(payType == "051301"){
		nui.get("settleTypeId").setValue("");
		showMsg("到付不需要填写结算方式","W");
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

                    nui.get("guestName").setValue(text);

                    var row = leftGrid.getSelected();
                    var newRow = {guestName: text};
                    leftGrid.updateRow(row,newRow);

                    setGuestLogistics(value,false);
                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);
                    nui.get("guestName").setValue(null);

                    var row = leftGrid.getSelected();
                    var newRow = {guestName: null};
                    leftGrid.updateRow(row,newRow);

                    setGuestLogistics(null,true);
                }
            }
            else
            {
                var el = nui.get('guestId');
                el.setValue(null);
                el.setText(null);
                nui.get("guestName").setValue(null);

                var row = leftGrid.getSelected();
                var newRow = {guestName: null};
                leftGrid.updateRow(row,newRow);

                setGuestLogistics(null,true);
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function setGuestLogistics(guestId,setNull){
    receiveManEl.setValue(null);
    receiveManTelEl.setValue(null);
    receiveCompNameEl.setValue(null);
    provinceIdEl.setValue(null);
    cityIdEl.setValue(null);
    countyIdEl.setValue(null);
    streetAddressEl.setValue(null);
    addressEl.setValue(null);
    if(setNull){
    }else{
        if(guestId){
            getLogistics(guestId,function(data) {
                list = data.list || [];
                receiveManEl.setData(list);

                //默认收货地址
                list.filter(function(v){
                    if(v.isDefault && v.isDefault==1){

                        receiveManEl.setValue(v.receiveMan);
                        receiveManTelEl.setValue(v.receiveManTel);
                        receiveCompNameEl.setValue(v.receiveCompName);
                        provinceIdEl.setValue(v.provinceId);
                        cityIdEl.setValue(v.cityId);
                        countyIdEl.setValue(v.countyId);
                        streetAddressEl.setValue(v.streetAddress);
                        addressEl.setValue(v.address);

                        return true;
                    }
                });

            });        
        }

    }
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

    selectPart(guestId,function(rows) {
        
        addDetail(rows);

    },function(serviceId) {
        var rtn = checkBillExists(serviceId);
        return rtn;
    });
}
function selectPart(guestId,callback,checkcallback)
{
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.purchase.packSellOrderSelect.flow?token="+token,
        title: "销售订单选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setInitData(guestId,callback,checkcallback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function addDetail(rows)
{
	if(!rows)return;
    for(var i=0; i<rows.length; i++){
        var row = rows[i];
        var newRow = {
            billMainId:row.id,
            billServiceId:row.serviceId,
            billAmt:row.orderAmt,
            settleTypeId:row.settleTypeId,
            orderMan:row.orderMan,
            billDate:row.auditDate,
            remark:row.remark
        };


        rightGrid.addRow(newRow);
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
        showMsg( "业务单"+row.billServiceId+"在发货列表中已经存在!","W");
        return true;
    }
    
    
}
function deleteBill(){
    var row = leftGrid.getSelected();
//    if(row){
//        if(row.auditSign == 1) {
//            return;
//        } 
//    }

    var rows = rightGrid.getSelecteds();
    rightGrid.removeRows(rows);
}
function onDrawCell(e)
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
function onLeftGridBeforeDeselect(e)
{
	nui.get("guestId").setText(null);
    nui.get("logisticsGuestId").setText(null);
	basicInfoForm.setData({});
    var rows = leftGrid.getSelecteds();
    if(rows.length>0){
    	rightGrid.clearRows();
    }
    var serviceId=rows[0].serviceId;
    var deleteRow = rightGrid.findRow(function(row){
        if(row.billServiceId == serviceId) {
            return true;
        }
        return false;
    });

    rightGrid.removeRow(deleteRow);

}
var getLogisticsUrl = apiPath + cloudPartApi + "/com.hsapi.cloud.part.baseDataCrud.crud.getLogisticsByGuestId.biz.ext";
function getLogistics(guestId,callback) {
    nui.ajax({
        url : getLogisticsUrl,
        data : {
            token: token, 
            guestId: guestId
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
function onReceiveManChanged(e) 
{
    var v = e.selected;
    //receiveManEl.setValue(v.receiveMan);
    receiveManTelEl.setValue(v.receiveManTel);
    receiveCompNameEl.setValue(v.receiveCompName);
    provinceIdEl.setValue(v.provinceId);
    cityIdEl.setValue(v.cityId);
    countyIdEl.setValue(v.countyId);
    streetAddressEl.setValue(v.streetAddress);
    addressEl.setValue(v.address);
}  
function selectLogisticsSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title: "物流公司选择", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier:1,
                guestType:'01020204'
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
                var settTypeIdV = supplier.settTypeId;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
                if(elId== 'logisticsGuestId'){
                	nui.get("logisticsName").setValue(text);	
                }else if(elId== 'transitLogisticsId'){
                	nui.get('transitLogisticsName').setValue(text);
                }
                

                settleTypeIdEl.setValue(settTypeIdV);

            }
        }
    });
}

function addLogistics() 
{
	var comguest={};
	comguest.fullName=nui.get('logisticsGuestId').getText();
	var title = "新增物流公司";
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.basic.LogisticsDetail.flow?token="+token,
        allowResize:false,
        title: title, width: 470, height: 250,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {};
            if (comguest) {
                params.comguest = comguest;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
            if (action == "ok") {
//                dataGrid.reload();
            }
        }
    });
}

function addLogistics() 
{
	var comguest={};
	comguest.fullName=nui.get('logisticsGuestId').getText();
	var title = "新增物流公司";
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.basic.LogisticsDetail.flow?token="+token,
        allowResize:false,
        title: title, width: 470, height: 250,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {};
            if (comguest) {
                params.comguest = comguest;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
            if (action == "ok") {
//                dataGrid.reload();
            }
        }
    });
}

function onPrint(){
	var row = leftGrid.getSelected();
	if(!row){
		showMsg("请选择一条销售单","W");
		return;
	}
	var params={
			id : row.id,
		auditSign:row.auditSign,
		guestId :row.guestId,
		currRepairSettorderPrintShow : currRepairSettorderPrintShow,
		currOrgName : currOrgName,
		currUserName : currUserName,
		currCompAddress : currCompAddress,
		currCompTel : currCompTel,
		storeHash : storeHash,
		brandHash: brandHash
	};
	var detailParams={
			mainId :row.id,
	};
	var openUrl = webPath + contextPath+"/purchase/sellOrder/sellOrderPrint.jsp";

    nui.open({
       url: openUrl,
       width: "100%",
       title : "销售订单打印",
       height: "80%",
       showMaxButton: false,
       allowResize: false,
       showHeader: true,
       onload: function() {
           var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(params,detailParams);
       },
   });
   
}