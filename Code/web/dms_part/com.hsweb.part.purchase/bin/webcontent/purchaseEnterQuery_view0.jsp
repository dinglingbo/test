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
<script src="<%=webPath + contextPath%>/purchasePart/js/purchaseInbound/purchaseEnterQuery.js?v=1.0.11"></script>
<style type="text/css">
.title {
	width: 90px;
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

    <input class="nui-combobox" visible="false" id="settType"/>
    <input class="nui-combobox" visible="false" id="billTypeId"/>
    <input class="nui-combobox" visible="false" id="enterTypeId"/>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
                <a class="nui-menubutton " iconCls="icon-date" menu="#popupMenuDate" id="menuBtnDateQuickSearch">本日</a>
                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 0, '本日')" id="type0">本日</li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 1, '昨日')" id="type1">昨日</li>
                    <li class="separator"></li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 2, '本周')" id="type2">本周</li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 3, '上周')" id="type3">上周</li>
                    <li class="separator"></li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 4, '本月')" id="type4">本月</li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 5, '上月')" id="type5">上月</li>
                </ul>
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
                <label style="font-family:Verdana;">供应商：</label>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..."
                       allowInput="false"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <label style="font-family:Verdana;">可出库数大于零：</label>
                <input class="nui-checkbox" id="outableQtyGreaterThanZero" trueValue="1" falseValue="0"/>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
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
         allowCellWrap="true"
         showSummaryRow="true"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="enterCode" width="150" headerAlign="center" header="入库单号"></div>
                    <div allowSort="true" field="enterDate" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div>
                    <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>
                    <div allowSort="true" field="settType" width="60" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
                </div>
            </div>
            <div header="配件属性" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="partCode" width="121" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="partFullName" width="200" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                    <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="含税" trueValue="1" falseValue="0"></div>
                    <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="票点"></div>
                </div>
            </div>
            <div header="数量单价" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="enterQty" width="60" headerAlign="center" header="入库数"  summaryType="sum"></div>
                    <div allowSort="true" datatype="float" field="outableQty" width="60" headerAlign="center" header="可出库数"  summaryType="sum"></div>
                    <div allowSort="true" datatype="float" field="noTaxUnitPrice" width="60" headerAlign="center" header="单价"></div>
                    <div allowSort="true" datatype="float" field="noTaxAmt" width="60" headerAlign="center" header="金额"  summaryType="sum"></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                    <div field="guestFullName" width="200" headerAlign="center" header="供应商"></div>
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
     title="高级查询" style="width:416px;height:330px;"
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
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span style="letter-spacing: 6px;">供应</span>商:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           class="nui-buttonedit"
                           allowInput="false"
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
                <td class="title">可出库数大于零:</td>
                <td colspan="1">
                    <input class="nui-checkbox" name="outableQtyGreaterThanZero" trueValue="1" falseValue="0"/>
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
