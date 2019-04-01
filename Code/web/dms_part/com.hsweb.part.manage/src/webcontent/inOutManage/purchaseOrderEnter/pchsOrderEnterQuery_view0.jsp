<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>采购入库查询</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/purchaseOrderEnter/pchsOrderEnterQuery.js?v=1.0.17"></script>
<link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
<style type="text/css">
.title {
	width: 90px;
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


                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                    <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                    <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                    <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                    <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
                </ul>

				<label style="font-family:Verdana;">审核日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 

                <input id="partNameAndPY" width="100px" emptyText="配件名称/拼音" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">配件编码：</label> -->
                <input id="partCode" width="100px" emptyText="配件编码" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">订单单号：</label> -->
                <input id="serviceId" width="100px" emptyText="采购单号" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">供应商：</label> -->
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <span class="separator"></span>

                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
                <input id="storeId"
                           name="storeId"
                           width="80px"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="仓库"
                           url=""
                           valueFromSelect="true"
                           allowInput="false"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                 <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
               <!--  <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> -->

            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="detailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         allowCellWrap = true
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         showSummaryRow="true">
        <div property="columns">
            <div width="40" type="indexcolumn">序号</div>
            <div header="入库信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="manualCode" width="180" summaryType="count" headerAlign="center" header="入库单号"></div>
                    <div field="guestFullName" name="guestFullName" width="180" headerAlign="center" header="供应商"></div>
                    <div field="orderMan" name="orderMan" width="60" headerAlign="center" header="采购员"></div>
                    <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
                    <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="enterDate"width="140" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="storeId" width="90" headerAlign="center" header="仓库"></div>
                </div>
            </div>
            <div header="配件信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="comPartCode" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true"width="100" field="comPartName" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
                    <div allowSort="true" field="partBrandId" width="80" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="applyCarModel" name="applyCarModel" width="120" headerAlign="center" header="品牌车型"></div>
                    <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
                </div>
            </div>
            <div header="数量单价" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" summaryType="sum" field="enterQty" width="60" headerAlign="center" header="入库数量"></div>
                    <div allowSort="true" datatype="float" field="enterPrice" width="60" headerAlign="center" header="入库单价"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="enterAmt" width="60" headerAlign="center" header="入库金额"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="outableQty" width="60" headerAlign="center" header="剩余库存"></div>
                    <div allowSort="true" field="detailRemark" width="120" headerAlign="center" header="备注"></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                	<div allowSort="true" datatype="float" field="suggSellPrice" width="60" headerAlign="center" header="建议售价"></div>
                	<div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                    <div allowSort="true" width="140"field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:360px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
        	<tr>
                <td class="title">入库日期:</td>
                <td>
                    <input name="sCreateDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eCreateDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">审核日期:</td>
                <td>
                    <input id="sAuditDate"
                           name="sAuditDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eAuditDate"
                           name="eAuditDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
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
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">入库单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件编码:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="partCodeList" name="partCodeList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件名称:</td>
                <td colspan="3">
                    <input id="partName"
                           name="partName"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">采购员:</td>
                <td colspan="3">
                    <input id="orderMan"
                           name="orderMan"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;margin-right:20px;">取消</a>
            <a class="nui-button" onclick="ononAdvancedSearchClear" style="width:60px;">清除</a>
        </div>
    </div>
</div>



</body>
</html>
