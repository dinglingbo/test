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
<title>库存查询</title>
<script src="<%=webPath + contextPath%>/purchase/js/stockQuery/partStoreStockQuery.js?v=2.2.9"></script>
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
				<!-- <label style="font-family:Verdana;">配件名称/拼音：</label> -->
              <input id="comPartCode" width="120px" emptyText="配件编码" class="nui-textbox"/>
	            <input id="comPartNameAndPY" width="120px" emptyText="配件名称/拼音" class="nui-textbox"/>
	            <!-- <label style="font-family:Verdana;">配件ID：</label> -->
	            
	            <!-- <label style="font-family:Verdana;">订单单号：</label> -->
                <input id="partBrandId"
                           name="partBrandId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="品牌"
                           valueFromSelect="true"
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
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
                <input id="storeShelf" width="120px" emptyText="仓位" class="nui-textbox"/>
                 <input id="upOrDown"
                           name="upOrDown"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="库存上下限"
                           url=""
                           data="UpOrDownList"
                           valueFromSelect="true"
                           allowInput="true"
                           showNullItem="true"
                           nullItemText="请选择..."/>
                <input id="partId" width="80px" visible="false" emptyText="配件ID" class="nui-textbox"/>
                <span class="separator"></span>
                <label style="font-family:Verdana;">显示零库存：</label>
                <input class="nui-checkbox" id="showAll" trueValue="1" falseValue="0"/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
                <a class="nui-menubutton" plain="true" menu="#popupMenuMore" id="menuMore">
                <span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                <ul id="popupMenuMore" class="nui-menu" style="display:none;">
                     <li name="enterBtn" iconCls="icon-add" onclick="onEnter">入库记录</li>
	                 <li name="outBtn" iconCls="icon-edit" onclick="onOut">出库记录</li>
	      <!--           <li name="outBtn" iconCls="icon-edit" onclick="sellRecord">库存占用记录</li>-->
                </ul>
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
                    <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="comPartName" width="150"headerAlign="center" header="配件名称" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="comOemCode" width="100" headerAlign="center" header="OE码" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="applyCarModel" width="120" headerAlign="center" header="品牌车型" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="shelf" width="120" headerAlign="center" header="仓位" allowSort="true" dataType="string"></div>
                </div>
            </div>
            <div header="数量金额" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
                    <div allowSort="true" datatype="float" field=expEnterPrice width="60" headerAlign="center" header="人进单价"></div>
                    <div allowSort="true" datatype="float" field="expEnterAmt" summaryType="sum" width="60" headerAlign="center" header="人进金额"></div>
                    <div allowSort="true" datatype="float" field="costPrice" width="60" headerAlign="center" header="库存单价"></div>
                    <div allowSort="true" datatype="float" field="stockAmt" summaryType="sum" width="60" headerAlign="center" header="库存金额"></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="orderQty" visible="false" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div>
                    <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                    <div allowSort="true" datatype="float" field="onRoadQty" visible="true" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
                    <div allowSort="true" field="lastEnterDate" headerAlign="center" width="120" header="最近入库日期" allowSort="true" dataType="date" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="lastOutDate" headerAlign="center"  width="120" header="最近出库日期" allowSort="true" dataType="date" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="upLimit" width="95" headerAlign="center" header="库存上限(夏季)"></div>
                    <div allowSort="true" field="downLimit" width="95" headerAlign="center" header="库存下限(夏季)"></div>
                    <div allowSort="true" field="upLimitWinter" width="95" headerAlign="center" header="库存上限(冬季)" numberFormat="0.00"></div>
                    <div allowSort="true" field="downLimitWinter" width="95" headerAlign="center" header="库存下限(冬季)" numberFormat="0.00"></div>
                    <div allowSort="true" field="remark" width="200" headerAlign="center" header="备注" allowSort="true" dataType="string"></div>
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
                    <input name="sEnterDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eEnterDate"
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
                    <input name="sAuditDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eAuditDate"
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
                <td class="title">采购单号:</td>
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
                <td class="title">配件ID:</td>
                <td colspan="3">
                    <input id="partId"
                           name="partId"
                           class="nui-textbox" 
                           width="100%"/>
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
            <td colspan="1" align="center">开单数量</td>
            <td colspan="1" align="center">可售数量</td>
            <td colspan="1" align="center">在途数量</td>
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
