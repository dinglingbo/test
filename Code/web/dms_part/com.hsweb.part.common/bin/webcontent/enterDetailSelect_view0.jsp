<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-03 17:33:18
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/commonPart/js/enterDetailSelect.js?v=1.0.3"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}
</style>
</head>
<body>
    <input class="nui-combobox" visible="false" id="billTypeId"/>
    <input class="nui-combobox" visible="false" id="settType"/>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div id="queryForm" class="form">
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
                    <label style="font-family:Verdana;">助记码：</label>
                    <input class="nui-textbox" width="100" name="queryCode"/>
                    <label style="font-family:Verdana;">零件编码：</label>
                    <input class="nui-textbox" width="100" name="partCode"/>
                </td>
            </tr>
            <tr>
                <td style="width:100%;">
                    <label style="font-family:Verdana;">零件名称：</label>
                    <input class="nui-textbox" width="100" name="name"/>
                    <label style="font-family:Verdana;">供应商：</label>
                    <input id="guestId" class="nui-buttonedit"
                           name="guestId"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('guestId')" selectOnFocus="true" />
                    <label style="font-family:Verdana;">仓库：</label>
                    <input id="storeId"
                           name="storeId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                    <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
                    <a class="nui-button" iconCls="icon-ok" plain="true" onclick="onOk()" id="okBtn">选择</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-no" plain="true" onclick="onCancel()" id="cancelBtn">关闭</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="ptsEnterMainDetailList"
         idField="detailId"
         onrowdblclick="onOk"
         sortMode="client"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="零件信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="partCode" width="100" headerAlign="center" header="零件编码"></div>
                    <div allowSort="true" field="partName" headerAlign="center" header="零件名称"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" header="适用车型"></div>
                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                    <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
                </div>
            </div>
            <div header="库存" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="int" field="outableQty" width="60" headerAlign="center" header="库存" align="right"></div>
                    <div allowSort="true" datatype="int" field="enterQty" width="60" headerAlign="center" header="入库数" align="right"></div>
                    <div allowSort="true" datatype="int" field="outQty" width="60" headerAlign="center" header="已出库" align="right"></div>
                </div>
            </div>
            <div header="不含税信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="noTaxUnitPrice" width="80" headerAlign="center" header="单价" align="right"></div>
                </div>
            </div>
            <div header="含税信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="taxRate" width="60" headerAlign="center" header="税率" align="right"></div>
                    <div allowSort="true" datatype="float" field="taxUnitPrice" width="60" headerAlign="center" header="单价" align="right"></div>
                </div>
            </div>
            <div header="入库信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="enterId" width="100" headerAlign="center" header="入库单号"></div>
                    <div allowSort="true" field="guestFullName" width="100" headerAlign="center" header="供应商"></div>
                    <div allowSort="true" field="enterDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:300px;"
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
                           format="yyyy-MM-dd"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
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
                    <input id="guestId1"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('guestId1')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">零件名称:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="name"/>
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
            <a class="mini-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="mini-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>


</body>
</html>
