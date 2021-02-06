/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + saleApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
//var leftGridUrl = baseUrl
//		+ "com.hsapi.part.invoice.svr.queryPjPchsOrderMainList.biz.ext";
var rightGridUrl = baseUrl
		+ "com.hsapi.sales.svr.inventory.queryPchsOrderDetailList.biz.ext";
var storeShelf = baseUrl+"com.hsapi.part.baseDataCrud.crud.getSorehouseLocation.biz.ext";
//var advancedSearchWin = null;
var advancedMorePartWin = null;
var advancedAddWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var bottomInfoForm = null;
var advancedAddForm = null;
//var leftGrid = null;
var rightGrid = null;
var formJson = null;
var brandHash = {};
var brandList = [];
var storehouse = null;
var storeHash = {};
var gsparams = {};
var sOrderDate = null;
var eOrderDate = null;
var fastPartEntryEl = null;
var dataList = null;
var morePartGrid = null;
var FStoreId = null;
var isNeedSet = false;
var oldValue = null;
var oldRow = null;
var partShow = 0;
var quickAddShow=0;
var provinceList = [];
var cityList = [];
var advancedTipWin = null;
var autoNew = 0;
var memList=[];
var storeShelfList=[];
var frameColorIdList = []//车身颜色
var interialColorIdList = []//内饰颜色
var isFinancial = 0;//是否提交财务
var cssCheckEnter=[];//保存成功返回过来的完整单据
// 单据状态
var AuditSignList = [ {
	customid : '0',
	name : '未审'
}, {
	customid : '1',
	name : '已审'
}, {
	customid : '2',
	name : '已过账'
}, {
	customid : '3',
	name : '已取消'
} ];
var AuditSignHash = {
	"0" : "未审",
	"1" : "已审",
	"2" : "已过账",
	"3" : "已取消"
};

var provinceName =null;
var cityName =null;
var countyName = null;

$(document).ready(function(v) {
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '加载中...'
	});
	
	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);

	advancedMorePartWin = nui.get("advancedMorePartWin");
	advancedAddWin = nui.get("advancedAddWin");
	morePartGrid = nui.get("morePartGrid");

	basicInfoForm = new nui.Form("#basicInfoForm");
	advancedAddForm  = new nui.Form("#advancedAddForm");


	gsparams.startDate = getNowStartDate();
	gsparams.endDate = addDate(getNowEndDate(), 1);

	sOrderDate = nui.get("sOrderDate");
	eOrderDate = nui.get("eOrderDate");
	
/*	nui.get("orderMan").setValue(currEmpId);
	nui.get("orderMan").setText(currUserName);*/
/*	initMember("orderMan",function(){
        memList = nui.get('orderMan').getData();
    });*/


	advancedTipWin = nui.get("advancedTipWin");

/*    $("#orderMan").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });*/

    $("#remark").bind("keydown", function (e) {

    	if (e.keyCode == 13) {
            addNewRow(true);
        }
   $("#predictDeliveryDate").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            addNewRow(true);
        }
    })

    	
	});

    morePartGrid.on("load", function(e) {
        var row = morePartGrid.getRow(0);
        if(row){
            morePartGrid.select(row,true);
        }
    });
    
	morePartGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "partBrandId":
            	 if(brandHash[e.value])
                 {
//                     e.cellHtml = brandHash[e.value].name||"";
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
	rightGrid.on('drawcell', function (e) {
        var value = e.value;
        var field = e.field;
        if (field == 'frameColorId') {
            e.cellHtml = setColVal('frameColorId', 'customid', 'name', e.value);
        } else if (field == 'interialColorId') {
            e.cellHtml = setColVal('interialColorId', 'customid', 'name', e.value);
        } else if (field == 'isImported') {
            e.cellHtml = (value == 0 ? '是' : '否');
        }else if(field == 'operateBtn'){
            e.cellHtml = //'<span class="fa fa-close fa-lg" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';
            			'<span class="fa fa-plus" onClick="javascript:addNewRow(true)" title="添加行">&nbsp;&nbsp;</span>' +
                        ' <span class="fa fa-close" onClick="javascript:deletePart()" title="删除行"></span>';
        }
        
    });
	rightGrid.on("cellbeginedit",function(e){
        var field=e.field; 
        var editor = e.editor;
        var row = e.row;
        var column = e.column;
        var editor = e.editor;

        if(field == 'operateBtn'|| field == 'carModelCode' || field == 'frameColorId'|| field == 'interialColorId'|| field == 'orderQty'|| field == 'orderPrice'|| field == 'orderAmt'){
            if(isFinancial == 1) {
                e.cancel = true;
            }else{
                    e.cancel = false;
            }
        }
    });    
	document.ondragstart = function() {
	    return false;
	};
    document.onkeyup=function(event){
	    var e=event||window.event;
	    var keyCode=e.keyCode||e.which;
	  
	    if((keyCode==78)&&(event.altKey))  {  //新建
			add();	
	    } 
	  
	    if((keyCode==83)&&(event.altKey))  {   //保存
			save();
	    } 
	  
	    if((keyCode==80)&&(event.altKey))  {   //打印
			onPrint();
	    } 
	    if((keyCode==113))  {  
			addMorePart();
		} 
		 
/*		if((keyCode==13))  {  //新建
            if(partShow == 1) {
				var row = morePartGrid.getSelected();
				if(row){
					addSelectPart();
				}
			}
        } */

        if((keyCode==27))  {  //ESC
            if(partShow == 1){
                onPartClose();
            }
            if(quickAddShow==1){
            	onAdvancedAddCancel();
            }
        }
	 
	};

	$("partTempId").focus(function(){
/*		$("orderMan").css("background-color","#FFFFCC");*/
		addNewRow(true);
	});


	// 绑定表单

	var dictDefs ={"billTypeId":"DDT20130703000008", "payMode":"DDT20130703000035",frameColorId:"DDT20130726000003",interialColorId:"10391"};
	initDicts(dictDefs, function(){
		getStorehouse(function(data) {
			getAllPartBrand(function(data) {
				brandList = data.brand;
				brandList.forEach(function(v) {
					brandHash[v.id] = v;
				});
		 	 	frameColorIdList = nui.get('frameColorId').getData();
 	 			interialColorIdList = nui.get('interialColorId').getData();
				gsparams.billStatusId = 2;
				gsparams.auditSign = 1;
//				quickSearch(0);

				nui.unmask();
			});
			
		});
	});
	
	add();
	
});

