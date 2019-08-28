/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.process.queryProcessMain.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.process.queryProcessProduct.biz.ext";
var detailGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.process.queryProcessDetail.biz.ext";
var basicInfoForm = null;

var leftGrid = null;
var rightGrid = null;
var detailGrid =null;
var formJson = null;
var brandHash = {};
var brandList = [];
var storehouse = [];
var storeHash={};
var morePartGrid = null;
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var dataList = null;
var FStoreId = null;
var isNeedSet = false;

var AuditSignHash = {
  "0":"草稿",
  "1":"已审核"
};

var storeLimitMap={};
var storeShelfList=[];
var storeShelfHash={}
var partHash={};
$(document).ready(function(v)
{
  
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    
    detailGrid = nui.get("detailGrid");
    detailGrid.setUrl(detailGridUrl);
  
    basicInfoForm = new nui.Form("#basicInfoForm");
   
    morePartGrid = nui.get("morePartGrid");
  
	
    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    //gsparams.isOut = 0;

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");


    
    document.onkeyup=function(event){
	    var e=event||window.event;
	    var keyCode=e.keyCode||e.which;
	  
	    if((keyCode==78)&&(event.altKey))  {  //新建
			add();	
	    } 
	  
	    if((keyCode==83)&&(event.altKey))  {   //保存
			save();
	    } 
	  
	    if((keyCode==84)&&(event.altKey))  {   //审核 Alt+T
        	audit();
        } 
      
      

		if((keyCode==13))  {  //新建
            if(partShow == 1) {
            	if(partIn!=false){
            		var row = morePartGrid.getSelected();
    				if(row){
    					addSelectPart();
    				}
    				
            	}
            	partIn=true;
			}
        } 

        if((keyCode==27))  {  //ESC
            if(partShow == 1){
                onPartClose();
            }
            if(moreSearchShow==1){
            	onAdvancedSearchCancel();
            }
        }
	}
    
    getStorehouse(function(data) {
		storehouse = data.storehouse || [];
		nui.get('storeId').setData(storehouse);
		if(storehouse && storehouse.length>0){
			FStoreId = storehouse[0].id;
			storehouse.forEach(function(v){
        		storeHash[v.id]=v;
        	});
		}else{
			isNeedSet = true;
		}
		 quickSearch(0);
    });
   
    add();

   

});

function getParentStoreId(){
    return FStoreId;
}
function loadMainAndDetailInfo(row)
{
    if(row) {    
       basicInfoForm.setData(row);

       var auditSign=row.auditSign;
	   $('#status').text(AuditSignHash[auditSign]);
       //bottomInfoForm.setData(row);
 

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
    },function(){

//        var data = rightGrid.getData();
//        
//       
//        if(data && data.length <= 0){
//            addNewRow(false);
//        }else{
//
//          
//        } 
        

    });
    var p ={};
    p.codeId= mainId;
    detailGrid.load({
    	params:p,
    	token : token
    });
}
function onLeftGridDrawCell(e)
{
    var record = e.record;
    switch (e.field){
        case "auditSign":
            if(AuditSignHash && AuditSignHash[e.value])
            {
                e.cellHtml = AuditSignHash[e.value];
            }
            break;
       default:
    	   break;
    }
}
var currType = 2;
function quickSearch(type){
    var params = {};
    var querysign = 1;
    var queryname = "本日";
    var querytypename = "草稿";
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
        	gsparams.billStatusId = 0;
            querytypename = "草稿";
            querysign = 2;
            gsparams.auditSign = 0;
            break;
        case 7:
        	gsparams.billStatusId = 1;
            querytypename = "已审核";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
       
        default:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querytypename = "草稿";
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
    gsparams.isDiffOrder = 0;
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
    params.isDiffOrder = 1;
  //是业务员且业务员禁止可见
	if(currIsSalesman ==1 && currIsOnlySeeOwn==1){
		params.creator= currUserName;
	}
    return params;
}
function setBtnable(flag)
{
    if(flag)
    {
        //nui.get("unAuditBtn").disable();
        nui.get("auditBtn").enable();
        nui.get("saveBtn").enable();
        //nui.get("auditToOutBtn").disable();
        //nui.get("printBtn").enable();
    }
    else
    {
        //nui.get("unAuditBtn").enable();
        nui.get("auditBtn").disable();
        //nui.get("auditToOutBtn").enable();
        nui.get("saveBtn").disable();
    }
}
var requiredField = {
	storeId  : "仓库",
    orderMan : "业务员",
    orderDate : "订单日期",

};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.process.saveProcess.biz.ext";
function save() {
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            parent.showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            parent.showMsg("此单已提交!","W");
            return;
        } 
    }else{
        return;
    }
    
    var rightRow =rightGrid.getData();
	var orderMan =nui.get('orderMan').value;	

    data = getMainData();

    var processProductData = rightGrid.getData();
    var processProduct=processProductData[0];
 
