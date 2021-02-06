var gridUrl = apiPath + saleApi + "/com.hsapi.sales.svr.base.searchCssFactoryRebate.biz.ext";
var gUrl = apiPath + saleApi + "/com.hsapi.sales.svr.base.searchCsbRebate.biz.ext?params/isDisabled=0&token=" + token;
var payUrl = apiPath + saleApi + "/com.hsapi.sales.svr.base.generateReceivable.biz.ext";
var grid = null;
var rebateId = null;
var startDateEl = null;
var endDateEl = null;
var form = null;
$(document).ready(function () {
    grid = nui.get("grid1");
    grid.setUrl(gridUrl);
    grid.load();
    rebateId = nui.get("rebateId");
    rebateId.setUrl(gUrl);
    startDateEl = nui.get("startDate");
    endDateEl = nui.get("endDate");
    form = new nui.Form("form1");

    grid.on("drawcell", function (e) {
        if (e.field == 'status') {
            e.cellHtml = (e.value == 0 ? '草稿' : '已提交');
        }
    })
})


function edit(e) {
    var tit = null;
    var row = null;
    if (e == 1) {
        tit = '新增';
    } else {
        tit = '修改';
        row = grid.getSelected(); 
        if (!row) {
            showMsg('请选择要修改的数据', 'W');
            return;
        }
        if (row.status == 1) {
            showMsg("该返利单已提交", "W");
            return;
        }
    }
    var item = {};
    item.id = '12993';
    item.text = '厂家返利编辑';
    item.url = webPath + contextPath + '/sales/base/sFactoryRebateDet.jsp';
    item.iconCls = "fa fa-file-text";
    window.parent.activeTabAndInit(item, row);
    // nui.open({
    //     url: webPath + contextPath + '/sales/base/sFactoryRebateDet.jsp',
    //     title: tit,
    //     width: '100%',
    //     height: '100%',
    //     onload: function () {
    //         var iframe = this.getIFrameEl();
    //         iframe.contentWindow.SetData(row);
    //     },
    //     ondestroy: function (action) {
    //         grid.reload();
    //     }
    // });
}

function search() {
    var data = form.getData(true);
    if (data.endDate) {
        data.endDate = data.endDate + " 23:59:59";
    }
    grid.load({
        params: data
    });
}


function quickSearch(type) {
    var params = {};
    var queryname = "本日";
    switch (type) {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate, -1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    if (params.endDate) {
        params.endDate = params.endDate + " 23:59:59";
    }
    grid.load({
        params: params
    });
}


function submit() {
    var row = grid.getSelected(); 
    if (!row) {
        showMsg("请选择一条数据", "W");
        return;
    }
    if (row.status == 1) {
        showMsg("请勿重复提交", "W");
        return;
    }
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '提交中...'
	});
    nui.ajax({
        url: payUrl,
        type: 'post',
        data: {
            data: row
        },
        success: function (res) {
            nui.unmask(document.body);
            if (res.errCode == 'S') {
                showMsg('提交成功', 'S');
            } else {
                showMsg('提交失败', 'E');
            }
        }
    });
}