var StatusHash = {
	"0" : "草稿",
	"1" : "待发货",
	"2" : "待收货",
	//"3" : "部分入库",
	"4" : "已入库",
	//"5" : "已退回",
	//"6" : "已关闭"
};
function addNewRow(check){
	var data = basicInfoForm.getData();

    if(data.auditSign == 1){
        return;
    }
    
	var rows = [];
	if(check){
		rows = rightGrid.findRows(function(row) {
			if (row.carModelId == null || row.carModelId == "" || row.carModelId == undefined)
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
			rightGrid.beginEditCell(row, "carModelCode");
		}
		
	}else{
		rightGrid.addRow(newRow);
		if(focusGuest){
			var guestId = nui.get("guestId");
			guestId.focus();
		}else{
			rightGrid.beginEditCell(newRow, "carModelCode");
		}
		
	}
}


//返回类型给srvBottom，用于srvBottom初始化
function confirmType(){
	return "pchs";
}
function getParentStoreId(){
	return FStoreId;
}
function loadMainAndDetailInfo(row) {
	if (row) {
/*		nui.get("orderMan").setText(row.orderMan);*/
/*		row.orderMan=row.orderManId; */
		basicInfoForm.setData(row);
		//bottomInfoForm.setData(row);
		nui.get("guestId").setText(row.guestFullName);

		
		var data = basicInfoForm.getData();

		var text=StatusHash[row.billStatusId];
		/*nui.get('AbillStatusId').setValue(text);*/
		if(StatusHash){
			
			/*nui.get('AbillStatusId').setValue(text);*/
	    }
		if(data.billStatusId && data.billStatusId !=0){
			document.getElementById("fd1").disabled = true;

			setBtnable(false);
			setEditable(false);
		}
		if (data.auditSign == 1) {
			document.getElementById("fd1").disabled = true;

			setBtnable(false);
			setEditable(false);
		} else {
			document.getElementById("basicInfoForm").disabled = false;
			setBtnable(true);
			setEditable(true);
		}

		// 序列化入库主表信息，保存时判断主表信息有没有修改，没有修改则不需要保存
		data.orderAmt = data.orderAmt||0;
		formJson = nui.encode(data);

		// 加载采购订单明细表信息
		var mainId = row.id;
		if(!mainId){
			mainId = -1;
		}
		var auditSign = data.auditSign||0;
		loadRightGridData(mainId, auditSign);
	} else {
	}

}

function setBottomData(row){
	var type = row.type;
	document.getElementById("formIframe").contentWindow.setInitEmbedParams(row);
}
function loadRightGridData(orderId, auditSign) {
	editPartHash = {};
	var params = {};
	params.orderId = orderId;
	rightGrid.load({
		params : params,
		token : token
	},function(){
	var data = rightGrid.getData();
	if(data && data.length <= 0){
		addNewRow(false);
	}
	rightGrid.cancelEdit();	
	});

}

var currType = 2;

function onSearch() {
	search();
}
function search() {
	var param = getSearchParam();
	doSearch(param);
}
function getSearchParam() {
	var params = {};
	params = gsparams;
	params.guestId = nui.get("searchGuestId").getValue();
	return params;
}
function setBtnable(flag) {
	if (flag) {
		nui.get("saveBtn").enable();
		nui.get("auditBtn").enable();
		//nui.get("printBtn").enable();
	} else {
		nui.get("saveBtn").disable();
		nui.get("auditBtn").disable();
		//nui.get("printBtn").disable();
	}
}
function setEditable(flag) {
	if (flag) {
		document.getElementById("fd1").disabled = false;
		nui.get('guestId').enabled=true;
/*		nui.get('orderMan').enabled=true;*/
		nui.get('payMode').enabled=true;
		nui.get('predictDeliveryDate').enabled=true;

	} else {
		document.getElementById("fd1").disabled = true;
		nui.get('guestId').enabled=false;
/*		nui.get('orderMan').enabled=false;*/
		nui.get('payMode').enabled=false;
		nui.get('predictDeliveryDate').enabled=false;
	}
}
function doSearch(params) {
	// 目前没有区域采购订单，销退受理 params.enterTypeId = '050101';
	params.orderTypeId = 1;
	params.isDiffOrder = 0;

}


function onComboValidation(e){
	var items = this.findItems(e.value);
    if (!items || items.length == 0) {
    	var sender = e.sender;
    	var id = sender.id;
    	if(id == "storeId") {
    		//nui.get("storeId").setValue(null);
    	}
    	if(id == "billTypeId") {
    		nui.get("billTypeId").setValue(null);
    	}
    	if(id == "payMode") {
    		nui.get("payMode").setValue(null);
    	}
        
    }
}

function add() {

	var formJsonThis = nui.encode(basicInfoForm.getData());
	var len = rightGrid.getData().length;
	cssCheckEnter = [];
	if (formJson != formJsonThis && len > 0) {// 
		nui.confirm("您正在编辑数据,是否要继续?", "友情提示", function(action) {
			if (action == "ok") {

				setBtnable(true);
				setEditable(true);
				nui.get('guestId').enable();

				basicInfoForm.reset();
				rightGrid.clearRows();


				var newRow = {
					serviceId : '新采购订单',
					auditSign : 0
				};

				$('#bServiceId').text("订单号: 新厂家订货单");
				nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票				
				addNewRow();
				var guestId = nui.get("guestId");
				guestId.focus();
				isFinancial = 0;
			} else {
				return;
			}
		});
	}else{
		setBtnable(true);
		setEditable(true);
		nui.get('guestId').enable();

		basicInfoForm.reset();
		rightGrid.clearRows();


		var newRow = {
			serviceId : '新采购订单',
			auditSign : 0
		};


		$('#bServiceId').text("订单号: 新厂家订货单");
		nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票
/*		nui.get("createDate").setValue(new Date());*/
		
/*		if(!orderMan || orderMan==""){
			for(var i=0;i<memList.length;i++){
				if(currEmpId==memList[i].empId){
					nui.get("orderMan").setValue(currEmpId);
					nui.get("orderMan").setText(currUserName);
				}
			}
		
		}else{
			nui.get("orderMan").setValue(orderManId);
			nui.get("orderMan").setText(orderMan);
		}*/

		addNewRow();

		var guestId = nui.get("guestId");
		guestId.focus();

	}

	
}
function getMainData() {
	var data = basicInfoForm.getData();
	// 汇总明细数据到主表
	data.isDiffOrder = 0;
	if (data.predictDeliveryDate) {
		data.predictDeliveryDate = format(data.predictDeliveryDate, 'yyyy-MM-dd HH:mm:ss');
	}
	if (data.advanceDepositDate) {
		data.advanceDepositDate = format(data.advanceDepositDate, 'yyyy-MM-dd HH:mm:ss');
	}
	if (data.payableBalaDate) {
		data.payableBalaDate = format(data.payableBalaDate, 'yyyy-MM-dd HH:mm:ss');
	}
    delete data.createDate;
    
	
	if (data.operateDate) {
		data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss')
				+ '.0';// 用于后台判断数据是否在其他地方已修改
		// data.versionNo = format(data.versionNo, 'yyyy-MM-dd HH:mm:ss');
	}

	rightGrid.findRow(function(row){
		var carModelId = row.carModelId;
		var partCode = row.carModelCode;
		if(carModelId == null || carModelId == "" || carModelId == undefined || partCode == null || partCode == "" || partCode == undefined){
			rightGrid.removeRow(row);
		}
	});

	return data;
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
var requiredField = {
	guestId : "供应商",
/*	orderMan : "采购员",*/
	billTypeId : "票据类型",
	payMode : "结算方式",
	predictDeliveryDate :"预计到货日期"
/*	advanceDepositAmt :"预交定金",*/
};
var saveUrl = baseUrl
		+ "com.hsapi.sales.svr.inventory.savePchsOrder.biz.ext";
function save() {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
//			mainTabs.activeTab(billmainTab);

			return;
		}
	}
		
	if (data) {
		if (isFinancial == 1) {
			showMsg("此单已提交!","W");
			return;
		}
	} else {
		return;
	}

	data = getMainData();

	//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
	var detailData = rightGrid.getData();
	//总金额，订单金额
	var totalAmt = 0;
	for(var i=0;i<detailData.length;i++){
		totalAmt = totalAmt+detailData[i].orderAmt;
		var carModelCode=detailData[i].carModelCode;
		if(!detailData[i].frameColorId){
			showMsg("车型编码："+carModelCode+"的车身颜色不能为空","W");
			return ;
		}
		if(!detailData[i].interialColorId){
			showMsg("车型编码："+carModelCode+"的内饰颜色不能为空","W");
			return ;
		}
		if(!detailData[i].orderQty || detailData[i].orderQty==="0" || detailData[i].orderQty==null){
			showMsg("车型编码："+carModelCode+"的数量不能为0","W");
			return ;
		}
		if(!detailData[i].orderPrice  || detailData[i].orderPrice==null){
			showMsg("车型编码："+carModelCode+"的单价不能为空","W");
			return ;
		}
	}
	//工单主表的未付，总金额赋值
	data.orderTotalAmt = totalAmt;
	data.payableBalaAmt = totalAmt-data.advanceDepositAmt;
	var pchsOrderDetailAdd = rightGrid.getChanges("added");
	var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
	var pchsOrderDetailDelete = rightGrid.getChanges("removed");
	var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);

	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			pchsOrderMain : data,
			pchsOrderDetailAdd : pchsOrderDetailAdd,
			pchsOrderDetailUpdate : pchsOrderDetailUpdate,
			pchsOrderDetailDelete : pchsOrderDetailDelete,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("保存成功!","S");
				// onLeftGridRowDblClick({});
				var pjPchsOrderMainList = data.pjPchsOrderMainList;
				cssCheckEnter = pjPchsOrderMainList;
				if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