//    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
        	processMain : data,
        	processProduct : processProduct,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                parent.showMsg("保存成功!","S");
                //onLeftGridRowDblClick({});
//                var pjSellOrderMainList = data.pjSellOrderMainList;
//                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
//                    var leftRow = pjSellOrderMainList[0];
//                    var row = leftGrid.getSelected();
//                    leftGrid.updateRow(row,leftRow);
//
//                    //保存成功后重新加载数据
//                    loadMainAndDetailInfo(leftRow);
//
//                    
//                }
            } else {
                parent.showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
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
    data.auditSign = 0;
    data.printTimes = 0;
    data.orderTypeId = 1;
    delete data.createDate;	
    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    if (data.orderDate) {
  	  data.orderDate = format(data.orderDate, 'yyyy-MM-dd HH:mm:ss');
  	}
  
    rightGrid.findRow(function(row){
        var partId = row.partId;
        var partCode = row.partCode;
        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
            rightGrid.removeRow(row);
        }
    });

    return data;
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
    params.orderTypeId = 1;
  //是业务员且业务员禁止可见
	if(currIsSalesman ==1 && currIsOnlySeeOwn==1){
		params.creator= currUserName;
	}
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
                setEditable(false);
                document.getElementById("basicInfoForm").disabled=true;
            }else {
                setBtnable(true);
                setEditable(true);
                document.getElementById("basicInfoForm").disabled=false;
            }
        }
    });
}

