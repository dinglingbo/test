<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>
    <!-- 
  - Author(s): Administrator
  - Date: 2019-05-06 09:34:06
  - Description:
-->

    <head>
        <title>编辑客户信息</title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
        <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
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
        
        .style1 {
            width: 55px;
        }
        
        .style2 {
            width: 55px;
        }
        
        .td_title {
            width: 65px;
            text-align: right;
        }
    </style>

    <body>
        <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
            <a class="nui-button  mini-button-info" plain="true" iconCls="" plain="false" onclick="close()" id="">取消</a>
        </div>
        <div class="nui-fit">
            <table style="width: 100%;height: 100%;">
                <tr>
                    <td style="text-align: right; width: 60px;">
                        客户编号
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="cust_id" class="nui-textbox" disabled style="width: 110px;" value="自动编号" />
                    </td>
                    <td style="text-align: right;" class="style1">
                        客户名称
                    </td>
                    <td colspan="3" style="text-align: left; width: 70px;">
                        <input id="cust_name" style="width: 290px;" class="nui-textbox" tipposition="left" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 60px;">
                        客户类别
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="txtcust_sort" style="width: 110px;" class="nui-combobox" />
                    </td>
                    <td style="text-align: right;" class="style1">
                        地区
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="txtcust_area" style="width: 110px;" class="nui-combobox" />
                    </td>
                    <td style="text-align: right;" class="style2">
                        客户性质
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <select id="cust_nature" name="cust_nature" class="nui-combobox" name="state" style="width: 110px;" editable="false">
                            <option value="个人客户">个人客户</option>
                            <option value="单位客户">单位客户</option>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 60px;">
                        联系人
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="linkman" style="width: 110px;" class="nui-textbox" />
                    </td>
                    <td style="text-align: right;" class="style1">
                        证件号码
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="idcard" style="width: 110px;" class="nui-textbox" />
                    </td>
                    <td style="text-align: right;" class="style2">
                        出生日期
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="birthday" class="nui-textbox" style="width: 110px;" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 70px;">
                        性别
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <select id="sex" name="sex" class="nui-combobox" name="state" style="width: 110px;" editable="false">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </td>
                    <td style="text-align: right;" class="style1">
                        联系电话
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="phone" class="nui-textbox" style="width: 110px;" />
                    </td>
                    <td style="text-align: right;" class="style2">
                        手机号码
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="movephone" class="nui-textbox" style="width: 110px;" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 70px;">
                        备用电话
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="backupphone" class="nui-textbox" style="width: 110px;" />
                    </td>
                    <td style="text-align: right;" class="style1">
                        传真号码
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="fax" class="nui-textbox" style="width: 110px;" />
                    </td>
                    <td style="text-align: right;" class="style2">
                        电子邮箱
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="email" class="nui-textbox" style="width: 110px;" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 70px;">
                        邮政编码
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="zipcode" class="nui-textbox" style="width: 110px;" />
                    </td>
                    <td style="text-align: right;" class="style1">
                        联系地址
                    </td>
                    <td style="text-align: left; width: 115px;" colspan="3">
                        <input id="address" class="nui-textbox" style="width: 290px;" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 70px;">
                        银行账户
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="bankid" class="nui-textbox" style="width: 110px;" />
                    </td>
                    <td style="text-align: right;" class="style1">
                        开户行
                    </td>
                    <td style="text-align: left; width: 115px;" colspan="3">
                        <input id="bankname" class="nui-textbox" style="width: 290px;" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 70px;">
                        税号
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="tax" class="nui-textbox" style="width: 110px;" />
                    </td>
                    <td style="text-align: right;" class="style1">
                        结算公式
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input class="nui-combobox" id="txtsettleformula" style="width: 110px;" />
                    </td>
                    <td style="text-align: right;" class="style2">
                        拼音码
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="cust_code" class="nui-textbox" style="width: 110px;" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 70px;">
                        允许欠款
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="low_days" class="nui-textbox" style="width: 70px;" min="0" />天以内
                    </td>
                    <td style="text-align: right;" class="style1">
                        允许欠款
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="low_money" class="nui-textbox" style="width: 70px;" min="0" />元以内
                    </td>
                    <td style="text-align: right;" class="style2">
                        开票名称
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="bill_name" class="nui-textbox" style="width: 110px;" />
                    </td>
                </tr>
                <tr>
                    <td style="text-align: right; width: 70px;">
                        开票电话
                    </td>
                    <td style="text-align: left; width: 115px;">
                        <input id="bill_phone" class="nui-textbox" style="width: 110px;" />
                    </td>
                    <td style="text-align: right;" class="style1">
                        开票地址
                    </td>
                    <td style="text-align: left; width: 115px;" colspan="3">
                        <input id="bill_address" class="nui-textbox" style="width: 290px;" />
                    </td>
                </tr>
            </table>
        </div>
        <script type="text/javascript">
            nui.parse();
        </script>
    </body>

    </html>