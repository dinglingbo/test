var gridUrl = apiPath + saleApi + "/sales.base.searchCssFactoryRebate.biz.ext";

$(document).ready(function() {
    


})


function edit(e) {
    var tit = null;
    if (e == 1) {
        tit = '新增';
    } else {
        tit = '修改';
    }
    nui.open({
        url: webPath + contextPath + '/sales/base/sFactoryRebateDet.jsp',
        title: tit,
        width: '100%',
        height: '100%',
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
            visitHis.reload();
        }
    });
}