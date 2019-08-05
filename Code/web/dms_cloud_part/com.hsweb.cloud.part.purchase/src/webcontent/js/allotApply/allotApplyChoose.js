
/**
 * Created by Administrator on 2018/8/8.
 */
var baseUrl = apiPath + cloudPartApi + "/";
var mainGrid = null;
var detailGrid = null;
var queryInfoForm = null;
var mainGridUrl = baseUrl+ "com.hsapi.cloud.part.invoicing.allotsettle.queryPjAllotApplyMains.biz.ext";
var detailGridUrl = baseUrl+ "com.hsapi.cloud.part.invoicing.allotsettle.getAllotApplyDetail.biz.ext";

var sOrderDateEl = null;
var eOrderDateEl = null;
var pickManHash={};
var AuditSignHash = {
  "0":"草稿",
  "1":"待受理",
  "2":"部分受理",
  "3":"全部受理",
  "4":"已拒绝"
};
$(document).ready(function(v) {

	queryInfoForm = new nui.Form("#queryInfoForm").getData(false, false);

	mainGrid = nui.get("mainGrid");
	detailGrid = nui.get("detailGrid");
	mainGrid.setUrl(mainGridUrl);
	detailGrid.setUrl(detailGridUrl);

	mainGrid.on("drawcell", onDrawCell);

	sOrderDateEl=nui.get("sOrderDate");
	eOrderDateEl=nui.get("eOrderDate");
	sOrderDateEl.setValue(getLastWeekStartDate());
	eOrderDateEl.setValue(addDate(getLastWeekEndDate(), 1));

	mainGrid.on("selectionchanged", function(e) {
		var row = mainGrid.getSelected();
		detailGrid.load({
			mainId: row.id,
			token: token
		});
	});

	mainGrid.on("drawcell", function(e) {
		switch (e.field) {
			case "status":
				if(AuditSignHash && AuditSignHash[e.value])
	            {
	                e.cellHtml = AuditSignHash[e.value];
	            }else {
	                e.cellHtml = "草稿";
	            }
	            break;
			default:
				break;
		}

	});

});

function getSearchParams() {
	var params = {};
	params.sOrderDate = sCreateDateEl.getText();
	params.eOrderDate = addDate(eCreateDateEl.getText(),1);
	params.isDiffOrder=0;
	params.isAllotFinished = 0;
	params.auditSign = 1;
	params.serviceId = nui.get('serviceId').getValue();
	params.guestId = nui.get('guestId').getValue();

	return params;
}
function onSearch() {
	var params = getSearchParams();

	doSearch(params);
}
function doSearch(params) {
	mainGrid.load({
		token : token,
		params : params
	});
}

var resultData = {};
function setInitData() {
	onSearch();

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
