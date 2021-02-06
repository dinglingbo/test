<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>采购订单选择</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/common/pchsOrderSelect.js?v=1.0.11"></script>
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

.panelwidth{
    width: 300px;
}
.tmargin{
    margin-top: 10px;
    margin-left: 50px;
    margin-bottom: 10px;
}
.twidth{
    width:200px;
}

.vpanel{
    border:1px solid #d9dee9;
    margin:10px 0px 0px 20px;
    height:248px;
    float:left;
}
.vpanel_heading{
    border-bottom:1px solid #d9dee9;
    width:100%;
    height:28px;
    line-height:28px;
}
.vpanel_heading span{
    margin:0 0 0 20px;
    font-size:16px;
    font-weight:normal;
}
.vpanel_bodyww{
    padding : 10 10 10 10px !important

}
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">单据日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                <span class="separator"></span> 
                <input id="billStatusId" width="75px" emptyText="状态" textField="name" valueField="id" valuefromselect="true" allowInput="true" class="nui-combobox"/>
                <input id="serviceId" width="100px" emptyText="订单号" class="nui-textbox"/>
                <input id="serviceMan" name="serviceMan"  width="100px" emptyText="业务员" class="nui-combobox" textField="empName" showNullItem="true" valueField="empName" allowInput="true" emptyText="请选择..."/>
                <input id="searchGuestId" class="nui-buttonedit"
                        emptyText="请选择供应商..."
                        onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />

                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                
                <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消 </a>

                <input id="billTypeId" width="60px" emptyText="票据类型" textField="name" valueField="customid" class="nui-combobox" visible="false"/>
                <input id="settleTypeId" width="60px" emptyText="结算方式" textField="name" valueField="customid" class="nui-combobox" visible="false"/>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="mainTabs" class="nui-tabs" name="mainTabs"
            style="width:100%; height:100%;" 
            plain="true" 
            onactivechanged="ontopTabChanged">
        <div title="采购订单" id="pchsOrderTab" name="pchsOrderTab" visible="false" >
            <div class="nui-fit">
                <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                        showPager="true"
                        dataField="detailList"
                        idField="detailId"
                        ondrawcell="onDrawCell"
                        sortMode="client"
                        showModified="false"
                        url=""
                        multiSelect="true"
                        pageSize="50"
                        sizeList="[50,100,200]"
                        onshowrowdetail="onShowRowDetail"
                        showSummaryRow="true">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div type="expandcolumn" width="20" >#</div>
                        <div field="operateBtn" name="operateBtn" align="center" width="70" headerAlign="center" align="center" header="操作"></div>
                        <div field="fullName" width="150" headerAlign="center" header="供应商名称"></div>
                        <div allowSort="true" summaryType="count" field="serviceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
                        <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
                        <div field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
                        <div field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
                        <div allowSort="true" field="createDate" headerAlign="center" header="制单日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                        <div field="billStatusId" width="60" headerAlign="center" header="状态"></div>
                        <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                        <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                        <div field="remark" width="120" headerAlign="center" header="备注"></div>
            
                    </div>
                </div>
            </div>
        </div>
        <div title="供应商销售单" name="sellOrderTab" id="sellOrderTab" visible="false">
                <div class="nui-fit">
                    <div id="sellOrderGrid" class="nui-datagrid" style="width:100%;height:100%;"
                        showPager="true"
                        dataField="pjPchsOrderMainList"
                        idField="detailId"
                        ondrawcell="onSellDrawCell"
                        sortMode="client"
                        url=""
                        showModified="false"
                        multiSelect="true"
                        pageSize="50"
                        sizeList="[50,100,200]"
                        onshowrowdetail="onSellShowRowDetail"
                        showSummaryRow="true">
                       <div property="columns">
                           <div type="indexcolumn">序号</div>
                           <div type="checkcolumn" width="30"></div>
                           <div type="expandcolumn" width="20" >#</div>
                           <div field="operateBtn" name="operateBtn" align="center" width="70" headerAlign="center" align="center" header="操作"></div>
                           <div field="guestFullName" width="150" headerAlign="center" header="供应商名称"></div>
                           <div allowSort="true" summaryType="count" field="serviceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
                           <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
                           <div field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
                           <div field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
                           <div allowSort="true" field="outDate" headerAlign="center" header="出库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                           <div field="isFinished" width="60" headerAlign="center" header="状态"></div>
                           <div field="remark" width="120" headerAlign="center" header="备注"></div>
             
                       </div>
                   </div>
                </div>
        </div>   
    </div>
</div>



<div id="editFormPchsEnterDetail" style="display:none;">
    <div id="innerPchsEnterGrid" class="nui-datagrid" style="width:100%;height:150px;"
         showPager="false"
         dataField="pjPchsOrderDetailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
            <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
            <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
            <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
            <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
            <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
            <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
            <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
            <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
            <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
        </div>
    </div>
</div>

<div id="editFormSellOutDetail" style="display:none;">
        <div id="innerSellOutGrid" class="nui-datagrid" style="width:100%;height:150px;"
             showPager="false"
             dataField="pjSellOrderDetailList"
             idField="detailId"
             ondrawcell="onSellDrawCell"
             sortMode="client"
             url=""
             showSummaryRow="true">
            <div property="columns">
                <div type="indexcolumn">序号</div>
                <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码"></div>
                <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
                <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
                <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
                <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
                <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
                <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="销售单价"></div>
                <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
                <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
            </div>
        </div>
    </div>



</body>
</html>
