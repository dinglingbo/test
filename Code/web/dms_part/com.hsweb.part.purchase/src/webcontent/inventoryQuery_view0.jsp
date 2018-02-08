<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 16:54:29
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/purchase/js/queryMgr/inventoryQuery.js?v=1.0.0"></script>
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
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)">本日</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)">昨日</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)">本周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)">上周</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)">本月</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)">上月</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(10)">本年</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(11)">上年</a>
                <span class="separator"></span>
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(6)">未审</a>-->
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(7)">已审</a>-->
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(8)">已过帐</a>-->
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(9)">全部</a>-->
                <!--<span class="separator"></span>-->
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
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
         dataField="ptsOutMainList"
         idField="id"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="维度" headerAlign="center">
                <div property="columns">
                    <div field="id" width="100" headerAlign="center" header="零件类别"></div>
                </div>
            </div>
            <div header="采购" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="采购入库"></div>
                    <div field="partName" headerAlign="center" header="采购退货"></div>
                </div>
            </div>
            <div header="维修" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="出库金额"></div>
                    <div field="partName" headerAlign="center" header="归库金额"></div>
                </div>
            </div>
            <div header="销售" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="出库金额"></div>
                    <div field="partName" headerAlign="center" header="退货金额"></div>
                </div>
            </div>
            <div header="调拨" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="入库金额"></div>
                    <div field="partName" headerAlign="center" header="出库金额"></div>
                </div>
            </div>
            <div header="耗材" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="出库金额"></div>
                    <div field="partName" headerAlign="center" header="归库金额"></div>
                </div>
            </div>
            <div header="库存" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="期初金额"></div>
                    <div field="partName" headerAlign="center" header="期末库存金额"></div>
                    <div field="partName" headerAlign="center" header="当前库存金额"></div>
                </div>
            </div>
            <div header="盘点" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="盘盈金额"></div>
                    <div field="partName" headerAlign="center" header="盘亏金额"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:110px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">日期:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd H:mm:ss"
                           timeFormat="H:mm:ss"
                           showTime="true"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>


</body>
</html>
