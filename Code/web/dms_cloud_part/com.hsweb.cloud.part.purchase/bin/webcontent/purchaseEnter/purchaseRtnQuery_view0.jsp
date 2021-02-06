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
<title>采购退货查询</title>
<script src="<%=webPath + contextPath%>/purchase/js/purchaseEnter/purchaseRtnQuery.js?v=2.0.10"></script>
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
                <input id="partNameAndPY" width="80px" emptyText="配件名称/拼音" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">配件ID：</label> -->
                <input id="partCode" width="80px" emptyText="配件编码" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">订单单号：</label> -->
                <input id="serviceId" width="80px" emptyText="采退单号" class="nui-textbox"/>
                <input id="manualCode" width="80px" emptyText="订单号" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">供应商：</label> -->
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..." width="80px"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
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
                <span class="separator"></span>
                <label style="font-family:Verdana;">可退货数大于零：</label>
                <input class="nui-checkbox" id="rtnableQty" trueValue="1" falseValue="0"/>
               
                <span class="separator"></span>
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <span class="separator"></span>

                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->

                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
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
         allowSort="true"
         url=""
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="" headerAlign="center">
                <div property="columns">
                	<div allowSort="true" field="manualCode" width="170" headerAlign="center" header="订单号" allowSort="true" dataType="string"></div>
                    <div field="guestFullName" width="150" headerAlign="center" header="供应商" allowSort="true" dataType="string"></div>
                    <div field="orderMan" width="60" headerAlign="center" header="退货员" allowSort="true" dataType="string"></div>
                    <div allowSort="true"width="120" field="outDate" headerAlign="center" header="退货日期" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" dataType="date"></div>
                    <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div> 
                    <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>-->
                    <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
                    <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库" allowSort="true" dataType="string"></div>
                </div>
            </div>
            <div header="退货信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="comPartCode" width="80" headerAlign="center" header="配件编码" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="comPartName"width="120" headerAlign="center" header="配件名称" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="comOemCode" width="120"headerAlign="center" header="OE码" allowSort="true" dataType="string"></div>
                    <div field="orgCarBrandId" width="60" headerAlign="center" header="厂牌"></div>
                    <div allowSort="true" field="partBrandId" width="80" headerAlign="center" header="品牌" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="applyCarModel" width="160" headerAlign="center" header="品牌车型" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位" allowSort="true" dataType="string"></div>
                </div>
            </div>
            <div header="数量单价" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
                    <div allowSort="true" datatype="float" name="sellPrice" field="sellPrice" visible="false" width="60" headerAlign="center" header="退货单价"></div>
                    <div allowSort="true" datatype="float" name="sellAmt" field="sellAmt" visible="false" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
                    <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
                </div>
            </div>
            <!-- <div header="采购信息" headerAlign="center">
                <div property="columns">
                    <div name="enterPrice" field="enterPrice" visible="false" width="60" headerAlign="center" header="采购单价"></div>
                    <div name="enterAmt" field="enterAmt" visible="false" width="60" headerAlign="center" summaryType="sum" header="采购金额"></div>
                </div>
            </div> -->
            <div header="含税信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
                    <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
                    <div name="taxPrice" field="taxPrice" visible="false" width="60" headerAlign="center" header="含税单价"></div>
                    <div name="taxAmt" field="taxAmt" visible="false" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
                </div>
            </div>
            <div header="不含税信息" headerAlign="center">
                <div property="columns">
                    <div name="noTaxPrice" field="noTaxPrice" visible="false" width="60" headerAlign="center" header="不含税单价"></div>
                    <div name="noTaxAmt" field="noTaxAmt" visible="false" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
                </div>
            </div>
            <div header="人进价信息" headerAlign="center">
                <div property="columns">
                    <div name="taxCostPrice" field="taxCostPrice" visible="false" width="80" headerAlign="center" header="人进价单价"></div>
                    <div name="taxCostAmt" field="taxCostAmt" visible="false" width="80" headerAlign="center" summaryType="sum" header="人进价金额"></div>
                </div>
            </div>
            <div header="采购成本价信息" headerAlign="center">
                <div property="columns">
                    <div name="expEnterPrice" field="expEnterPrice" visible="false" width="90" headerAlign="center" header="采购成本单价"></div>
                    <div name="expEnterAmt" field="expEnterAmt" visible="false" width="90" headerAlign="center" summaryType="sum" header="采购成本金额"></div>
                </div>
            </div>
            <div header="定价成本信息" headerAlign="center">
                <div property="columns">
                    <div name="setCostPrice" field="setCostPrice" visible="false" width="90" headerAlign="center" header="定价成本单价"></div>
                    <div name="setCostAmt" field="setCostAmt" visible="false" width="90" headerAlign="center" summaryType="sum" header="定价成本金额"></div>
                </div>
            </div>
            <div header="库存商品信息" headerAlign="center">
                <div property="columns">
                    <div name="noTaxCostPrice" field="noTaxCostPrice" visible="false" width="90" headerAlign="center" header="库存商品单价"></div>
                    <div name="noTaxCostAmt" field="noTaxCostAmt" visible="false" width="90" headerAlign="center" summaryType="sum" header="库存商品金额"></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="serviceId" width="170" summaryType="count" headerAlign="center" header="采退单号" allowSort="true" dataType="string"></div>
                    <div field="auditor" width="60" headerAlign="center" header="审核人" allowSort="true" dataType="string"></div>
                    <div allowSort="true" width="120"field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" dataType="date"></div>
                    <div allowSort="true" field="partId" width="50" headerAlign="center" header="配件ID" allowSort="true" dataType="string"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:450px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
        	<tr>
                <td class="title">出库日期:</td>
                <td>
                    <input name="sOutDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eOutDate"
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
                    <input id="sAuditDate" name="sAuditDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eAuditDate" name="eAuditDate"
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
                <td class="title">采退单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">订单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="manualCodeList" name="manualCodeList"></textarea>
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
                <td class="title">配件ID:</td>
                <td colspan="3">
                    <input id="partId"
                           name="partId"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">厂牌:</td>
                <td colspan="3">
                    <input name="orgCarBrandId"
                       id="orgCarBrandId"
                       class="nui-combobox"
                       textField="name"
                       valueField="customid"
                       valueFromSelect="true"
                       emptyText="请选择..."
                       url=""
                       width="100%"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100%"
                       nullItemText="请选择..."/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>


