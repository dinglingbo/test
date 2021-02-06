<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:18:32
  - Description:
-->
<head>
<title>调拨入库查询</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/allotMgr/allotEnterQuery.js?v=1.0.2"></script>
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

    <input class="nui-combobox" id="billTypeId" visible="false"/>
    <input class="nui-combobox" id="settType" visible="false"/>
    <input class="nui-combobox" id="enterType" visible="false"/>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)" id="type0">本日</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)" id="type1">昨日</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">本周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)" id="type3">上周</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)" id="type4">本月</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)" id="type5">上月</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(10)" id="type10">本年</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(11)" id="type11">上年</a>
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
         dataField="ptsEnterMainDetailList"
         idField="detailId"
         sortMode="client"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="enterId" width="100" headerAlign="center" header="调拨单号"></div>
                    <div allowSort="true" field="enterDate" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div>
                    <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>
                    <!--<div field="settType" width="60" headerAlign="center" header="结算方式"></div>-->
                    <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
                </div>
            </div>
            <div header="零件属性" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="partCode" width="60" headerAlign="center" header="零件编码"></div>
                    <div allowSort="true" field="partName" headerAlign="center" header="零件名称"></div>
                    <div allowSort="true" field="partBrandName" width="60" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                </div>
            </div>
            <div header="数量单价" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="int" field="enterQty" width="40" headerAlign="center" header="入库数量"></div>
                    <div allowSort="true" datatype="float" field="noTaxUnitPrice" width="40" headerAlign="center" header="单价"></div>
                    <div allowSort="true" datatype="float" field="noTaxAmt" width="40" headerAlign="center" header="金额"></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="guestFullName" width="60" headerAlign="center" header="调出公司"></div>
                    <div allowSort="true" field="modifier" width="60" headerAlign="center" header="操作人"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:260px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">入库日期:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           allowInput="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="true"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span>客户:</span>
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           allowInput="false"
                           class="nui-buttonedit"
                           emptyText="请选择客户..."
                           onbuttonclick="selectCustomer('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">入库单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height:60px;" name="enterIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">零件编码:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" name="partCodeList"></textarea>
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
