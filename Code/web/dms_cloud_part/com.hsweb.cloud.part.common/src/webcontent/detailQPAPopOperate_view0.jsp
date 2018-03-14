<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%-- <%@include file="/common/common.jsp"%> --%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:35:46
  - Description:
-->
<head>
<title>jsp auto create</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/js/detailQPAPopOperate.js?v=1.0.0"></script>
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

<div id="basicInfoForm" class="form">
    <input class="nui-hidden" name="detailId"/>
    <input class="nui-hidden" name="id"/>
    <input class="nui-hidden" name="oemCode"/>
    <input class="nui-hidden" name="partBrandId"/>
    <input class="nui-hidden" name="applyCarModel"/>
    <input class="nui-hidden" name="unit"/>
    <input class="nui-hidden" name="oemCode"/>
    <input class="nui-hidden" name="spec"/>
    <input class="nui-hidden" name="rootId"/>
    <input class="nui-hidden" name="sourceId"/>
    <input class="nui-hidden" name="taxSign"/>
    <input class="nui-hidden" name="taxRate"/>
    <input class="nui-hidden" name="taxPrice"/>
    <input class="nui-hidden" name="noTaxPrice"/>
    <input class="nui-hidden" name="enterPrice"/>
    <input class="nui-hidden" name="sellPrice"/>
    <input class="nui-hidden" name="enterDate"/>
    <table style="width: 100%" id="list_table">
        <tr>
            <td class="title">
                <label>配件编码：</label>
            </td>
            <td>
                <input name="code" class="nui-textbox" enabled="false" width="100%"/>
            </td>
            <td class="title">
                <label>配件名称：</label>
            </td>
            <td>
                <input name="name" class="nui-textbox width1" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>配件全称：</label>
            </td>
            <td colspan="3">
                <input name="fullName" class="nui-textbox" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>单位：</label>
            </td>
            <td colspan="1">
                <input name="unit" class="nui-textbox" enabled="false" width="100%" value="0"/>
            </td>
            <td class="title required">
                <label>仓库：</label>
            </td>
            <td>
                <input id="storeId"
                       name="storeId"
                       class="nui-combobox"
                       textField="name"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       allowInput="true"
                       showNullItem="true"
                       width="100%"
                       nullItemText="请选择..."/>
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>数量：</label>
            </td>
            <td>
                <input id="qty" name="qty" class="nui-textbox" onvaluechanged="calc('qty')" vtype="float" selectOnFocus="true" width="100%" value="1"/>
            </td>
            <td class="title required">
                <label>单价：</label>
            </td>
            <td>
                <input id="price" name="price" class="nui-textbox width1" onvaluechanged="calc('price')" vtype="float" selectOnFocus="true" enabled="true" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>金额：</label>
            </td>
            <td>
                <input id="amt" name="amt" class="nui-textbox" onvaluechanged="calc('amt')" vtype="float" selectOnFocus="true" enabled="true" width="100%"/>
            </td>
            <td class="title">
                <label>备注：</label>
            </td>
            <td>
                <input id="remark" name="remark" class="nui-textbox" selectOnFocus="true" enabled="true" width="100%"/>
            </td>
        </tr>
    </table>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" id="chooseBtn" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" id="cancelBtn" onclick="onCancel" style="width:60px;">取消</a>
</div>


</body>
</html>