//					var leftRow = pjPchsOrderMainList[0];
//					var row = leftGrid.getSelected();
//					leftGrid.updateRow(row, leftRow);
					
					var row=pjPchsOrderMainList[0];
					row.billStatusId=0;
					// 保存成功后重新加载数据
					loadMainAndDetailInfo(row);
					$('#bServiceId').text("订单号："+row.serviceCode);
			
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
var supplier = null;
function selectSupplier(elId) {
	supplier = null;
	nui.open({
		// targetWindow: window,,
		url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
		title : "供应商资料",
		width : 980,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			// var params = {
            //     isSupplier: 1,
            //     guestType:'01020202'
			// };
			var params = {
                isSupplier: 1,
                guestType :"01020201"
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

					nui.get("billTypeId").setValue(billTypeIdV);
					nui.get("payMode").setValue(settTypeIdV);

				}
			}
		}
	});
}

function onCellEditEnter(e){
	var record = e.record;
	var cell = rightGrid.getCurrentCell();//行，列
	var orderPrice = record.orderPrice;
	if(cell && cell.length >= 2){
		var column = cell[1];
		if(column.field == "carModelCode"){
			var carModelCode = record.carModelCode||"";
			carModelCode = carModelCode.replace(/\s+/g, "");
			if(!carModelCode){
				showMsg("请输入编码!","W");
				var row = rightGrid.getSelected();
				rightGrid.removeRow(row);
				addNewRow(false);
				return;
			}else{				
				getPartInfo(record);
				
			}
		}
	}
}
// 提交单元格编辑数据前激发
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

			var orderAmt = orderQty * orderPrice;

			newRow = {
				orderAmt : orderAmt
			};
			rightGrid.updateRow(e.row, newRow);

			// record.enteramt.cellHtml = enterqty * enterprice;
		} else if (e.field == "orderPrice") {
			var orderQty = record.orderQty;
			var orderPrice = e.value;
			
			if (e.value == null || e.value == '') {
				e.value = 0;
				orderPrice = 0;
			} else if (e.value < 0) {
				e.value = 0;
				orderPrice = 0;
			}

			var orderAmt = orderQty * orderPrice;

			newRow = {
				orderAmt : orderAmt
			};
			rightGrid.updateRow(e.row, newRow);		

		} else if (e.field == "orderAmt") {
			var orderQty = record.orderQty;
			var orderAmt = e.value;

			if (e.value == null || e.value == '') {
				e.value = 0;
				orderAmt = 0;
			} else if (e.value < 0) {
				e.value = 0;
				orderAmt = 0;
			}

			// e.cellHtml = enterqty * enterprice;
			var orderPrice = orderAmt * 1.0 / orderQty;


			if (orderQty) {
				newRow = {
					orderPrice : orderPrice
				};
				rightGrid.updateRow(e.row, newRow);
			}

			//addNewKeyRow();

		}else if(e.field == "carModelCode"){
			oldValue = e.oldValue;
			oldRow = row;

    		
		}else if(e.field == "remark"){
			//addNewKeyRow();
		}
	}
}


