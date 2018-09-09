<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/sysCommon.jsp"%>	

<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 19:45:52
  - Description:
-->

<head>
    <title>开票管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/cw/js/invoiceManagement/invoiceManagement.js" type="text/javascript"></script>
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
</style>

<body>
    <div class="nui-fit">
        <div style="height: 60px;">
            <table>
                <tr>
                    <td style="width:20%">
                        <input class="nui-textbox" style="width:50%" emptytext="请输入发票号/开票单号/源单号/客户姓名/手机号码/车牌号查询">
                        <input class="nui-combobox" style="width:20%" data="data" value="1">
                    </td>
                    <td style="width:20%">
                        <span>开票金额</span>
                        <span>666</span>&nbsp;
                        <span>税额</span>
                        <span>666</span>
                    </td>
                    <td style="width:20%">
                        <a class="nui-button" iconCls="icon-search" onclick="newBill()">新建</a>
                        <a class="nui-button" iconCls="icon-search" onclick="">导出到XLS</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="nui-fit">
            <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
                <div property="columns">
                    <div field="" name="" headeralign="center" align="center">开票单号</div>
                    <div field="" name="" headeralign="center" align="center">源单号</div>
                    <div field="" id="" name="" headeralign="center" align="center">客户姓名</div>
                    <div field="" id="" name="" headeralign="center" align="center">车牌号</div>
                    <div field="" id="" name="" headeralign="center" align="center">手机号</div>
                    <div field="" id="" name="" headeralign="center" align="center">发票类型</div>
                    <div field="" id="" name="" headeralign="center" align="center">税率</div>
                    <div field="" id="" name="" headeralign="center" align="center">开票金额</div>
                    <div field="" id="" name="" headeralign="center" align="center">税额</div>
                    <div field="" id="" name="" headeralign="center" align="center">发票号</div>
                    <div field="" id="" name="" headeralign="center" align="center">发票抬头</div>
                    <div field="" id="" name="" headeralign="center" align="center">开票日期</div>
                    <div field="" id="" name="" headeralign="center" align="center">源单日期</div>
                    <div field="" id="" name="" headeralign="center" align="center">开票人</div>
                    <div field="" id="" name="" headeralign="center" align="center">开票备注</div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var data = [{
            id: "1",
            text: "更多筛选"
        }];
        nui.parse();

        function newBill() {
            var item={};
            item.id = "TicketOpeningMgr";
            item.text = "开票单";
            item.url = webPath + contextPath + "/cw/invoice.jsp";
            item.iconCls = "fa fa-cog";
            window.parent.activeTab(item);
        }
    </script>
</body>

</html>