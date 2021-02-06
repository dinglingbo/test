<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-23 15:07:01
  - Description:
-->
<head>
<title>新增、编辑班组</title>
<script	src="<%= request.getContextPath() %>/repair/js/DataBase/Team/addEditTeam.js?v=1.0.2"  type="text/javascript"></script>
<style type="text/css">
table {
	width: 100%;
}

table .title {
	width: 80px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div id="basicInfoForm" class="form">
    <input name="id" class="nui-hidden" />
    <table>
        <tr>
            <td class="title required">
                <label>维修工种：</label>
            </td>
            <td>
                <input name="type" id="type"
                       showNullItem="false"
                       allowInput="false"
                       class="nui-combobox"
                       textField="name"
                       style="width: 100%;"
                       alwaysView="true"
                       valueField="customid" />
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>班组类型：</label>
            </td>
            <td>
                <input name="code"  id="code"
                       showNullItem="false"
                       allowInput="false"
                       class="nui-combobox"
                       textField="name"
                       style="width: 100%;"
                       alwaysView="true"
                       popupMaxHeight="90"
                       valueField="customid" />
            </td>
        </tr>
        <tr>
            <td class="title required">
                <label>班组长名称：</label>
            </td>
            <td>
                <input class="nui-buttonedit" name="captainId" id="captainId" onclick="selectCaptain('captainId')" width="100%"/>
            </td>
        </tr>
    </table>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>
</body>
</html>