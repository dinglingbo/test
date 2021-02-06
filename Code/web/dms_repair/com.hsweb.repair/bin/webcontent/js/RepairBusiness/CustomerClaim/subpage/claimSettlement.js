/**
 * Created by Administrator on 2018/4/18.
 */



var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;
var agioAmtEl = null;
var otherAmtEl = null;
var itemAmtEl = null;
var partAmtEl = null;
var balanceAmtEl = null;
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    balanceAmtEl = nui.get("balanceAmt");
    itemAmtEl = nui.get("itemAmt");
    partAmtEl = nui.get("partAmt");
    agioAmtEl = nui.get("agioAmt");
    agioAmtEl.on("valuechanged",function(){
        calculateBalanceAmt();
    });
    otherAmtEl = nui.get("otherAmt");
    otherAmtEl.on("valuechanged",function(){
        calculateBalanceAmt();
    });
}
function calculateBalanceAmt()
{
    var agioAmt = agioAmtEl.getValue()||0;
    var otherAmt = otherAmtEl.getValue()||0;
    var itemAmt = itemAmtEl.getValue()||0;
    var partAmt = partAmtEl.getValue()||0;
    var balanceAmt = agioAmt + otherAmt + itemAmt + partAmt;
    balanceAmtEl.setValue(balanceAmt);
}

function setData(data)
{
    init();
    data = data||{};
    var claimsId = data.claimsId;
    if(claimsId)
    {
        getClaimsMainById(claimsId);
    }
}
function getClaimsMainById(claimsId)
{
    nui.mask({
        html: '数据加载中..'
    });
    var Url = baseUrl + "com.hsapi.repair.repairService.claims.getClaimsMainById.biz.ext";
    doPost({
        url: Url,
        data: {
            params:{
                orgid:currOrgid,
                claimsId:claimsId
            }
        },
        success: function (data)
        {
            nui.unmask();
            data = data||{};
            var main = data.claimsMain||{};
            if(main.id)
            {
                basicInfoForm.setData(main);
                agioAmtEl.doValueChanged();
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}
var resultData = {};
function getData()
{
    return resultData;
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
function onOk()
{
    var data = basicInfoForm.getData();
    resultData.claimMain = data;
    CloseWindow("ok");
}