<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:17:43
  - Description:
-->
<head>
<title>采购车/销售车</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containOrderCart.js?v=1.0.8"></script>
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
                    <!-- <label style="font-family:Verdana;">编码：</label> -->
                    <input class="nui-textbox" emptyText="编码" width="80" id="search-code" name="partCode"/>
                    <!-- <label style="font-family:Verdana;">名称：</label> -->
                    <input class="nui-textbox" emptyText="名称" width="80" id="search-name" name="fullName"/>
                    <span class="separator"></span>
                    <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                    <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
                    <a class="nui-button" iconCls="icon-ok" plain="true" onclick="onOk()">选入</a> -->
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="deleteCartShop()"><span class="fa fa-close fa-lg"></span>&nbsp;删除</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" visible="false" id="pchsOrderBtn" plain="true" onclick="generatePchsOrder()"><span class="fa fa-plus fa-lg"></span>&nbsp;生成采购订单</a>
                    <a class="nui-button" iconCls="" visible="false" id="pchsCartBtn" plain="true" onclick="addToPchsOrder()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加到指定采购订单</a>
                    <a class="nui-button" iconCls="" visible="false" id="sellOrderBtn" plain="true" onclick="generateSellOrder()"><span class="fa fa-plus fa-lg"></span>&nbsp;生成销售订单</a>
                    <a class="nui-button" iconCls="" visible="false" id="sellCartBtn" plain="true" onclick="addToSellOrder()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加到指定销售订单</a>
                    
                </td>
            </tr>
        </table>
    </div>
</div>

<div class="nui-fit">
        <div id="cartGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     borderStyle="border:0;"
                     dataField="list"
                     url=""
                     idField="id"
                     totalField="page.count"
                     pageSize="100"
                     showPager="true"
                     showLoading="false"
                     multiSelect="true"
                     showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
                <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div type="checkcolumn" width="25"></div>
                        <div field="partId" width="50" visible="false" headerAlign="center">配件ID</div>
                        <div field="partCode" width="80" headerAlign="center" allowSort="true">编码</div>
                        <div field="fullName" width="120" headerAlign="center" allowSort="true">全称</div>
                        <div field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
                        <div field="orderQty" width="50" headerAlign="center" allowSort="true">数量</div>
                        <div field="orderPrice" width="50" headerAlign="center" allowSort="true">单价</div>
                        <div field="remark" width="80" headerAlign="center" allowSort="true">备注</div>
                        <div field="shortName" width="60" headerAlign="center" allowSort="true">往来单位</div>
                        <div field="creator" width="50" headerAlign="center" allowSort="true">业务员</div>
                        <div field="createDate" width="80" dateFormat="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true">创建日期</div>
                        <div field="showPartId" width="50" visible="false" headerAlign="center"></div>
                        <div field="showPartCode" width="50" visible="false" headerAlign="center"></div>
                        <div field="showFullName" width="50" visible="false" headerAlign="center"></div>
                        <div field="showBrandName" width="50" visible="false" headerAlign="center"></div>
                        <div field="showCarModel" width="50" visible="false" headerAlign="center"></div>
                        <div field="showOemCode" width="50" visible="false" headerAlign="center"></div>
                        <div field="showSpec" width="50" visible="false" headerAlign="center"></div>
                        <div field="showPrice" width="50" visible="false" headerAlign="center"></div>
                        <div field="showAmt" width="50" visible="false" headerAlign="center"></div>
                </div>
        </div>
</div>


</body>
</html>
