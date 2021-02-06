/**
 * Created by Administrator on 2018/3/29.
 */


window._rootPartUrl = "http://127.0.0.1:8080/default/";
var baseUrl = window._rootPartUrl||"http://127.0.0.1:8080/default/";

var basicInfoForm = null;
function setData(data)
{
    basicInfoForm = new nui.Form("#basicInfoForm");

    var out = data.out;
    if(out.taxSign == 1)
    {
        out.trueUnitPrice = out.taxUnitPrice;
    }
    else{
        out.trueUnitPrice = out.noTaxUnitPrice;
    }
    out.sellUnitPrice = out.trueUnitPrice;
    out.outQty = 1;
    out.sellAmt = out.sellUnitPrice*out.outQty;
    out.sourceId = out.detailId;
    var pickManList = data.pickManList;
    nui.get("pickMan").setData(pickManList);
    basicInfoForm.setData(out);

    var outQty = nui.get("outQty");
    outQty.setMaxValue(out.outableQty);
    outQty.on("valuechanged",function()
    {
        updateAmt();
    });
    var sellUnitPriceEl = nui.get("sellUnitPrice");
    sellUnitPriceEl.on("valuechanged",function()
    {
        updateAmt();
    });
}
function updateAmt()
{
    var outQty = nui.get("outQty").getValue();
    var sellUnitPrice = nui.get("sellUnitPrice").getValue();
    var sellAmtEl = nui.get("sellAmt");
    var sellAmt = sellUnitPrice*outQty;
    sellAmtEl.setValue(sellAmt);
}
var requiredField = {
    outQty:"销售数量",
    sellUnitPrice:"销售单价",
    pickMan:"领料人"
};
var saveUrl = baseUrl+"com.hsapi.part.purchase.repair.repairOut.biz.ext";
function onOk()
{
    var out = basicInfoForm.getData();
    for(var key in requiredField)
    {
        if(!out[key] || out[key].toString().trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    out.pickType = "050203";
    out.recorder = currUserName;
    out.orgid = currOrgid;

    var qty = out.outQty;
    out.taxAmt = out.taxUnitPrice*qty;
    out.noTaxAmt = out.noTaxUnitPrice*qty;
    out.trueCost = out.trueUnitPrice*qty;

    out.taxAmt = out.taxAmt.toFixed(2);
    out.noTaxAmt = out.noTaxAmt.toFixed(2);
    out.trueCost = out.trueCost.toFixed(2);
    nui.mask({
        html:'保存中..'
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
                nui.alert("保存成功","提示",function(){
                    CloseWindow("ok");
                });
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
