/**
 * Created by Administrator on 2018/1/24.
 */

var basicInfoForm = null;
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
}

function setData(data)
{
    init();
    console.log(data);
    data = data||{};
    var part = data.part;
    if(part)
    {
    	if(part.fullName)
        {
            part.partFullName = part.fullName;
        }
        basicInfoForm.setData(part);
    }
}
var resultData = {};
var callback = null;
function getData(){
    return resultData;
}

var requiredField = {
    enterQty:"数量",
    unitPrice:"单价"
};
function onOk()
{
    var data = basicInfoForm.getData();
    console.log(data);
    data.taxSign = 0;
    data.taxRate = ".07";
    var totalTaxRate = parseFloat(1+data.taxRate);
    data.taxUnitPrice = (totalTaxRate*data.noTaxUnitPrice).toFixed(2);//含税单价=税率*
    data.taxAmt = (data.taxUnitPrice*data.enterQty).toFixed(2);//含税总额
    data.noTaxAmt = (data.noTaxUnitPrice*data.enterQty).toFixed(2);//不含税总额
    data.taxRateAmt = (data.taxAmt-data.noTaxAmt).toFixed(2);//税额
    data.outableQty = data.enterQty;
    data.suggestPrice = 0;
    data.suggestAmt = 0;
    //return;
    for(var key in requiredField)
    {
        if(!data[key] || data[key].toString().trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    resultData.enterDetail = data;
    CloseWindow("ok");
}

function CloseWindow(action) {
    //if (action == "close" && form.isChanged()) {
    //    if (confirm("数据被修改了，是否先保存？")) {
    //        return false;
    //    }
    //}
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
