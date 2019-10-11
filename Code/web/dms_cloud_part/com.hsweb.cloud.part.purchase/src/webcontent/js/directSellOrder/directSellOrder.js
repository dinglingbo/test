/**
 * Created by Administrator on 2018/2/23.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOrderDetailList.biz.ext";
var partInfoUrl = baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.queryBillPartChoose.biz.ext";
var enterUrl = baseUrl + "com.hsapi.cloud.part.invoicing.stockcal.queryOutableEnterGridWithPage.biz.ext";
var advancedSearchWin = null;
var advancedMorePartWin = null;
var advancedMorePartWin2 = null;
var advancedAddWin = null;
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
var storeHash ={};
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;

var billmainTab = null;
var partInfoTab = null;
var dataList = null;
var morePartGrid = null;
var morePartGrid2 =null;
var enterGrid = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldValue2 =null;
var oldRow = null;
var oldRow2 =null;
var morePartCodeEl = null;
var morePartNameEl = null;
var showStockEl = null;
var sortTypeEl = null;
var morePartTabs = null;
var enterTab = null;
var partInfoTab = null;
var guestIdEl=null;
var quickAddShow=0;
var advancedSearchShow=0;
var directStoreHouse =[];

var AuditSignHash = {
  "0":"未审",
  "1":"已审",
  "2":"已过账",
  "3":"已取消"
};
var StatusHash={
	"0"	:"草稿",
	"1"	:"已提交",
	"2"	:"已出库",
	"6" :"部分出库"
};
var partShow=0;
var storeLimitMap={};

var storeShelfList=[];
var storeShelfHash={}
var partHash={};
//是否开单
var isBilling=0;
//是否修改配件
var isEditPart =0;
var partIn =false;
var directOrgidEl =null;
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
    advancedMorePartWin = nui.get("advancedMorePartWin");
    advancedMorePartWin2 = nui.get("advancedMorePartWin2");
    
    advancedAddWin = nui.get("advancedAddWin");
    morePartGrid = nui.get("morePartGrid");
    morePartGrid2 = nui.get("morePartGrid2");
    
    enterGrid = nui.get("enterGrid");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    advancedAddForm  = new nui.Form("#advancedAddForm");
    morePartCodeEl = nui.get("morePartCode");
    morePartNameEl = nui.get("morePartName");
    showStockEl = nui.get("showStock");
    sortTypeEl = nui.get("sortType");
    sortTypeEl.setData(sortTypeList);
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
    gsparams.auditSign = 0;

    sOrderDate = nui.get("sOrderDate");
    eOrderDate = nui.get("eOrderDate");


    directOrgidEl = nui.get("directOrgid");
	getCompany();

    morePartTabs = nui.get("morePartTabs");
    enterTab = morePartTabs.getTab("enterTab");
    partInfoTab = morePartTabs.getTab("partInfoTab");

    morePartGrid.setUrl(partInfoUrl);
    morePartGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    morePartGrid.on("load", function(e) {
        var data = e.data;
    });
    morePartGrid.on("drawcell",function(e){
        switch (e.field)
        {
	        case "partBrandId":
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
            default:
                break;
        }
    });

    morePartGrid2.on("drawcell",function(e){
        switch (e.field)
        {
	        case "partBrandId":
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
            default:
                break;
        }
    });
    enterGrid.setUrl(enterUrl);
    enterGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    enterGrid.on("drawcell",function(e){
        switch (e.field)
        {
	        case "partBrandId":
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
            case "storeId":
                if(storeHash[e.value])
                {
                    e.cellHtml = storeHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            default:
                break;
        }
    });

    $("#guestId").bind("keydown", function (e) {
        /*if (e.keyCode == 13) {
            var orderMan = nui.get("orderMan");
            orderMan.focus();
        }*/
        if (e.keyCode == 13) {
            //addNewRow(true);
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

    $("#morePartCode").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            var value = morePartCodeEl.getValue().replace(/\s+/g, "");
            value = value.replace(/\s+/g, "");
            if(value.length>=3){
                morePartSearch();
            }
        }  
        
    });

    $("#morePartName").bind("keydown", function (e) {

        if (e.keyCode == 13) {
            var value = morePartNameEl.getValue();
            value = value.replace(/\s+/g, "");
            if(value.length>=3){
                morePartSearch();
            }
        }
        
    });

    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;
        
        if((keyCode==78)&&(event.altKey))  {  //新建  Alt+N
            add();  
        } 
      
        if((keyCode==83)&&(event.altKey))  {   //保存 Alt+S
            save();
        } 
        
        if((keyCode==84)&&(event.altKey))  {   //提交 Alt+T
        	audit();
        } 
      
        if((keyCode==89)&&(event.altKey))  {   //出库 Alt+Y
        	auditToOut();
        } 
      
        if((keyCode==80)&&(event.altKey))  {   //打印  Alt+P
            onPrint();
        } 
        if((keyCode==27))  {  
            if(quickAddShow==1){
            	onAdvancedAddCancel();
            }
            if(advancedSearchShow==1){
            	onAdvancedSearchCancel();
            }if(partShow ==1){
            	onPartClose2();
            }
        }
