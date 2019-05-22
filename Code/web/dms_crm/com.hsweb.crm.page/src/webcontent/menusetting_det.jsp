<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 14:49:39
  - Description:
-->

<head>
    <title>menusetting_det</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style>
        html,
        body {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        .td_title {
            width: 20%;
            text-align: right;
        }

        .td_ctrl {
            width: 80%;
        }
    </style>
</head>

<body>
    <div class="nui-toolbar">
        <a class="nui-button" plain="true" onclick="" id="" plain="false"><span
                class="fa fa-save fa-lg"></span>&nbsp;保存</a>

    </div>

    <table style="font-size: 9pt; padding-left: 20px;padding-top:10px;line-height:30px;">
        <tr>
            <td class="td_title">
                所属栏目：
            </td>
            <td>
                <input id="txtDocumentId" class="nui-textbox"  style="width: 100%" />
            </td>
        </tr>
        <tr>
            <td class="td_title">
                栏目名称：
            </td>
            <td>
                <input id="txtDocumentDate" class="nui-textbox" style="width: 100%" />
            </td>
        </tr>
        <tr>
            <td class="td_title">
                栏目介绍：
            </td>
            <td>
                <input id="cmbDealMan" class="nui-textbox" style="width: 100%" />
            </td>
        </tr>
        <tr>
            <td class="td_title">
                栏目排序：
            </td>
            <td>
                <input id="cmbDealMan" class="nui-textbox" style="width: 100%" />
            </td>
        </tr>
        <tr>
            <td class="td_title">
                启用/禁用：
            </td>
            <td>
                <input class="nui-combobox" style="width:100%;"  style="width: 120px" 
                data="[{id:'0',text:'启用'},{id:'1',text:'禁用'}]"
                valueField="id" textField="text"/> 
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        nui.parse();


    </script>
</body>

</html>