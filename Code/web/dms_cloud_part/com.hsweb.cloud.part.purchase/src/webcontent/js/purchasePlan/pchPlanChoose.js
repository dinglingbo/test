
/**
 * Created by Administrator on 2018/8/8.
 */
var baseUrl = apiPath + cloudPartApi + "/";
var mainGrid = null;
var detailGrid = null;
var queryInfoForm = null;
var mainGridUrl = baseUrl+ "com.hsapi.cloud.part.invoicing.pchsplan.queryPjPchsPlanMainList.biz.ext";
var detailGridUrl = baseUrl+ "com.hsapi.cloud.part.invoicing.pchsplan.getPjPchsPlanDetailById.biz.ext";

var sOrderDateEl = null;
var eOrderDateEl = null;
var pickManHash={};
var AuditSignHash = {
  "0":"未下订单",
  "1":"部分转订单",
  "2":"全部转订单"
};

$(document).ready(function(v) {

	mainGrid = nui.get("mainGrid");
	detailGrid = nui.get("detailGrid");
	mainGrid.setUrl(mainGridUrl);
	detailGrid.setUrl(detailGridUrl);
	
	sOrderDateEl=nui.get("sOrderDate");
	eOrderDateEl=nui.get("eOrderDate");
	sOrderDateEl.setValue(getLastWeekStartDate());
	eOrderDateEl.setValue(addDate(now, 1));

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
	params.sOrderDate = sOrderDateEl.getFormValue();
	params.eOrderDate = addDate(eOrderDateEl.getValue(),1);
	params.isDiffOrder=0;
	params.isFinished = 0;
	params.auditSign = 1;
	params.nstatus = 4;
	params.serviceId = nui.get('serviceId').getValue();
	params.guestId = nui.get('guestId').getValue();
	params.searchType = "applyEnter";

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

	sOrderDateEl=nui.get("sOrderDate");
	eOrderDateEl=nui.get("eOrderDate");
	sOrderDateEl.setValue(getLastWeekStartDate());
	eOrderDateEl.setValue(addDate(now, 1));

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

function getData() {
	return resultData;
}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
        title : "供应商资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1,
                guestType:'01020202',
                isInternal: 1
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
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

            }
        }
    });
}

function onOk() {
	var node = mainGrid.getSelected();
    if(node)
    {
        resultData = {
            apply:node
        };
        CloseWindow("ok");
    }
}