<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-15 14:45:11
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/commonRepair/js/empSelect.js?v=1.0.2"></script>
<style type="text/css">
</style>
</head>
<body>

<div class="nui-fit">
    <ul id="tree" class="nui-tree"
        style="width:100%;height:100%;"
        resultAsTree="true"
        dataField="treeNodes"
        onpreload="onPreTreeLoad"
        ondrawnode="onDrawTreeNode"
        onbeforeload="onBeforeTreeLoad"
        showTreeIcon="true"
        textField="nodeName"
        idField="nodeId"
        showCheckBox="true"
        showFolderCheckBox="false">
    </ul>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>


</body>
</html>
