<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-03 11:24:15
  - Description:
-->
<head>
<title>未修归档</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/subpage/NotRepair.js?v=1.0.0"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 84px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div id="basicInfoForm">
    <input class="nui-hidden" name="id"/>
    <table width="100%">
        <tr>
            <td class="form_label required">
                <label>未修原因类别：</label>
            </td>
            <td>
                <input class="nui-combobox" id="noMtType" name="noMtType" style="width:100%;"
                       popupMaxHeight="150"
                       textField="name" valueField="customid"/>
            </td>
        </tr>
        <tr>
            <td class="form_label required">
                <label>未修原因说明：</label>
            </td>
            <td>
                <textarea class="nui-textArea" name="noMtReason" style="width:100%;height:120px;"></textarea>
            </td>
        </tr>
    </table>
</div>
<div style="text-align:right;padding:10px;margin-top:0">
    <a class="nui-button" onclick="onOk">保存</a>
    <a class="nui-button" onclick="onCancel">关闭</a>
</div>
</body>
</html>