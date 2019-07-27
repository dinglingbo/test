<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">订货日期 从：</label>
                <input class="nui-datepicker" id="orderBeginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="orderEndDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                <span class="separator"></span> 
                <input id="orderServiceId" width="120px" emptyText="业务单号" class="nui-textbox"/>
                <input id="orderServiceMan" width="60px" emptyText="业务员" class="nui-textbox"/>
                <!-- <input id="orderSearchGuestId" class="nui-buttonedit"
                       emptyText="请选择往来单位..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" /> -->

                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onOrderSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                
                <a class="nui-button" iconCls="" plain="true" onclick="onOrderOk()"><span class="fa fa-check fa-lg"></span>&nbsp;转采购入库</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="orderGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="detailList"
         idField="detailId"
         ondrawcell="onOrderDrawCell"
         sortMode="client"
         url=""
         multiSelect="true"
         pageSize="50"
         sizeList="[50,100,200]"
         onshowrowdetail="onShowRowDetail"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div type="expandcolumn" width="20" >#</div>
            <div field="fullName" width="150" headerAlign="center" header="供应商名称"></div>
            <div allowSort="true" summaryType="count" field="serviceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
            <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
            <div allowSort="true" field="createDate" headerAlign="center" header="制单日期" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="auditSign" width="60" headerAlign="center" header="审核状态"></div>
            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="remark" width="120" headerAlign="center" header="备注"></div>

        </div>
    </div>
</div>

<div id="editFormPchsEnterDetail" style="display:none;">
    <div id="innerPchsEnterGrid" class="nui-datagrid" style="width:100%;height:150px;"
         showPager="false"
         dataField="pjPchsOrderDetailList"
         idField="detailId"
         ondrawcell="onOrderDrawCell"
         sortMode="client"
         url=""
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
            <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
            <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
            <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
            <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
            <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
            <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
            <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
            <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
            <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
            <div allowSort="true" datatype="float" field="trueEnterQty" summaryType="sum" width="60" headerAlign="center" header="已入库数量"></div>
            <div allowSort="true" datatype="float" field="notEnterQty" summaryType="sum" width="60" headerAlign="center" header="未入库数量"></div>
            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
        </div>
    </div>
</div>