/*function addDetail(part) {
	var data = basicInfoForm.getData();
	var row=rightGrid.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
//			mainTabs.activeTab(billmainTab);

			return;
		}
	}

	if (data) {
		if (data.auditSign == 1) {
			showMsg("此单已审核!","W");
			return;
		}
	} else {
		return;
	}
	
	nui.open({
				// targetWindow: window,,
				url : webPath+contextPath+"/com.hsweb.part.manage.detailQPAPopOperate.flow?token="+token,

				title : "采购订单数量金额",
				width : 540,
				height : 240,
				allowDrag : true,
				allowResize : false,
				onload : function() {
					var iframe = this.getIFrameEl();
					part.storeId = FStoreId;//nui.get("storeId").getValue();
					iframe.contentWindow.setData({
						part : part,
						priceType : "pchsIn"
					});
				},
				ondestroy : function(action) {
					if (action == "ok") {
						var iframe = this.getIFrameEl();
						var data = iframe.contentWindow.getData();
						var enterDetail = {};
						enterDetail.partId = data.id;
						enterDetail.carModelCode = data.code;
						enterDetail.comPartName = data.name;
						enterDetail.comPartBrandId = data.partBrandId;
						enterDetail.comApplyCarModel = data.applyCarModel;
						enterDetail.comUnit = data.unit;
						enterDetail.orderQty = data.qty;
						enterDetail.orderPrice = data.price;
						enterDetail.orderAmt = data.amt;
						enterDetail.remark = data.remark;
						enterDetail.storeId = data.storeId;
						enterDetail.comOemCode = data.oemCode;
						enterDetail.comSpec = data.spec;
						enterDetail.partCode = data.code;
						enterDetail.partName = data.name;
						enterDetail.fullName = data.fullName;
						enterDetail.systemUnitId = data.unit;
						enterDetail.enterUnitId = data.unit;
						
						for(var i=0;i<row.length;i++){
							if(!row[i].partId){
								rightGrid.removeRow(row[i]);
							}
						}
						var e={value:enterDetail.storeId};
						rightGrid.addRow(enterDetail);
						nui.get("storehouse").doValueChanged();
			
					}
				}
			});
}*/
/*var partPriceUrl = baseUrl
		+ "com.hsapi.part.invoice.pricemanage.getPchsDefaultPrice.biz.ext";
function getPartPrice(params){
	var price = 0;
	var shelf = null;
	var sellPrice = null;
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
				if(priceRecord.pchsPrice){
					price = priceRecord.pchsPrice;
				}
				if(priceRecord.shelf){
					shelf = priceRecord.shelf;
				}
				if(priceRecord.sellPrice){
					sellPrice = priceRecord.sellPrice;
				}
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

	var dInfo = {price: price, shelf: shelf, sellPrice: sellPrice};

	return dInfo;
}*/
function addInsertRow(value,row) {    
	
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
//			mainTabs.activeTab(billmainTab);

			return;
		}
	}
    var params = {code:value};
	var part = getPartInfo(params);
	var storeId = FStoreId;

	if(part){
		params.partId = part.id;
		params.storeId = storeId;
		var dInfo = getPartPrice(params);
		var price = dInfo.price;
		var shelf = dInfo.shelf;
		var sellPrice = dInfo.sellPrice;
					
		var newRow = {
			partId : part.id,
			carModelCode : part.code,
			comPartName : part.name,
			comPartBrandId : part.partBrandId,
			comApplyCarModel : part.applyCarModel,
			comUnit : part.unit,
			orderQty : 1,
			orderPrice : price,
			orderAmt : price,
			storeId : storeId,
			storeShelf : shelf,
			comOemCode : part.oemCode,
			comSpec : part.spec,
			partCode : part.code,
			partName : part.name,
			fullName : part.fullName,
			systemUnitId : part.unit,
			enterUnitId : part.unit,
			sellPrice : sellPrice
		};

		if(row){
			var e={value :newRow.storeId};
			rightGrid.updateRow(row,newRow);
			//nui.get("storehouse").doValueChanged();
	
			//rightGrid.beginEditCell(row, "comUnit");
		}else{
			rightGrid.addRow(newRow);
			//rightGrid.beginEditCell(row, "comUnit");
		}
	
		return true;
	}else{
		var newRow = {};
		if(row){
			rightGrid.updateRow(row,newRow);
			rightGrid.beginEditCell(row, "carModelCode");
		}
		return true;
	}

	return false;
}
/*function addPart() {
	
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
//			mainTabs.activeTab(billmainTab);

			return;
		}
	}
	var data = basicInfoForm.getData();
	if (data) {
		if (data.auditSign == 1) {
			return;
		}
	}

	selectPart(function(data) {
		var part = data.part;
		addDetail(part);
	}, function(data) {
		var part = data.part;
		var partid = part.id;
		var rtn = checkPartIDExists(partid);
		return rtn;
	});
}*/
function checkAddNewRow() {
	var rows = rightGrid.findRows(function(row) {
		if (row.carModelCode == ""||row.carModelCode == null||row.carModelCode == undefined)
			return true;
	});

	return rows;
}
function checkPartIDExists(partid) {
	var row = rightGrid.findRow(function(row) {
		if (row.partId == partid) {
			return true;
		}
		return false;
	});

	if (row) {
		return "配件编码：" + row.carModelCode + "在采购订单列表中已经存在，是否继续？";
	}

	return null;

}
var editPartHash = {};
function deletePart() {
	
	var data = basicInfoForm.getData();
	if (data) {
		if (data.auditSign == 1) {
			return;
		}
	}
	
	 //电商平台的供应商，srmGuestId有值
    var srmGuestId=data.srmGuestId;
	if(srmGuestId){
		return;
	} 
	
	var part = rightGrid.getSelected();
	if (!part) {
		return;
	}
	if (part.detailId && editPartHash[part.detailId]) {
		delete editPartHash[part.detailId];
	}
	var data = rightGrid.getData();
    if(data && data.length==1){
        var row = rightGrid.getSelected();
        rightGrid.removeRow(row);
        var newRow = {};
        rightGrid.addRow(newRow);
        rightGrid.beginEditCell(newRow, "carModelCode");
    }else{
        var row = rightGrid.getSelected();
        rightGrid.removeRow(row);
    }
}
function checkRightData() {
	var msg = '';
	var qtyArr = [];
	var priceArr = [];

	var rows = rightGrid.findRows(function(row) {
		if(row.partId){
			if (row.orderQty) {
				if (row.orderQty <= 0){
					var newRow = {partCode: row.carModelCode};
					qtyArr.push(newRow);
					return true;
				}
			} else {
				if (row.orderQty <= 0){
					var newRow = {partCode: row.carModelCode};
					qtyArr.push(newRow);
					return true;
				}
			}
			if (row.orderPrice) {
				if (row.orderPrice <= 0){
					var newRow = {partCode: row.carModelCode};
					priceArr.push(newRow);
					return true;
				}
			} else {
				if (row.orderPrice <= 0){
					var newRow = {partCode: row.carModelCode};
					priceArr.push(newRow);
					return true;
				}
			}
			if (row.orderAmt) {
				if (row.orderAmt <= 0){
					var newRow = {partCode: row.carModelCode};
					priceArr.push(newRow);
					return true;
				}
			} else {
				if (row.orderAmt <= 0){
					var newRow = {partCode: row.carModelCode};
					priceArr.push(newRow);
					return true;
				}
			}

			if (row.storeId) {
			} else {
				return true;
			}	
		}

	});

	var p = {};
	if(qtyArr && qtyArr.length>0){
		p.qtyPartCode = qtyArr[0].partCode;
	}
	if(priceArr && priceArr.length>0){
		p.pricePartCode = priceArr[0].partCode;
	}
	// if (rows && rows.length > 0) {
	// 	msg = "请完善采购配件的数量，单价，金额，仓库等信息！";
	// }
	return p;
}
var salesCheckCar = baseUrl+"com.hsapi.sales.svr.inventory.applyCheckCar.biz.ext";
function salesCheck(){
	if (isFinancial == 0) {
		showMsg("请先提交!","W");
		return;
	}
	var data = basicInfoForm.getData();
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '申请验车中...'
	});

	nui.ajax({
		url : salesCheckCar,
		type : "post",
		data : JSON.stringify({
			orderMain : data,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("申请成功!","S");
			} else {
				showMsg(data.errMsg || "申请失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});	
}
var salesSubmitFinancial = baseUrl+"com.hsapi.sales.svr.inventory.salesSubmitFinancial.biz.ext";
function audit(){
	if (isFinancial == 1) {
		showMsg("此单已提交!","W");
		return;
	}

	if(cssCheckEnter.length==0){
		showMsg("请先保存单据!","W");
		return;
	}
	var data = basicInfoForm.getData();
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '提交中...'
	});

	nui.ajax({
		url : salesSubmitFinancial,
		type : "post",
		data : JSON.stringify({
			orderMain : data,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("提交成功!","S");
				document.getElementById("fd1").disabled = true;
				isFinancial = 1;//提交后靠这个变量控制是否能编辑
			} else {
				showMsg(data.errMsg || "提交失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});	
}
function auditToEnter(){
	//如果是内部订单，直接入库时需要判断 bill_status_id = 2（待收货）
	var data = basicInfoForm.getData();
	var isInner = data.isInner||0;
	var billStatusId = data.billStatusId||0;
	
	if(data.auditSign!=1){
		showMsg("请先提交再入库!","W");
		return;
	}
	if(data.billStatusId==1){
		showMsg("待收货状态才能入库!","W");
		return;
	}
	if (data) {
		if (data.auditSign == 1 && data.billStatusId == 4) {
			showMsg("此单已入库!","W");
			return;
		}
	} else {
		return;
	}
	if(billStatusId == 0){
		showMsg("请先提交再入库!","W");
		return;
	}else if(billStatusId == 2 || billStatusId == 1){  //待发货和待收货状态下都可以入库
		var id = data.id||0;
		//电商供应商先生成电商单号，再提交订单
		if(data.srmGuestId){
			nui.confirm("是否确定入库?", "友情提示", function(action) {
				if (action == "ok") {
					updateOrderStatus("5",id);
				}else{
					return;
				}
			});
		}else{			
			orderEnter(id);	
		}
	}

	

}
//不判断，直接提交
function auditOrderDirect(flagSign, flagStr, flagRtn){
	var str = "提交";
	if(flagSign == 1){
		str = "入库";
	}
	data = getMainData();
	
	//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
	var detailData = rightGrid.getData();

    if(detailData.length <=0) {
        showMsg("订单明细为空，不能提交!","W");
        rightGrid.addRow({});
        return;
    }

/*	for(var i=0;i<detailData.length;i++){
		var carModelCode=detailData[i].carModelCode;
		if(!detailData[i].orderQty || detailData[i].orderQty==="0" || detailData[i].orderQty==null){
			showMsg("配件编码为"+carModelCode+"的数量不能为0","W");
			return ;
		}
		if(!detailData[i].storeId){
			showMsg("配件编码为"+carModelCode+"的仓库不能为空","W");
			return ;
		}
	}*/
	
	var pchsOrderDetailAdd = rightGrid.getChanges("added");
	var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
	var pchsOrderDetailDelete = rightGrid.getChanges("removed");
	var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
	
	
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : flagStr
	});

	nui.ajax({
		url : auditUrl,
		type : "post",
		data : JSON.stringify({
			pchsOrderMain : data,
			pchsOrderDetailAdd : pchsOrderDetailAdd,
			pchsOrderDetailUpdate : pchsOrderDetailUpdate,
			pchsOrderDetailDelete : pchsOrderDetailDelete,
			operateFlag : flagSign,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg(str+"成功!","S");
				// onLeftGridRowDblClick({});
				var pjPchsOrderMainList = data.pjPchsOrderMainList;
				if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
					var leftRow = pjPchsOrderMainList[0];

					// 保存成功后重新加载数据
//					leftRow.billStatusId=2;
					loadMainAndDetailInfo(leftRow);
					$('#bServiceId').text("订单号："+leftRow.serviceCode);

				}
			} else {
				//车道订单提交失败了，把电商订单取消
				updateOrderStatus("6");
				showMsg(data.errMsg || (str+"失败!"),"E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var auditUrl = baseUrl
		+ "com.hsapi.part.invoice.crud.auditPjPchsOrder.biz.ext";
function auditOrder(flagSign, flagStr, flagRtn) {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");

//			mainTabs.activeTab(billmainTab);
			return;
		}
	}

	if (data) {
		if (data.auditSign == 1) {
			showMsg("此单已审核!","W");
			return;
		}
	} else {
		return;
	}
	
/*	var detailData = rightGrid.getData();
	for(var i=0;i<detailData.length;i++){
		var carModelCode=detailData[i].carModelCode;
		if(!detailData[i].orderQty || detailData[i].orderQty==="0" || detailData[i].orderQty==null){
			showMsg("配件编码为"+carModelCode+"的数量不能为0","W");
			return ;
		}
		if(!detailData[i].storeId){
			showMsg("配件编码为"+carModelCode+"的仓库不能为空","W");
			return ;
		}
	}*/

	// 审核时，数量，单价，金额，仓库不能为空,单价可以为0，只需要提示
	var p = checkRightData();
	if (p && p.qtyPartCode) {
		var partCode = p.qtyPartCode;
		showMsg("配件编码:"+partCode+"数量为0","W");
		return;
	}

	var str = "提交";
	if(flagSign == 1){
		str = "入库";
	}

	if (p && p.pricePartCode) {
		var partCode = p.pricePartCode;
		nui.confirm("存在单价为0信息，是否继续?", "友情提示", function(action) {
			if (action == "ok") {
	
				data = getMainData();
	
				//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
				var detailData = rightGrid.getData();

			    if(detailData.length <=0) {
			        showMsg("订单明细为空，不能提交!","W");
			        rightGrid.addRow({});
			        return;
			    }
				var pchsOrderDetailAdd = rightGrid.getChanges("added");
				var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
				var pchsOrderDetailDelete = rightGrid.getChanges("removed");
				var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
				
				
				nui.mask({
					el : document.body,
					cls : 'mini-mask-loading',
					html : flagStr
				});
	
				nui.ajax({
					url : auditUrl,
					type : "post",
					data : JSON.stringify({
						pchsOrderMain : data,
						pchsOrderDetailAdd : pchsOrderDetailAdd,
						pchsOrderDetailUpdate : pchsOrderDetailUpdate,
						pchsOrderDetailDelete : pchsOrderDetailDelete,
						operateFlag : flagSign,
						token: token
					}),
					success : function(data) {
						nui.unmask(document.body);
						data = data || {};
						if (data.errCode == "S") {
							showMsg(str+"成功!","S");
							// onLeftGridRowDblClick({});
							var pjPchsOrderMainList = data.pjPchsOrderMainList;
							if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
								var leftRow = pjPchsOrderMainList[0];

								// 保存成功后重新加载数据
//								leftRow.billStatusId=2;
								loadMainAndDetailInfo(leftRow);
								$('#bServiceId').text("订单号："+leftRow.serviceCode);

							}
						} else {
							showMsg(data.errMsg || (str+"失败!"),"E");
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
	}else {
		nui.confirm("是否确定"+str+"?", "友情提示", function(action) {
			if (action == "ok") {
	
				data = getMainData();
	
				//由于票据类型可能修改，所以除了新建和删除，其他都应该是修改
				var detailData = rightGrid.getData();
				
				 if(detailData.length <=0) {
				        showMsg("订单明细为空，不能提交!","W");
				        rightGrid.addRow({});
				        return;
				    }
				 
				
				var pchsOrderDetailAdd = rightGrid.getChanges("added");
				var pchsOrderDetailUpdate = rightGrid.getChanges("modified");
				var pchsOrderDetailDelete = rightGrid.getChanges("removed");
				var pchsOrderDetailUpdate = getModifyData(detailData, pchsOrderDetailAdd, pchsOrderDetailDelete);
				
				nui.mask({
					el : document.body,
					cls : 'mini-mask-loading',
					html : flagStr
				});
	
				nui.ajax({
					url : auditUrl,
					type : "post",
					data : JSON.stringify({
						pchsOrderMain : data,
						pchsOrderDetailAdd : pchsOrderDetailAdd,
						pchsOrderDetailUpdate : pchsOrderDetailUpdate,
						pchsOrderDetailDelete : pchsOrderDetailDelete,
						operateFlag : flagSign,
						token: token
					}),
					success : function(data) {
						nui.unmask(document.body);
						data = data || {};
						if (data.errCode == "S") {
							showMsg(str+"成功!","S");

							var pjPchsOrderMainList = data.pjPchsOrderMainList;
							if (pjPchsOrderMainList && pjPchsOrderMainList.length > 0) {
								var leftRow = pjPchsOrderMainList[0];

//	
								// 保存成功后重新加载数据
//								leftRow.billStatusId=2;
								loadMainAndDetailInfo(leftRow);
								$('#bServiceId').text("订单号："+leftRow.serviceCode);
								

							}
						} else {
							showMsg(data.errMsg || (str+"失败!"),"E");
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
//不判断，直接入库
function orderEnterDirect(mainId){
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '入库中...'
	});

	nui.ajax({
		url : enterUrl,
		type : "post",
		data : JSON.stringify({
			orderMainId : mainId,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("入库成功!","S");

			var orderMainAudit = data.orderMainAudit;
			if (orderMainAudit) { 
				var leftRow = orderMainAudit;
//				
				// 入库成功后重新加载数据
				leftRow.billStatusId=4;
				
				if(!leftRow.guestFullName){
					var guestFullName = nui.get("guestId").getText();
					leftRow.guestFullName = guestFullName;
				}
				loadMainAndDetailInfo(leftRow);

				nui.confirm("是否打印？", "友情提示", function(action) {
					if(action== 'ok'){
						onPrint();
					}else{
						
					}
					
				});
//				$('#bServiceId').text("订单号："+leftRow.serviceId);
			}

			} else {
				showMsg(data.errMsg || "入库失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});

}

var enterUrl = baseUrl
		+ "com.hsapi.part.invoice.ordersettle.generateNewPchsOrderEnter.biz.ext";
function orderEnter(mainId) {
	
	var data = basicInfoForm.getData();
	if(data.auditSign!=1){
		showMsg("请先提交再入库!","W");
		return;
	}
	if(data.billStatusId==1){
		showMsg("待收货状态才能入库!","W");
		return;
	}
	if (data) {
		if (data.auditSign == 1 && data.billStatusId == 4) {
			showMsg("此单已入库!","W");
			return;
		}
	} else {
		return;
	}

	nui.confirm("是否确定入库?", "友情提示", function(action) {
		if (action == "ok") {

			nui.mask({
				el : document.body,
				cls : 'mini-mask-loading',
				html : '入库中...'
			});

			nui.ajax({
				url : enterUrl,
				type : "post",
				data : JSON.stringify({
					orderMainId : mainId,
					token: token
				}),
				success : function(data) {
					nui.unmask(document.body);
					data = data || {};
					if (data.errCode == "S") {
						showMsg("入库成功!","S");

					var orderMainAudit = data.orderMainAudit;
					if (orderMainAudit) { 
						var leftRow = orderMainAudit;
//						
						// 入库成功后重新加载数据
						leftRow.billStatusId=4;
						
						if(!leftRow.guestFullName){
							var guestFullName = nui.get("guestId").getText();
							leftRow.guestFullName = guestFullName;
						}
						loadMainAndDetailInfo(leftRow);

						nui.confirm("是否打印？", "友情提示", function(action) {
							if(action== 'ok'){
								onPrint();
							}else{
								
							}
							
						});
//						$('#bServiceId').text("订单号："+leftRow.serviceId);
					}

					} else {
						showMsg(data.errMsg || "入库失败!","E");
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
function onDrawSummaryCell(e) {
	var rows = e.data;// rightGrid.getData();
	if (e.field == "orderAmt") {
		var orderAmt = 0;
		for (var i = 0; i < rows.length; i++) {
			orderAmt += parseFloat(rows[i].orderAmt);
		}

	}
}
function onGuestValueChanged(e) {
	// 供应商中直接输入名称加载供应商信息
	var params = {};
	params.pny = e.value;
	params.isSupplier = 1;
	setGuestInfo(params);
}
var getGuestInfo = baseUrl
		+ "com.hsapi.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params) {
	nui.ajax({
		url : getGuestInfo,
		async:false,
		data : {
			params : params,
			token : token
		},
		type : "post",
		success : function(text) {
			if (text) {
				var supplier = text.suppliers;
				if (supplier && supplier.length > 0) {
					var data = supplier[0];
					var value = data.id;
					var text = data.fullName;
					var el = nui.get('guestId');
					el.setValue(value);
					el.setText(text);


					var billTypeIdV = data.billTypeId;
					var settTypeIdV = data.settTypeId;

					nui.get("billTypeId").setValue(billTypeIdV);
					nui.get("payMode").setValue(settTypeIdV);
					nui.get('planArriveDate').focus();
//					addNewRow(true);
					
				} else {
					var el = nui.get('guestId');
					el.setValue(null);
					el.setText(null);


					nui.get("billTypeId").setValue("010103"); // 010101 收据 010102 普票 010103 增票

					addGuest();
				}
			} else {
				var el = nui.get('guestId');
				el.setValue(null);
				el.setText(null);


				nui.get("billTypeId").setValue("010103");

				addGuest();
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
function addGuest(){
	nui.confirm("此供应商不存在，是否新增?", "友情提示", function(action) {
		if (action == "ok") {
			nui.open({
				// targetWindow: window,
				url: webPath+contextPath+"/com.hsweb.part.baseData.supplierDetail.flow?token=" + token,
				title: "供应商资料", width: 570, height: 510,
				allowDrag:true,
				allowResize:false,
				onload: function ()
				{
					var iframe = this.getIFrameEl();
					iframe.contentWindow.setData({
						province:[],
						city:[],
						supplierType:[],
						billTypeId:nui.get("billTypeId").getData(),
						settTypeId:nui.get("payMode").getData(),
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

		}else{
			nui.get("guestId").focus();
		}
	});
}

function onPrint(){
	var from = basicInfoForm.getData();
	var params={
			id : from.id,
		auditSign:from.auditSign,
		guestId :from.guestId,
		currUserName :currUserName,
		currRepairSettorderPrintShow :currRepairSettorderPrintShow,
		currCompAddress :currCompAddress,
		currCompTel :currCompTel,
		currCompLogoPath : currCompLogoPath,
		currOrgName : currOrgName
	};
	var detailParams={
			mainId :from.id,
			auditSign:from.auditSign
	};
	var openUrl = webPath + contextPath+"/manage/inOutManage/purchaseOrder/purchaseOrderPrint.jsp";

    nui.open({
       url: openUrl,
       width: "100%",
       height: "100%",
       showMaxButton: false,
       allowResize: false,
       showHeader: true,
       onload: function() {
           var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(params,detailParams);
       },
   });
}
//function onPrint(e){
////	var main = leftGrid.getSelected();
////	if(!main){
////		showMsg("请选择一条记录");
////	}
//	var detail=rightGrid.getData();
//	var from = basicInfoForm.getData();
//	var mainParams=null;
//	var billTypeId=nui.get('billTypeId').text;
//	var settleTypeId=nui.get('settleTypeId').text;
//	var guestFullName=nui.get('guestId').text;
//	var serviceId =$('#bServiceId').text().substr(4);
//	var guestId =from.guestId;
//	var formParms={
//			guestId : guestId,
//			billTypeId :billTypeId,
//			settleTypeId:settleTypeId,
//			guestFullName : guestFullName,
//			serviceId : serviceId,
//			createDate :from.createDate
//	};
//	var detailParms=detail;
//
//	for(var i=0;i<detailParms.length;i++){
//		for(var j=0;j<storehouse.length;j++){
//			if(detailParms[i].storeId==storehouse[j].id){
//				detailParms[i].storehouse=storehouse[j].name;
//			}
//		}
//	}
//	
//	for(var i=0;i<detailParms.length;i++){	
//		var comPartBrindId=detailParms[i].comPartBrandId;
//		detailParms[i].comPartBrindId=brandHash[comPartBrindId].name;
//	}
//	
//	var openUrl = webPath + contextPath+"/manage/inOutManage/purchaseOrder/purchaseOrderPrint.jsp";
//
//     nui.open({
//        url: openUrl,
//        width: "100%",
//        height: "100%",
//        title : "采购订单打印",
//        showMaxButton: false,
//        allowResize: false,
//        showHeader: true,
//        onload: function() {
//            var iframe = this.getIFrameEl();
//            iframe.contentWindow.SetData(mainParams,detailParms,formParms);
//        },
//    });
// }

function addSelectPart(){
	
	var row = morePartGrid.getSelected();
	if(row){
		var params = {partCode:row.code};
		params.partId = row.id;
		params.storeId = FStoreId;					
		var newRow = {
			carModelId : row.id,
			carModelName : row.fullName,			
			fullName : row.fullName,
		};

		advancedMorePartWin.hide();
		morePartGrid.setData([]);
		partShow = 0;

		if(rightGrid.getSelected()){
			var e={value:newRow.storeId};
			rightGrid.updateRow(rightGrid.getSelected(),newRow);
			//nui.get("storehouse").doValueChanged();

		}else{
			rightGrid.addRow(newRow);
		}
		rightGrid.beginEditCell(rightGrid.getSelected(), "orderQty");

		
	}else{
		showMsg("请选择车型!","W");
		return;
	}
}
function onPartClose(){
	advancedMorePartWin.hide();
	morePartGrid.setData([]);
	partShow = 0;

	var newRow = {carModelCode: oldValue};
	rightGrid.updateRow(oldRow, newRow);
	rightGrid.beginEditCell(oldRow, "carModelCode");
}
function OnrpMainGridCellBeginEdit(e){
    var field=e.field; 
    var row = e.row;
    var column = e.column;
    var editor = e.editor;

    var data = basicInfoForm.getData();
    
    if(data.auditSign == 1){
        e.cancel = true;
	}
    //选择的供应商是电商平台的
    if(data.srmGuestId){
    	if(field =='carModelCode'|| field =='orderQty' || field =='orderPrice' || field =='orderAmt'){		
    		e.cancel = true;
    	}
    }
	if(advancedMorePartWin.visible) {
		e.cancel = true;
		morePartGrid.focus();
	}

    if (field == "storeShelf") {
        var value = e.record.storeId;
        getLocationListByStoreId(value,function(data) {
			storeShelfList = data.locationList || [];
			nui.get('storeShelf').setData(storeShelfList);

		});
        }

}
function addMorePart(){
	
	var main = basicInfoForm.getData();

	if(main.auditSign == 1){
		showMsg("此单已审核!","W");
		return;
	}

	if(!main.id){
		showMsg("请先保存单据!","W");
		return;
	}
	advancedAddForm.setData([]);
	advancedAddWin.show();
	quickAddShow=1;

	var fastCodeList = nui.get("fastCodeList");
	fastCodeList.focus();
}

/*function addOrEditPart(row)
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 470, height: 320,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params={};
//            params.qualityTypeIdList=null;
//            params.partBrandIdList=null;
//            params.unitList=null;
//            params.abcTypeList=null;
//            params.applyCarModelList=null;
            if(row)
            {
                params.carModelCode= row.carModelCode;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
          	var iframe = this.getIFrameEl();
        	var data = iframe.contentWindow.getData();
        	var enterDetail={
        		carModelCode : data.code
        	};
            if(action == "ok")
            {	
            	addInsertRow(enterDetail.carModelCode,row);
            	
            }
        }
    });

}*/

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
				url : baseUrl + "com.hsapi.part.invoice.paramcrud.getPartInfoByCodes.biz.ext",
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
						showMsg(data.errMsg || "添加数据失败!","E");
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
				carModelCode : part.partCode,
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
				enterUnitId : part.unit
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
		var newRow = {carModelCode:""};
	    rightGrid.addRow(newRow);

	    rightGrid.cancelEdit();
	    //rightGrid.beginEditRow(newRow);	
	    rightGrid.beginEditCell(newRow, "operateBtn");
		
	}

}
var unAuditUrl = baseUrl+"com.hsapi.part.invoice.crud.unAuditPjPchsOrder.biz.ext";
function unAudit()
{
    var data = basicInfoForm.getData();
    var billStatusId = data.billStatusId;
    var isInner = data.isInner;
    var mainId = data.id;
    if(isInner && isInner == 1){
	    if(billStatusId != 1 && billStatusId != 5){
			showMsg("【待发货】和【已退回】状态下的单才可以返单!","W");
	        return;
	    }
    }else{
    	if(billStatusId != 2){
			showMsg("【待收货】状态下的单才可以返单!","W");
	        return;
	    }
    }
    if(data.srmGuestId){
    	updateOrderStatus("6");
	}else{
		unAuditTrue();
	}
}

//实际车道返单方法
function unAuditTrue(){
	var data = basicInfoForm.getData();
    var billStatusId = data.billStatusId;
    var isInner = data.isInner;
    var mainId = data.id;
    if(isInner && isInner == 1){
	    if(billStatusId != 1 && billStatusId != 5){
			showMsg("【待发货】和【已退回】状态下的单才可以返单!","W");
	        return;
	    }
    }else{
    	if(billStatusId != 2){
			showMsg("【待收货】状态下的单才可以返单!","W");
	        return;
	    }
    }


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
				nui.get('billStatusId').setValue('0');
				nui.get('auditSign').setValue('0');
				var text=StatusHash[0];
				if(StatusHash){
					/*nui.get('AbillStatusId').setValue(text);*/
			    }
				document.getElementById("basicInfoForm").disabled = false;
				setBtnable(true);
				setEditable(true);
                
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
function importPart(){
	
	var main = basicInfoForm.getData();

	if(main.auditSign == 1){
		showMsg("此单已审核!","W");
		return;
	}

	if(!main.id){
		showMsg("请先保存单据!","W");
		return;
	}

    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.manage.getPartInfoImoprt.flow?token="+token,
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
				carModelCode : part.partCode,
				comPartName : part.partName,
				comPartBrandId : part.partBrandId,
				comApplyCarModel : part.applyCarModel,
				comUnit : part.unit,
				orderQty : orderQty,
				orderPrice : orderPrice,
				orderAmt : orderQty * orderPrice,
				storeId : part.storeId,
				comOemCode : part.oemCode,
				comSpec : part.spec,
				partCode : part.partCode,
				partName : part.partName,
				fullName : part.fullName,
				systemUnitId : part.unit,
				enterUnitId : part.unit,
				storeShelf: part.shelf,
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
	
	var main=basicInfoForm.getData();	
	if(main.billStatusId===""){
		showMsg("清先保存数据!","W");
		return;
	}
	var detail = nui.clone(rightGrid.getData());
	
	for(var i=0;i<detail.length;i++){
		for(var j=0;j<storehouse.length;j++){
			if(detail[i].storeId==storehouse[j].id){
				detail[i].storeId=storehouse[j].name;
			}
		}
	}
	
	if(detail && detail.length > 0){
		setInitExportData(main, detail);
	}
}
function setInitExportData(main, detail){
	document.getElementById("eServiceId").innerHTML = main.serviceId?main.serviceId:"";
	document.getElementById("eGuestName").innerHTML = main.guestFullName?main.guestFullName:"";
	document.getElementById("eRemark").innerHTML = main.remark?main.remark:"";
    var tds = '<td  colspan="1" align="left">[carModelCode]</td>' +
        "<td  colspan='1' align='left'>[comFullName]</td>" +
        "<td  colspan='1' align='left'>[comApplyCarModel]</td>" +
        "<td  colspan='1' align='left'>[comUnit]</td>" +
        "<td  colspan='1' align='left'>[orderQty]</td>" +
        "<td  colspan='1' align='left'>[orderPrice]</td>" +
        "<td  colspan='1' align='left'>[orderAmt]</td>" +
        "<td  colspan='1' align='left'>[remark]</td>"+
        "<td  colspan='1' align='left'>[storeId]</td>"+
        "<td  colspan='1' align='left'>[storeShelf]</td>"+
        "<td  colspan='1' align='left'>[comOemCode]</td>"+
        "<td  colspan='1' align='left'>[comSpec]</td>";
        
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
        if(row.partId){
            var tr = $("<tr></tr>");
            tr.append(tds.replace("[carModelCode]", detail[i].carModelCode?detail[i].carModelCode:"")
                         .replace("[comFullName]", detail[i].comFullName?detail[i].comFullName:"")
                         .replace("[comApplyCarModel]", detail[i].comApplyCarModel?detail[i].comApplyCarModel:"")
                         .replace("[comUnit]", detail[i].comUnit?detail[i].comUnit:"")
                         .replace("[orderQty]", detail[i].orderQty?detail[i].orderQty:"")
                         .replace("[orderPrice]", detail[i].orderPrice?detail[i].orderPrice:"")
                         .replace("[orderAmt]", detail[i].orderAmt?detail[i].orderAmt:"")
                         .replace("[remark]", detail[i].remark?detail[i].remark:"")
                         .replace("[storeId]", detail[i].storeId?detail[i].storeId:"")
                         .replace("[storeShelf]", detail[i].storeShelf?detail[i].storeShelf:"")
                         .replace("[comOemCode]", detail[i].comOemCode?detail[i].comOemCode:"")
                         .replace("[comSpec]", detail[i].comSpec?detail[i].comSpec:""));
            tableExportContent.append(tr);
        }
    }

    var serviceId = main.serviceId?main.serviceId:"";
    method5('tableExcel',"采购订单"+serviceId,'tableExportA');
}

function deleteState(){
	var data=rightGrid.getData();
	for(var i=0;i<data.length;i++){
		delete data[i]._state;
	}	
	
}

function setInitData(params){
	if(params.id){
		basicInfoForm.setData(params);
		$('#bServiceId').text("订单号："+params.serviceCode);
		nui.get("guestId").setText(params.guestFullName);
		
		var mainId=params.id;
		if(params.id){		
			loadRightGridData(mainId, params.isFinancial);	
		}
		cssCheckEnter[0] = params;
		isFinancial = params.isFinancial;
		if(params.isFinancial != 0){			
			document.getElementById("fd1").disabled = true;

			nui.get("guestId").disable();
		}
	}else{
		formJson = nui.encode(basicInfoForm.getData());
		add();	
	}
}





function getPartInfo(params){	
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
//			mainTabs.activeTab(billmainTab);

			return;
		}
	}
	var oldRow = params;
	nui.open({
		url: webPath + contextPath + '/sales/base/selectCarModel.jsp',
		title: '选择车型',
		width: 1000,
		height: 500,
		onload: function () {
		var iframe = this.getIFrameEl();
		iframe.contentWindow.setData(params);
		},
		ondestroy: function (action) {
		var iframe = this.getIFrameEl();
		if(action == 'ok'){
		var rows=rightGrid.getData();
		for(var i=0;i<rows.length;i++){
			if(!rows[i].carModelCode){
				rightGrid.removeRow(rows[i]);
			}
		}
		var row = iframe.contentWindow.getRow();
		if(row){				
			var newRow = {
				carModelId : row.id,
				carModelName : row.fullName,			
				fullName : row.fullName,
				carModelCode : row.code
			};
			rightGrid.removeRow(oldRow);
			rightGrid.addRow(newRow);		
		}else{
			showMsg("请选择车型!","W");
			return;
		}
		 }
	    }
	  });
}