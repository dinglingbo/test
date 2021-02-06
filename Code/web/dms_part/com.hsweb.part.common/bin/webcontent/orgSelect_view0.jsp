<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-28 17:23:33
  - Description:
-->
<head>
<title>jsp auto create</title> 
<script src="<%=webPath + contextPath%>/commonPart/js/orgSelect.js?v=1.0.0"></script>
</head>
<body>
<div class="nui-fit">
    <ul id="tree1" class="nui-tree" url="" style="width:100%;height:100%;" dataField="orgList"
        resultAsTree="false"
        showTreeIcon="true" textField="orgname" idField="orgid" parentField="parentorgid" value="base" expandOnNodeClick="true">
    </ul>
</div>
<div style="text-align:center;padding:10px;">
    <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
    <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>
</div>



</body>
</html>
