<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-31 18:01:40
  - Description:
-->
<head>
<title>车辆总检</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/WorkshopManagement/WorkshopDispatching/workInspection.js?v=1.0.0"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	
}

.required {
	color: red;
}
</style>
</head>
<body>

<div class="nui-panel" title="基本信息" style="width:calc(100% - 20px);height: 330px;margin: 10px;">
    <div id="basicInfoForm">
        <input class="nui-hidden" name="id"/>
        <table class="nui-form-table">
            <tr>
                <td class="form_label">
                    <label>是否有出车报告：</label>
                </td>
                <td>
                    <input class="nui-combobox" name="hasReport" value="1"
                           data="[{id:1,text:'有'},{id:0,text:'无'}]"
                           id="hasReport"/>
                </td>
                <td class="form_label required">
                    <label>总检员：</label>
                </td>
                <td>
                    <input class="nui-combobox" name="checker"
                           valueField="empname" textField="empname"
                           id="checker"/>
                </td>
                <td class="form_label" style="width:100px;">
                </td>
                <td class="form_label" style="width:100px;">
                </td>
            </tr>
            <tr>
                <td class="form_label required">
                    <label id="drawOutReportTitle">报告内容：</label>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <textarea class="nui-textarea" name="drawOutReport" id="drawOutReport"
                              style="width:100%;height: 230px;"></textarea>
                </td>
            </tr>
        </table>
    </div>
</div>
<div style="text-align:right;padding:10px;">
    <a class="mini-button" onclick="selectReport" id="selectReportBtn" style="margin-right:20px;">出车报告模板</a>
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">关闭</a>
</div>

</body>
</html>
