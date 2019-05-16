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
    <title>销售退货 编辑</title>
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
    .textboxWidth{
        width: 100%;
    }
    .tbText{
        text-align: right;
    }
</style> 
</head>
<body>
   
    <div class="nui-fit" id="form1">
          <div class="nui-toolbar" style="padding:0px;">
           <table style="width:80%;">
               <tr>
                   <td style="width:80%;">
                       <a class="nui-button" iconCls="" plain="true" onclick=""><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                       <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                   </td>
               </tr>
           </table>
       </div>
       <table style="font-size: 9pt; padding-left: 10px">
            <tr>
                <td class="td_title">
                    单据编号：
                </td>
                <td>
                    <input id="txtDocumentId" class="nui-textbox" disabled value="自动编号" style="width: 120px" />
                </td>
                <td class="td_title">
                    单据日期：
                </td>
                <td>
                    <input id="txtDocumentDate" class="nui-datepicker" style="width: 120px" />
                </td>
                <td class="td_title">
                    经办人：
                </td>
                <td>
                    <input id="cmbDealMan" class="nui-combobox" style="width: 120px"   />
                </td>
            </tr>
            <tr>
                <td align="right">
                    销售单号：
                </td>
                <td colspan="3">
                    <input id="cmbSailId" class="nui-combobox" style="width: 295px" />
                </td>
                <td align="right">
                    客户名称：
                </td>
                <td>
                    <input id="txtCustName" class="nui-textbox" disabled style="width: 120px" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    联系人：
                </td>
                <td>
                    <input id="txtLinkMan" class="nui-textbox" disabled style="width: 120px" />
                </td>
                <td align="right">
                    手机号码：
                </td>
                <td>
                    <input id="txtMovePhone" class="nui-textbox" disabled style="width: 120px" />
                </td>
                <td align="right">
                    联系电话：
                </td>
                <td>
                    <input id="txtPhone" class="nui-textbox" disabled style="width: 120px" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    车型编号：
                </td>
                <td>
                    <input id="txtAutoTypeId" class="nui-textbox" disabled style="width: 120px" />
                </td>
                <td align="right">
                    车型名称：
                </td>
                <td colspan="3">
                    <input id="txtAutoTypeName" class="nui-textbox" disabled style="width: 305px" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    付款方式：
                </td>
                <td>
                    <input id="cmbPayWay" class="nui-combobox" style="width: 120px" />
                </td>
                <td align="right">
                    票据类型：
                </td>
                <td>
                    <select id="cmbBillSort" class="nui-combobox" style="width: 120px" >
                        <option value=""></option>
                        <option value="普通发票">普通发票</option>
                        <option value="增值税发票">增值税发票</option>
                    </select>
                </td>
                <td align="right">
                    发票号码：
                </td>
                <td>
                    <input id="txtBillNum" class="nui-textbox" style="width: 120px" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    应收金额：
                </td>
                <td>
                    <input id="txtTotalMoney"  min="0" disabled class="nui-textbox" style="width: 93px;" value="0" />元
                </td>
                <td align="right">
                    已收金额：
                </td>
                <td>
                    <input id="txtCollectMoney" min="0" disabled class="nui-textbox" style="width: 93px;" value="0" />元
                </td>
                <td align="right">
                    退款金额：
                </td>
                <td>
                    <input id="txtReturnMoney" numbertype="Money" min="0" disabled class="nui-textbox" style="width: 93px;" value="0" />元
                </td>
            </tr>
            <tr>
                <td align="right">
                    退货原因：
                </td>
                <td colspan="5">
                    <input id="txtReason" class="nui-textarea" style="width: 486px; height: 50px;"
                        multiline="true" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    备注：
                </td>
                <td colspan="5">
                    <input id="txtRemark" class="nui-textarea" style="width: 486px; height: 50px;"
                        multiline="true" />
                </td>
            </tr>
        </table>
</div>
<script type="text/javascript">
    nui.parse();
   




function onCancel() {
    CloseWindow("cancel");
}

function CloseWindow(action){
    if (window.CloseOwnerWindow) 
        return window.CloseOwnerWindow(action);
    else 
        window.close();
}

</script>
</body>
</html>