//        if((keyCode==13))  { 
//        	if(partShow==1){
//    			if(advancedMorePartWin2.visible){
//	    			var row = morePartGrid2.getSelected();
//					if(row){
//						addSelectPart2();
//					}
//    			}
//        	}           
//            
//        }
        if((keyCode==13))  { 
        	if(partShow==1){
        		if(partIn==true){
                	addSelectPart2();
                	
                }
        		partIn=true;
        	}                        
        }  
     
    }

    //绑定表单
    //var db = new nui.DataBinding();
    //db.bindForm("basicInfoForm", leftGrid);
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        if(storehouse && storehouse.length>0){
            FStoreId = storehouse[0].id;
            storehouse.forEach(function(v) {
                storeHash[v.id] = v;
            });
        }else{
            isNeedSet = true;
        }
        
        var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
        initDicts(dictDefs, null);

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
    
    if(currIsCommission ==1){
    	nui.get('chooseMemBtn').setVisible(true);
    }
	//开启APP
    if(currIsOpenApp ==1){
  	  nui.get('unAuditBtn').setVisible(false);
  	  getStoreLocation();
//  	  getPart();
    }
    
    if(currIsOpenApp !=1){
    	nui.get('auditToOutBtn').setVisible(true);
    }
    
    rightGrid.on("preload",function(e){
		var result=e.result;
		var resultList=result.data;
		
		var sender=e.sender;
		var columnsList = [];
	    columnsList=sender.columns;
	    for(var i=0;i<columnsList.length;i++){
	    	if(columnsList[i].header=="辅助信息"){
	    		 columnsObjList=columnsList[i].columns;
	    		 break;
	    	}
	    }
//	    columnsObjList=columnsList[3].columns;
	    //开启APP，处理仓位
	    if(currIsOpenApp ==1){
	    	var shelfObj={};
	    	var editor={};
	    	var flag=null;
	    	for(var i=0;i<columnsObjList.length;i++){
	 	    	if(columnsObjList[i].field=="storeShelf"){
	 	    		shelfObj=columnsObjList[i];
	 	    		editor=shelfObj.editor;
	 	    		flag =i;
	 	    		break;
	 	    	}
	 	    }
	    	editor.cls="nui-combobox";
	    	editor.data="storeShelfList";
	    	editor.dataField="storeShelfList";
	    	editor.enabled=true;
	    	editor.id ="storeShelf";
	    	editor.name="storeShelf";
	    	editor.textField="name";
	    	editor.type="combobox";
	    	editor.valueField="name";
	    	columnsObjList[flag].editor=editor;
	    	
	    }
	   
		rightGrid.set({
	        columns: columnsList
	    });
	});
});
//库存数量↑，库存数量↓；入库日期↑，入库日期↓；成本↑，成本↓
var sortTypeList = [
    {id:"1",text:"入库日期↑"},{id:"2",text:"入库日期↓"},
    {id:"3",text:"库存数量↑"},{id:"4",text:"库存数量↓"},
    {id:"5",text:"成本↑"},{id:"6",text:"成本↓"}
];

var companyUrl = apiPath + sysApi + "/"+"com.hsapi.system.basic.organization.getCompanyAll.biz.ext";
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
            	directOrgidEl.setData(data.companyList);
               
            }else {
            	
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
	});
}


