/**
 * Created by Administrator on 2018/4/27.
 */
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var grid = null;
var gridUrl = baseUrl + "com.hsapi.repair.repairService.report.queryCarSellAfterList.biz.ext";
var filedHash = ["quoteCount","noMtCount","repairCount","accidentCount","finishedCount","settleCount","settleAmt","firstGuestCount","bigAccidentCount","bigAccidentAmt","bigVerhaulCount","bigVerhaulAmt","grossProfit"];
$(document).ready(function (v)
{
    grid = nui.get("grid");
    grid.setUrl(gridUrl);
    grid.on("load",function()
    {
        var list = grid.getData();
        var orgList = nui.get("orgId").getData();
        var newList = [];
        for(var i=0;i<orgList.length;i++)
        {
            var tmp = {
                orgid:orgList[i].orgid
            };
            list.forEach(function(v)
            {
                if(v.orgid == tmp.orgid)
                {
                    tmp[filedHash[v.type]] = v.value;
                }
            });
            if(tmp.settleAmt > 0 && tmp.grossProfit > 0)
            {
                tmp.grossProfitRate = tmp.grossProfit / tmp.settleAmt;
            }
            newList.push(tmp);
        }
        console.log(newList);
        grid.setData(newList);
    });
    grid.on("drawcell",onDrawCell);
    var hash = {};
    nui.mask({
        html: '数据加载中..'
    });
    var checkComplete = function () {
        var keyList = ['initComp'];
        for (var i = 0; i < keyList.length; i++) {
            if (!hash[keyList[i]]) {
                return;
            }
        }
        nui.unmask();
        quickSearch(currType);
    };
    initComp("orgId",function(){
        hash.initComp = true;
        checkComplete();
    });
});
var searchByDateBtnTextHash = ["本日","昨日","本周","上周","本月","上月","本年","上年"];
var currType = 0;
function quickSearch(type) {
    var params = {};
    currType = type;

    var btn = nui.get("searchByDateBtn");
    if(btn)
    {
        var text = searchByDateBtnTextHash[type];
        btn.setText(text);
    }
    var dateObj = getDate(type);
    nui.get("startDate").setValue(dateObj.startDate);
    nui.get("endDate").setValue(dateObj.endDate);
    onSearch();
}
function getSearchParams()
{
    var params = {};
    params.startDate = nui.get("startDate").getFormValue();
    params.endDate = nui.get("endDate").getFormValue();
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params) {
    params.orgid = currOrgid;
    grid.load({
        token:token,
        params: params
    });
}