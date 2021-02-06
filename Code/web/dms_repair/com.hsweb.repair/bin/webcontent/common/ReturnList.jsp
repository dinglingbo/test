<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-07 10:23:36
  - Description:
-->
<head>
<title>返单</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/returnList.js?v=1.0.0"></script>
<style type="text/css">
table {
	font-size: 12px;
}

.form_label {
	width: 60px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<table style="width: 100%;">
    <tr>
        <td class="form_label">
            <label>当前进程：</label>
        </td>
        <td>
            <input id="oldStatus" class="nui-combobox"
                   enabled="false"
                   data="[{id:3,text:'完工总检'},{id:4,text:'预结算'}]"
                   style="width: 100%;"/>
        </td>
    </tr>
    <tr>
        <td class="form_label">
            <label>返入进程：</label>
        </td>
        <td>
            <input id="newStatus" class="nui-combobox" data="[{id:2,text:'在维修'},{id:3,text:'完工总检'},{id:4,text:'预结算'}]"  style="width: 100%;"/>
        </td>
    </tr>
</table>
<div style="text-align:right;padding:10px;">
    <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="nui-button" onclick="onCancel" style="width:60px;">关闭</a>
</div>
</body>
</html>