<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>

<head>
    <title>车型级别</title>
    <%@include file="/common/sysCommon.jsp"%>
    <script src="<%= request.getContextPath() %>/repair/js/potentialCustomer/visitMode.js?v=1.0.0"></script>
</head>

<body>
    <div class="nui-toolbar">
        <a class="nui-button" plain="true" onclick="addShareUrl" id="addStationBtn">
            <span class="fa fa-plus fa-lg"></span>&nbsp;新增
        </a>
        <a class="nui-button" plain="true" onclick="addShareUrl" id="addStationBtn">
            <span class="fa fa-save fa-lg"></span>&nbsp;保存
        </a>
    </div>
    <div class="nui-fit">
        <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;" dataField="list" sortMode="client"
            allowCellSelect="true" allowCellEdit="true" showModified="false" showSummaryRow="true"
            style="width: 80%; height: 40%; margin-left:10%; ">
            <div property="columns">
                <div type="indexcolumn" headerAlign="center">序号</div>
                <div allowSort="true" field="name" summaryType="count" headerAlign="center" header="车型级别">
                    <input property="editor" class="nui-textbox" />
                </div>
                <div allowSort="true" allowSort="true" field="isDisabled" headerAlign="center" header="状态">
                    <input property="editor" class="nui-combobox" textField="name" data="statusList" valueField="id" />
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">


</script>

</html>