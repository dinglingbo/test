var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + saleApi + "/";
var form = null;

$(document).ready(function(v) {
    form = new nui.Form("#form1");
    initDicts({
        saleType: '10392', //购车方式
        signBillBankId: "DDT20140530000001" //贷款银行
    });
});

function SetData(serviceId, isSettle) {
    var url = null;
    var params = {};
    if (isSettle == 0) { //未结算
        url = baseUrl + "sales.search.searchSaleCalc.biz.ext";
        params.billType = 2;
        params.serviceId = serviceId;
    } else { //结算
        url = baseUrl + "sales.search.searchSalesMain.biz.ext";
        params.id = serviceId;
    }
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