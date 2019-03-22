<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>安全库存设置</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/stockQuery/partStoreStockSet.js?v=1.0.16"></script>
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
                           allowInput="false"
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
<!--                    <label style="font-family:Verdana;">显示高于库存上限：</label> -->
<!--                 <input class="nui-checkbox" id="showUp" trueValue="1" falseValue="0"/> -->
<!--                 <label style="font-family:Verdana;">显示低于库存下限：</label> -->
<!--                 <input class="nui-checkbox" id="showDown" trueValue="1" falseValue="0"/> -->
                <span class="separator"></span>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
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
         oncellcommitedit="onCellCommitEdit"
         allowCellSelect="true"
         allowCellWrap = true
         showModified="false"
         allowCellEdit="true"
         pageSize="1000"
         sizeList="[1000,2000,5000]"
         showSummaryRow="true">
        <div property="columns">
            <div width="40" type="indexcolumn">序号</div>
            <div header="配件信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="comPartName" width="150"headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="comOemCode"width="150" headerAlign="center" header="OEM码"></div>
                    <div allowSort="true" field="partBrandId" width="80" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="applyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
                    <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="65" headerAlign="center" header="库存数量"></div>
                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                    <div allowSort="true" field="storeId" width="100" headerAlign="center" header="仓库"></div>
                    
                </div>
            </div>
            <div header="库存设置" headerAlign="center">
                <div property="columns">
                	<div allowSort="true" field="shelf" width="60" headerAlign="center" header="仓位">
                        <input property="editor" class="nui-textbox"/>
                    </div>
                    <div allowSort="true" field="sellPrice" width="65" headerAlign="center" header="参考售价" numberFormat="0.00"><input property="editor" vtype="float" class="nui-textbox"/></div>
                    <div allowSort="true" field="upLimit" width="65" headerAlign="center" header="库存上限" numberFormat="0.00"><input property="editor" vtype="float" class="nui-textbox"/></div>
                    <div allowSort="true" field="downLimit" width="65" headerAlign="center" header="库存下限" numberFormat="0.00"><input property="editor" vtype="float" class="nui-textbox"/></div>
                    <div allowSort="true" field="minOrderQty" width="85" headerAlign="center" header="最小起订量" numberFormat="0.00"><input property="editor" vtype="float" class="nui-textbox"/></div>
                    <div allowSort="true" field="minPackQty" width="85" headerAlign="center" header="最小包装量" numberFormat="0.00"><input property="editor" vtype="float" class="nui-textbox"/></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                	<div allowSort="true" field="wain" width="40" headerAlign="center" header="警戒"></div>
                    <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div>
                    <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                    <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
                    <div allowSort="true" field="lastEnterDate" headerAlign="center" header="最近入库日期"  width="120"dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="lastOutDate" headerAlign="center" header="最近出库日期"  width="120"dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div allowSort="true" field="remark" width="200" headerAlign="center" header="备注"></div>
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



</body>
</html>
