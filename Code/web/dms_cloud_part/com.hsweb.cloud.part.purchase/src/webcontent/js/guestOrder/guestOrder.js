/**
 * Created by Administrator on 2018/2/23.
 */

var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.guestOrder.queryGuestOrderMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.guestOrder.getPjGuestOrderDetailListByMainId.biz.ext";//com.hsapi.cloud.part.invoicing.guestOrder.queryPjGuestOrderDetailList.biz.ext
var advancedSearchWin = null;
var advancedMorePartWin = null;
var advancedMorePartWin2 = null;
var advancedAddWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var bottomInfoForm = null;
var bottomInfoForm = null;
var advancedAddForm = null;
var leftGrid = null;
var rightGrid = null;
var formJson = null;
var compBrandList = [];
var compBrandHash = {};
var brandHash = {};
var brandList = [];
var storehouse = [];
var storeHash={};
var morePartGrid = null;
var morePartGrid2 =null;
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var dataList = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldValue2 =null;
var oldRow = null;
var oldRow2 =null;
var guestIdEl=null;
var partShow=0;
var moreSearchShow=0;
var autoNew = 0;
var partIn=null;
var advancedTipWin = null;

var StatusHash={
		"0"	:"草稿",
		"1"	:"已提交",
		"2"	:"已受理",
		"3" :"已完成",
		"4" :"已作废"
	};
