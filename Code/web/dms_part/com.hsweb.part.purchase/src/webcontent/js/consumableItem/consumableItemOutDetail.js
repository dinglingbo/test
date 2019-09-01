/**
 * Created by Administrator on 2018/3/10.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;
$(document).ready(function(v)
{
    basicInfoForm = new nui.Form("#basicInfoForm");

    nui.mask({
        html:'数据加载中...'
    });
    initRoleMembers({
        pickMan:"010817"
    },function(){
        nui.unmask();
    });
});
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
var saveUrl = baseUrl + "com.hsapi.part.purchase.repair.repairOut.biz.ext";
function onOk()
{
	var out = basicInfoForm.getData();
    out.serviceId = 0;
    out.serviceCode = "耗材出库";
    out.orgid = currOrgid;
    out.recorder = currUserName;
    out.pickType = "050210";
    var qty = out.outQty;
    out.taxAmt = out.taxUnitPrice*qty;
    out.noTaxAmt = out.noTaxUnitPrice*qty;
    out.trueCost = out.trueUnitPrice*qty;

    out.taxAmt = out.taxAmt.toFixed(2);
    out.noTaxAmt = out.noTaxAmt.toFixed(2);
    out.trueCost = out.trueCost.toFixed(2);
    
    nui.mask({
        html:'出库中...'
    });
    doPost({
        url:saveUrl,
        data:{
            out:out
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("出库成功");
                CloseWindow("ok");
            }
            else{
                nui.alert(data.errMsg||"出库失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function setData(data)
{
	var part = data.part;
    if(part.taxSign == 1)
    {
        part.trueUnitPrice = part.taxUnitPrice;
    }
    else{
        part.trueUnitPrice = part.noTaxUnitPrice;
    }
    part.sellUnitPrice = part.trueUnitPrice;
    part.outQty = 1;
    part.sellAmt = part.sellUnitPrice*part.outQty;
    part.sourceId = part.detailId;
    basicInfoForm.setData(part);

    var outQty = nui.get("outQty");
    outQty.setMaxValue(part.outableQty);
    outQty.on("valuechanged",function()
    {
        var outQty = nui.get("outQty").getValue();
        var sellUnitPrice = nui.get("sellUnitPrice").getValue();
        var sellAmtEl = nui.get("sellAmt");
        var sellAmt = sellUnitPrice*outQty;
        sellAmtEl.setValue(sellAmt);
    });
}
