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
<title>采购订单选择</title>
<script src="<%=webPath + cloudPartDomain%>/purchase/js/purchaseEnter/pchsOrderSelect.js?v=1.0.0"></script>
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
                <label style="font-family:Verdana;">制单日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                <span class="separator"></span> 
                <input id="serviceId" width="120px" emptyText="业务单号" class="nui-textbox"/>
                <input id="serviceMan" width="60px" emptyText="业务员" class="nui-textbox"/>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择往来单位..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />

                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                
                <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;关闭 </a>
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
         multiSelect="true"
         pageSize="50"
         sizeList="[50,100,200]"
         onshowrowdetail="onShowRowDetail"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div type="expandcolumn" width="20" >#</div>
            <div field="fullName" width="150" headerAlign="center" header="往来单位名称"></div>
            <div allowSort="true" summaryType="count" field="serviceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
            <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
            <div allowSort="true" field="createDate" headerAlign="center" header="制单日期" dateFormat="yyyy-MM-dd H:mm:ss"></div>
            <div field="auditSign" width="60" headerAlign="center" header="审核状态"></div>
            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd H:mm:ss"></div>
            <div field="remark" width="120" headerAlign="center" header="备注"></div>

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
            <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="车型"></div>
            <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
            <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
            <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
            <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
            <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
            <div allowSort="true" datatype="float" field="trueEnterQty" summaryType="sum" width="60" headerAlign="center" header="已入库数量"></div>
            <div allowSort="true" datatype="float" field="notEnterQty" summaryType="sum" width="60" headerAlign="center" header="未入库数量"></div>
            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
            <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
            <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
            <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
            <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div>
        </div>
    </div>
</div>




</body>
</html>
