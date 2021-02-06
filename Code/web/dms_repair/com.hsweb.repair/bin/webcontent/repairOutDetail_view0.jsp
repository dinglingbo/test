<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-31 18:14:11
  - Description:
-->
<head>
<title>车间领料</title>
<script src="<%=request.getContextPath()%>/repair/js/repairOut/repairOutDetail.js?v=1.0.0"></script>
<style type="text/css">

.required {
	color: red;
}

.form_label {
	width: 60px;
	text-align: right;
}
</style>
</head>
<body>

<div id="basicInfoForm">
    <input class="nui-hidden" name="serviceId"/>
    <input class="nui-hidden" name="carId"/>
    <input class="nui-hidden" name="vin"/>
    <input class="nui-hidden" name="partId"/>
    <input class="nui-hidden" name="partFullName"/>
    <input class="nui-hidden" name="partNameId"/>
    <input class="nui-hidden" name="unit"/>
    <input class="nui-hidden" name="storeId"/>
    <input class="nui-hidden" name="noTaxUnitPrice"/>
    <input class="nui-hidden" name="taxUnitPrice"/>
    <input class="nui-hidden" name="sourceId"/>
    <div id="panel1" class="nui-panel" title="工单信息" iconCls="" style="width:100%;"
         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false"
         collapseOnTitleClick="false">
        <table class="nui-form-table" style="width: 100%">
            <tr>
                <td class="form_label">
                    <label>工单号：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="serviceCode" style="width: 100%"
                           enabled="false"/>
                </td>
                <td class="form_label">
                    <label>车牌号：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="carNo" style="width: 100%"
                           enabled="false"/>
                </td>
            </tr>
        </table>
    </div>
    <div id="panel2" class="nui-panel" title="零件录入" iconCls="" style="width:100%;margin-top: 10px;"
         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false"
         collapseOnTitleClick="false">
        <table class="nui-form-table" style="width: 100%">
            <tr>
                <td class="form_label">
                    <label>零件编码：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="partCode" style="width: 100%"
                           enabled="false"/>
                </td>
                <td class="form_label">
                    <label>零件名称：</label>
                </td>
                <td>
                    <input class="nui-textbox" name="partName" style="width: 100%"
                           enabled="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>可出库数：</label>
                </td>
                <td>
                    <input class="nui-Spinner" style="width: 100%"
                           minValue="0" maxValue="100000000"
                           name="outableQty" allowNull="false" enabled="false"
                           showButton="false"/>
                </td>
                <td class="form_label">
                    <label>成本价：</label>
                </td>
                <td>
                    <input class="nui-Spinner" style="width: 100%"
                           minValue="0" maxValue="100000000" format="¥#,0.00"
                           name="trueUnitPrice" allowNull="false" enabled="false"
                           showButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label required">
                    <label>销售数量：</label>
                </td>
                <td>
                    <input class="nui-Spinner" style="width: 100%"
                           minValue="1" maxValue="100000000" value="1" id="outQty"
                           name="outQty" allowNull="false" enabled="true"
                           showButton="true"/>
                </td>
                <td class="form_label required">
                    <label>销售单价：</label>
                </td>
                <td>
                    <input class="nui-Spinner" style="width: 100%" value="0"
                           minValue="0" maxValue="100000000" format="¥#,0.00"
                           name="sellUnitPrice" allowNull="false" enabled="true"
                           id="sellUnitPrice"
                           showButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label required">
                    <label>领料人：</label>
                </td>
                <td>
                    <input name="pickMan"
                           id="pickMan"
                           nullItemText="请选择..."
                           emptyText="请选择..."
                           showNullItem="false"
                           class="nui-combobox" style="width: 100%"
                           valueField="empName" textField="empName"/>
                </td>
                <td class="form_label">
                    <label>销售金额：</label>
                </td>
                <td>
                    <input class="nui-Spinner" style="width: 100%" value="0"
                           minValue="0" maxValue="100000000" format="¥#,0.00"
                           name="sellAmt" allowNull="false" enabled="false"
                           id="sellAmt"
                           showButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>备注：</label>
                </td>
                <td colspan="3">
                    <input class="nui-textbox" name="remark" style="width: 100%"
                           enabled="false"/>
                </td>
            </tr>
        </table>
    </div>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>


</body>
</html>
