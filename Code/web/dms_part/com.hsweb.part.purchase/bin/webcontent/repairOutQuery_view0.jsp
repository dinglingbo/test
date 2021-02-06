<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-07 17:08:17
  - Description:
-->
<head>
<title>维修出库查询</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/repairMgr/repairOutQuery.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}
</style>
</head>
<body>
    <input class="nui-combobox" visible="false" id="settType"/>
    <input class="nui-combobox" visible="false" id="billTypeId"/>
    <input class="nui-combobox" visible="false" id="outTypeId"/>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div class="form" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)" id="type0">本日</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">本周</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)" id="type4">本月</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)" id="type5">上月</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(10)" id="type10">本年</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(11)" id="type11">上年</a>
                    <span class="separator"></span>
                    <label style="font-family:Verdana;">车牌号：</label>
                    <input class="nui-textbox" name="carNo" enabled="true"/>
                    <label style="font-family:Verdana;">零件编码：</label>
                    <input class="nui-textbox" name="partCode" enabled="true"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="ptsOutMainDetailList"
         idField="detailId"
         sortMode="client"
         frozenStartColumn="0"
         frozenEndColumn="7"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="业务信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="partName" width="60" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="appCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                    <div allowSort="true" field="unit" width="60" headerAlign="center" header="单位"></div>
                    <div allowSort="true" field="outQty" width="60" headerAlign="center" header="数量"></div>
                    <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
                </div>
            </div>
            <div header="车辆信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="serviceCode" width="60" headerAlign="center" header="业务单号"></div>
                    <div allowSort="true" field="carNo" headerAlign="center" header="车牌号"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="维修顾问"></div>
                </div>
            </div>
            <div header="领料信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="pickDate" width="60" headerAlign="center" header="领料日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="pickMan" headerAlign="center" header="领料人"></div>
                </div>
            </div>
            <div header="成本信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="trueUnitPrice" width="60" headerAlign="center" header="成本单价"></div>
                    <div allowSort="true" datatype="float" field="trueAmt" width="60" headerAlign="center" header="成本金额"></div>
                </div>
            </div>
            <div header="销售信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="sellUnitPrice" width="60" headerAlign="center" header="销售单价"></div>
                    <div allowSort="true" datatype="float" field="sellAmt" width="60" headerAlign="center" header="销售金额"></div>
                </div>
            </div>
            <div header="盈利信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="costUnitPrice" width="60" headerAlign="center" header="毛利"></div>
                    <div allowSort="true" datatype="float" field="costAmt" width="60" headerAlign="center" header="成本率%"></div>
                    <div allowSort="true" datatype="float" field="costAmt" width="60" headerAlign="center" header="毛利率%"></div>
                </div>
            </div>
            <div header="归库信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="returnDate" width="60" headerAlign="center" header="归库日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="returnSign" headerAlign="center" header="归库标志"></div>
                    <div allowSort="true" field="returnMan" width="60" headerAlign="center" header="归库人"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:280px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">退货日期：</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至：</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="true"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span>零件名称：</span>
                </td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="partName"/>
                </td>
            </tr>
            <tr>
                <td class="title">工单号：</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="serviceCode"/>
                </td>
            </tr>
            <tr>
                <td class="title">车牌号：</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="carNo"/>
                </td>
            </tr>
            <tr>
                <td class="title">零件编码：</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="partCode"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span >供应商：</span>
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">
                    <label>领料人：</label>
                </td>
                <td colspan="3">
                    <input name="pickMan"
                           showNullItem="true"
                           class="nui-combobox"
                           url=""
                           textField="text"
                           width="100%"
                           valueField="id" />
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
