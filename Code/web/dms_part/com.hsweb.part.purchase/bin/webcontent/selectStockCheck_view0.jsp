<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-14 15:39:03
  - Description:
-->
<head>
<title>盘点单选择</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/inventoryMgr/selectStockCheck.js?v=1.0.3"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div class="form" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">仓库：</label>
                    <input id="storeId"
                           name="storeId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="false"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-ok" plain="true" onclick="onOk()">选择</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-close" plain="true" onclick="onCancel()">关闭</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit" >
    <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
         frozenStartColumn="0"
         frozenEndColumn="0"
         dataField="list"
         url=""
         idField="id"
         totalField="page.count"
         selectOnLoad="true"
         pageSize="20"
         sortMode="client"
         showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="checkCode" width="150" headerAlign="center">单号</div>
            <div allowSort="true" field="checkName" width="60" headerAlign="center">名称</div>
            <div allowSort="true" field="checker" width="70" headerAlign="center">盘点人</div>
            <div allowSort="true" field="checkDate" width="80" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm">盘点日期</div>
            <div allowSort="true" field="remark" width="80" headerAlign="center" allowSort="true">备注</div>
        </div>
    </div>
</div>

</body>
</html>
