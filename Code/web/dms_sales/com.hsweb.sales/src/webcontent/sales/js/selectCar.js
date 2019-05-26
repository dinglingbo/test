var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var gridUrl = baseUrl + "/sales.inventory.queryCheckEnter.biz.ext";
var grid = null;
$(document).ready(function(v) {
    grid = nui.get("grid");
    grid.setUrl(gridUrl);
    grid.load();
});

function getSelectedValue() {
    var data = grid.getSelected();
    return data;
}

function selectCar() {
    var data = grid.getSelected();
    data.billStatus = 1;
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