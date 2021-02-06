<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-10 12:18:27
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/consumableItem/consumableItemOutDetail.js?v=1.0.11"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}
</style>
</head>
<body>

<div id="basicInfoForm" class="form">
    <input class="nui-hidden" name="partId"/>
    <input class="nui-hidden" name="partFullName"/>
    <input class="nui-hidden" name="partNameId"/>
    <input class="nui-hidden" name="unit"/>
    <input class="nui-hidden" name="storeId"/>
    <input class="nui-hidden" name="noTaxUnitPrice"/>
    <input class="nui-hidden" name="taxUnitPrice"/>
    <input class="nui-hidden" name="sourceId"/>
    <table style="width: 100%">
        <tr>
            <td class="title">
                <label>零件编码：</label>
            </td>
            <td>
                <input name="partCode" class="nui-textbox" enabled="false" width="100%"/>
            </td>
            <td class="title">
                <label>零件名称：</label>
            </td>
            <td>
                <input name="partName" class="nui-textbox" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>可出库数：</label>
            </td>
            <td>
                <input name="outableQty" class="nui-spinner"  minValue="1" maxValue="10000000" width="100%" value="1"/>
            </td>
            <td class="title">
                <label>成本价：</label>
            </td>
            <td>
                <input name="trueUnitPrice" class="nui-textbox" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>出库数量：</label>
            </td>
            <td>
                <input name="outQty" id="outQty" class="nui-spinner"  minValue="1" maxValue="10000000" width="100%" value="1"/>
            </td>
            <td class="title">
                <label>出库单价：</label>
            </td>
            <td>
                <input name="sellUnitPrice" id="sellUnitPrice" class="nui-textbox" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>领料人：</label>
            </td>
            <td>
                <input name="pickMan"
                       id="pickMan"
                       class="nui-combobox"
                       textField="empname"
                       valueField="empname"
                       emptyText="请选择..."
                       url=""
                       showNullItem="false"
                       width="100%"
                       popupMaxHeight="100"
                       showPopupOnClick="true"
                       allowInput="false"
                       nullItemText="请选择..."/>
            </td>
            <td class="title">
                <label>出库金额：</label>
            </td>
            <td>
                <input name="sellAmt" id="sellAmt" class="nui-textbox" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>车牌号：</label>
            </td>
            <td>
                <input name="carNo" class="nui-textbox" enabled="true" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>备注：</label>
            </td>
            <td colspan="3">
                <input name="remark" class="nui-textbox" enabled="true" width="100%"/>
            </td>
        </tr>
    </table>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">关闭</a>
</div>


</body>
</html>
