<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>库存查询</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/stockQuery/partStoreStockQuery.js?v=1.0.1"></script>
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
                <input id="partBrandId" width="100px"
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
                  <input id="applyCarModel" width="120px"  emptyText="品牌车型" class="nui-textbox"/>                           
                 <input id="storeId"  width="100px"
                           name="storeId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="仓库"
                           url=""
                           valueFromSelect="true"
                           allowInput="false"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                 
                <input id="storeShelf" width="80px" emptyText="仓位" class="nui-textbox"/>
                <input id="upOrDown"
               			 width="100px"
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
                       <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <input id="partId" width="80px" visible="false" emptyText="配件ID" class="nui-textbox"/>
                <span class="separator"></span>
                <label style="font-family:Verdana;">显示零库存：</label>
                <input class="nui-checkbox" id="showAll" trueValue="1" falseValue="0"/>
<!--                 <label style="font-family:Verdana;">显示高于库存上限：</label> -->
<!--                 <input class="nui-checkbox" id="showUp" trueValue="1" falseValue="0"/> -->
<!--                 <label style="font-family:Verdana;">显示低于库存下限：</label> -->
<!--                 <input class="nui-checkbox" id="showDown" trueValue="1" falseValue="0"/> -->
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
<!--                 <a class="nui-button" iconCls="" plain="true" onclick="onEnterRecord()" id="enterBtn"><span class=""></span>&nbsp;入库记录</a> -->
<!--                 <a class="nui-button" iconCls="" plain="true" onclick="onOutRecord()" id="outBtn"><span class=""></span>&nbsp;出库记录</a> -->
            </td>
        </tr>
    </table>
</div>

 	<ul id="gridMenu" class="mini-contextmenu" >              
        <li name="enterBtn" iconCls="icon-add" onclick="onEnter">入库记录</li>
	    <li name="outBtn" iconCls="icon-edit" onclick="onOut">出库记录</li>        
    </ul>
        <div id="mainTabs" class="nui-tabs" name="mainTabs" activeIndex="0" style="width:100%; height:100%;" plain="false" onactivechanged="activechangedmain()">
	        <div title="库存查询" id="inventory" name="inventory">
				<div class="nui-fit">
				    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="detailList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         allowCellWrap = true
				         pageSize="1000"
				         sizeList="[1000,2000,5000]"
				         contextMenu="#gridMenu"
				         showSummaryRow="true">
				        <div property="columns">
				            <div type="indexcolumn"  width="40">序号</div>
				            <div header="配件信息" headerAlign="center">
				                <div property="columns">
				                    <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码"></div>
				                    <div allowSort="true" field="comPartFullName" width="150" headerAlign="center" header="配件全称"></div>
				                    <div allowSort="true" field="comOemCode" width="150"headerAlign="center" header="OEM码"></div>
				                    <div allowSort="true" field="partBrandId" width="90" headerAlign="center" header="品牌"></div>
				                    <div allowSort="true" field="applyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
				                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
				                    <div allowSort="true" field="storeId" width="100" headerAlign="center" header="仓库"></div>
				                    <div allowSort="true" field="shelf" width="60" headerAlign="center" header="仓位"></div>
				                </div>
				            </div>
				            <div header="库存信息" headerAlign="center">
				                <div property="columns">
				                    <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="70" headerAlign="center" header="数量"></div>
				                    <div allowSort="true" datatype="float" field="costPrice" width="70" headerAlign="center" header="单价"></div>
				                    <div allowSort="true" datatype="float" field="stockAmt" summaryType="sum" width="70" headerAlign="center" header="金额"></div>
				                    <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
				                </div>
				            </div>
				            <div header="其他" headerAlign="center">
				                <div property="columns">
				                    <div allowSort="true" datatype="float" field="sellPrice" width="70" headerAlign="center" header="建议售价"></div>
				                    <div allowSort="true" field="comPartName" width="150" headerAlign="center" header="配件名称"></div>
<!-- 				                    <div allowSort="true" datatype="float" field="orderQty" visible="false" summaryType="sum" width="70" headerAlign="center" header="开单数量"></div>
				                    <div allowSort="true" datatype="float" field="onRoadQty" visible="false" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div> -->
				                    <div allowSort="true" field="lastEnterDate" headerAlign="center" header="最近入库日期"  width="120" dateFormat="yyyy-MM-dd HH:mm"></div>
				                    <div allowSort="true" field="lastOutDate" headerAlign="center" header="最近出库日期" width="120" dateFormat="yyyy-MM-dd HH:mm"></div>
				                    <div allowSort="true" field="upLimit" width="60" headerAlign="center" header="库存上限"></div>
				                    <div allowSort="true" field="downLimit" width="60" headerAlign="center" header="库存下限"></div>
				                    <div allowSort="true" field="wain" width="40" headerAlign="center" header="警戒"></div>
				                    <div allowSort="true" field="remark" width="200" headerAlign="center" header="备注"></div>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>	        	
	        </div>
	        <div title="批次查询" id="batch" name="batch">
				<div class="nui-fit">
				    <div id="rightGrid2" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="detailList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         totalField="page.count"
				         url=""
				         allowCellWrap = true
				         pageSize="10000"
				         sizeList="[1000,5000,10000]"
				         showSummaryRow="true">
				        <div property="columns">
				            <div width="40" type="indexcolumn">序号</div>
				            <div header="配件信息" headerAlign="center">
				                <div property="columns">
				                    <div allowSort="true" field="comPartCode" headerAlign="center" header="配件编码"></div>
				                    <div allowSort="true"width="100" field="comPartName" headerAlign="center" header="配件名称"></div>
				                    <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
				                    <div allowSort="true" field="partBrandId" width="80" headerAlign="center" header="品牌"></div>
				                    <div allowSort="true" field="applyCarModel" name="applyCarModel" width="140" headerAlign="center" header="品牌车型"></div>
				                    <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
				                </div>
				            </div>
				            <div header="库存信息" headerAlign="center">
				                <div property="columns">
				                   <!--  <div allowSort="true" field="manualCode" width="180" summaryType="count" headerAlign="center" header="入库单号"></div> -->
				                    <div field="guestFullName" name="guestFullName" width="180" headerAlign="center" header="供应商" allowSort="true"></div>
				                    <div field="orderMan" name="orderMan" width="60" headerAlign="center" header="采购员"></div>
<!-- 				                    <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
				                    <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div> -->
				                    <div allowSort="true" field="enterDate"width="140" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				                    <div allowSort="true" field="storeId" width="90" headerAlign="center" header="仓库"></div>
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
<!-- 				            <div header="其他" headerAlign="center">
				                <div property="columns">
				                	<div allowSort="true" datatype="float" field="suggSellPrice" width="60" headerAlign="center" header="建议售价"></div>
				                	<div field="auditor" width="60" headerAlign="center" header="审核人"></div>
				                    <div allowSort="true" width="140"field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				                    <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
				                </div>
				            </div> -->
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

</div>  

</body>
</html>
