<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:35:46
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/purchase/js/purchaseInbound/inBoundCount.js?v=1.0.0"></script>
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
    <input class="nui-hidden" name="id"/>
    <table style="width: 100%">
        <tr>
            <td class="title">
                <label>配件编码</label>
            </td>
            <td>
                <input name="code" class="nui-textbox" enabled="false" width="100%"/>
            </td>
            <td class="title">
                <label>配件名称</label>
            </td>
            <td>
                <input name="name" class="nui-textbox width1" enabled="true" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>配件全称</label>
            </td>
            <td colspan="3">
                <input name="fullName" class="nui-textbox" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>单位</label>
            </td>
            <td colspan="1">
                <input name="fullName" class="nui-textbox" enabled="false" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>数量</label>
            </td>
            <td>
                <input name="count" class="nui-textbox" enabled="true" width="100%"/>
            </td>
            <td class="title required">
                <label>单价</label>
            </td>
            <td>
                <input name="acount" class="nui-textbox width1" enabled="true" width="100%"/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>库位</label>
            </td>
            <td>
                <input name="kuwei" class="nui-textbox" enabled="false" width="100%"/>
            </td>
            <td class="title">
                <label>入库分配</label>
            </td>
            <td>
                <input name="fenpei"
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
    </table>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>


</body>
</html>
