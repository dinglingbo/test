var form = null;
$(document).ready(function(v) {
    form = new nui.Form("#form1");
    var calculate = "银行利息=贷款金额*贷款利率(%)" +
        "\r\n担保费=贷款金额*担保费率(%)" +
        "\r\n费用合计 = 按揭手续费 + 合同保证金 + 续保押金 + 风险保证金+ 家访费+ 保险费预算+ 购置税预算 + GPS费用   + 上牌费 + 其它费 + 不分摊银行利息" +
        "\r\n购车预算合计= 车辆销价+费用合计"
    nui.get("calculate").setValue(calculate);
});

function getValue() {
    var data = form.getData();
    return data;
}

function SetDataMsg(rid) {
    var params = {
        rid: rid
    };
    nui.ajax({
        url: "com.hsapi.managementt.crud.submitStragetyPlan.biz.ext",
        type: "post",
        cache: false,
        data: {
            params: params
        },
        success: function(text) {
            if (text.errCode == "S") {
                var data = text.data;
                form.setData(data);
                nui.alert(text.errMsg, "温馨提示");
            } else {
                nui.alert(text.errMsg, "温馨提示");
            }
        }
    });
}