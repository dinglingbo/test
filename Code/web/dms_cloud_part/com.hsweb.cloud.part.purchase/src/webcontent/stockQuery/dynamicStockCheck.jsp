<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>配件库存动态盘点</title>
<script src="<%=webPath + contextPath%>/purchase/js/stockQuery/dynamicStockCheck.js?v=1.0.3"></script>
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

				<label style="font-family:Verdana;">变动日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                <span class="separator"></span> 
                <input id="partNameAndPY" width="100px" emptyText="配件名称/拼音" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">配件ID：</label> -->
                <input id="partCode" width="100px" emptyText="配件编码" class="nui-textbox"/>
                 <input id="storeId"
                           name="storeId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="仓库"
                           url=""
                           valueFromSelect="true"
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
               
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
         pageSize="1000"
         sizeList="[1000,2000,5000]"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="库存信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码" summaryType="count"></div>
                    <div allowSort="true" field="comPartName" width="150"headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="comOemCode" width="120" headerAlign="center" header="OE码"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="applyCarModel" width="120" headerAlign="center" header="品牌车型"></div>
                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                    <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
                    <div allowSort="true" field="shelf" width="60" headerAlign="center" header="仓位"></div>
                </div>
            </div>
            <div header="数量金额" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
                    <div allowSort="true" datatype="float" field="costPrice" width="60" headerAlign="center" header="库存单价"></div>
                    <div allowSort="true" datatype="float" field="stockAmt" summaryType="sum" width="60" headerAlign="center" header="库存金额"></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="orderQty" visible="false" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div>
                    <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                    <div allowSort="true" datatype="float" field="onRoadQty" visible="false" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
                    <div allowSort="true" field="lastEnterDate" headerAlign="center" width="120"header="最近入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="lastOutDate" headerAlign="center"  width="120" header="最近出库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="upLimit" width="60" headerAlign="center" header="库存上限(夏季)"></div>
                    <div allowSort="true" field="downLimit" width="60" headerAlign="center" header="库存下限(夏季)"></div>
                    <div allowSort="true" field="upLimitWinter" width="95" headerAlign="center" header="库存上限(冬季)" numberFormat="0.00"></div>
                    <div allowSort="true" field="downLimitWinter" width="95" headerAlign="center" header="库存下限(冬季)" numberFormat="0.00"></div>
                    <div allowSort="true" field="remark" width="200" headerAlign="center" header="备注"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
            <td colspan="1" align="center">配件编码</td>
            <td colspan="1" align="center">配件名称</td>
            <td colspan="1" align="center">OE码</td>
            <td colspan="1" align="center">品牌</td>
            <td colspan="1" align="center">品牌车型</td>
            <td colspan="1" align="center">单位</td>
            <td colspan="1" align="center">仓库</td>
            <td colspan="1" align="center">仓位</td>
            <td colspan="1" align="center">库存数量</td>
            <td colspan="1" align="center">库存金额</td>
            <td colspan="1" align="center">可售数量</td>
            <td colspan="1" align="center">最近入库日期</td>
            <td colspan="1" align="center">最近出库日期</td>
            <td colspan="1" align="center">库存上限(夏季)</td>
            <td colspan="1" align="center">库存下限(夏季)</td>
            <td colspan="1" align="center">库存上限(冬季)</td>
            <td colspan="1" align="center">库存下限(冬季)</td>
            <td colspan="1" align="center">备注</td>
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div>  



</body>
</html>