<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>  
        	<td colspan="1" align="center"  rowspan="2">序号</td>
             <td colspan="5" align="center" ></td>
            <td colspan="6" align="center" >退货信息</td>
            <td colspan="4" align="center" >数量单价</td>
            <td colspan="2" align="center" >成本信息</td>
            <td colspan="4" align="center" >含税信息</td>
            <td colspan="2" align="center" >不含税信息</td>
             <td colspan="4" align="center" >其他</td>
        </tr>
        <tr>
        	 <td colspan="1" align="center" >采退单号</td>
        	 <td colspan="1" align="center" >供应商</td>
        	 <td colspan="1" align="center" >退货员</td>
        	 <td colspan="1" align="center" >退货日期</td>
        	 <td colspan="1" align="center" >仓库</td>
        	 <td colspan="1" align="center" >配件编码</td>
        	 <td colspan="1" align="center" >配件名称</td>
        	 <td colspan="1" align="center" >OE码</td>
        	 <td colspan="1" align="center" >品牌</td>
        	 <td colspan="1" align="center" >品牌车型</td>
        	 <td colspan="1" align="center" >单位</td>
        	 <td colspan="1" align="center" >退货数量</td>
        	 <td colspan="1" align="center" >退货单价</td>
        	 <td colspan="1" align="center" >退货金额</td>
        	 <td colspan="1" align="center" >备注</td>
        	 <td colspan="1" align="center" >成本单价</td>
        	 <td colspan="1" align="center" >成本金额</td>
        	 <td colspan="1" align="center" >是否含税</td>
        	 <td colspan="1" align="center" >税点</td>
        	 <td colspan="1" align="center" >含税单价</td>
        	 <td colspan="1" align="center" >含税金额</td>
        	 <td colspan="1" align="center" >不含税单价</td>
        	 <td colspan="1" align="center" >不含税金额</td>
        	 <td colspan="1" align="center" >订单号</td>
        	 <td colspan="1" align="center" >审核人</td>
        	 <td colspan="1" align="center" >审核日期</td>
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table> 
    <a href="" id="tableExportA"></a>
</div>  

</body>
</html>
