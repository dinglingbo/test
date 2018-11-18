<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:35:46
  - Description:
-->
<head>
<title>打包发货</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/common/packPopOperate.js?v=1.0.1"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	border: 0;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>

    <div id="basicInfoForm" class="form" contenteditable="false">
        <input class="nui-hidden" name="id"/>
        <input class="nui-hidden" name="operateDate"/>
        <input class="nui-hidden" name="auditSign"/>
        <input class="nui-textbox" id="serviceId" name="serviceId" width="100%" enabled="true" visible="false">
        <input name="billTypeId" visible="false"
                     id="billTypeId"
                     class="nui-combobox width1"
                     textField="name"
                     valueField="customid"
                     enabled="true"
                     valuefromselect="true"
                     allowInput="true"
                     selectOnFocus="true"
                     showNullItem="false"
                     width="100%"/>
        <table style="width: 100%;">
            <tr>
                <td class="title required">
                    <label>物流公司：</label>
                </td>
                <td colspan="">
                    <input id="logisticsGuestId"
                           name="logisticsGuestId"
                           class="nui-buttonedit"
                           allowInput="false"
                           emptyText="请选择物流公司..."
                           onbuttonclick="selectLogisticsSupplier('logisticsGuestId')"
                           width="100%"
                           placeholder="请选择物流公司"
                           selectOnFocus="true" />
                    <input class="nui-textbox" id="logisticsName" name="logisticsName" width="100%" visible="false">
                </td>
                <td class="title required">
                    <label>客户：</label>
                </td>
                <td colspan="">
                    <input id="guestId"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择客户..."
                           onvaluechanged="onGuestValueChanged"
                           onbuttonclick="selectSupplier('guestId')"
                           width="100%"
                           enabled="false"
                           placeholder="请选择客户"
                           selectOnFocus="true" />
                    <input class="nui-textbox" id="guestName" name="guestName" width="100%" visible="false">
                </td>
            </tr>
            <tr>
                <td class="title required">
                    <label>物流单号：</label>
                </td>
                <td colspan="">
                    <input class="nui-textbox" id="logisticsNo" name="logisticsNo" width="100%" enabled="true">
                </td>
                <td class="title required">
                    <label>收货人：</label>
                </td>
                <td colspan="">
                    <input class="nui-combobox" id="receiveMan" name="receiveMan" width="100%" textField="receiveMan"
                     valueField="receiveMan" valuefromselect="true"
                     onvaluechanged="onReceiveManChanged"
                     allowInput="true" selectOnFocus="true">
                </td>
            </tr>
            <tr>
                <td class="title">
                    <label>收货单位：</label>
                </td>
                <td colspan="">
                    <input class="nui-textbox" id="receiveCompName" name="receiveCompName" width="100%" enabled="false">
                    <input class="nui-textbox" id="provinceId" name="provinceId" width="100%" visible="false">
                    <input class="nui-textbox" id="cityId" name="cityId" width="100%" visible="false">
                    <input class="nui-textbox" id="countyId" name="countyId" width="100%" visible="false">
                    <input class="nui-textbox" id="streetAddress" name="streetAddress" width="100%" visible="false">
                </td>
                <td class="title">
                    <label>联系方式：</label>
                </td>
                <td colspan="1">
                    <input class="nui-textbox" id="receiveManTel" name="receiveManTel" width="100%" enabled="false">
                </td>
            </tr>
            <tr>
                <td class="title">
                    <label>收货地址：</label>
                </td>
                <td colspan="3">
                    <input class="nui-textbox" id="address" name="address" width="100%" enabled="false">
                </td>
            </tr>
            <tr>
                <td class="title required">
                    <label>发货员：</label>
                </td>
                <td colspan="">
                    <input class="nui-textbox" id="packMan" name="packMan" width="100%">
                </td>
                <td class="title required">
                    <label>发货日期：</label>
                </td>
                <td width="120">
                    <input name="createDate"
                           id="createDate"
                           width="100%"
                           enabled="false"
                           showTime="true"
                           class="nui-datepicker" enabled="false" format="yyyy-MM-dd HH:mm"/>
                </td>
            </tr>
            <tr>
                <td class="title required">
                    <label>结算方式：</label>
                </td>
                <td colspan="1">
                    <input name="settleTypeId" 
                     id="settleTypeId"
                     class="nui-combobox width1"
                     textField="name"
                     valueField="customid"
                     enabled="true"
                     valuefromselect="true"
                     allowInput="true"
                     selectOnFocus="true"
                     showNullItem="false"
                     width="100%"/>
                </td>
                <td class="title required">
                    <label>总包数：</label>
                </td>
                <td colspan="">
                    <input class="nui-textbox" id="packItem" name="packItem" width="100%" vtype="float" selectOnFocus="true">
                </td>
            </tr>
            <tr>
                <td class="title required">
                    <label>运费：</label>
                </td>
                <td colspan="">
                    <input class="nui-textbox" id="truePayAmt" name="truePayAmt" width="100%" vtype="float" enabled="true">
                </td>
                <td class="title">
                    <label>备注：</label>
                </td>
                <td colspan="">
                    <input class="nui-textbox" id="remark" name="remark" width="100%" enabled="true">
                </td>
            </tr>
        </table>
    </div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" id="cancelBtn" onclick="onCancel" style="width:60px;"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>&nbsp;&nbsp;
    <a class="mini-button" id="chooseBtn" onclick="onOk" style="width:60px;margin-right:20px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
    
    
</div>


</body>
</html>