var storeLimitMap={};
var partHash={};
//是否开单
var isBilling=0;
//是否修改配件
var isEditPart =0;
var partIn =false;
$(document).ready(function(v)
{
	
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '加载中...'
    });
    
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    advancedMorePartWin = nui.get("advancedMorePartWin");
    advancedMorePartWin2 = nui.get("advancedMorePartWin2");
    advancedAddWin = nui.get("advancedAddWin");
    morePartGrid = nui.get("morePartGrid");
    morePartGrid2 = nui.get("morePartGrid2");
    
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
    	params.isClient = 1;

        data.params = params;
        e.data =data;
        return;
            
       
        
    });
	
    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    //gsparams.isOut = 0;

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");
    
    advancedTipWin = nui.get("advancedTipWin");

    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035", "orgCarBrandId": "10444", "businessTypeId": "10445"};
    
    if(currIsCommission ==1){
    	//nui.get('chooseMemBtn').setVisible(true);
    }
    initDicts(dictDefs, function(){
    	compBrandList = nui.get("orgCarBrandId").getData();
		compBrandList.forEach(function(v){
			compBrandHash[v.customid]=v;
    	});
		
        getStorehouse(function(data)
        {
            storehouse = data.storehouse||[];
            if(storehouse && storehouse.length>0){
                FStoreId = storehouse[0].id;
                storehouse.forEach(function(v){
            		storeHash[v.id]=v;
            	});
                nui.get("storeId").setData(storehouse);
            }else{
                isNeedSet = true;
            }

            getAllPartBrand(function(data) {
                brandList = data.brand;
                brandList.forEach(function(v) {
                    brandHash[v.id] = v;
                });
    
                gsparams.auditSign = 0;
                quickSearch(10);

                nui.unmask();
            });
        });
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
	    
	    if((keyCode==84)&&(event.altKey))  {   //提交 Alt+T
        	audit();
        } 
      
        if((keyCode==89)&&(event.altKey))  {   //完成销售 Alt+Y
        	finish();
        } 
        
	  
	    if((keyCode==80)&&(event.altKey))  {   //打印
			onPrint();
	    } 
	    if((keyCode==113))  {  
			addMorePart();
		} 

		if((keyCode==13))  {  //新建
            if(partShow == 1) {
            	if(partIn!=false){
            		if(advancedMorePartWin.visible){
            			var row = morePartGrid.getSelected();
        				if(row){
        					addSelectPart();
        				}
            		}
            		else if(advancedMorePartWin2.visible){
            			var row = morePartGrid2.getSelected();
        				if(row){
        					addSelectPart2();
        				}
            		}
    				
            	}
            	partIn=true;
			}
        } 

        if((keyCode==27))  {  //ESC
            if(partShow == 1){
            	if(advancedMorePartWin.visible){
            		 onPartClose();
            	}
            	else if(advancedMorePartWin2.visible){
            		onPartClose2();
            	}
               
            }
            if(moreSearchShow==1){
            	onAdvancedSearchCancel();
            }
        }
	}
    
    $("#guestId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var rtnReasonId = nui.get("rtnReasonId");
            rtnReasonId.focus();
        }
    });
    $("#rtnReasonId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            ow(true);
        }
    });
    add();
    

});
function onBusinessTypeIdValueChanged(e) {
	var data = e.selected;
	var guestname = data.property2 || "";
	getBusinessGuest(guestname);
	/*if(data.customid != "1591934420679" && data.customid != "1591934420684") {//平台销售，保险平台或是保险业务时，需要指定二级（结算单位），转第三方结算
		setSettleGuestVisible(true);
		nui.get("settleTypeId").setValue("020502");
	}else {
		nui.get("settleGuestId").setValue("");
		setSettleGuestVisible(false);
	}*/
}
//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
    return "pcshRtn";
}
function getParentStoreId(){
    return FStoreId;
}
function loadMainAndDetailInfo(row)
{
    if(row) {    
       basicInfoForm.setData(row);
  /*     var auditSign=row.auditSign;
       if(auditSign==0){
    	   $('#status').text("草稿");	   
       }else if(auditSign==1){
    	   $('#status').text("已退货");
       }*/
       var status=row.status;
	   $('#status').text(StatusHash[status]);
	   
	   var pr ={
	   			guestId : row.guestId,
	   			orgid : currOrgId,
	   			isDisabled :0,
	   			billDc   :1,
	   	   }
  	   var pp ={
  			guestId : row.guestId,
  			orgid : currOrgId,
  			isDisabled :0,
  			billDc : -1
  	   }
	   var dueAmt = getDueAmt(pr,pp);
	   $('#dueAmt').html("客户欠款: "+"<a style='text-decoration:underline;color:#0066cc'><span>"+dueAmt+"<span></a>");
       //bottomInfoForm.setData(row);
       nui.get("guestId").setText(row.guestFullName);

       var row = leftGrid.getSelected();
       nui.get("isBilling").setValue(row.isBilling);
	   billingChange();
	   
	   /*if(row.businessTypeId != "1591934420679" && row.businessTypeId != "1591934420684") {//平台销售，保险平台或是保险业务时，需要指定二级（结算单位），转第三方结算
			setSettleGuestVisible(true);
			if(row.settleGuestId != null && row.settleGuestId != ""){
				getSettleGuest(row.settleGuestId);
			}else{
				nui.get("settleGuestName").setText("");
			}
			
		}else {
			setSettleGuestVisible(false);
		}*/
	   
	   if(currIsSalesman ==1 && currIsCanSubmitOtherBill ==1 && row.creator !=currUserName ){
			nui.get("auditBtn").disable();
		}else {
			nui.get("auditBtn").enable();
		}
	   
       if(row.auditSign == 1 || row.status==4) {
            setBtnable(false);
            document.getElementById("basicInfoForm").disabled=true;
            setEditable(false);
       }else {
            setBtnable(true);
            document.getElementById("basicInfoForm").disabled=false;
            setEditable(true);
       }
       
       if(row.status == 2) {
    	   nui.get('finishSellBtn').enable();
       } else {
    	   nui.get('finishSellBtn').disable();
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
function setSettleGuestVisible(flag) {
	if(flag) {
		document.getElementById("settleGuestTitle").style.display="";
		document.getElementById("settleGuest").style.display="";
	}else {
		document.getElementById("settleGuestTitle").style.display="none";
		document.getElementById("settleGuest").style.display="none";
	}
}
function onLeftGridSelectionChanged(){    
   var row = leftGrid.getSelected(); 
   
   loadMainAndDetailInfo(row);
} 
function onLeftGridBeforeDeselect(){
	var row = leftGrid.getSelected(); 
    if(row.serviceId == '新预售单'){

        leftGrid.removeRow(row);
    }
}
function loadRightGridData(mainId)
{
    editPartHash={};
    var params = {};
    params.mainId = mainId;
    rightGrid.load({
    	mainId:mainId,
        token:token
    },function(){

        var data = rightGrid.getData();
        
        if(autoNew == 0){
			add();
			autoNew = 1;
        }
        if(data && data.length <= 0){
            addNewRow(false);
        }else{
            var guestId = nui.get("guestId").getValue();
            var changeData = rightGrid.getChanges();
            if(changeData.length == 0 && guestId){
                addNewRow(false);
            }
        }   

    });
}
var settleGuestUrl = apiPath + cloudPartApi + "/"+"com.hsapi.cloud.part.common.svr.getGuestById.biz.ext";
function getSettleGuest(guestId){
	nui.ajax({
        url: settleGuestUrl,
        type: 'post',
        async:false,
        data: nui.encode({
        	id: guestId,
            token: token
        }),
        cache: false,
        success: function (data) {
        	var guest =data.guest;
        	if(guest != null) {
        		nui.get("settleGuestName").setText(guest.fullName);
        	}
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
	});
}
var businessGuestUrl = apiPath + cloudPartApi + "/com.hsapi.cloud.part.baseDataCrud.crud.queryGuestList.biz.ext";
function getBusinessGuest(guestFullName){
	if(guestFullName == null || guestFullName == "") {
		nui.get("settleGuestId").setValue("");
		nui.get("settleGuestName").setText("");
		return;
	}
	nui.ajax({
        url: businessGuestUrl,
        type: 'post',
        async:false,
        data: nui.encode({
        	params: {
        		guestFullName: guestFullName
        	},
            token: token
        }),
        cache: false,
        success: function (data) {
        	var guests =data.guest;
        	if(guests != null && guests.length>0) {
        		var guest = guests[0];
        		nui.get("settleGuestId").setValue(guest.id);
        		nui.get("settleGuestName").setText(guest.fullName);
        		nui.get("billTypeId").setValue(guest.billTypeId);
        		nui.get("settleTypeId").setValue(guest.settTypeId);
        	}else {
        		nui.get("settleGuestId").setValue("");
        		nui.get("settleGuestName").setText("");
        	}
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
	});
}
function onLeftGridDrawCell(e)
{
    var record = e.record;
    if(e.record.status == 3 && e.field) {
		if(e.value == null) {
			e.value = "";
		}
    	e.cellHtml = '<a style="color:red;">' + e.value + '</a>';
    }
    switch (e.field){
        case "status":
            if(StatusHash && StatusHash[e.value])
            {
                e.cellHtml = StatusHash[e.value];
            }
            if(e.record.status == 3) {
            	e.cellHtml = '<a style="color:red;">' + StatusHash[e.value] + '</a>';
            }
            break;
        case "orderDate":
            if(e.record.status == 3) {
            	e.cellHtml = '<a style="color:red;">' + format(e.value, 'yyyy-MM-dd HH:mm') + '</a>';
            } else {
            	e.cellHtml = e.value ? format(e.value, 'yyyy-MM-dd HH:mm') : "";
            }
            break;
        case "auditDate":
            if(e.record.status == 3) {
            	e.cellHtml = '<a style="color:red;">' + format(e.value, 'yyyy-MM-dd HH:mm') + '</a>';
            }else {
            	e.cellHtml = e.value ? format(e.value, 'yyyy-MM-dd HH:mm') : "";
            }
            
            break;
       
    }
}
var currType = 2;
function quickSearch(type){
    var params = getSearchParam();
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
        	gsparams.status = 0;
            querytypename = "草稿";
            querysign = 2;
            gsparams.auditSign = 0;
            break;
        case 7:
        	gsparams.status = 1;
            querytypename = "已提交";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 8:
        	gsparams.status = 2;
            querytypename = "已受理";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 9:
        	gsparams.status = 3;
            querytypename = "已完成";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 10:
        	gsparams.status = null;
        	gsparams.auditSign = null;
            querytypename = "所有";
            querysign = 2;

            break;
        case 11:
        	gsparams.status = 4;
        	gsparams.auditSign = null;
            querytypename = "已作废";
            querysign = 2;

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
    doSearch(gsparams);
}

var delUrl = baseUrl+"com.hsapi.cloud.part.invoicing.guestOrder.updateGuestOrderDisabled.biz.ext";
function del()
{
    var data = basicInfoForm.getData();
    if(data.status==4){
    	showMsg("订单已作废","W");
    	return;
    }
    if(data.status!=0){
    	showMsg("草稿状态才能作废","W");
    	return;
    }
    if(data.auditSign ==1){
    	showMsg("订单已审核","W");
    	return;
    }
   
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : delUrl,
        type : "post",
        data : JSON.stringify({
            mainId : data.id,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("操作成功!","S");
                var row = leftGrid.getSelected();
                var newRow =nui.clone(row);
                newRow.status = 4;
                leftGrid.updateRow(row,newRow);
                basicInfoForm.setData(newRow);

              
                    //document.getElementById("delBtn").childNodes[0].innerHTML = '<span class="fa fa-reply fa-lg"></span>&nbsp;反作废';
//                    nui.get("delBtn").setVisible(false);
//                    nui.get("undelBtn").setVisible(true);
                setBtnable(false);
                setEditable(false);
                document.getElementById("basicInfoForm").disabled=false;
                

            } else {
                showMsg(data.errMsg || "操作失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
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
    params.orgid= currOrgid;
  //是业务员且业务员禁止可见
	if(currIsSalesman ==1 && currIsOnlySeeOwn==1){
		params.creator= currUserName;
	}
	if(currIsSalesman ==1 &&currIsCanViewOtherBill ==1){
		params.creator= currUserName;
	}
    return params;
}
function setBtnable(flag)
{
    if(flag)
    {
        //nui.get("importPartBtn").disable();
        nui.get("auditBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("selectSupplierBtn").enable();
        //nui.get("auditToOutBtn").disable();
        //nui.get("printBtn").enable();
    }
    else
    {
        //nui.get("importPartBtn").enable();
        nui.get("auditBtn").disable();
        //nui.get("auditToOutBtn").enable();
        nui.get("saveBtn").disable();
        nui.get("selectSupplierBtn").disable();
    }
}
var requiredField = {
    guestId : "客户",
    orderMan : "业务员",
    orderDate : "订单日期",
    billTypeId : "票据类型",
    settleTypeId : "结算方式",
    storeId : "仓库",
    businessTypeId : "销售类型"
};

var updateCreditUrl= baseUrl +"com.hsapi.cloud.part.invoicing.settle.updateCredit.biz.ext";
function beforeSave(){
	var flag = false;
	var row =rightGrid.getData();
	var amt =0;
	for(var i=0;i<row.length;i++){
		if(row[i].orderAmt){
			amt = parseFloat(row[i].orderAmt)+parseFloat(amt);
		}
		
	}
	var data = basicInfoForm.getData();
	var guestId = data.guestId;
	nui.ajax({
		url : updateCreditUrl,
		type : "post",
		async : false,
		data : JSON.stringify({
			guestId : guestId,
			mainId : data.id,
			amt : amt,
            token : token
		}),
		success : function(data) {
            nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				flag =true;
			} else {
                showMsg(data.errMsg || "保存失败!","E");
                flag = false;
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
		
	});
	return flag;
}

var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.guestOrder.saveGuestOrder.biz.ext";
function save() {
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
            showMsg("此单已提交!","W");
            return;
        } 
        if(row.status ==4){
        	 showMsg("此单已作废!","W");
             return;
        }
    }else{
        return;
    }
    
  //开启额度管理
    if(currIsOpenCredit ==1 && data.id){
    	 var flag = beforeSave();
    	    if(flag ==false){
    	    	return;
    	    }
    }
   
    
    var rightRow =rightGrid.getData();
	var orderMan =nui.get('orderMan').value;
//	if(orderMan !=currUserName){
		getStoreLimit();
//	}
	/*for(var i=0;i<rightRow.length;i++){
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(row.storeId)  && storeHash[row.storeId]){
				showMsg("没有选择"+storeHash[row.storeId].name+"的权限","W");
				return;
			}
		}
	}*/

	if(currIsOpenApp ==1){
		// set集合
	    var set =new  Set();
		for(var i=0;i<rightRow.length;i++){
			if(!rightRow[i].partId){
				rightGrid.removeRow(rightRow[i]);
				continue;
			}
			set.add(rightRow[i].partId+"-"+rightRow[i].storeId);
		}
		if(set.size <rightGrid.getData().length){
			showMsg("订单明细不能出现相同配件同个仓库两次以上","W");
			return;
		}

	}

    data = getMainData();

    var guestOrderDetailAdd = rightGrid.getChanges("added");
    var guestOrderDetailUpdate = rightGrid.getChanges("modified");
    var guestOrderDetailDelete = rightGrid.getChanges("removed");
    var guestOrderDetailList = rightGrid.getData();
    guestOrderDetailUpdate =  getModifyData(guestOrderDetailList, guestOrderDetailAdd, guestOrderDetailDelete);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
        	guestOrderMain : data,
        	guestOrderDetailAdd : guestOrderDetailAdd,
        	guestOrderDetailUpdate : guestOrderDetailUpdate,
        	guestOrderDetailDelete : guestOrderDetailDelete,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                //onLeftGridRowDblClick({});
                var guestOrderMainList = data.guestOrderMainList;
                if(guestOrderMainList && guestOrderMainList.length>0) {
                    var leftRow = guestOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);

                    
                }
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
    data.status = '';

    delete data.createDate;	
    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    if (data.orderDate) {
  	  data.orderDate = format(data.orderDate, 'yyyy-MM-dd HH:mm:ss');
  	}
    if (data.planSendDate) {
	  data.planSendDate = format(data.planSendDate, 'yyyy-MM-dd HH:mm:ss');
	}
    if (data.planArriveDate) {
	  data.planArriveDate = format(data.planArriveDate, 'yyyy-MM-dd HH:mm:ss');
	}
    if(!data.billTypeId){
        data.billTypeId = "010103";
    }
    
    //是否开单
	if(isBilling ==1){
		data.isBilling=1;
	}else{
		data.isBilling=0;
	}
	var showAmt =0;
	var rows =rightGrid.getData();
	for (var i = 0; i < rows.length; i++) {
		if(rows[i].showAmt){
			showAmt += parseFloat(rows[i].showAmt);
		}
		
	}
	data.showAmt =showAmt;
	
    rightGrid.findRow(function(row){
        var partId = row.partId;
        var partCode = row.comPartCode;
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

  //是业务员且业务员禁止可见
	if(currIsSalesman ==1 && currIsOnlySeeOwn==1){
		params.creator= currUserName;
	}
	if(currIsSalesman ==1 &&currIsCanViewOtherBill ==1){
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
            
            if(autoNew == 0){
				add();
				autoNew = 1;
			}
            
        }else {
            var row = leftGrid.getSelected();
            if(currIsSalesman ==1 &&currIsCanSubmitOtherBill ==1 && row.creator !=currUserName ){
				nui.get("auditBtn").disable();
			}else {
				nui.get("auditBtn").enable();
			}
            if(row.auditSign == 1 || row.status==4) {
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
function advancedSearch()
{
    advancedSearchWin.show();
    moreSearchShow=1;
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
        searchData.sCreateDate = formatDate(searchData.sCreateDate);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        
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
    searchData.auditSign = gsparams.auditSign;
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
function checkNew() 
{
    var rows = leftGrid.findRows(function(row){
        if(row.serviceId == "新预售单") return true;
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
        case "orgCarBrandId" :
    		if(compBrandHash[e.value]) {
    			e.cellHtml = compBrandHash[e.value].name;
    		}else {
    			e.cellHtml = "";
    		}
    		break;
        case "operateBtn":
            e.cellHtml = //'<span class="icon-remove" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';/*'<span class="icon-add" onClick="javascript:addPart()" title="添加行">&nbsp;&nbsp;&nbsp;&nbsp;</span>' +
                        '<span class="fa fa-plus" onClick="javascript:addNewRow(true)" title="添加行">&nbsp;&nbsp;</span>' +
                        ' <span class="fa fa-close" onClick="javascript:deletePart()" title="删除行"></span>';
            break;
        case "storeId":
        	if(storeHash[e.value])
            {
//                e.cellHtml = brandHash[e.value].name||"";
            
            		
            		e.cellHtml =storeHash[e.value].name; 
            }
            else{
                e.cellHtml = "";
            }
            break;
        default:
            break;
    }
}

var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.guestOrder.auditGuestOrder.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.status != 0) {
            showMsg("单据状态不是草稿状态，不能提交!","W");
            return;
        } 
    }else{
        return;
    }


 
    //审核时，判断是否存在缺货信息
    var msg = checkRightData();
    if(msg){
        showMsg(msg,"W");
        return;
    }
    
  //开启额度管理
    if(currIsOpenCredit ==1  && data.id){
    	 var flag = beforeSave();
    	    if(flag ==false){
    	    	return;
    	    }
    }

    data = getMainData();

    var guestOrderDetailAdd = rightGrid.getChanges("added");
    var guestOrderDetailUpdate = rightGrid.getChanges("modified");
    var guestOrderDetailDelete = rightGrid.getChanges("removed");
    var guestOrderDetailList = rightGrid.getData();
    if(guestOrderDetailList.length <= 0) {
        showMsg("订单明细为空，不能提交!","W");
        return;
    }
    
    getStoreLimit();
	var rightRow =rightGrid.getData();
	for(var i=0;i<rightRow.length;i++){
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(row.storeId) && storeHash[row.storeId]){
				showMsg("没有选择"+storeHash[row.storeId].name+"的权限","W");
				return;
			}
		}
	}

	if(currIsOpenApp ==1){
		// set集合
	    var set =new  Set();
		for(var i=0;i<rightRow.length;i++){
			if(!rightRow[i].partId){
				rightGrid.removeRow(rightRow[i]);
				continue;
			}
			set.add(rightRow[i].partId+"-"+data.storeId);
		}
		if(set.size <rightGrid.getData().length){
			showMsg("订单明细不能出现相同配件同个仓库两次以上","W");
			return;
		}

	}
	
	 guestOrderDetailUpdate =  getModifyData(guestOrderDetailList, guestOrderDetailAdd, guestOrderDetailDelete);

   
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            guestOrderMain : data,
            guestOrderDetailAdd : guestOrderDetailAdd,
            guestOrderDetailUpdate : guestOrderDetailUpdate,
            guestOrderDetailDelete : guestOrderDetailDelete,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("提交成功!","S");
                //onLeftGridRowDblClick({});
                var guestOrderMainList = data.guestOrderMainList;
                if(guestOrderMainList && guestOrderMainList.length>0) {
                    var leftRow = guestOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                    nui.confirm("提交成功,是否打印？", "友情提示", function(action) {
    					if(action== 'ok'){
    						onPrint();
    					}else{
    						rightGrid.setData([]);
    						add();
    					}
    				});
                }
            } else {
                showMsg(data.errMsg || "退货失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

var finishUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.generatePchsOut.biz.ext";
//完成销售
function finish()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.status != 2) {
            showMsg("单据不是已受理状态,不能完成销售!","W");
            return;
        } 
    }else{
        return;
    }

    //审核时，判断是否存在缺货信息
    var msg = checkRightData();
    if(msg){
        showMsg(msg,"W");
        return;
    }

    data = getMainData();
   
    var cangHash ="";
	if(currIsOpenApp ==1){
//		cangHash=getCangHash(data,sellOrderDetailList);
	}

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : finishUrl,
        type : "post",
        data : JSON.stringify({
            id : data.id,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("完成销售，请到销售出库明细表中查看销售记录!","S");

                var row = leftGrid.getSelected();
                var newRow =nui.clone(row);
                newRow.status=3;
                leftGrid.updateRow(row,newRow);

                //保存成功后重新加载数据
                loadMainAndDetailInfo(newRow);
       
                
            } else {
                showMsg(data.errMsg || "失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

var auditToOutUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditSellOrderToOutTran.biz.ext";
function auditToOut()
{

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            showMsg("此单已退货!","W");
            return;
        } 
    }else{
        return;
    }

    if(row.auditSign != 1) {
        showMsg("请先提交，再出库!","W");
        return;
    } 

    // var isRtnSign = row.isRtnSign;
    // if(isRtnSign == 0){
    //     showMsg("待供应商受理后才可出库!","W");
    //     return;
    // }

    var data = basicInfoForm.getData();
    var mainId = data.id;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : auditToOutUrl,
        type : "post",
        data : JSON.stringify({
            mainId : mainId,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("出库成功!","S");
                var newRow = {isOut: 1};
                leftGrid.updateRow(row, newRow);

                setBtnable(false);
				loadMainAndDetailInfo(leftRow);
                nui.confirm("是否打印？", "友情提示", function(action) {
					if(action== 'ok'){
						onPrint();
					}else{
						rightGrid.setData([]);
						add();
					}
				});
                
            } else {
                showMsg(data.errMsg || "出库失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onPrint(){
	var from = basicInfoForm.getData();
	var params={
			id : from.id,
		auditSign:from.auditSign,
		guestId :from.guestId,
		currRepairSettorderPrintShow : currRepairSettorderPrintShow,
		currOrgName : currOrgName,
		currUserName : currUserName,
		currCompAddress : currCompAddress,
		currCompTel : currCompTel,
		currCompLogoPath : currCompLogoPath,
		storeHash : storeHash,
		brandHash: brandHash
	};
	var detailParams={
			mainId :from.id,
			auditSign:from.auditSign
	};
	var openUrl = webPath + contextPath+"/purchase/guestOrder/guestOrderPrint.jsp";

    nui.open({
       url: openUrl,
       width: "10%",
       height: "10%",
       showMaxButton: false,
       allowResize: false,
       showHeader: true,
       onload: function() {
           var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(params,detailParams);
       },
   });
    /*if(checkNew() > 0){
    	return;
    }
    rightGrid.setData([]);
	add();*/
	
}

function add()
{
    if(isNeedSet){
        showMsg("请先到仓库定义功能设置仓库!","W");
        return;
    }

    if(checkNew() > 0) 
    {
        showMsg("请先保存数据!","W");
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

                    nui.get("guestId").enable();

                    basicInfoForm.reset();
                    rightGrid.clearRows();
                    
                    var newRow = { serviceId: '新预售单', auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新预售单");
                    nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
                    nui.get("storeId").setValue(FStoreId);
//                    nui.get("createDate").setValue(new Date());
                    nui.get("orderDate").setValue(new Date());
                    nui.get("orderMan").setValue(currUserName);
                    nui.get("businessTypeId").setValue("1591934420679");//正常销售
                    
                    nui.get("isBilling").setValue(0);
                    nui.get("isEditPart").setValue(0);
             	    billingChange();
                    
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

        nui.get("guestId").enable();

        basicInfoForm.reset();
        rightGrid.clearRows();
        
        var newRow = { serviceId: '新预售单', auditSign: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新预售单");
        nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
        nui.get("storeId").setValue(FStoreId);
//        nui.get("createDate").setValue(new Date());
        nui.get("orderDate").setValue(new Date());
        nui.get("orderMan").setValue(currUserName);
        nui.get("businessTypeId").setValue("1591934420679");//正常销售
        
        nui.get("isBilling").setValue(0);
        nui.get("isEditPart").setValue(0);
 	    billingChange();

        addNewRow();
        var guestId = nui.get("guestId");
        guestId.focus();
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
    }else {
        var newRow = {};
        if (e.field == "orderQty") {
            var orderQty = e.value;
            var orderPrice = record.orderPrice;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                orderQty = 0;
            }else if(e.value < 0) {
                e.value = 0;
                orderQty = 0;
            }
            
            var orderAmt = orderQty * orderPrice;                  
            var showPrice =  record.showPrice;
            var showAmt = orderQty* showPrice;
            //开单
            if(isBilling==1){
            	newRow = { orderAmt: orderAmt,showAmt:showAmt};
            }else{
            	var showAmt = orderAmt;
            	newRow = { orderAmt: orderAmt,showAmt:showAmt};
            }
//            newRow = { orderAmt: orderAmt};
            rightGrid.updateRow(e.row, newRow);
            
            //record.enteramt.cellHtml = enterqty * enterprice;
        }else if (e.field == "orderPrice") {
            var orderQty = record.orderQty;
            var orderPrice = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                orderPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                orderPrice = 0;
            }
            
            var orderAmt = orderQty * orderPrice; 
                           
          //开单
            if(isBilling==1){
            	newRow = { orderAmt: orderAmt};
            }else{
            	var showAmt = orderAmt;
            	var showPrice=orderPrice;
            	newRow = { orderAmt: orderAmt,showAmt:showAmt,showPrice:showPrice };
            }
            
//            newRow = { orderAmt: orderAmt};
            rightGrid.updateRow(e.row, newRow);

            if(orderPrice){
                rightGrid.commitEditRow(row);
//                mainTabs.activeTab(billmainTab);
            }
            
        }else if (e.field == "orderAmt") {
            var orderQty = record.orderQty;
            var orderAmt = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                orderAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                orderAmt = 0;
            }
            
            //e.cellHtml = enterqty * enterprice;
            var orderPrice = (orderAmt*1.0/orderQty).toFixed(4);
            
            if(orderQty) {
            	//开单
                if(isBilling==1){
                	newRow = { orderPrice: orderPrice};
                }else{
                	var showAmt = orderAmt;
                	var showPrice=orderPrice;
                	newRow = { orderPrice: orderPrice,showAmt:showAmt,showPrice:showPrice };
                }
                
//                newRow = { orderPrice: orderPrice};
                rightGrid.updateRow(e.row, newRow);
            }
            
        }else if(e.field == "comPartCode"){
            oldValue = e.oldValue;
            oldRow = row;
            /*if(!e.value){
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
                    //rightGrid.beginEditCell(row, "comUnit");
                }
            }*/
            
        }else if(e.field == "showPartCode"){
	       	 oldValue2 = e.oldValue;
	         oldRow2 = row;
	    }else if(e.field =="showPrice"){
	    	 var orderQty = record.orderQty;
	         var showPrice = e.value;
	         var orderPrice = record.orderPrice;
            if(showPrice<orderPrice){
	           	 e.value =e.oldValue;
	           	 showMsg("开单价不能低于销售价","W");
	           	 return;
            }
	         if(e.value==null || e.value=='') {
	             e.value = 0;
	             showPrice = 0;
	         }else if(e.value < 0) {
	             e.value = 0;
	             showPrice = 0;
	         }
	         
	         var showAmt = orderQty * showPrice;             
	       //开单             
	     	newRow = { showAmt: showAmt};
	     	rightGrid.updateRow(e.row, newRow);
	         
	    }else if(e.field =="showAmt"){
	    	 var orderQty = record.orderQty;
	         var showAmt = e.value;
	         var orderAmt = record.orderAmt;
	         
	         if(showAmt<orderAmt){
	           	 e.value =e.oldValue;
	           	 showMsg("开单价不能低于销售价","W");
	           	 return;
            }
	         
	         if(e.value==null || e.value=='') {
	             e.value = 0;
	             showAmt = 0;
	         }else if(e.value < 0) {
	             e.value = 0;
	             showAmt = 0;
	         }
	         
	         //e.cellHtml = enterqty * enterprice;
	         var showPrice = (showAmt*1.0/orderQty).toFixed(4);
	       
	         if(orderQty) {
	         	//开单
	             if(isBilling==1){
	             	newRow = { showPrice: showPrice};
	             	rightGrid.updateRow(e.row, newRow);
	             }
	            
	         }
	    }
    }
}
function onCellEditEnter(e){
    var record = e.record;
    var cell = rightGrid.getCurrentCell();//行，列
    var orderPrice = record.orderPrice;
    if(cell && cell.length >= 2){
        var column = cell[1];
        if(column.field == "orderQty"){
            if(orderPrice){
                addNewKeyRow();
            }
        }else if(column.field == "orderPrice"){
            addNewKeyRow();
        }else if(column.field == "remark"){
            addNewKeyRow();
        }else if(column.field == "comPartCode"){
            if(!record.comPartCode){
                showMsg("请输入编码!","W");
                var row = rightGrid.getSelected();
                rightGrid.removeRow(row);
                addNewRow(false);
                return;
            }else{
                var rs = addInsertRow(record.comPartCode,record);
                if(!rs){
                    var newRow = {comPartCode: ""};
                    rightGrid.updateRow(record, newRow);
                    rightGrid.beginEditCell(record, "comPartCode");
                    return;
                }else{
                    rightGrid.beginEditCell(record, "comUnit");
                }
            }
        }
        else if(column.field == "showPartCode"){
        	var partCode = record.showPartCode||"";
            partCode = partCode.replace(/(^\s*)|(\s*$)/g, "");
			if(!partCode){
				showMsg("请输入编码!","W");
				return;
			}else{
				var rs = addInsertRow2(partCode,record);
				if(!rs){
					var newRow = {showPartCode: oldValue2};
					rightGrid.updateRow(record, newRow);
					return;
				}
			}
        }
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
var partInfoUrl = baseUrl
        + "com.hsapi.cloud.part.invoicing.paramcrud.queryPartInfoByParam.biz.ext";
function getPartInfo(params){
	if(currIsOpenApp==1){
		params.onlyOrgid =currOrgid;
	}
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
                    partShow = 1;
					event.keyCode = null;
                }
                
            }else{
                //清空行数据
                showMsg("没有搜索到配件信息!","W");
                var row = rightGrid.getSelected();
                rightGrid.removeRow(row);
                addNewRow(false);
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });

    return part;
}

function getPartInfo2(params){
	var part = null;
	var page = {size:100,length:100};
//	params.sortField = "b.stock_qty";
//	params.sortOrder = "desc";
	//仓先生
	if(currIsOpenApp ==1){
	params.showStock=2;
	}
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
			//如果有替换件(不直接添加)
			if(partlist.length==1 && partlist[0].commonId==0){
				part = partlist[0];
	
			}else{
				advancedMorePartWin2.show();
				morePartGrid2.setData(partlist);
				partShow = 1;
			    var row = morePartGrid2.getRow(0);
		        if(row){
		            morePartGrid2.select(row,true);
		        }
		        partIn=false;
				//mainTabs.activeTab(partInfoTab);
				//var partCode = params.partCode;
				//var partName = params.partName;
				//var param = {code:partCode, name:partName};
				//document.getElementById("formIframePart").contentWindow.initData(params.partCode);
				//mainTabs.getTabIFrameEl(partInfoTab).contentWindow.initData(params.partCode);
			}
			
		}else{
			//清空行数据
			// nui.confirm("没有搜索到配件信息，是否需要新增?", "友情提示", function(action) {
			// 	if (action == "ok") {
	
			// 		var row = rightGrid.getSelected();
			// 		rightGrid.removeRow(row);
			// 		addNewRow(false);
			// 	} else {
			// 		var row = rightGrid.getSelected();
			// 		rightGrid.removeRow(row);
			// 		addNewRow(false);
			// 		return;
			// 	}
			// });
			showMsg("没有搜索到配件信息!","W");
			var newRow = {showPartCode: oldValue2};
			rightGrid.updateRow(oldRow2, newRow);
//			var row = rightGrid.getSelected();
//			
//			nui.confirm("是否添加配件?", "友情提示", function(action) {
//				
//				if (action == "ok") {
//					addOrEditPart(row);
//				}
//				else{
//					return;
//				}
//				});
//	//		rightGrid.removeRow(row);
	//		addNewRow(false);
			/*var row = rightGrid.getSelected();
			var newRow = {comPartCode: ""};
	
			rightGrid.cancelEdit();
			rightGrid.updateRow(row, newRow);
			rightGrid.beginEditCell(row,"comPartCode");*/
		}
	
	},
	error : function(jqXHR, textStatus, errorThrown) {
		// nui.alert(jqXHR.responseText);
		console.log(jqXHR.responseText);
	}
	});
	
	return part;
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
function addInsertRow(value, row) {    
	value=value.replace(/(^\s*)|(\s*$)/g, "");
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请先选择客户再添加配件!","W");
        return;
    }
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

//给修改的配件用
function addInsertRow2(value,row) {    

    var params = {partCode:value.replace(/(^\s*)|(\s*$)/g, "")};
	var part = getPartInfo2(params);

	if(part){
					
		var newRow = {
			showPartId : part.id,
			showPartCode : part.code,
			showCarModel : part.applyCarModel,
			showOemCode : part.oemCode,
			showFullName : part.fullName,
			showSpec    : part.spec
		};
		if(brandHash[part.partBrandId]){
			newRow.showBrandName=brandHash[part.partBrandId].name|| "";
		}
		
		if(row){
			rightGrid.updateRow(row,newRow);
			//rightGrid.beginEditCell(row, "comUnit");
		}else{
			rightGrid.addRow(newRow);
			//rightGrid.beginEditCell(row, "comUnit");
		}
	
		return true;
	}else{
		var newRow = {showPartCode:oldValue2};
		if(row){
			rightGrid.updateRow(row,newRow);
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
    var data = rightGrid.getData();
    if(data && data.length==1){
        var row = rightGrid.getSelected();
        rightGrid.removeRow(row);
        var newRow = {};
        rightGrid.addRow(newRow);
        rightGrid.beginEditCell(newRow, "comPartCode");
    }else{
        var row = rightGrid.getSelected();
        rightGrid.removeRow(row);
    }
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
                if(row.orderPrice < 0) return true;
            }else{
                return true;
            }
            if(row.orderAmt){
                if(row.orderAmt < 0) return true;
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
		var row = leftGrid.getSelected();
		var newRow = {
			guestFullName : text
		};
		leftGrid.updateRow(row, newRow);

		var billTypeIdV = data.billTypeId;
		var settTypeIdV = data.settTypeId;

		nui.get("billTypeId").setValue(billTypeIdV);
		nui.get("settleTypeId").setValue(settTypeIdV);

		addNewRow(true);
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


                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text};
                    leftGrid.updateRow(row,newRow);

                    var billTypeIdV = data.billTypeId;
                    var settTypeIdV = data.settTypeId;

                    nui.get("billTypeId").setValue(billTypeIdV);
                    nui.get("settleTypeId").setValue(settTypeIdV);
                    //nui.get("isNeedPack").setValue(data.isNeedPack);

                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);

                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: null};
                    leftGrid.updateRow(row,newRow);
                    //nui.get("isNeedPack").setValue(0);

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
                //nui.get("isNeedPack").setValue(0);
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function addSelectPart(){
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请先选择客户再添加配件!","W");
        return;
    }
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
            outUnitId : row.unit,
            showPartId : row.id,
			showPartCode : row.code,
			showBrandName :"",
			showCarModel : row.applyCarModel,
			showOemCode : row.oemCode,
			showFullName : row.fullName
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
        showMsg("请选择配件!","W");
        return;
    }
}

function addSelectPart2(){
	
	var row = morePartGrid2.getSelected();
	row.partId =row.id;
	if(row){			
		var newRow = {
			showPartId : row.id,
			showPartCode : row.code,
			showBrandName :"",
			showCarModel : row.applyCarModel,
			showOemCode : row.oemCode,
			showFullName : row.fullName
		};
		if(brandHash[row.partBrandId]){
			newRow.showBrandName =brandHash[row.partBrandId].name;
		}
		advancedMorePartWin2.hide();
		morePartGrid2.setData([]);
		partShow = 0;

		if(rightGrid.getSelected()){
			rightGrid.updateRow(rightGrid.getSelected(),newRow);
		}else{
			rightGrid.addRow(newRow);
		}
	
		
	}else{
		showMsg("请选择配件!","W");
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

function onPartClose2(){
    advancedMorePartWin2.hide();
    morePartGrid2.setData([]);
    partShow = 0;
	var newRow = {showPartCode: oldValue2};
	rightGrid.updateRow(oldRow2, newRow);
	rightGrid.beginEditCell(oldRow2, "showPartCode");
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

    if(e.field=="storeId"){
    	e.cancel = true;
    }
    
    if(e.field == 'storeId'){
    	editor.setData(storehouse);
    }
    if(row.partId) {
    	
        if(row.isMarkBatch && row.isMarkBatch == 1){
            if(column.field != "remark" 
            	&& column.field != "showPrice" && column.field != "showAmt" && column.field != "showPartCode"){
                e.cancel = true;
            }
           
        }else{
            if(column.field != "remark" && column.field != "orderQty" && column.field != "orderPrice" && column.field != "orderAmt" && column.field != "storeId" && column.field != "storeShelf"
            	&& column.field != "showPrice" && column.field != "showAmt" && column.field != "showPartCode" && column.field != "comPartCode"){
                e.cancel = true;
            }
        }  
    }
    
    if(advancedMorePartWin.visible) {
		e.cancel = true;
		morePartGrid.focus();
		var row = morePartGrid.getRow(0);   //默认不能选中，回车事件会有影响
        if(row){
            morePartGrid.select(row,true);
        }
        partIn=false;
	}
    
    if(advancedMorePartWin2.visible) {
		e.cancel = true;
		morePartGrid2.focus();
		var row = morePartGrid2.getRow(0);   //默认不能选中，回车事件会有影响
        if(row){
            morePartGrid.select(row,true);
        }
        partIn=false;
	}

}
function addMorePart(){
    var row = leftGrid.getSelected();
    if(row.auditSign == 1){
        showMsg("此单已提交!","W");
        return;
    }

    var main = basicInfoForm.getData();
    if(!main.id){
        showMsg("请先保存数据!","W");
        return;
    }
    var data = rightGrid.getChanges()||[];
    if (data.length>0) {
        showMsg("请先保存数据!","W");
        return;
    }
    advancedAddForm.setData([]);
    advancedAddWin.show();
    partShow = 1;
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
function addDetail(row,data,ck)
{
    var maindata = leftGrid.getSelected();
    if(maindata){
        if(maindata.auditSign == 1) {
            showMsg("此单已提交!","W");
            return;
        } 
    }else{
        return;
    }
    
    var p = {};
    var newRow = {};
    var enterDetail = {};
    if(data.isMarkBatch && data.isMarkBatch == 1){
        enterDetail.partId = data.partId;
        enterDetail.comPartCode = data.partCode;
        enterDetail.comPartName = data.partName;
        enterDetail.isMarkBatch = 1;
        enterDetail.batchSourceId = data.batchSourceId;
        enterDetail.comUnit = data.enterUnitId;     
        enterDetail.systemUnitId = data.enterUnitId; 
        enterDetail.outUnitId = data.enterUnitId;
    }else{
        enterDetail.partId = data.id;
        enterDetail.comPartCode = data.code;
        enterDetail.comPartName = data.name;
        enterDetail.isMarkBatch = 0;
        enterDetail.comUnit = data.unit;
        enterDetail.systemUnitId = data.unit; 
        enterDetail.outUnitId = data.unit;
    }
    enterDetail.comPartBrandId = data.partBrandId;
    enterDetail.comApplyCarModel = data.applyCarModel;
    enterDetail.orderQty = data.qty;
    enterDetail.orderPrice = data.price;
    enterDetail.orderAmt = data.amt;
    enterDetail.remark = data.remark;
    enterDetail.storeId = data.storeId;
    enterDetail.storeShelf = data.storeShelf;
    enterDetail.comOemCode = data.oemCode;
    enterDetail.comSpec = data.spec;
    enterDetail.partCode = data.code;
    enterDetail.partName = data.name;
    enterDetail.fullName = data.fullName;
    enterDetail.serviceId = row.serviceId;
    enterDetail.mainId = row.mainId;
    
    //开单和修改配件的信息赋默认值
    enterDetail.showPrice = enterDetail.orderPrice;
    enterDetail.showAmt = enterDetail.orderAmt;
    enterDetail.showPartId = enterDetail.partId;
    enterDetail.showPartCode = enterDetail.comPartCode;
    enterDetail.showFullName = enterDetail.fullName;
    enterDetail.showCarModel = enterDetail.comApplyCarModel;
    enterDetail.showOemCode = enterDetail.comOemCode;
    enterDetail.showSpec = enterDetail.comSpec;
    if(brandHash[data.partBrandId]){
    	enterDetail.showBrandName =brandHash[data.partBrandId].name;
    }
    

    //if(row){
        //rightGrid.updateRow(row,enterDetail);
    saveDetail(enterDetail, function(data,p){
        enterDetail.id = data.id;
        enterDetail.occupyQty = data.occupyQty;
        enterDetail.stockOutQty = data.stockOutQty;
        enterDetail.notOutQty = data.notOutQty;
        enterDetail.notOutAmt = data.notOutAmt;
        enterDetail.trueOutQty = data.trueOutQty;
        enterDetail.trueOutAmt = data.trueOutAmt;
        rightGrid.addRow(enterDetail);
        //改变行的状态
        delete enterDetail._state;
        p = p;
        ck && ck(p);
    });
    //rightGrid.beginEditCell(newRow, "comPartCode");

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
        showMsg("请选择客户!","W");
        return;
    }

    rightGrid.findRow(function(row){
        var partId = row.partId;
        var partCode = row.comPartCode;
        if(partId == null || partId == "" || partId == undefined || partCode == null || partCode == "" || partCode == undefined){
            rightGrid.removeRow(row);
        }
    });

    selectPart(function(data) {
        addDetail(data);
    },function(data) {
        var part = data.part;
        var partid = part.id;
        //var rtn = checkPartIDExists(partid);
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
        return "配件编码："+row.comPartCode+"在销售退货列表中已经存在，是否继续？";
    }
    
    return null;
    
}
//function addDetail(rows)
//{
//    //var iframe = this.getIFrameEl();
//    //var data = iframe.contentWindow.getData();
//    for(var i=0; i<rows.length; i++){
//        var row = rows[i];
//        var newRow = {
//            partId : row.partId,
//            comPartCode : row.comPartCode,
//            comPartName : row.comPartName,
//            comPartBrandId : row.comFullName,
//            comApplyCarModel : row.comApplyCarModel,
//            comUnit : row.comUnit,
//            orderQty : row.orderQty,
//            orderPrice : row.orderPrice,
//            orderAmt : row.orderAmt,
//            storeId : row.storeId,
//            comOemCode : row.comOemCode,
//            comSpec : row.comSpec,
//            partCode : row.comPartCode,
//            partName : row.comPartName,
//            fullName : row.comFullName,
//            systemUnitId : row.comUnit,
//            outUnitId : row.comUnit
//        };
//
//
//        rightGrid.addRow(newRow);
//    }
//
//}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title : "往来单位资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1
//                guestType:'01020202'
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
                var billTypeIdV = supplier.billTypeId;
                var settTypeIdV = supplier.settTypeId;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

                if (elId == 'guestId') {
                    var row = leftGrid.getSelected();
                    var newRow = {
                        guestFullName : text,
                        billTypeId: billTypeIdV,
                        settleTypeId: settTypeIdV
                    };
                    leftGrid.updateRow(row, newRow);

                    nui.get("billTypeId").setValue(billTypeIdV);
                    nui.get("settleTypeId").setValue(settTypeIdV);

                }
                
                if(elId == 'settleGuestName') {
                	nui.get("settleGuestId").setValue(value);
                }
            }
        }
    });
}



function getCangHash(data,detailData){
	getGuest(data.guestId);
	var cangHash ={};
	var dataList=[];
	var stockHash={};
	var partIdList ="";
	if(currAgencyId && currAgencyId>0){
		cangHash.agency_id= currAgencyId;
		cangHash.stock_id =data.id;
		cangHash.stock =data.serviceId;
		cangHash.stock_type_name ="采购退货订单";
		cangHash.stock_type_id =3;
		cangHash.stock_args ="";
		cangHash.direct ="out";
	}
	for(var i =0;i<detailData.length;i++){
		partIdList=partIdList+detailData[i].partId+",";
	}
	partIdList=partIdList.substring(0,partIdList.length-1);
	getPart(partIdList);
	for(var i =0;i<detailData.length;i++){
		var temp={};
		var warehouse=[];
		var warehousetemp={};
		var part_id=detailData[i].partId;
		if(!partHash[part_id].cangPartId){
			showMsg("该配件未同步仓先生","W");
			return;
		}
		temp.part_id=partHash[part_id].cangPartId || "" ;
		if(!temp.part_id){
			showMsg("该配件未同步仓先生","W");
			return;
		}
		temp.detailId = detailData[i].id;
		warehousetemp.num =detailData[i].orderQty;
		if(storeHash && storeHash[detailData[i].storeId]){
			warehousetemp.wid =storeHash[detailData[i].storeId].cangStoreId || "";
		}
		
		warehouse.push(warehousetemp);
		temp.warehouse =warehouse;
		dataList.push(temp);
	}
	stockHash.data= dataList;
	stockHash.company= company;
	stockHash.phone= phone;
	stockHash.addr= addr;
	stockHash.stock_create_time= format(new Date(), 'yyyy-MM-dd HH:mm:ss');
	cangHash.stock_args=JSON.stringify(stockHash);
	return cangHash;
}

var company="";
var phone ="";
var addr ="";
var supplierUrl=baseUrl +"com.hsapi.cloud.part.baseDataCrud.crud.queryGuestList.biz.ext";
function getGuest(guestId){
	$.ajaxSettings.async = false;
	$.post(supplierUrl+"?params/guestId="+guestId+"&token="+token,{},function(text){
		var guest=text.guest[0];
		company =guest.fullName || "";
		phone =guest.mobile ||"";
		addr =guest.addr || "";
	});
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

function importPart(){
    var row = leftGrid.getSelected();
	if(row.auditSign == 1){
		showMsg("此单已审核!","W");
		return;
	}

	var main = basicInfoForm.getData();
	if(!main.id){
		showMsg("请先保存单据!","W");
		return;
	}

    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.purchase.getPartInfoImoprt.flow?token="+token,
        title: "配件导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.initData(function(data,msg){
				if(data && data.length > 0){
					addImportRtnList(data,msg);
				}
			});
        },
        ondestroy: function (action)
        {
            var mainId = data.id;
            loadRightGridData(mainId);
        }
    });
}

