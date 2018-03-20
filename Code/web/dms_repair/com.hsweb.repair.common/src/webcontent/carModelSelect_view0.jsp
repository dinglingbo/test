<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-19 10:28:11
  - Description:
-->
<head>
<title>选择车型</title>
<script src="<%= request.getContextPath() %>/commonRepair/js/carModelSelect.js?v=1.0.0"></script>
<style type="text/css">
table {
	font-size: 12px;
}
</style>
</head>
<body>

<div class="nui-splitter" style="width:100%;height:100%;"
     borderStyle="border:0"
     handlerSize="6" allowResize="false">
    <div size="250" showCollapseButton="false" style="border:0;">
        <div class="nui-panel" title="品牌-厂商-车系"
             headerCls="panel-header"
             style="width:100%;height:100%;"
             showToolbar="false" showCloseButton="false" showFooter="false">
            <!--body-->
            <ul id="tree" class="nui-tree"
                style="width:100%;height:100%;"
                dataField="list"
                showTreeIcon="true" textField="nodeName" idField="nodeId" >
            </ul>
        </div>
    </div>
    <div showCollapseButton="false" style="border:0;">
        <div class="nui-toolbar" style="border-bottom: 0;">
            <div class="nui-form" id="queryForm">
                <table class="table">
                    <tr>
                        <td>
                            <label>车型名称</label>
                            <input class="nui-textbox" name="carModel"/>
                            <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                            <a class="nui-button" iconCls="icon-ok" plain="true" onclick="onOk()">选择</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="nui-fit">
            <div id="datagrid1"
                 class="nui-datagrid" style="width:100%;height:100%;"
                 showPager="false"
                 dataField="list"
                 allowSortColumn="true"
                 virtualScroll="true"
                 frozenStartColumn="0" frozenEndColumn="0">
                <div property="columns">
                    <div width="30" type="indexcolumn">序号</div>
                    <div field="carBrandName" headerAlign="center" allowSort="true" visible="true" header="品牌"></div>
                    <div field="carFactoryName" headerAlign="center" allowSort="true" visible="true" header="厂商"></div>
                    <div field="carSeriesName" headerAlign="center" allowSort="true" visible="true" header="车系"></div>
                    <div field="carModel" headerAlign="center" allowSort="true" visible="true" header="车型"></div>
                    <div field="remark" headerAlign="center" allowSort="true" visible="true" header="备注"></div>
                    <div field="id" headerAlign="center" allowSort="true" visible="true" header="车型ID"></div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
