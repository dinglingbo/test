
/**
 * Created by Administrator on 2018/8/8.
 */
var baseUrl = apiPath + cloudPartApi + "/";
var mainGrid = null;
var detailGrid = null;
var queryInfoForm = null;
var mainGridUrl = baseUrl+ "com.hsapi.part.invoice.paramcrud.queryBillPartChoose.biz.ext";
var detailGridUrl = baseUrl+ "com.hsapi.cloud.part.invoicing.allotsettle.getAllotApplyDetail.biz.ext";

var sOrderDateEl = null;
var eOrderDateEl = null;
var pickManHash={};
$(document).ready(function(v) {

	queryInfoForm = new nui.Form("#queryInfoForm").getData(false, false);

	mainGrid = nui.get("mainGrid");
	detailGrid = nui.get("detailGrid");
	mainGrid.setUrl(mainGridUrl);
	detailGrid.setUrl(detailGridUrl);

	mainGrid.on("drawcell", onDrawCell);

	sOrderDateEl=nui.get("sOrderDate");
	eOrderDateEl=nui.get("eOrderDate");

	getNowFormatDate();

	quickSearch(4);

	mainGrid.on("selectionchanged", function(e) {
		var row = enterGrid.getSelected();
		gpartId = row.partId || 0;

	});

	enterGrid.on("drawcell", function(e) {
		switch (e.field) {
		case "partBrandId":
			 if(brandHash[e.value])
             {
//                 e.cellHtml = brandHash[e.value].name||"";
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
			if (storeHash[e.value]) {
				e.cellHtml = storeHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		case "billTypeId":
			if (billTypeHash[e.value]) {
				e.cellHtml = billTypeHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
			break;
		default:
			break;
		}

	});

});

function getSearchParams() {
	var params = {};
	params.returnSign=0;
	params.billTypeId='050207';
    params.partCode=nui.get("partCode").getValue();
    params.partName=nui.get("partName").getValue();
	params.sCreateDate = sCreateDateEl.getText();
	params.eCreateDate = addDate(eCreateDateEl.getText(),1);
	params.pickMan = nui.get('pickMan1').getText();
	return params;
}
function onSearch() {
	var params = getSearchParams();

	doSearch(params);
}
function doSearch(params) {
	grid.load({
		token : token,
		params : params
	});
}

var resultData = {};
var callback = null;
var checkcallback = null;
function setInitData(params, ck, cck) {
	var value = params.value;
	mainId = params.mainId;
	guestId = params.guestId;
	callback = ck;
	checkcallback = cck;

	var params = {};

	params.sortField = "B.ENTER_DATE";
	params.sortOrder = "asc";
	enterGrid.load({
		params : params
	}, function(e) {
		enterGrid.focus();
	});

}

function onPartClose() {
	CloseWindow("cancel");
}

function CloseWindow(action) {
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}

function getRtnData() {
	return resultData;
}
