<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-22 15:07:42
  - Description: 
-->

<head>
    <title></title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
        body {
            margin: 0; 
            padding: 0;
            border: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            font-family: "微软雅黑";
        }

        .textboxWidth {
            width: 100%;
        }

        .tbText {
            text-align: right;
        }

        .td_title {
            padding-left: 15px;
        }
    </style>
</head>

<body>

    <div class="nui-fit" id="form1">
        <div class="nui-toolbar" style="padding:0px;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick=""><span
                                class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span
                                class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <table style="font-size: 9pt; padding-left: 10px">
            <tr>
                <td class="td_title">车型编号：
                </td>
                <td>
                    <input id="AutotypeId_input" class="nui-textbox" type="text" style="width: 150px" value="自动编号"
                        disabled="disabled" />
                </td>
                <td class="td_title">拼音码：
                </td>
                <td>
                    <input id="AutotypeCode_input" class="nui-textbox" type="text" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">级别：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
                <td class="td_title">国别：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">车系：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
                <td class="td_title">年款：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">车型名称：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
                <td class="td_title">结构：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">排量：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
                <td class="td_title">座位数：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">进气形式：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
                <td class="td_title">能源：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">驱动方式：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
                <td class="td_title">续航里程：
                </td>
                <td>
                    <input id="" class="nui-textbox" style="width: 150px" enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="td_title">电动机：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" enabled="false"/>
                </td>
                <td class="td_title">充电时间：
                </td>
                <td >
                    <input id="" class="nui-textbox" style="width: 150px" enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="td_title">变速箱：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
                <td class="td_title">生产方式：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
            </tr>
            <tr>
                <td class="td_title">上市日期：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
                <td class="td_title">是否共享：
                </td>
                <td>
                    <input id="" class="nui-combobox" style="width: 150px" />
                </td>
            </tr>


            <tr>
                <td align="right">指导进价：
                </td>
                <td>
                    <input id="PurchasePrice_input" class="nui-textbox" type="text" style="width: 135px" />元
                </td>

                <td align="right">指导销价：
                </td>
                <td>
                    <input id="SailPrice_input" class="nui-textbox" type="text" style="width: 135px" />元
                </td>
            </tr>
            <tr>
                <td align="right">销售底价：
                </td>
                <td>
                    <input id="LimitPrice_input" class="nui-textbox" type="text" style="width: 135px" />元
                </td>
                <td align="right">购车订金：
                </td>
                <td>
                    <input id="MustDeposit_input" class="nui-textbox" type="text" style="width: 135px" />元
                </td>
            </tr>
            <tr>
                <td align="right">备注说明：
                </td>
                <td colspan="3">
                    <input id="Remark_input" class="nui-textarea" multiline="true" style="width: 100%; height: 65px;" />
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        nui.parse();





        function onCancel() {
            CloseWindow("cancel");
        }

        function CloseWindow(action) {
            if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
            else
                window.close();
        }
    </script>
</body>

</html>