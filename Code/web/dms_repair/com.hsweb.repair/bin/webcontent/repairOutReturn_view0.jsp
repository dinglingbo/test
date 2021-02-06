<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-31 18:12:15
  - Description:
-->
<head>
<title>领料退回</title>
<script src="<%=request.getContextPath()%>/repair/js/repairOut/repairOutReturn.js?v=1.0.0"></script>
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
    <div id="panel1" class="nui-panel" title="材料信息" iconCls="" style="width:100%;"
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
        </table>
    </div>
    <div id="panel2" class="nui-panel" title="零件录入" iconCls="" style="width:100%;margin-top: 10px;"
         showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false"
         collapseOnTitleClick="false">
        <table style="width: 100%">
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

</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">关闭</a>
</div>


</body>
</html>
