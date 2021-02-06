<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>

<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>采购入库选择</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/sellOrderOut/pchsOrderEnterSelect.js?v=1.0.3"></script>
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
                <input id="serviceId" width="100px" emptyText="单号" class="nui-textbox"/>
                <input id="serviceMan" width="50px" emptyText="业务员" class="nui-textbox"/>
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
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
            showPager="true"
            dataField="detailList"
            sortMode="client"
            multiSelect="false"
            showReloadButton="false"
            pageSize="50"
            sizeList="[50,100,200]"
            showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div type="expandcolumn" width="20" >#</div>
            <div field="guestShortName" width="150" headerAlign="center" header="供应商名称"></div>
            <div allowSort="true" summaryType="count" field="code" width="150" summaryType="count" headerAlign="center" header="单号"></div>
            <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
            <div field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
            <div field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
            <div field="remark" width="120" headerAlign="center" header="备注"></div>

        </div>
    </div>
</div>



<div id="editFormPchsEnterDetail" style="display:none;">
    <div id="innerPchsEnterGrid" class="nui-datagrid" style="width:100%;height:150px;"
            borderStyle="border:1;"
            selectOnLoad="true"
            showPager="false"
            dataField="detailList"
            sortMode="client"
            idField="id"
            allowCellSelect="true" allowCellEdit="false">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div field="comOemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
            <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
            <div allowSort="true" datatype="float" width="60" field="outableQty" name="outableQty" headerAlign="center" header="库存数量"></div>
            <div allowSort="true" datatype="float" width="60" field="preOutQty" headerAlign="center" header="待出库数量"></div>
            <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" header="库存单价"></div>
            <div field="storeId" width="60" headerAlign="center" allowSort="true" header="仓库"></div>
            <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
            <div field="partBrandId" name="partBrandId" width="60" headerAlign="center" header="品牌"></div>
            <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
            <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
            <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div> 
        </div>
    </div>
</div>



</body>
</html>