function addImportRtnList(partList,msg){
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
				orderQty : orderQty,
				orderPrice : orderPrice,
				orderAmt : orderQty * orderPrice,
				storeId : FStoreId,
				comOemCode : part.oemCode,
				comSpec : part.spec,
				partCode : part.partCode,
				partName : part.partName,
				fullName : part.fullName,
				systemUnitId : part.unit,
				enterUnitId : part.unit,
				remark: part.remark
			};

			rows.push(newRow);
		}	

		rightGrid.addRows(rows);		
		
	}
	if(msg){
		nui.get("imprtPastCodeList").setValue("");
		nui.get("imprtPastCodeList").setValue(msg);
		advancedTipWin.show();
	}
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
		setInitExportData(main, detail);
	}
}
function setInitExportData(main, detail){
	document.getElementById("eServiceId").innerHTML = main.serviceId?main.serviceId:"";
    document.getElementById("eGuestName").innerHTML = main.guestFullName?main.guestFullName:"";
    document.getElementById("eRemark").innerHTML = main.remark?main.remark:"";
    var tds = '<td  colspan="1" align="left">[showPartCode]</td>' +
        "<td  colspan='1' align='left'>[showFullName]</td>" +
        "<td  colspan='1' align='left'>[showCarModel]</td>" +
        "<td  colspan='1' align='left'>[comUnit]</td>" +
        "<td  colspan='1' align='left'>[orderQty]</td>" +
        "<td  colspan='1' align='left'>[showPrice]</td>" +
        "<td  colspan='1' align='left'>[showAmt]</td>" +
        "<td  colspan='1' align='left'>[orderPrice]</td>" +
        "<td  colspan='1' align='left'>[orderAmt]</td>" +
        "<td  colspan='1' align='left'>[remark]</td>";
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.partId){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[showPartCode]", detail[i].showPartCode?detail[i].showPartCode:"")
                         .replace("[showFullName]", detail[i].showFullName?detail[i].showFullName:"")
                         .replace("[showCarModel]", detail[i].showCarModel?detail[i].showCarModel:"")
                         .replace("[comUnit]", detail[i].comUnit?detail[i].comUnit:"")
                         .replace("[orderQty]", detail[i].orderQty?detail[i].orderQty:"")
                         .replace("[showPrice]", detail[i].showPrice?detail[i].showPrice:"")
                         .replace("[showAmt]", detail[i].showAmt?detail[i].showAmt:"")
                         .replace("[orderPrice]", detail[i].orderPrice?detail[i].orderPrice:"")
                         .replace("[orderAmt]", detail[i].orderAmt?detail[i].orderAmt:"")
                         .replace("[remark]", detail[i].remark?detail[i].remark:""));
            tableExportContent.append(tr);
        }
    }
    var serviceId = main.serviceId?main.serviceId:"";
    method5('tableExcel',"预销售单"+serviceId,'tableExportA');
}