function addNewRow(check){
	rightGridSet();
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
       var billStatusId=row.billStatusId;
	   $('#status').text(StatusHash[billStatusId]);
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
	   
	   if(row.directOrgid>0){
		   queryStore();
	   }
       
       if(row.codeId && row.codeId>0){
            //可以编辑票据类型和结算方式，是否需要打包，备注，业务员；明细不能修改；如果需要，则退回
            nui.get("guestId").disable();
            nui.get("code").disable();
       }else{
           nui.get("guestId").enable();
           nui.get("code").enable();
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
function onLeftGridBeforeDeselect(e)
{
    var row = leftGrid.getSelected(); 
    if(row.serviceId == '新销售订单'){

        leftGrid.removeRow(row);
    }
}
function addInsertRow(value, row) {    
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请先选择客户再添加配件!","W");
        return;
    }

    //var type = judgeConditionType(value);//1代表编码，2代表名称，3代表拼音，-1输入信息有误
    value = value.replace(/\s+/g, "");

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
            orderPrice : price,
            orderAmt : price,
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
            //rightGrid.beginEditCell(row, "comUnit");
        }else{
            rightGrid.addRow(newRow);
            //rightGrid.beginEditCell(newRow, "enterQty");
            //rightGrid.beginEditCell(row, "comUnit");
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

    var params = {partCode:value.replace(/\s+/g, "")};
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
//var partInfoUrl = baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.queryPartInfoByParam.biz.ext";
function getPartInfo(params, callback){
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
            callback && callback(data)
            
            var partlist = data.partlist;
            if(partlist && partlist.length>0){
                //如果只返回一条数据，直接添加；否则切换到配件选择界面按输入的条件输出
                //if(partlist.length==1){
                //    part = partlist[0];
                //}else{
                    advancedMorePartWin.show();
                    morePartGrid.setData(partlist);
                //}
                
            }else{
                //清空行数据
                /*nui.alert("没有搜索到配件信息!","提示",function(){
                    var row = rightGrid.getSelected();
                    rightGrid.removeRow(row);
                    addNewRow(false);
                });*/
                advancedMorePartWin.show();
                morePartGrid.setData(partlist);
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
	params.sortField = "b.stock_qty";
	params.sortOrder = "desc";
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
		var partlist = data.parts;
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

function showPartInfo(row, value, mainId){
	partShow=1;
	var directOrgid =directOrgidEl.getValue();
	if(!directOrgid){
		showMsg("请先选择直发门店","W");
		return;
	}
    nui.open({
        // targetWindow: window,
        url: webBaseUrl+"purchase/directSellOrder/fastPartChoose_view0.jsp?token="+token,
        title: "配件信息", width: 980, height: 560,
        showHeader:false,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            //仓先生
//            if(currIsOpenApp ==1){
//            	params.showStock=2;
//            }
            var params = {
                type: "sellOrder",
                value:value,
                mainId:mainId,
                guestId: nui.get("guestId").getValue(),
                directOrgid : directOrgidEl.getValue()
            };
            iframe.contentWindow.setInitData(params,
                function(data,ck) {
            		queryStore();
                    addDetail(row,data,ck);
                },function(data) {
                    var partid = 0;
                    if(data.isMarkBatch && data.isMarkBatch == 1){
                        partid = data.partId;
                    }else{
                        partid = data.id;
                    }
                    var rtn = checkPartIDExists(partid);
                    return rtn;
                }
            );
        },
        ondestroy: function (action)
        {
        	if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
            }
            
            rightGrid.removeRow(row);

            var newRow = {};
            rightGrid.addRow(newRow);
            rightGrid.beginEditCell(newRow,"comPartCode");
        }
    });
}
function morePartSearch(){
    var params = {}; 
    params.partCode = morePartCodeEl.getValue().replace(/\s+/g, "");
    params.partName = morePartNameEl.getValue().replace(/\s+/g, "");
    params.showStock = showStockEl.getValue();
    //仓先生
    if(currIsOpenApp ==1 &&  params.showStock==0){
    	params.showStock=2;
    }
    params.sortField = "b.outable_qty";
    params.sortOrder = "asc";

    morePartGrid.load({params:params});
    return;
    getPartInfo(params, function(data){
        var partlist = data.partlist;
        if(partlist && partlist.length>0){
            advancedMorePartWin.show();
            morePartGrid.setData(partlist);
        }else{
            //清空行数据
            /*nui.alert("没有搜索到配件信息!","提示",function(){
                var row = rightGrid.getSelected();
                rightGrid.removeRow(row);
                addNewRow(false);
            });*/
            advancedMorePartWin.show();
            morePartGrid.setData(partlist);
        }
    });
}
function onLeftGridSelectionChanged(){    
   var row = leftGrid.getSelected(); 
   
   loadMainAndDetailInfo(row);
} 
/*function onRightGridSelectionChanged(){    
    var row = rightGrid.getSelected(); 
   
    if(row){
    }else{
        row = {};
        row.guestId = null;
        row.partId = null;
        row.storeId = null;
    }
    row.guestId = nui.get('guestId').getValue();

    document.getElementById("formIframe").contentWindow.setInitEmbedParams(row);
}*/
function setBottomData(row){
    var type = row.type;
    document.getElementById("formIframe").contentWindow.setInitEmbedParams(row);
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

    	var data = rightGrid.getData();
		if(data && data.length <= 0){
			if(partShow==1){
				
			}else{				
				addNewRow(false);
			}
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
            if(StatusHash && StatusHash[e.value])
            {
                e.cellHtml = StatusHash[e.value];
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
            gsparams.billStatusId = 0;
            querytypename = "草稿";
            querysign = 2;
            gsparams.auditSign = 0;
            break;
        case 7:
            params.auditSign = 1;
            gsparams.billStatusId = 1;
            querytypename = "已提交";
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 8:
        	 querytypename = "部分出库";
             gsparams.billStatusId = 6;
             querysign = 2;
             gsparams.auditSign = 1;
             break;
        case 9:
            querytypename = "已出库";
            gsparams.billStatusId = 2;
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 10:
            querytypename = "所有";
            gsparams.billStatusId = null;
            querysign = 2;
            gsparams.auditSign = -1;
            break;
        default:
        	params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querytypename = "草稿";
            gsparams.billStatusId = 0;
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
        //nui.get("addPartBtn").enable();
        //nui.get("editPartBtn").enable();
        //nui.get("deletePartBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("auditBtn").enable();
        nui.get("selectSupplierBtn").enable();
        //nui.get("printBtn").enable();
    }
    else
    {
        //nui.get("addPartBtn").disable();
        //nui.get("editPartBtn").disable();
        //nui.get("deletePartBtn").disable();
        nui.get("saveBtn").disable();
        nui.get("auditBtn").disable();
        nui.get("selectSupplierBtn").disable();
        //nui.get("printBtn").disable();
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
    params.orderTypeId = 2;
	params.isDiffOrder = 0;
	params.directOrgid =1;
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
                document.getElementById("basicInfoForm").disabled=true;
                setBtnable(false);
                setEditable(false);
            }else {
                document.getElementById("basicInfoForm").disabled=false;
                setBtnable(true);
                setEditable(true);
            }
        }
	});
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchShow=1;
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
        searchData.sOrderDate = searchData.sOrderDate.substr(0,10);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eOrderDate;
        searchData.eOrderDate = addDate(date, 1);
        searchData.eOrderDate = searchData.eOrderDate.substr(0,10);
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
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.partCodeList = tmpList.join(",");
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
function checkNew() 
{
    var rows = leftGrid.findRows(function(row){
        if(row.serviceId == "新销售订单") return true;
    });
    
    return rows.length;
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
                    nui.get("code").enable();

                    basicInfoForm.reset();
                    rightGrid.clearRows();
                    
                    var newRow = { serviceId: "新销售订单", auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新销售订单");
                    nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
//                    nui.get("createDate").setValue(new Date());
                    nui.get("orderDate").setValue(new Date());
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

        nui.get("guestId").enable();
        nui.get("code").enable();

        basicInfoForm.reset();
        rightGrid.clearRows();
        
        var newRow = { serviceId: "新销售订单", auditSign: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新销售订单");
        nui.get("billTypeId").setValue("010103");  //010101  收据   010102  普票  010103  增票
//        nui.get("createDate").setValue(new Date());
        nui.get("orderDate").setValue(new Date());
        nui.get("orderMan").setValue(currUserName);

        addNewRow();
        
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
    //汇总明细数据到主表
    data.isFinished = 0;
    data.auditSign = 0;
    data.billStatusId = '';
    data.printTimes = 0;
    data.orderTypeId = 2;
    data.isDiffOrder = 0;
    delete data.createDate;	
    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }
    if (data.orderDate) {
  	   data.orderDate = format(data.orderDate, 'yyyy-MM-dd HH:mm:ss');
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
//新增单据时，取单据ID
var saveAddUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.saveAddSellOrder.biz.ext";
function getSellOrderBillNO(callback){
    var data = basicInfoForm.getData();
    data.isDiffOrder = 0;
    nui.ajax({
        url : saveAddUrl,
        type : "post",
        data : JSON.stringify({
            main : data,
            token : token
        }),
        success : function(data) {
            data = data || {};
            if (data.errCode == "S") {
                var main = data.main;
                leftGrid.reload();
                callback && callback(main)
            } else {
                showMsg(data.errMsg || "请先保存单据添加配件","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var requiredField = {
    guestId : "客户",
    orderMan : "销售员",
    orderDate : "订单日期",
	billTypeId : "票据类型",
    settleTypeId : "结算方式",
	directOrgid : "直发门店"
};
var updateCreditUrl= baseUrl +"com.hsapi.cloud.part.invoicing.settle.updateGuestCredit.biz.ext";
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
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.savePjSellOrder.biz.ext";
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
	for(var i=0;i<rightRow.length;i++){
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(rightRow[i].storeId) && storeHash[rightRow[i].storeId]){
				showMsg("没有选择"+storeHash[rightRow[i].storeId].name+"的权限","W");
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
			set.add(rightRow[i].partId+"-"+rightRow[i].storeId);
		}
		if(set.size <rightGrid.getData().length){
			showMsg("订单明细不能出现相同配件同个仓库两次以上","W");
			return;
		}

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

    var sellOrderDetailAdd = rightGrid.getChanges("added");
    var sellOrderDetailUpdate = rightGrid.getChanges("modified");
    var sellOrderDetailDelete = rightGrid.getChanges("removed");
    var sellOrderDetailList = rightGrid.getData();
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			sellOrderMain : data,
			sellOrderDetailAdd : sellOrderDetailAdd,
			sellOrderDetailUpdate : sellOrderDetailUpdate,
			sellOrderDetailDelete : sellOrderDetailDelete,
            sellOrderDetailList : sellOrderDetailList,
            token : token
		}),
		success : function(data) {
            nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
                showMsg("保存成功!","S");
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
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
var supplier = null;	
function selectSupplier(elId)
{
	supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title: "客户资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            // var params = {
            //     isClient: 1,
            //     guestType:'01020102'
            // };
            var params = {
                isClient: 1
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
                var isInternal = supplier.isInternal||0;
                //if(isInternal == 1){
                //    nui.alert("不能直接向平台内单位发启销售，只能受理对方采购订单!");
                //    return;
                //}

                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

                if(elId == 'guestId') {
                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text};
                    leftGrid.updateRow(row,newRow);

                    nui.get("billTypeId").setValue(billTypeIdV);
                    nui.get("settleTypeId").setValue(settTypeIdV);
                    nui.get("isNeedPack").setValue(supplier.isNeedPack);

                    nui.get("codeId").setValue(0);
                    nui.get("code").setValue(null);

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
        case "operateBtn":
            e.cellHtml = //'<span class="icon-remove" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';/*'<span class="icon-add" onClick="javascript:addPart()" title="添加行">&nbsp;&nbsp;&nbsp;&nbsp;</span>' +
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
            var guestId = nui.get("guestId").getValue();
            if(!guestId) {
                showMsg("请先选择客户再添加配件!","W");
                nui.get("guestId").focus();
                return;
            }

            var partCode = record.comPartCode||"";
            partCode = partCode.replace(/\s+/g, "");
            if(!partCode){
                showMsg("请输入编码!","W");
                var row = rightGrid.getSelected();
                rightGrid.removeRow(row);
                addNewRow(false);
                return;
            }else{
                var main = basicInfoForm.getData();
                if(!main.id){
                    getSellOrderBillNO(function(data){ 
                        var newRow = {id: data.id, serviceId: data.serviceId};
                        var row = leftGrid.getSelected();
                        leftGrid.updateRow(row,newRow);

                        basicInfoForm.setData(data);

                        nui.get("id").setValue(data.id);
                        nui.get("serviceId").setValue(data.serviceId);
                        record.serviceId = data.serviceId;
                        record.mainId = data.id;
                        showPartInfo(record,partCode,data.id);

                        /*var rs = addInsertRow(record.comPartCode,record);
                        if(!rs){
                            var newRow = {comPartCode: ""};
                            rightGrid.updateRow(record, newRow);
                            rightGrid.beginEditCell(record, "comPartCode");
                            return;
                        }else{
                            rightGrid.beginEditCell(record, "comUnit");
                        }*/
                    });
                }else{
                    record.mainId = main.id;
                    record.serviceId = nui.get("serviceId").getValue().replace(/\s+/g, "");
                    showPartInfo(record,partCode,main.id);
                    /*var rs = addInsertRow(record.comPartCode,record);
                    if(!rs){
                        var newRow = {comPartCode: ""};
                        rightGrid.updateRow(record, newRow);
                        rightGrid.beginEditCell(record, "comPartCode");
                        return;
                    }else{
                        rightGrid.beginEditCell(record, "comUnit");
                    }*/
                }
            }
        }else if(column.field == "showPartCode"){
        	var partCode = record.showPartCode||"";
            partCode = partCode.replace(/\s+/g, "");
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
                }
            }*/
            
        }else if(e.field == "showPartCode"){
        	 oldValue2 = e.oldValue;
             oldRow2 = row;
        }else if(e.field =="showPrice"){
        	 var orderQty = record.orderQty;
             var showPrice = e.value;
             
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
    enterDetail.directStoreId =data.directStoreId;
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
var saveStepUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.insertPjSellOrderStepTran.biz.ext";
function saveDetail(detail, callback){
    nui.ajax({
		url : saveStepUrl,
		type : "post",
		data : JSON.stringify({
			sellOrderDetail : detail,
			serviceId : detail.serviceId,
			directOrgid :directOrgidEl.getValue(),
            token : token
		}),
		success : function(data) {
			data = data || {};
			if (data.errCode == "S") {
                var sellOrderDetail = data.sellOrderDetail;
                callback && callback(sellOrderDetail,data.p);
			} else {
				alert(data.errMsg || "新增数据失败!");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
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

	selectPart(function(data) {
		addDetail(row,data);
	},function(data) {
        var partid = 0;
        if(data.isMarkBatch && data.isMarkBatch == 1){
            partid = data.partId;
        }else{
            partid = data.id;
        }
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
        return "配件编码："+row.comPartCode+"在销售列表中已经存在，是否继续？";
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
        var newRow = {comPartCode:""};
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
//            if(row.orderPrice){
//                if(row.orderPrice <= 0) return true;
//            }else{
//                return true;
//            }
//            if(row.orderAmt){
//                if(row.orderAmt <= 0) return true;
//            }else{
//                return true;
//            }
            
            if(row.storeId){
            }else{
                return true;
            }       
        }

    });
    
    if(rows && rows.length > 0){
        msg = "请完善销售配件的数量，单价，金额，仓库等信息！";
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
var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjSellOrder.biz.ext";
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
        if(row.auditSign == 1) {
            showMsg("此单已提交!","W");
            return;
        } 
    }else{
        return;
    }

    //审核时，数量，单价，金额，仓库不能为空
    var msg = checkStockOutQty();
    if(msg){
        showMsg(msg,"W");
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
    
    getStoreLimit();
	var rightRow =rightGrid.getData();
	for(var i=0;i<rightRow.length;i++){
		if(Object.getOwnPropertyNames(storeLimitMap ).length >0){
			if(!storeLimitMap.hasOwnProperty(rightRow[i].storeId)  && storeHash[rightRow[i].storeId]){
				showMsg("没有选择"+storeHash[rightRow[i].storeId].name+"的权限","W");
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
			set.add(rightRow[i].partId+"-"+rightRow[i].storeId);
		}
		if(set.size <rightGrid.getData().length){
			showMsg("订单明细不能出现相同配件同个仓库两次以上","W");
			return;
		}

	}
    data = getMainData();

    var sellOrderDetailAdd = rightGrid.getChanges("added");
    var sellOrderDetailUpdate = rightGrid.getChanges("modified");
    var sellOrderDetailDelete = rightGrid.getChanges("removed");
    var sellOrderDetailList = rightGrid.getData();
    if(sellOrderDetailList.length <= 0) {
        showMsg("销售明细为空，不能提交!","W");
        return;
    }
    
    sellOrderDetailList = removeChanges(sellOrderDetailAdd, sellOrderDetailUpdate, sellOrderDetailDelete, sellOrderDetailList);
    
    var cangHash ="";
	if(currIsOpenApp ==1){
		cangHash=getCangHash(data,sellOrderDetailList);
	}
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '提交中...'
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
            cangHash : cangHash,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("提交成功!","S");
                //onLeftGridRowDblClick({});
                var pjSellOrderMainList = data.pjSellOrderMainList;
                if(pjSellOrderMainList && pjSellOrderMainList.length>0) {
                    var leftRow = pjSellOrderMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                }
            } else {
                showMsg(data.errMsg || "提交失败!","W");
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
    if (e.field == "orderAmt") { 
        var orderAmt = 0;
        for (var i = 0; i < rows.length; i++) {
            orderAmt += parseFloat(rows[i].orderAmt);
        }
        //nui.get("orderAmt").setValue(orderAmt);
    }
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
//    var params = {};
//    params.pny = e.value;
//    params.isClient = 1;
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
		var isNeedPack =data.isNeedPack;
		nui.get("isNeedPack").setValue(isNeedPack);
		nui.get("billTypeId").setValue(billTypeIdV);
		nui.get("settleTypeId").setValue(settTypeIdV);

		addNewRow(true);
    }
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
				showMsg("没有选择"+storeHash[id].name+"的权限","W");
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
//                    var data = supplier[0];
//                    var value = data.id;
//                    var text = data.fullName;
//                    var isInternal = data.isInternal||0;
                    //if(isInternal == 1){
                    //    nui.alert("不能直接向平台内单位发启销售，只能受理对方采购订单!");
                    //    return;
                    //}

//                    var el = nui.get('guestId');
//                    el.setValue(value);
//                    el.setText(text);

                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text};
                    leftGrid.updateRow(row,newRow);

                    var billTypeIdV = data.billTypeId;
                    var settTypeIdV = data.settTypeId;

                    nui.get("billTypeId").setValue(billTypeIdV);
                    nui.get("settleTypeId").setValue(settTypeIdV);
                    nui.get("isNeedPack").setValue(data.isNeedPack);

                    nui.get("codeId").setValue(0);
                    nui.get("code").setValue(null);

                    addNewRow(true);

                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);

                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: null};
                    leftGrid.updateRow(row,newRow);
                    nui.get("isNeedPack").setValue(0);
                    nui.get("codeId").setValue(0);
                    nui.get("code").setValue(null);

                    nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
                    addGuest();
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
                nui.get("isNeedPack").setValue(0);

                nui.get("codeId").setValue(0);
                nui.get("code").setValue(null);

                nui.get("billTypeId").setValue("010103");
                addGuest();
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addGuest(){
//	nui.confirm("此客户不存在，是否新增?", "友情提示", function(action) {
//		if (action == "ok") {
            nui.open({
                // targetWindow: window,
                url: webPath+contextPath+"/com.hsweb.cloud.part.basic.customerAdd.flow?token=" + token,
                title: "客户资料", width: 570, height: 530,
                allowDrag:true,
                allowResize:false,
                onload: function ()
                {
                    var iframe = this.getIFrameEl();
                    iframe.contentWindow.setData({
                        province:[],
                        city:[],
                        billTypeId:nui.get("billTypeId").getData(),
                        settTypeId:nui.get("settleTypeId").getData(),
                        tgrade:[],
                        managerDuty:[]
                    });
                },
                ondestroy: function (action)
                {
                    if(action == "ok")
                    {
                        
                    }
                    nui.get("guestId").focus();
                }
            });

//		}else{
//			nui.get("guestId").focus();
//		}
//	});
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
		currCloudSellOrderPrintContent :currCloudSellOrderPrintContent,
		storeHash : storeHash,
		brandHash: brandHash
	};
	var detailParams={
			mainId :from.id,
	};
	var openUrl = webPath + contextPath+"/purchase/directSellOrder/directSellOrderPrint.jsp";

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
    if(checkNew() > 0){
    	return;
    }
    rightGrid.setData([]);
	add();
}
//function onPrint() {
//    var row = leftGrid.getSelected();
//    if (row) {
//
//        if(!row.id) return;
//
//        var auditSign = row.auditSign||0;
//        var logisticsName = getLogistics(row.id, row.guestId);
//
//        nui.open({
//
//            url : webPath + contextPath + "/com.hsweb.cloud.part.purchase.sellOrderPrint.flow?ID="
//                    + row.id+"&printMan="+currUserName+"&auditSign="+auditSign+"&logisticsName="+logisticsName,// "view_Guest.jsp",
//            title : "销售订单打印",
//            width : 900,
//            height : 600,
//            onload : function() {
//                var iframe = this.getIFrameEl();
//                // iframe.contentWindow.setInitData(storeId, 'XSD');
//            }
//        });
//    }
//
//}
function getLogistics(mainId, guestId){
    var logName = "";
    nui.ajax({
        url : baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.getPrintLogistics.biz.ext",
        async : false,
        data : {
            token: token, 
            mainId:mainId,
            guestId: guestId
        },
        type : "post",
        success : function(data) {
            if (data && data.logisticsName) {
                logName = data.logisticsName;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });

    return logName;
}

function addSelectPart(){
    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请先选择客户再添加配件!","W");
        nui.get("guestId").focus();
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
            outUnitId : row.unit
        };

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

function onPartClose(){
    advancedMorePartWin.hide();
    morePartGrid.setData([]);
    morePartCodeEl.setValue("");
    morePartNameEl.setValue("");

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

    if(data.codeId && data.codeId>0){
        e.cancel = true;
    }

    if(row.partId) {
    	
        if(row.isMarkBatch && row.isMarkBatch == 1){
            if(column.field != "remark" 
            	&& column.field != "showPrice" && column.field != "showAmt" && column.field != "showPartCode"){
                e.cancel = true;
            }
           
        }else{
            if(column.field != "remark" && column.field != "orderQty" && column.field != "orderPrice" && column.field != "orderAmt" && column.field != "storeId" && column.field != "storeShelf"
            	&& column.field != "showPrice" && column.field != "showAmt" && column.field != "showPartCode" && column.field != "directStoreId"){
                e.cancel = true;
            }
        }  
    }
    
    if (field == "storeShelf") {
	    var value = e.record.storeId;
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
    if (field == "directStoreId") {
	    var value = e.record.directStoreId;
	    var editor = e.editor;
	    editor.setData(directStoreHouse);

	    
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
//    if (data.length>0) {
//        showMsg("请先保存数据!","W");
//        return;
//    }
    advancedAddForm.setData([]);
    advancedAddWin.show();
    quickAddShow=1;
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
                showMsg("第"+(i+1)+"条录入信息格式有问题!","W");
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
                            showMsg(msg,"S");
                        }
                        
                    } else {
                        showMsg(data.errMsg || "添加数据失败!","W");
                    }
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    // nui.alert(jqXHR.responseText);
                    console.log(jqXHR.responseText);
                }
            });
        }


    }else{
        showMsg("请按格式输入信息!","W");
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
                outUnitId : part.unit
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
function onExport(){
    if (checkNew() > 0) {
        showMsg("请先保存数据!","W");
        return;
    }
    var changes = rightGrid.getChanges();
    if(changes.length>0){
        var len = changes.length;
        var row = changes[0];
        if(len == 1 && !row.partId){
        }else{
            showMsg("请先保存数据!","W");
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
                         .replace("[remark]", detail[i].remark?detail[i].remark:""));
            tableExportContent.append(tr);
        }
    }

    var serviceId = main.serviceId?main.serviceId:"";
    method5('tableExcel',"直发销售订单"+serviceId,'tableExportA');
}
function onMoreTabChanged(e){
    var tab = e.tab;
    var name = tab.name;
  
    if(name == "enterTab"){
        nui.get("showStock").hide();
        
    }else if(name == "partInfoTab"){
        nui.get("showStock").show();
        nui.get("showStock").setValue(1);
    }
    
}

//直接出库，生成isDifferOrder =1数据
var auditToOutUrl = baseUrl+"com.hsapi.cloud.part.invoicing.allotsettle.generateSellOrderDirectOut.biz.ext";
function auditToOut()
{

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign != 1){
            showMsg("请先提交单据!","W");
            return;
        }
        if(row.isOut == 1) {
            showMsg("此单已出库!","W");
            return;
        } 
    }else{
        return;
    }

    var data = basicInfoForm.getData();
    var mainId = data.id;

    var main = getMainData();

    var sellOrderDetailList = rightGrid.getData();
    
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '出库中...'
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
                var newRow = {isOut: 1,billStatusId :2};
                leftGrid.updateRow(row, newRow);

                setBtnable(false);
                nui.confirm("是否打印？", "友情提示", function(action) {
					if(action== 'ok'){
						onPrint();
					}else{
						
					}
				});

//                add();
                
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
var unAuditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.unAuditSellOrderToOut.biz.ext";
function unAudit()
{

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign != 1){
            showMsg("此单未提交，不需要返单!","W");
            return;
        }
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
                leftGrid.updateRow(row, {auditSign:0});
                row = leftGrid.getSelected();
                //loadMainAndDetailInfo(row);
                rightGrid.setData([]);
                add();
                
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
function packOut(){
    var row = leftGrid.getSelected();
    if(row){
        if(row.isOut == 1) {
            nui.open({
                // targetWindow: window,
                url: webBaseUrl+"com.hsweb.cloud.part.common.packPopOperate.flow?token="+token,
                title: "发货信息编辑", 
                width: 580, height: 300,
                showHeader:true,
                allowDrag:true,
                allowResize:true,
                onload: function ()
                {
                    var iframe = this.getIFrameEl();
                    var list = nui.get("settleTypeId").getData();
                    iframe.contentWindow.setInitData(row, row.guestId, row.guestFullName, list);
                },
                ondestroy: function (action)
                {

                }
            });
        }else{
            showMsg("请先出库再编辑发货信息!","W");
            return;
        }
    }else{
        return;
    }
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
	  var serviceType=1;
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
		cangHash.stock_type_name ="销售订单";
		cangHash.stock_type_id =2;
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
		if(storeShelfHash && storeShelfHash[detailData[i].storeId+"-"+detailData[i].storeShelf]){
			warehousetemp.cid =storeShelfHash[detailData[i].storeId+"-"+detailData[i].storeShelf].cangShelfId
		}else{
			warehousetemp.cid ="";
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
var storeLoactionUrl=baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryStoreLocation.biz.ext";
function getStoreLocation(){
	$.ajaxSettings.async = false;
	$.post(storeLoactionUrl+"?orgid="+currOrgid+"&token="+token,{},function(text){
		var locations=text.locations;
		locations.forEach(function(v){
			storeShelfHash[v.storeId+"-"+v.name]=v;			
		});
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
        	page   :page,
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

function rightGridSet(){
	var columnsList = [];
    columnsList=rightGrid.columns;
    for(var i=0;i<columnsList.length;i++){
    	if(columnsList[i].header=="辅助信息"){
    		 columnsObjList=columnsList[i].columns;
    		 break;
    	}
    }
//    columnsObjList=columnsList[3].columns;
    //获取下标
    var index=null;
    
    //开启APP，处理仓位
    if(currIsOpenApp ==1){
    	var shelfObj={};
    	var editor={};
    	var flag=null;
    	for(var i=0;i<columnsObjList.length;i++){
 	    	if(columnsObjList[i].field=="storeShelf"){
 	    		shelfObj=columnsObjList[i];
 	    		editor=shelfObj.editor;
 	    		flag =i;
 	    		break;
 	    	}
 	    }
    	editor.cls="nui-combobox";
    	editor.data="storeShelfList";
    	editor.dataField="storeShelfList";
    	editor.enabled=true;
    	editor.id ="storeShelf";
    	editor.name="storeShelf";
    	editor.textField="name";
    	editor.type="combobox";
    	editor.valueField="name";
    	columnsObjList[flag].editor=editor;
    	
    }
    
    rightGrid.set({
        columns: columnsList
    });
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

var queryStoreUrl =baseUrl+'com.hsapi.cloud.part.baseDataCrud.crud.queryStoreHouse.biz.ext'
function queryStore(){
	nui.ajax({
        url: queryStoreUrl,
        type: 'post',
        async:true,
        data: nui.encode({
        	orgid: directOrgidEl.getValue(),
            token: token
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
            	directStoreHouse =data.storehouse;
            	
            }else {
            	
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
	});
}

