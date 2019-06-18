var gridUrl = apiPath + saleApi + "/sales.base.searchCssFactoryRebate.biz.ext";
var gUrl = apiPath + saleApi + "/sales.base.searchCsbRebate.biz.ext?params/isDisabled=0&token=" + token;
var payUrl = apiPath + saleApi + "/sales.base.generateReceivable.biz.ext";
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
    }
    nui.open({
        url: webPath + contextPath + '/sales/base/sFactoryRebateDet.jsp',
        title: tit,
        width: '100%',
        height: '100%',
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData(row);
        },
        ondestroy: function (action) {
            grid.reload();
        }
    });
}

function search() {
    var data = form.getData(true);
    data.endDate = data.endDate + " 23:59:59";
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
    params.endDate = params.endDate + " 23:59:59";
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
    nui.ajax({
        url: payUrl,
        type: 'post',
        data: {
            data: row
        },
        success: function (res) {
            if (res.errCode == 'S') {
                showMsg(showText, 'S');
            } else {
                showMsg('失败', 'E');
            }
        }
    });
}