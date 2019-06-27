/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + saleApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl
		+ "com.hsapi.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
var storeShelf = baseUrl+"com.hsapi.part.baseDataCrud.crud.getSorehouseLocation.biz.ext";
var rightGrid = null;
var dataform1 = null;


var provinceName =null;
var cityName =null;
var countyName = null;
var cssCheckEnter = {};//列表界面传过来或者返回保存的
var orderDetailId = null;//防止id覆盖入库单id,采购明细id
$(document).ready(function(v) {
	
	dataform1 = new nui.Form("#dataform1");
	var dictDefs ={carGoods:"DDT20130801000004",frameColorId:"DDT20130726000003",interialColorId:"10391"};
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
	nui.get("procedureMan").setValue(currEmpId);
	nui.get("procedureMan").setText(currUserName);
	initMember("procedureMan",function(){
        memList = nui.get('procedureMan').getData();
    });
});

var requiredField = {
	guestId : "供应商",
	procedureMan : "经手人",
	unitPrice : "车价（成本）",
	logisticCompId : "运输公司",
	carModelId : "车型",
	vin :"车架号（VIN）",
/*	kilometers : "公里数",*/
	carModelId : "车身颜色",
	interialColorId :"内饰颜色"
	
};
var salesCheckCarUrl = baseUrl
		+ "com.hsapi.sales.svr.inventory.salesCheckCar.biz.ext";
function save() {
	if(cssCheckEnter.billStatus==1){
		showMsg("单据已入库!","W");
		return;
	}else if(cssCheckEnter.billStatus==2){
		showMsg("单据已退货!","W");
		return;
	}
	
    var carVinData = validation(nui.get("vin").getValue());
    if(carVinData.isNo){
    	nui.get("vin").setValue(carVinData.vin);
    }else{
    	showMsg("VIN不规范，请确认！","W");
    	return;
    }
	var data = dataform1.getData();
	data.guestFullName = nui.get("guestId").getText();
	data.logisticCompName = nui.get("logisticCompId").getText();
	var json = nui.encode({
		cssCheckEnter:data,
		token:token
	});
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			showMsg(requiredField[key] + "不能为空!","W");
			//如果检测到有必填字段未填写，切换到主表界面
//			mainTabs.activeTab(billmainTab);
			return;
		}
	}

	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : salesCheckCarUrl,
		type : "post",
		data : json,
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("保存成功!","S");	
				cssCheckEnter = data.cssCheckEnter;
				nui.get("id").setValue(cssCheckEnter.id);
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
					nui.get("settleTypeId").setValue(settTypeIdV);

				}
			}
		}
	});
}
function selectTransport(elId) {
	supplier = null;
	nui.open({
		// targetWindow: window,,
		url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
		title : "运输公司资料",
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
	                guestType :"01020204"
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
					nui.get("settleTypeId").setValue(settTypeIdV);

				}
			}
		}
	});
}





//查看出库记录
function onOut(){
	var row ={};
	row = rightGrid.getSelected();
	if(!row){
		showMsg("请选择一条记录","W");
		return;
	}
	var partId = row.partId;
	onOutRecord(partId);
}

function check() {
	nui.open({
		url : webPath+contextPath+"/com.hsweb.inventory.carCheck.flow?token="+token,
		title : "选择待验车辆",
		width : 1000,
		height : 560,
		onload : function() {

		},
		ondestroy : function(action) {
			var iframe = this.getIFrameEl();
			if(action == 'ok'){
				add();
			var row = iframe.contentWindow.getRow();
			orderDetailId = row.id;
			row.id=null;//防止id覆盖入库单id
			row.unitPrice  = row.orderPrice;//入库单与订单明细单价字段不一样
			dataform1.setData(row);
			nui.get("guestId").setText(row.guestFullName);
			nui.get("code").setText(row.serviceCode);
			nui.get("code").setVisible(true);
			nui.get("procedureMan").setValue(currEmpId);
			nui.get("procedureMan").setText(currUserName);
			nui.get("carModelId").setValue(row.carModelId);
			nui.get("carModelName").setValue(row.carModelName);
			nui.get("carModelName").setText(row.carModelName);
			nui.get("orderId").setValue(row.orderId);
			nui.get("orderDetailId").setValue(orderDetailId);
			nui.get("guestId").disable();
			nui.get("unitPrice").disable();
			nui.get("carModelName").disable();
			 }
		}
	});
}
function onButtonEdit(e) {
	nui.open({
	url: webPath + contextPath + '/sales/base/selectCarModel.jsp',
	title: '选择车型',
	width: 1000,
	height: 500,
	onload: function () {
	var iframe = this.getIFrameEl();
	//iframe.contentWindow.setData(row);
	},
	ondestroy: function (action) {
	var iframe = this.getIFrameEl();
	if(action == 'ok'){
	var row = iframe.contentWindow.getRow();
	nui.get("carModelId").setValue(row.id);
	nui.get("carModelName").setValue(row.fullName);
	nui.get("carModelName").setText(row.fullName);
	 }
    }
  });
}
//验车入库

function carPutInStorage(){
	if(cssCheckEnter.billStatus==1){
		showMsg("单据已入库!","W");
		return;
	}
	if(cssCheckEnter.billStatus!=0){
		showMsg("请先保存单据!","W");
		return;
	}
	var json = nui.encode({
		cssCheckEnter:cssCheckEnter,
		token:token
	});
	var carPutInStorageUrl = baseUrl
	+ "com.hsapi.sales.svr.inventory.carPutInStorage.biz.ext";
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '入库中...'
	});
	nui.ajax({
		url : carPutInStorageUrl,
		type : "post",
		data : json,
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("入库成功!","S");	
				cssCheckEnter = data.cssCheckEnter;
				document.getElementById("basicInfoForm").disabled = false;
			} else {
				showMsg(data.errMsg || "入库异常!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}

function add(){
	dataform1.setData({});
	nui.get("guestId").setText("");
	nui.get("logisticCompId").setText("");
	nui.get("code").setText("");
	nui.get("code").setVisible(true);
	nui.get("carModelName").setValue("");
	nui.get("carModelName").setText("");
	cssCheckEnter = {};
	nui.get("guestId").enable();
	nui.get("unitPrice").enable();
	nui.get("carModelName").enable();	
}

function setInitData(params){
	if(params.id){
		cssCheckEnter = params;
		dataform1.setData(params);
		nui.get("guestId").setText(params.guestFullName);
		nui.get("logisticCompId").setText(params.logisticCompName);	
		nui.get("carModelId").setValue(params.carModelId);
		nui.get("carModelName").setValue(params.carModelName);
		nui.get("carModelName").setText(params.carModelName);
		
	}else{
		add();	
	}
}

