/**
 * Created by Administrator on 2018/3/30.
 */

var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";

$(document).ready(function (v)
{
    //setData({
    //    serviceId:1
    //});
});

var basicInfoForm = null;
function init()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setEnabled(false);
    var editableList = ["outTurnUpTaxAmt","outBillAllowance","allowanceAmt","billAmt","businessRemark","accruedExpensesRemark","accruedExpensesAmt"];
    var textobxList = ["businessRemark","accruedExpensesRemark"];
    var list = basicInfoForm.getFields();
    list.forEach(function(v)
    {
        if(v.setInputStyle)
        {
            v.setInputStyle("text-align:right;");
        }
        if(v.setFormat)
        {
            v.setFormat("¥#,0.00");
        }
        if(editableList.indexOf(v.name) > -1)
        {
            v.enable();
            v.setInputStyle("color:red");
            if(v.setFormat)
            {
                v.on("focus",function(e)
                {
                    var el = e.sender;
                    v.setInputStyle("text-align:left;");
                    v.setFormat("");
                });
                v.on("blur",function(e)
                {
                    var el = e.sender;
                    v.setInputStyle("text-align:right;");
                    v.setFormat("¥#,0.00");
                });
                if(v.name == "outTurnUpTaxAmt")
                {
                    v.on("valuechanged",function()
                    {
                        updateOutRebateAmt();
                        updateIncomeAmt();
                    });
                }
                else
                {
                    v.on("valuechanged",function()
                    {
                        calcSettlement();
                    });
                }
            }
        }
        if(textobxList.indexOf(v.name) > -1)
        {
            v.setInputStyle("text-align:left;");
        }
    });
}
function calcSettlement()
{
    var data = basicInfoForm.getData();
    var itemPrefAmt = data.itemPrefAmt;
    var partPrefAmt = data.partPrefAmt;
    var itemPrefRate = data.itemPrefRate;
    var itemSubtotal = data.itemSubtotal;
    var partSubtotal = data.partSubtotal;
    var materialExp = data.materialExp;
    var partManageExp = data.partManageExp;
    var otherExp = data.otherExp;
    var mtAmt = data.mtAmt;
    var allowanceAmt = data.allowanceAmt;
    var billAmt = data.billAmt;
    var cardAmt = data.cardAmt||0;
    var packageDiscountAmt = data.packageDiscountAmt;
    var packgePrefAmt = data.packgePrefAmt;
    var partManageExpRate = 0;
    var itemFreeAmt = data.itemFreeAmt;
    var partFreeAmt = data.partFreeAmt;
    //所有应收金额
    data.totalReceivableAmt = mtAmt + materialExp + partManageExp + otherExp;
    var totalReceivableAmt = data.totalReceivableAmt;
    //优惠金额
    data.totalPrefAmt = itemPrefAmt + partPrefAmt + packgePrefAmt;
    var totalPrefAmt = data.totalPrefAmt;
    if(totalReceivableAmt > 0)
    {
    	data.totalPrefRate  = totalPrefAmt / totalReceivableAmt;
    }
    //优惠+免费+折让
    data.freePrefAllowanceAmt = totalPrefAmt + allowanceAmt + itemFreeAmt + partFreeAmt;
    var freePrefAllowanceAmt = data.freePrefAllowanceAmt;
    //结算金额=应收金额 - (优惠+免费+折让)
    data.balaAmt = totalReceivableAmt - freePrefAllowanceAmt;
    var balaAmt = data.balaAmt;
    if(totalReceivableAmt != 0)
    {
        //整单优惠率 = 优惠+免费+折让 / 应收总金额
        data.totalPrefRate = freePrefAllowanceAmt / totalReceivableAmt;
    }

    if(maintain.outBillSign == 1)
    {
        var outBillBalaAmt = data.outBillBalaAmt;
        //出单小计=出单金额-出单折让
        var outTotalPrefAmt = data.outTotalPrefAmt;
        data.outBillBalaSubtoal = outBillBalaAmt - outTotalPrefAmt;
        var outBillBalaSubtoal = data.outBillBalaSubtoal;
        //开大金额=出单小计-结算金额
        data.outTurnUpAmt = outBillBalaSubtoal - balaAmt;
        var outTurnUpAmt = data.outTurnUpAmt;
        //开大税款
        data.outTurnUpTaxAmt = (billAmt - balaAmt) * 0.17;
        if(data.outTurnUpTaxAmt<0)
        {
            data.outTurnUpTaxAmt = 0;
        }
        var outTurnUpTaxAmt = data.outTurnUpTaxAmt;
        //客户返利
        data.outRebateAmt = outTurnUpAmt - outTurnUpTaxAmt;
        //应收金额=出单小计
        data.receivableAmt = outBillBalaSubtoal - cardAmt;
        //营业收入=结算金额+开大税款
        data.incomeAmt = balaAmt + outTurnUpTaxAmt;
    }
    else{
        //应收金额=结算金额
        data.receivableAmt = balaAmt - cardAmt;
        //营业收入=结算金额
        data.incomeAmt = balaAmt;
    }
    //计划税款
    data.planTaxAmt = billAmt * 0.1;
    //真实收入=结算金额-计划税款-预提费用
    var planTaxAmt = data.planTaxAmt;
    var accruedExpensesAmt = data.accruedExpensesAmt;
    data.incomeRealAmt = balaAmt - planTaxAmt - accruedExpensesAmt;
    basicInfoForm.setData(data);
}
//毛利
function updateGrossProfit()
{
    var data = basicInfoForm.getData();
    var incomeAmt = data.incomeAmt;
    var partTrueCost = data.partTrueCost;
    var elecDeduct = data.elecDeduct;
    var metalDeduct = data.metalDeduct;
    var paintDeduct = data.paintDeduct;
    var planTaxAmt = data.planTaxAmt;
    var accruedExpensesAmt = data.accruedExpensesAmt;
    var mpRpCost = data.mpRpCost;
    //毛利=营业收入-配件成本-维修及配件费用 - 工时提成（机电+钣金+喷漆）-【计划税款 暂时没减】-开大税款-预提费
    data.grossProfit = incomeAmt - partTrueCost - (elecDeduct+metalDeduct+paintDeduct) - accruedExpensesAmt - mpRpCost;
    //毛利率=毛利/真实收入
    if(incomeAmt>0)
    {
        data.grossProfitRate = (data.grossProfit * 100.0) / (incomeAmt * 100.0);
    }
    else{
        data.grossProfitRate = 0;
    }
    basicInfoForm.setData(data);
}
//更新/营业收入=结算金额+开大税款
function updateIncomeAmt()
{
    var data = basicInfoForm.getData();
    var balaAmt = data.balaAmt;
    var outTurnUpTaxAmt = data.outTurnUpTaxAmt;
    data.incomeAmt = balaAmt + outTurnUpTaxAmt;
    basicInfoForm.setData(data);
}
//更新返利
function updateOutRebateAmt()
{
    if(maintain.outBillSign == 1)
    {
        var data = basicInfoForm.getData();
        var outTurnUpAmt = data.outTurnUpAmt;
        var outTurnUpTaxAmt = data.outTurnUpTaxAmt;
        data.outRebateAmt = outTurnUpAmt - outTurnUpTaxAmt;
        if(data.outRebateAmt<0)
        {
            data.outRebateAmt = 0;
        }
        basicInfoForm.setData(data);
    }
}
var maintain = {};
var guest = {};
function setData(data)
{
    init();
    basicInfoForm.setData(data);
    nui.mask({
        html:'数据加载中...'
    });
    getSettlement(data.serviceId,function(data)
    {
        nui.unmask();
        data = data||{};
        if(data.errCode == "S")
        {
        	var settlement = data.settlement||{};
            maintain = data.maintain||{};
            guest = data.guest||{};
            for(var key in settlement)
            {
                if(typeof settlement[key] == "number")
                {
                    settlement[key] = settlement[key].toFixed(2);
                    settlement[key] = parseFloat(settlement[key]);
                }
            }
            basicInfoForm.setData(settlement);
        }
        else{
            nui.alert(data.errMsg||"获取结算单失败","提示",function(){

            });
        }
    });
}
function getSettlement(serviceId,callback)
{
    var url = baseUrl+"com.hsapi.repair.repairService.settlement.getSettlement.biz.ext";
    doPost({
        url:url,
        data:{
            serviceId:serviceId
        },
        success:function(data)
        {
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            callback && callback(null);
        }
    });
}
function onOk()
{
    calcSettlement();
    updateGrossProfit();
    var data = basicInfoForm.getData();
    var balaAmt = data.balaAmt;//结算金额
    var outBillBalaSubtoal = data.outBillBalaSubtoal;//出单小计
    var billAmt = data.billAmt;//发票金额
    var receivableAmt = data.receivableAmt;//应收金额
    var outRebateAmt = data.outRebateAmt; //维修返利
    var accruedExpensesAmt = data.accruedExpensesAmt;//预提费

    if(accruedExpensesAmt > 0)
    {
        var accruedExpensesRemark = data.accruedExpensesRemark;
        if(!accruedExpensesRemark)
        {
            nui.alert("请填写预提费用说明！");
            return;
        }
    }

    if(maintain.outBillSign == 1)
    {
        if(billAmt > outBillBalaSubtoal)
        {
            nui.alert("发票金额不能大于出单金额！");
            return;
        }
        if (billAmt - balaAmt > 0) {
            var min_out_turn_up_tax_amt = (billAmt - balaAmt) * 0.17;
            var out_turn_up_tax_amt = data.outTurnUpTaxAmt;
            if (out_turn_up_tax_amt < min_out_turn_up_tax_amt) {
                nui.alert("开大税款不能小于：【" + min_out_turn_up_tax_amt + "】");
                return;
            }
        }
    }
    else
    {
        if (billAmt > balaAmt) {
            nui.alert("发票金额不能大于应收金额！");
            return;
        }
    }
    nui.mask({
        html:'保存中...'
    });
    var url = baseUrl+"com.hsapi.repair.repairService.settlement.updateSettlement.biz.ext";
    doPost({
        url:url,
        data:{
            settlement:data
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
            	var transferBillBtn = nui.get("transferBillBtn");
                transferBillBtn.enable();
                nui.alert("保存成功","提示",function(){
                    //   CloseWindow("ok");
                });
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
function transferBill()
{
    var data = basicInfoForm.getData();
    var balaAmt = data.balaAmt;//结算金额
    var outBillBalaSubtoal = data.outBillBalaSubtoal;//出单小计
    var billAmt = data.billAmt;//发票金额
    var receivableAmt = data.receivableAmt;//应收金额
    var outRebateAmt = data.outRebateAmt; //维修返利
    var accruedExpensesAmt = data.accruedExpensesAmt;//预提费

    if(accruedExpensesAmt > 0)
    {
        var accruedExpensesRemark = data.accruedExpensesRemark;
        if(!accruedExpensesRemark)
        {
            nui.alert("请填写预提费用说明！");
            return;
        }
    }

    if(maintain.outBillSign == 1)
    {
        if(billAmt > outBillBalaSubtoal)
        {
            nui.alert("发票金额不能大于出单金额！");
            return;
        }
    }
    else
    {
        if (billAmt > balaAmt) {
            nui.alert("发票金额不能大于应收金额！");
            return;
        }
    }
    if (balaAmt < 0) {
        nui.alert("应收金额小于零，不能转单！");
        return;
    }
    var title = "工单号码：" + data.serviceId + "\n"
        + "应收金额：" + (receivableAmt ? receivableAmt : "0.00") + "\n"
        + "发票金额：" + (billAmt ? billAmt : "不开票") + "\n"
        + "请确认，是否转单？";
    nui.confirm(title,"",function(action)
    {
        if(action == "ok")
        {
            var serviceId = maintain.id;
            var guestId = maintain.guestId;
            var guestName = maintain.fullName;
            var carNo = maintain.carNo;
            if(maintain.status != 4)
            {
                nui.alert("工单号不在预结算状态，不允许转单，请打开工单号重试！");
                return;
            }
            doTransferBill();
        }
    });
}
function doTransferBill()
{
    var data = basicInfoForm.getData();
    var serviceId = maintain.id;
    var serviceCode = maintain.serviceCode;
    var guestId = maintain.guestId;
    var guestName = guest.fullName;
    var carNo = maintain.carNo;
    var amt = data.receivableAmt;
    var billAmt = data.billAmt;
    var outRebateAmt = data.outRebateAmt;
    var accruedExpensesAmt = data.accruedExpensesAmt;
    var params = {
        rpType:1,
        guestId:guestId,
        guestFullName:guestName,
        serviceId:serviceId,
        serviceCode:serviceCode,
        serviceTypeId:"02020103",
        rpAmt:amt,
        billAmt:billAmt,
        remark:carNo,
        isPrimaryBusiness:1,
        rpAmtYes:0,
        rpAmtNo:amt
    };
    spRpAccountPost(params,function()
    {
        if(outRebateAmt > 0)
        {
            var params1 = {
                rpType:-1,
                guestId:guestId,
                guestFullName:guestName,
                serviceId:serviceId,
                serviceCode:serviceCode,
                serviceTypeId:"02020216",
                rpAmt:outRebateAmt,
                billAmt:0,
                remark:carNo,
                isPrimaryBusiness:1,
                rpAmtYes:0,
                rpAmtNo:outRebateAmt
            };
            spRpAccountPost(params1,function()
            {
                if(accruedExpensesAmt)
                {
                    var params2 = {
                        rpType:-1,
                        guestId:guestId,
                        guestFullName:guestName,
                        serviceId:serviceId,
                        serviceCode:serviceCode,
                        serviceTypeId:"02020217",
                        rpAmt:accruedExpensesAmt,
                        billAmt:0,
                        remark:carNo,
                        isPrimaryBusiness:1,
                        rpAmtYes:0,
                        rpAmtNo:accruedExpensesAmt
                    };
                    spRpAccountPost(params2,function()
                    {
                        afterTransferBill(serviceId);
                    });
                }
                else{
                    afterTransferBill(serviceId);
                }
            });
        }
        else{
            afterTransferBill(serviceId);
        }
    });
}

function spRpAccountPost(params,callback)
{
    var url = window._rootFrmUrl+"com.hsapi.frm.arap.createArapService.biz.ext";
    doPost({
        url:url,
        data:{
            data:params
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                callback && callback();
            }
            else{
                console.log(data.errMsg);
                nui.alert("转单失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
function afterTransferBill(serviceId)
{
    var url = baseUrl+"com.hsapi.repair.repairService.settlement.afterTransferBill.biz.ext";
    doPost({
        url:url,
        data:{
            serviceId:serviceId
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("转单成功","提示",function()
                {
                    CloseWindow("ok");
                });
            }
            else{
                console.log(data.errMsg);
                nui.alert("转单失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
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
function setRate()
{
    var serviceId = maintain.id;
    nui.open({
        url: "com.hsweb.repair.DataBase.discountSetting.flow",
        allowResize:false,
        title: "优惠设置", width: 800, height: 600,
        onload: function () {
            var iframe = this.getIFrameEl();
            var params = {
                maintain:maintain
            };
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            setData({
                serviceId:serviceId
            });
        }
    });
}
