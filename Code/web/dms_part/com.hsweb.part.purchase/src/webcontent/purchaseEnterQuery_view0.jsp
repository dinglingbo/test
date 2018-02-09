<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>采购入库查询</title>
<script src="<%= request.getContextPath() %>/purchase/js/purchaseInbound/purchaseEnterQuery.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	/*border-right: 0;*/
	
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
                <label style="font-family:Verdana;">可出库数大于零：</label>
                <input class="nui-checkbox" id="outableQtyGreaterThanZero" trueValue="1" falseValue="0"/>
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
         ondrawcell="onDrawCell"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="" headerAlign="center">
                <div property="columns">
                    <div field="enterId" width="150" headerAlign="center" header="入库单号"></div>
                    <div field="enterDate" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd"></div>
                    <div field="billStatus" width="60" headerAlign="center" header="单据状态"></div>
                    <div field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>
                    <div field="settType" width="60" headerAlign="center" header="结算方式"></div>
                    <div field="storeId" width="60" headerAlign="center" header="仓库"></div>
                </div>
            </div>
            <div header="配件属性" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="配件编码"></div>
                    <div field="partName" headerAlign="center" header="配件名称"></div>
                    <div field="partBrandName" width="60" headerAlign="center" header="品牌"></div>
                    <div field="applyCarModel" width="60" headerAlign="center" header="车型"></div>
                    <div field="unit" width="40" headerAlign="center" header="单位"></div>
                    <div type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="含税" trueValue="1" falseValue="0"></div>
                    <div field="taxRate1" width="40" headerAlign="center" header="票点"></div>
                </div>
            </div>
            <div header="数量单价" headerAlign="center">
                <div property="columns">
                    <div field="enterQty" width="40" headerAlign="center" header="入库数"></div>
                    <div field="outableQty" width="40" headerAlign="center" header="可出库数"></div>
                    <div field="noTaxUnitPrice" width="40" headerAlign="center" header="单价"></div>
                    <div field="noTaxAmt" width="40" headerAlign="center" header="金额"></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                    <div field="guestFullName" width="60" headerAlign="center" header="供应商"></div>
                    <div field="buyer" width="60" headerAlign="center" header="采购"></div>
                    <div field="enterDayCount" width="60" headerAlign="center" header="入库天数"></div>
                    <div field="remark" width="60" headerAlign="center" header="入库分配"></div>
                    <div field="modifier" width="60" headerAlign="center" header="操作员"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:320px;"
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
            <tr>
                <td class="title">
                    <span style="letter-spacing: 6px;">供应</span>商:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">采购单号:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="enterId"/>
                </td>
            </tr>
            <tr>
                <td class="title">操作人:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="modifier"/>
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