function getDueAmt(pr,pp){
	var dueAmt =0;
	nui.ajax({
        url : baseUrl+ "com.hsapi.cloud.part.settle.svr.queryBillsDue.biz.ext",
        type : "post",
        data : {pr: pr,pp:pp ,token: token},
        async: false,
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                dueAmt =data.dueAmt;
                
            } else {
                showMsg(data.errMsg ,"W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
	return dueAmt;
}


function chooseMember(){
	 //销售单
	  var serviceType=3;
	  var row = leftGrid.getSelected();
	    if(row){
	    	if(row.auditSign ==1){
	    		showMsg("单据已审核,不能修改");
	    		return;
	    	}
	        if(row.id) {
	            nui.open({
	                // targetWindow: window,
	                url: webBaseUrl+"com.hsweb.cloud.part.basic.selectMember.flow?token="+token,
	                title: "选择提成成员", 
	                width: 880, height: 650,
	                showHeader:true,
	                allowDrag:true,
	                allowResize:true,
	                onload: function ()
	                {
	                    var iframe = this.getIFrameEl();
	                    iframe.contentWindow.setData(row.id,serviceType);
	                },
	                ondestroy: function (action)
	                {

	                }
	            });
	        }else{
	            showMsg("请先选择订单!","W");
	            return;
	        }
	    }else{
	        return;
	    }
}

function showDueDetail(){
	var row =leftGrid.getSelected();
	if(!row){
		showMsg("请选择一条记录");
		return;
	}
	
	 nui.open({
         url: webBaseUrl+"com.hsweb.cloud.part.common.showDueDetail.flow?token="+token,
         title: "客户欠款记录", 
         width: 880, height: 650,
         showHeader:true,
         allowDrag:true,
         allowResize:true,
         onload: function ()
         {
        	 var params={}
        	 params.guestId =row.guestId;
             var iframe = this.getIFrameEl();
             iframe.contentWindow.setData(params);
         },
         ondestroy: function (action)
         {

         }
     });
}

//是否开单
function billingChange(){
	isBilling =nui.get("isBilling").getValue();
	var columnsList = [];
    columnsList=rightGrid.columns;
    var index =0;
    var billingList=[];
    for(var i=0;i<columnsList.length;i++){
    	if(columnsList[i].header=="开单信息"){
    		billingList=columnsList[i];
    		index=i;
    		 break;
    	}
    }
	if(isBilling==1){
		billingList.visible=true;
		columnsList[index]=billingList;
		rightGrid.set({
	        columns: columnsList
	    });
	}else{
		billingList.visible=false;
		columnsList[index]=billingList;
		rightGrid.set({
	        columns: columnsList
	    });
	}
	
}
//是否修改配件
function partChange(){
	isEditPart =nui.get("isEditPart").getValue();
	var columnsList = [];
    columnsList=rightGrid.columns;
    var index =0;
    var editPartList=[];
    for(var i=0;i<columnsList.length;i++){
    	if(columnsList[i].header=="修改的配件信息"){
    		editPartList=columnsList[i];
    		index=i;
    		 break;
    	}
    }
	if(isEditPart==1){
		editPartList.visible=true;
		columnsList[index]=editPartList;
		rightGrid.set({
	        columns: columnsList
	    });
	}else{
		editPartList.visible=false;
		columnsList[index]=editPartList;
		rightGrid.set({
	        columns: columnsList
	    });
	}
	
}

function onSettleTypeIdValueChanged(e) {
	var data = e.selected;
	if(data.customid == "020502") {//月结
		showMsg("现结不可修改为月结","W");
		nui.get("settleTypeId").setValue("020501");
	}
}


function onStoreIdValueChange(e){
	var data = e.selected;
	var rows =rightGrid.getData();
	var changes=[];
	if(data){
		
		var id = data.id;
		var orderMan =nui.get('orderMan').value;
		//if(orderMan !=currUserName){
		getStoreLimit();
		//}
		if(Object.getOwnPropertyNames(storeLimitMap ).length ==0){
			//不做限制
		}
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(id) && storeHash[id].name){
				showMsg("没有选择"+storeHash[id].name+"的权限","W");
				//return;
			}
		}
		
		if(rows.length>0){
			for(var i=0;i<rows.length;i++){
				if(rows[i].partId){
					rows[i].storeId =data.id;
				}
			}
			rightGrid.setData(rows);
		}
	}
}
