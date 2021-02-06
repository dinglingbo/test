<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-31 17:55:04
  - Description:
-->
<head>
<title>维修单审核</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/repairAudit.js?v=1.0.0"></script>
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

<div id="basicInfoForm">
    <input class="nui-hidden" name="id"/>
    <input class="nui-hidden" name="itemQuoteAmt"/>
    <input class="nui-hidden" name="partQuoteAmt"/>
    <table class="nui-form-table">
        <tr>
            <td class="form_label">
                <label>项目金额</label>
            </td>
            <td class="form_label">
                <input class="nui-textbox" name="itemAmt" enabled="false"/>
            </td>
            <td class="form_label">
                <label>配件金额</label>
            </td>
            <td class="form_label">
                <input class="nui-textbox" name="partAmt" enabled="false"/>
            </td>
            <td class="form_label">
                <label>套餐金额</label>
            </td>
            <td class="form_label">
                <input class="nui-textbox" name="packageAmt" enabled="false"/>
            </td>
            <td class="form_label">
                <label>合计金额</label>
            </td>
            <td class="form_label">
                <input class="nui-textbox" name="amt" enabled="false"/>
            </td>
        </tr>
        <tr>
            <td class="form_label">
                <label id="drawOutReportTitle">出车报告：</label>
            </td>
        </tr>
        <tr>
            <td colspan="8">
                    <textarea class="nui-textarea" name="drawOutReport" id="drawOutReport"
                              style="width:100%;height:330px;"></textarea>
            </td>
        </tr>
    </table>
</div>
<div style="text-align:right;padding:10px;">
    <a class="mini-button" onclick="selectReport" id="selectReportBtn" style="margin-right:20px;">选择出车报告</a>
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">关闭</a>
</div>


</body>
</html>
