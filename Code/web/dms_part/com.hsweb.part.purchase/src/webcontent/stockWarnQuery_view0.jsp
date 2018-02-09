<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 15:36:33
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/purchase/js/stockMgr/stockWarnQuery.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>


<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(12)">当前库存数量低于库存下限</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(13)">当前库存数量高于库存上限</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="addInbound()">打印</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="ptsStockCycList"
         idField="id"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="基础信息" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                    <div field="partName" width="100" headerAlign="center" header="配件名称"></div>
                    <div field="partBrandId" width="100" headerAlign="center" header="品牌"></div>
                    <div field="applyCarModel" width="100" headerAlign="center" header="车型"></div>
                    <div field="partName1" width="100" headerAlign="center" header="类型"></div>
                    <div field="stockLocation" width="100" headerAlign="center" header="存入仓位"></div>
                    <div field="suggestPrice" width="100" headerAlign="center" header="建议售价" align="right"></div>
                    <div field="stockQty" width="100" headerAlign="center" header="库存数量" align="right"></div>
                </div>
            </div>
            <div header="仓位周期信息" headerAlign="center">
                <div property="columns">
                    <div field="stockDownLimit" width="60" headerAlign="center" header="库存下限" align="right"></div>
                    <div field="stockUpLimit" headerAlign="center" header="库存上限" align="right"></div>
                </div>
            </div>
        </div>
    </div>
</div>




</body>
</html>
