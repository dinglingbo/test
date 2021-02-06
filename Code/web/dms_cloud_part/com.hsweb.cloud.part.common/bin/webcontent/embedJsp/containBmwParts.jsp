<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-07-09 09:17:43
  - Description:
-->
<head>
<title>宝马配件查询</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containBmwParts.js?v=1.0.23"></script>
<style type="text/css">
    .table-label {
        text-align: right;
    }
    body .mini-grid-row-selected{
        background:#89c3d6 !important; 
    }
    .title {
        width: 60px;
        text-align: right;
    }

    .title.required {
        color: red;
    }
</style>
</head>
<body>
<!-- 
<div class="nui-toolbar" style="padding:2px;border-bottom:1;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <input class="nui-textbox" width="100px" id="partId" name="partId" selectOnFocus="true" enabled="true" emptyText="宝马配件编码"/>
                <a class="nui-button" iconCls="" plain="true" onclick="doSearch()" id="searchBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
            </td>
        </tr>
    </table>
</div> -->
<div class="nui-fit">
    <div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;"
            borderStyle="border:1;"
            selectOnLoad="true"
            showPager="false"
            pageSize="20"
            sizeList=[20,50,100,200]
            sortMode="client"
            ondrawcell="onBmwDrawCell"
            onrowdblclick=""
            idField="id"
            totalField="page.count"
            allowCellSelect="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div field="partName" name="partName" width="100" headerAlign="center" header="配件名称"></div>
            <!--<div field="agioCode" name="agioCode" width="100" headerAlign="center" header="折扣代码"></div>
            <div field="agioRate" name="agioRate" width="100" headerAlign="center" header="折扣率(%)"></div>
            <div field="retailPrice" name="retailPrice" width="100" headerAlign="center" header="除税零售价"></div>-->
            <div field="displayRetailPrice" name="displayRetailPrice" width="100" headerAlign="center" header="零售价"></div>
            <div field="displayPurchasePrice" name="displayPurchasePrice" width="100" headerAlign="center" header="采购价"></div>
            <div field="stockQtySy01Bj" name="stockQtySy01Bj" width="100" headerAlign="center" header="北京仓"></div>
            <div field="stockQtySy02Sh" name="stockQtySy02Sh" width="100" headerAlign="center" header="上海仓"></div>
            <div field="stockQtySy03Gz" name="stockQtySy03Gz" width="100" headerAlign="center" header="广州仓"></div>
            <div field="stockQtySy06Cd" name="stockQtySy06Cd" width="100" headerAlign="center" header="成都仓"></div>
            <div field="stockQtySy07Sy" name="stockQtySy07Sy" width="100" headerAlign="center" header="沈阳仓"></div>
            <div field="remark" name="remark" width="100" headerAlign="center" header="备注"></div>
            <div field="modifyDate" name="modifyDate" width="120" headerAlign="center" header="更新日期"></div>
        </div>
    </div>
</div>

</body>
</html>
<script>
    var partCode = '<b:write property="partCode"/>';
</script>
