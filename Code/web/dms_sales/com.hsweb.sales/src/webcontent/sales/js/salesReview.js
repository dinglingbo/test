var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var form = null;
var url = baseUrl + "sales.search.searchSalesMain.biz.ext";
$(document).ready(function(v) {
    form = new nui.Form("#form1");
    initDicts({
        saleType: '10392', //购车方式
        signBillBankId: "DDT20140530000001" //贷款银行
    });
});

function SetData(id) {
    var params = { id: id };
    nui.ajax({
        url: url,
        data: {
            params: params
        },
        cache: false,
        async: false,
        success: function(text) {
            if (text.errCode == "S") {
                var data = text.data[0];
                form.setData(data);
            };
        }
    });
}