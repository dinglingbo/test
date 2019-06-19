var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var gridUrl = baseUrl + "/sales.inventory.queryCheckEnter.biz.ext";
var grid = null;
var frameColorData = null;
var interialColorData = null;
var isUpdate = null;//选完之后是否 锁定该车 不传 默认更新  传1 不更新
$(document).ready(function(v) {
    grid = nui.get("grid");
    grid.setUrl(gridUrl);

    initDicts({
        frameColorId: "DDT20130726000003", //车辆颜色
        interialColorId: "10391"
    });

    grid.on('rowdblclick', function (e) {
        window.CloseOwnerWindow('ok');
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


function SetData(data, isUpdateParam) {
    isUpdate = isUpdateParam;
    var params = {
        carModelId: data.carModelId||'',
        carModelName: nui.get("carModelName").value,
        carLock: data.carLock||'',
        carStatus: data.carStatus || '',
        billStatus: data.billStatus || ''
    };
    grid.load({ params: params });
}

function getSelectedValue() {
    var data = grid.getSelected();
    return data;
}

function selectCar() {
    var data = grid.getSelected();

    if (!data) {
        showMsg('请先选择一条数据', 'W');
        return;
    }
    if (isUpdate == 1) {
        window.CloseOwnerWindow('ok');
    } else {
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
}

function close() {
    window.CloseOwnerWindow('');
}