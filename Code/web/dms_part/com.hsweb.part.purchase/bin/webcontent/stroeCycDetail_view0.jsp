<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-07 14:50:32
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/stockMgr/storeCycDetail.js?v=1.0.2"></script>
<style type="text/css">
table {
	width: 100%;
}

table .title {
	width: 60px;
	text-align: right;
}
</style>
</head>
<body>
<div id="basicInfoForm" class="form">
    <input class="nui-hidden" name="id"/>
    <label style="font-family:Verdana;">零件信息</label>
    <table>
        <tbody>
            <tr>
                <td class="title">
                    <label style="font-family:Verdana;">零件编码：</label>
                </td>
                <td colspan="1">
                    <input class="nui-textbox" name="partCode" enabled="false" width="100%"/>
                </td>
                <td class="title">
                    <label style="font-family:Verdana;">零件名称：</label>
                </td>
                <td colspan="1">
                    <input class="nui-textbox" name="partName" enabled="false" width="100%"/>
                </td>
            </tr>
        </tbody>
    </table>
    <label style="font-family:Verdana;">销量及仓位设置</label>
    <table>
        <tbody>
            <tr>
                <td class="title">
                    <label style="font-family:Verdana;">仓库：</label>
                </td>
                <td colspan="1">
                    <input id="storeId"
                           name="storeId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           width="100%"
                           nullItemText="请选择..."/>
                </td>
                <td class="title">
                    <label style="font-family:Verdana;">仓位：</label>
                </td>
                <td colspan="1">
                    <input class="nui-textbox" name="storeLocation" enabled="true" width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <label style="font-family:Verdana;">日销量：</label>
                </td>
                <td colspan="1">
                    <input class="nui-spinner" name="daySellValume" id="daySellValume" minValue="0" maxValue="9999999999" value="0" enabled="true" width="100%"/>
                </td>
                <td class="title">
                    <label style="font-family:Verdana;">月销量：</label>
                </td>
                <td colspan="1">
                    <input class="nui-spinner" name="monthSellValume" id="monthSellValume" minValue="0" maxValue="9999999999" value="0" enabled="true" width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <label style="font-family:Verdana;">入库单价：</label>
                </td>
                <td colspan="1">
                    <input class="nui-textbox" name="costPrice" enabled="true" width="100%"/>
                </td>
                <td class="title">
                    <label style="font-family:Verdana;">建议销价：</label>
                </td>
                <td colspan="1">
                    <input class="nui-textbox" name="suggestPrice" enabled="true" width="100%"/>
                </td>
            </tr>
        </tbody>
    </table>
    <label style="font-family:Verdana;">周期设置</label>
    <table>
        <tbody>
            <tr>
                <td class="title">
                    <label style="font-family:Verdana;">安全周期：</label>
                </td>
                <td colspan="1">
                    <input class="nui-spinner" name="safeCyc" id="safeCyc" minValue="0" maxValue="9999999999" value="0" enabled="true" width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <label style="font-family:Verdana;">订货周期：</label>
                </td>
                <td colspan="1">
                    <input class="nui-spinner" name="orderCyc" id="orderCyc" minValue="0" maxValue="9999999999" value="0" enabled="true" width="100%"/>
                </td>
                <td class="title">
                    <label style="font-family:Verdana;">到货周期：</label>
                </td>
                <td colspan="1">
                    <input class="nui-spinner" name="arriveCyc" id="arriveCyc" minValue="0" maxValue="9999999999" value="0" enabled="true" width="100%"/>
                </td>
            </tr>
        </tbody>
    </table>
    <label style="font-family:Verdana;">上下限设置</label>
    <table>
        <tbody>
            <tr>
                <td class="title">
                    <label style="font-family:Verdana;">上限：</label>
                </td>
                <td colspan="1">
                    <input class="nui-spinner" name="stockUpLimit" id="stockUpLimit" minValue="0" maxValue="9999999999" value="0" enabled="true" width="100%"/>
                </td>
                <td class="title">
                    <label style="font-family:Verdana;">下限：</label>
                </td>
                <td colspan="1">
                    <input class="nui-spinner" name="stockDownLimit" id="stockDownLimit" minValue="0" maxValue="9999999999" value="0" enabled="true" width="100%"/>
                </td>
            </tr>
        </tbody>
    </table>
</div>
<div>
    <div class="nui-panel" title="安全库存周期定义" style="width:100%;height:110px;"
         showToolbar="false" showCloseButton="false" showFooter="false">
        <!--body-->
        12个月均发生销售的商品流动性为：1&nbsp;&nbsp;&nbsp;&nbsp;9-11个月均发生销售的商品流动性为：2<br/>
        5-8个月均发生销售的商品流动性为：3&nbsp;&nbsp;&nbsp;&nbsp;1-4个月均发生销售的商品流动性为：4<br/>
        12个月内从未发生销售的商品流动性为：5
    </div>
    <div class="nui-panel" title="库存上下限计算公式" style="width:100%;height:90px;"
         showToolbar="false" showCloseButton="false" showFooter="false">
        <!--body-->
        库存上限=日平均销量X(订货周期+到货周期+安全库存周期)<br/>
        库存下限=日平均销量X(订货周期+安全库存周期)
    </div>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>

</body>
</html>
