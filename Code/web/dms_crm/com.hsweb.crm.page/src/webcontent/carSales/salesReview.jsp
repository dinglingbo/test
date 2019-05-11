<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-09 17:30:27
  - Description:
-->

    <head>
        <title>销售结案审核</title>
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
        
        .td_title {
            width: 90px;
            text-align: right;
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
        <table style="line-height: 23px; padding-top: 10px;width: 100%" align="center">
            <tr>
                <td class="td_title">
                    购车方式：
                </td>
                <td>
                    <input id="cmbDbxm" style="width: 130px" class="nui-combobox">
                </td>
                <td class="td_title">
                    购车预算合计：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    已预收合计：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    未收余款：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    车辆销价：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    购买成本：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    运输费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    车辆毛利：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
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
                    实际保险费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    保险差额：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    保险毛利：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    购置税预算：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    实际购置税：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    购置税差额：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    差额合计：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    上牌费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    上牌成本：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    上牌毛利：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    GPS费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    GPS成本：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    GPS毛利：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    按揭手续费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    按揭成本：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    按揭毛利：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    加装费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    加装成本：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    加装毛利：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    家访费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    家访成本：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    家访毛利：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    其他收费：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    其他成本：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    其他毛利：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
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
                    利息分摊：
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
                    续保押金：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    风险保证金：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />

                </td>
                <td class="td_title">
                    合同保证金：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />

                </td>
            </tr>
            <tr>
                <td class="td_title">
                    购车总费用：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    销售收入：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    其销售提成：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    佣金：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    总成本：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    毛利调整：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    调整说明：
                </td>
                <td colspan="3">
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    总毛利：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    毛利率：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td class="td_title">
                    开票价格：
                </td>
                <td>
                    <input id="db_AgentitemId" style="width: 130px" class="nui-textbox" />
                </td>
                <td class="td_title">
                    发票抬头：
                </td>
                <td colspan="5">
                    <input id="db_AgentitemId" style="width: 100%" class="nui-textbox" />
                </td>
            </tr>
            <tr>
                <td align="right">备注：
                </td>
                <td colspan="7">
                    <input id="db_Remark" style="width: 100%;height:100px" class="nui-textarea" multiline="true" />
                </td>
            </tr>
        </table>
        <div class="nui-fit" style="float: right;width: 55%">
            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
            <a class="nui-button" iconCls="" plain="true" onclick="close()" id="addBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
        </div>
        <script type="text/javascript">
            nui.parse();

            function close() {
                window.CloseOwnerWindow('');
            }
        </script>
    </body>

    </html>