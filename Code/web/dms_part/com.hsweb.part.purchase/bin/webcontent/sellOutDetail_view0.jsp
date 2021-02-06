<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-03 17:10:57
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/sellMgr/sellOutDetail.js?v=1.0.9"></script>
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
    <table style="width: 100%">
        <tr>
            <td class="title">
                <label>配件编码</label>
            </td>
            <td>
                <input name="partCode" class="nui-textbox" enabled="false" width="100%"/>
            </td>
            <td class="title">
                <label>配件名称</label>
            </td>
            <td>
                <input name="partFullName" class="nui-textbox width1" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>品牌</label>
            </td>
            <td colspan="1">
                <input name="partBrandName" class="nui-textbox" enabled="false" width="100%"/>
            </td>
            <td class="title">
                <label>品牌车型</label>
            </td>
            <td colspan="1">
                <input name="applyCarModel" class="nui-textbox" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>单位</label>
            </td>
            <td colspan="1">
                <input name="unit" class="nui-textbox" enabled="false" width="100%"/>
            </td>
            <td class="title">
                <label>库存数</label>
            </td>
            <td colspan="1">
                <input name="outableQty" class="nui-textbox" enabled="false" width="100%" value="0"/>
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>数量</label>
            </td>
            <td>
                <input name="outQty"
                       id="outQty"
                       onvaluechanged="onUnitPriceChange"
                       class="nui-spinner"  minValue="1" maxValue="10000000" width="100%" value="1"/>
            </td>
            <td class="title required">
                <label>单价</label>
            </td>
            <td>
                <input name="sellUnitPrice"
                       id="sellUnitPrice"
                       class="nui-textbox width1"
                       enabled="true"
                       width="100%"
                       onvaluechanged="onUnitPriceChange"
                       value="1"/>
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>折扣率(%)</label>
            </td>
            <td>
                <input name="discountRate"
                       id="discountRate"
                       class="nui-spinner"
                       decimalPlaces="2"
                       format="n"
                       onvaluechanged="onUnitPriceChange"
                       minValue="0" maxValue="100"
                       width="100%" value="100"/>
            </td>
            <td class="title required">
                <label>折后单价</label>
            </td>
            <td>
                <input name="discountLastUnitPrice"
                       id="discountLastUnitPrice"
                       decimalPlaces="2"
                       format="¥#,0.00"
                       enabled="false"
                       class="nui-spinner"  minValue="0" width="100%" value="0"/>
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>折后</label>
            </td>
            <td>
                <input name="discountLastAmt" id="discountLastAmt"
                       decimalPlaces="2"
                       format="¥#,0.00"
                       onvaluechanged="onAmtChange"
                       class="nui-spinner"  minValue="0" width="100%" value="1"/>
            </td>
        </tr>
        <tr>
            <td class="title">
            </td>
            <td>
            </td>
            <td class="title">
                <span>小计</span>
            </td>
            <td>
                <span id="totalAmt">RMB</span>
            </td>
        </tr>
        <tr>
            <td class="title">
            </td>
            <td>
            </td>
            <td class="title">
                <span>折后</span>
            </td>
            <td>
                <span id="discountLastAmt1">RMB</span>
            </td>
        </tr>
        <tr>
            <td class="title">
            </td>
            <td>
            </td>
            <td class="title">
                <span>优惠</span>
            </td>
            <td>
                <span id="youhui">RMB</span>
            </td>
        </tr>
    </table>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>


</body>
</html>
