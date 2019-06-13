var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var gridUrl = baseUrl + "/sales.inventory.queryCheckEnter.biz.ext";
var grid = null;
var frameColorData = null;
var interialColorData = null;
$(document).ready(function(v) {
    grid = nui.get("grid");
    grid.setUrl(gridUrl);

    initDicts({
        frameColorId: "DDT20130726000003", //车辆颜色
        interialColorId: "10391"
    });

    grid.on("drawcell", function(e) {
        var field = e.field;
        if (field == "frameColorId") {
            if (e.value) {
                frameColorData = nui.get("frameColorId").getData();
                e.cellHtml = frameColorData.find(frameColorData => frameColorData.customid == e.value).name;
            }
        }
        if (field == "interialColorId") {
            if (e.value) {
                interialColorData = nui.get("interialColorId").getData();
                e.cellHtml = interialColorData.find(interialColorData => interialColorData.customid == e.value).name;
            }
        }
        if (field == "carLock") {
            e.cellHtml = e.value == 0 ? "否" : "是";
        }
    });
});

function SetData(carModelId) {
    var params = { carModelId: carModelId, carLock: 0, billStatus: 1, carStatus: 0 };
    grid.load({ params: params });
}

function getSelectedValue() {
    var data = grid.getSelected();
    return data;
}

function selectCar() {
    var data = grid.getSelected();
    data.carStatus = 1;
    nui.ajax({
        url: baseUrl + "sales.save.updateCheckEnter.biz.ext",
        data: {
            data: data
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                showMsg(text.errMsg, "S");
                window.CloseOwnerWindow('ok');
            } else {
                showMsg(text.errMsg, "W");
            }
        }
    });
}

function close() {
    window.CloseOwnerWindow('');
}