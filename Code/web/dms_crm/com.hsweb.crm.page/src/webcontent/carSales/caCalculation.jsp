<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-09 14:41:57
  - Description:
-->

    <head>
        <title>购车计算</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <%@include file="/common/commonRepair.jsp"%>
    </head>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        
        .auto-style1 {
            height: 31px;
        }
        
        .td_title {
            width: 90px;
            text-align: right;
        }
        
        .style1 {
            width: 95px;
            text-align: right;
        }
        
        .style2 {
            width: 80px;
        }
        
        .style3 {
            width: 132px;
        }
        
        .style4 {
            width: 81px;
            text-align: right;
        }
        
        .style5 {
            width: 81px;
        }
        
        .textbox {
            height: 20px;
            margin: 0;
            padding: 0 2px;
            box-sizing: content-box;
        }
        
        .textbox .textbox-text {
            white-space: pre-wrap!important;
        }
    </style>

    <body>
        <table style="line-height: 18px; padding-top: 10px;width: 60%">
            <tr>
                <td colspan="8">请填写购车计算信息(按回车计算)</td>
            </tr>
            <tr>
                <td class="td_title">
                    购车方式：
                </td>
                <td>
                    <input id="cmbDbxm" style="width: 130px" class="nui-combobox">
                </td>
                <td class="td_title">
                    车型销价：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    预付款：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    外观：
                </td>
                <td>
                    <input id="cmbDbxm" style="width: 130px" class="nui-combobox">
                </td>
                <td class="td_title">
                    外饰：
                </td>
                <td>
                    <input id="cmbDbxm" style="width: 130px" class="nui-combobox">
                </td>
                <td class="td_title">
                    交车地点：
                </td>
                <td colspan="3">
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    贷款比例：
                </td>
                <td>
                    <input id="cmbDbxm" style="width: 130px" class="nui-combobox">
                </td>
                <td class="td_title">
                    贷款金额：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    贷款期数：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-combobox" />
                </td>
                <td class="td_title">
                    首付金额：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />

                </td>
            </tr>
            <tr>
                <td class="td_title">
                    贷款银行：
                </td>
                <td>
                    <input id="cmbDbxm" style="width: 130px" class="nui-combobox">
                </td>
                <td class="td_title">
                    贷款利率(%)：
                </td>
                <td>
                    <input id="cmbDbxm" style="width: 130px" class="nui-combobox">
                </td>
                <td class="td_title">
                    银行利息分摊：
                </td>
                <td>
                    <input id="cmbDbxm" style="width: 130px" class="nui-combobox">
                </td>
                <td class="td_title">
                    贷款利息：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />

                </td>
            </tr>
            <tr>
                <td class="td_title">
                    月供：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    按揭手续费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    合同保证金：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    续保押金：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />

                </td>
            </tr>
            <tr>
                <td class="td_title">
                    月供保证金：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    家访费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
            </tr>
            <tr>
                <td class="td_title">
                    保险费预算：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    购置税预算：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    GPS费用：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    上牌费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />

                </td>
            </tr>
            <tr>
                <td class="td_title">
                    精品加装：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    其他费用：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
            </tr>
            <tr>
                <td class="td_title">
                    费用合计：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    提车合计：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    购车预算合计：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    <a class="nui-button">开始计算</a>
                </td>
            </tr>
            <tr>
                <td align="right">备注：
                </td>
                <td colspan="7">
                    <input id="db_Remark" style="width: 100%;height:50px" class="nui-textarea" multiline="true" />
                </td>
            </tr>
            <tr>
                <td align="right">计算公式：
                </td>
                <td colspan="7">
                    <input id="calculate" style="width: 100%;height:100px" class="nui-textarea" multiline="true" />
                </td>
            </tr>
        </table>

        <script type="text/javascript">
            nui.parse();
            var calculate = "银行利息=贷款金额*贷款利率(%)" +
                "\r\n担保费=贷款金额*担保费率(%)" +
                "\r\n费用合计 = 按揭手续费 + 合同保证金 + 续保押金 + 风险保证金+ 家访费+ 保险费预算+ 购置税预算 + GPS费用   + 上牌费 + 其它费 + 不分摊银行利息" +
                "\r\n购车预算合计= 车辆销价+费用合计"
            nui.get("calculate").setValue(calculate);
            nui.get("calculate").disable();
        </script>
    </body>

    </html>