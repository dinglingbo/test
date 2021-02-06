<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-10 17:36:49
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/consumableItem/consumableItemReturn.js?v=1.0.0"></script>
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
    <input class="nui-hidden" name="id"/>
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
            <td class="title required">
                <label>归库原因：</label>
            </td>
            <td colspan="3">
                <input name="returnId"
                       id="returnId"
                       class="nui-combobox"
                       textField="name"
                       valueField="customid"
                       emptyText="请选择..."
                       url=""
                       showNullItem="false"
                       width="100%"
                       popupMaxHeight="100"
                       showPopupOnClick="true"
                       allowInput="false"
                       nullItemText="请选择..."/>
            </td>
        </tr>
        <tr>
            <td class="title">
                <label>归库说明：</label>
            </td>
            <td colspan="3">
                <textarea name="remark" class="nui-textarea" enabled="true" width="100%" height="150"></textarea>
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
