<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-07 15:34:05
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/stockMgr/setStoreLocationBatch.js?v=1.0.1"></script>
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
    <table>
        <tbody>
            <tr>
                <td class="title">
                    <label style="font-family:Verdana;">配件编码：</label>
                </td>
                <td colspan="3">
                    <input class="nui-textarea" name="partCodeList" enabled="true" width="100%" height="300"/>
                </td>
            </tr>
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
        </tbody>
    </table>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>



</body>
</html>