function checkNew() 
{
    var rows = leftGrid.findRows(function(row){
        if(row.serviceId == "新配件组装") return true;
    });
    
    return rows.length;
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

var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjSellOrder.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            parent.showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            parent.showMsg("此单已出库!","W");
            return;
        } 
    }else{
        return;
    }

    //审核时，数量，单价，金额，仓库不能为空
    var msg = checkStockOutQty();
    if(msg){
        parent.showMsg(msg,"W");
        return;
    }
    //审核时，判断是否存在缺货信息
    var msg = checkRightData();
    if(msg){
        parent.showMsg(msg,"W");
        return;
    }

    data = getMainData();

    var sellOrderDetailAdd = rightGrid.getChanges("added");
    var sellOrderDetailUpdate = rightGrid.getChanges("modified");
    var sellOrderDetailDelete = rightGrid.getChanges("removed");
    var sellOrderDetailList = rightGrid.getData();
    if(sellOrderDetailList.length <= 0) {
        parent.showMsg("销售明细为空，不能提交!","W");
        return;
    }
    
    getStoreLimit();
	var rightRow =rightGrid.getData();
	for(var i=0;i<rightRow.length;i++){
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(rightRow[i].storeId) && storeHash[rightRow[i].storeId]){
				parent.showMsg("没有选择"+storeHash[rightRow[i].storeId].name+"的权限","W");
				return;
			}
		}
	}

	
	
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);

   
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
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
            operateFlag:1,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                parent.showMsg("退货成功!","S");
                //onLeftGridRowDblClick({});
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                    nui.confirm("是否打印？", "友情提示", function(action) {
    					if(action== 'ok'){
    						onPrint();
    					}else{
    						rightGrid.setData([]);
    						add();
    					}
    				});
                }
            } else {
                parent.showMsg(data.errMsg || "退货失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}


function add()
{
  
	if(isNeedSet){
		parent.parent.showMsg("请先到仓库定义功能设置仓库!","W");
		return;
	}
    if(checkNew() > 0) 
    {
        parent.parent.showMsg("请先保存数据!","W");
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
                    detailGrid.clearRows();
                    
                    var newRow = { serviceId: '新配件组装', auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新配件组装");
//                    nui.get("createDate").setValue(new Date());
                    nui.get("orderDate").setValue(new Date());
                    nui.get("orderMan").setValue(currUserName);
                    
                    addNewRow();
                    var storeId = nui.get("storeId");
                    storeId.focus();
                   

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
        detailGrid.clearRows();
        
        var newRow = { serviceId: '新配件组装', auditSign: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新配件组装");

//        nui.get("createDate").setValue(new Date());
        nui.get("orderDate").setValue(new Date());
        nui.get("orderMan").setValue(currUserName);

        addNewRow();
        
        var storeId = nui.get("storeId");
        storeId.focus();
      
    }

    
}

function addNewRow(check){

    var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        return;
    }

    if(data.codeId && data.codeId>0) return;
    
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
        rightGrid.updateRow(row, newRow);
        
    }else{
        rightGrid.addRow(newRow);
        
    }
}


function addInsertRow(value, row) {    

    var params = {partCode:value};
    var part = getPartInfo(params);
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
            storeId : FStoreId,
            comOemCode : part.oemCode,
            comSpec : part.spec,
            partCode : part.code,
            partName : part.name,
            fullName : part.fullName,
            systemUnitId : part.unit,
            outUnitId : part.unit
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
var editPartHash = {
};
function deletePart(){
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

    if(row.codeId && data.codeId>0) return;

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
        if(row.partId){
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
        }

    });
    
    if(rows && rows.length > 0){
        msg = "请完善退货配件的数量，单价，金额，仓库等信息！";
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
        msg = "配件：" + comPartCode + "缺货，不能提交！";
    }
    return msg;
}

function onStoreValueChange(e){
	var data = e.selected;
	if(data){
		var id = data.id;
		var orderMan =nui.get('orderMan').value;
		if(orderMan !=currUserName){
			getStoreLimit();
		}
		if(Object.getOwnPropertyNames(storeLimitMap ).length ==0){
			//不做限制
		}
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(id) && storeHash[id].name){
				parent.showMsg("没有选择"+storeHash[id].name+"的权限","W");
				return;
			}
		}
	}
		
}
var storeLimtUrl  = baseUrl +"com.hsapi.system.tenant.employee.queryStoreManOne.biz.ext";
function getStoreLimit(){
	storeLimitMap={};
	var orderMan =nui.get('orderMan').value;
	if(!orderMan){
		return;
	}
	nui.ajax({
		url : storeLimtUrl,
		async:false,
		data : {
			orgid : currOrgId,
			name : orderMan,
			token : token
		},
		type : "post",
		success : function(text) {
			var data =text.data;
			for(var i=0;i<data.length;i++){
				storeLimitMap[data[i].storeId] =data [i];
			}
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
	return storeLimitMap;
}

function addSelectPart(){

    var row = morePartGrid.getSelected();
    if(row){
        var params = {partCode:row.code};
        params.partId = row.id;
        params.guestId = guestId;
        var price = getPartPrice(params);
                    
        var newRow = {
            partId : row.id,
            comPartCode : row.code,
            comPartName : row.name,
            comPartBrandId : row.partBrandId,
            comApplyCarModel : row.applyCarModel,
            comUnit : row.unit,
            orderQty : 1,
            orderPrice : price,
            orderAmt : price,
            storeId : FStoreId,
            comOemCode : row.oemCode,
            comSpec : row.spec,
            partCode : row.code,
            partName : row.name,
            fullName : row.fullName,
            systemUnitId : row.unit,
            outUnitId : row.unit
        };
        
        advancedMorePartWin.hide();
        morePartGrid.setData([]);
        partShow = 0;
        
        if(rightGrid.getSelected()){
            rightGrid.updateRow(rightGrid.getSelected(),newRow);
        }else{
            rightGrid.addRow(newRow);
        }
        rightGrid.beginEditCell(rightGrid.getSelected(), "orderQty");
        
        advancedMorePartWin.hide();
        morePartGrid.setData([]);
        
    }else{
        parent.showMsg("请选择配件!","W");
        return;
    }
}

function onPartClose(){
    advancedMorePartWin.hide();
    morePartGrid.setData([]);
    partShow = 0;
    
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

    if(data.codeId && data.codeId>0){
        e.cancel = true;
    }
    if(e.field == 'storeId'){
    	editor.setData(storehouse);
    }
    
    if (field == "storeShelf") {
	    var value = e.record.storeId;
	    var editor = e.editor;
	    if(editor.type=='textbox'){
	    	return;
	    }
	    getLocationListByStoreId(value,function(data) {
			storeShelfList = data.locationList || [];
			nui.get('storeShelf').setData(storeShelfList);
			
	
		});
    }

}

function selectPart()
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.purchase.productChoose.flow?token="+token,
        title: "配件成品选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            
            iframe.contentWindow.setInitData();
        },
        ondestroy: function (action)
        {
        	if(action=='ok'){
        		var iframe = this.getIFrameEl();
        		var data = iframe.contentWindow.getData();
        		rightGrid.setData(data.rightData);
        		detailGrid.setData(data.detailData);
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
    var storeId =nui.get('storeId').getValue();
    if(!storeId){
    	parent.showMsg("请先选择仓库","W");
    	return;
    }
  

    rightGrid.findRow(function(row){
        var partId = row.partId;
        var partCode = row.partCode;
        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
            rightGrid.removeRow(row);
        }
    });
   

    selectPart();
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
        return "配件编码："+row.comPartCode+"在销售退货列表中已经存在，是否继续？";
    }
    
    return null;
    
}
function addDetail(rows)
{
    //var iframe = this.getIFrameEl();
    //var data = iframe.contentWindow.getData();
    for(var i=0; i<rows.length; i++){
        var row = rows[i];
        var newRow = {
            partId : row.partId,
            comPartCode : row.comPartCode,
            comPartName : row.comPartName,
            comPartBrandId : row.comFullName,
            comApplyCarModel : row.comApplyCarModel,
            comUnit : row.comUnit,
            orderQty : row.orderQty,
            orderPrice : row.orderPrice,
            orderAmt : row.orderAmt,
            storeId : row.storeId,
            comOemCode : row.comOemCode,
            comSpec : row.comSpec,
            partCode : row.comPartCode,
            partName : row.comPartName,
            fullName : row.comFullName,
            systemUnitId : row.comUnit,
            outUnitId : row.comUnit
        };


        rightGrid.addRow(newRow);
    }

}


var partUrl=baseUrl +"com.hsapi.cloud.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
function getPart(partIdList){
//	$.ajaxSettings.async = false;
//	$.post(partUrl+"?params/orgid="+currOrgid+"&params/noPage="+1+"&token="+token,{},function(text){
//		var parts=text.parts;
//		parts.forEach(function(v){
//			partHash[v.id]=v;			
//		});
//	});
  var params={};
  var page ={};
  page.length =1000;
  params.partIdList =partIdList;
  params.orgid = currOrgid;
  nui.ajax({
        url : partUrl,
        type : "post",
        async:false,
        data : JSON.stringify({
        	params : params,
        	page   : page,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
            	var parts=data.parts;
        		parts.forEach(function(v){
        			partHash[v.id]=v;			
        		});
            } else {
            	 nui.unmask(document.body);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
//  return partHash;
}

function onLeftGridBeforeDeselect(e)
{
    var row = leftGrid.getSelected(); 
    if(row.serviceId == '新配件组装'){

        leftGrid.removeRow(row);
    }
}

//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
	var editor = e.editor;
	var record = e.record;
	var row = e.row;

	editor.validate();
	if (editor.isValid() == false) {
		showMsg("请输入数字!","W");
		e.cancel = true;
	} else {
		var newRow = {};
		if (e.field == "orderQty") {
			var orderQty = e.value;
			var orderPrice = record.orderPrice;

			if (e.value == null || e.value == '') {
				e.value = 0;
				orderQty = 0;
			} else if (e.value < 0) {
				e.value = 0;
				orderQty = 0;
			}

		}
	}
}