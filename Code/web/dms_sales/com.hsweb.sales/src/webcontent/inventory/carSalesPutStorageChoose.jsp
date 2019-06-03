<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>整车验车</title>
<script src="<%=webPath + contextPath%>/sales/inventory/js/carSalesPutStorageChoose.js?v=1.0.3"></script>
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
				<label style="font-family:Verdana;">订货日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 
                <input id="serviceId" width="120px" emptyText="订单单号" class="nui-textbox"/>
     
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="choose()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('cancle')" id="addBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>

            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
	<input class="nui-hidden" name="auditSign" id="auditSign"/>
	<input class="nui-hidden" name="billStatusId" id="billStatusId"/>
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="pjPchsOrderMainList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         totalField="page.count"
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         selectOnLoad="true"
         onshowrowdetail="onShowRowDetail"
         allowCellWrap = true
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn" width="40">序号</div>
            <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                    <div field="serviceCode" name="serviceCode" allowSort="true"  width="160" summaryType="count" headerAlign="center" header="订单单号"></div>
                    <div field="guestFullName" name="guestFullName" width="220" headerAlign="center" header="供应商"></div>                    
                    <div allowSort="true" field="billTypeId"  name="billTypeId" width="90" headerAlign="center" header="票据类型"></div>
                    <div allowSort="true" field="payMode" name="payMode" width="90" headerAlign="center" header="结算方式"></div>
                    <div field="recordDate" allowSort="true"  width="130" headerAlign="center" header="订货日期" dateFormat="yyyy-MM-dd HH:mm" ></div>                 
                    <div field="orderTotalAmt" allowSort="true" datatype="float" summaryType="sum"  width="60" headerAlign="center" header="订单金额"></div>                                                                                                  
                    <div field="predictDeliveryDate" allowSort="true"  width="130" headerAlign="center" header="预计到货日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div field="remark" allowSort="true"  width="80" headerAlign="center" header="备注"></div>
                    <div field="recorder" width="90" name="creator" headerAlign="center" header="创建人"></div>
                    <div field="recordDate" allowSort="true"  width="130" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm" ></div>  
                    <div field="modifier" width="90" name="creator" headerAlign="center" header="修改人"></div>
                    <div field="modifyDate" allowSort="true"  width="130" headerAlign="center" header="修改日期" dateFormat="yyyy-MM-dd HH:mm" ></div>  
        </div>
    </div> 
</div>


<div id="editFormDetail" style="display:none;padding:5px;position:relative;">

   <div id="innerPartGrid"
       dataField="pjPchsOrderDetailList"
       allowCellWrap = true
       class="nui-datagrid"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
           <div headerAlign="center" type="indexcolumn" width="30">序号</div>
           <div field="code" name="code" width="120" headerAlign="center" header="车型编码"></div>
	       <div field="carModelName" headerAlign="center" width="150" header="车型名称"></div>
	       <div field="frameColorId" name="frameColorId" width="40" headerAlign="center" header="车身颜色"></div>
	       <div field="interialColorId" name="interialColorId"  headerAlign="center" header="内饰颜色"></div>
	       <div field="orderQty"  summaryType="sum" width="60" headerAlign="center" header="订货数量"></div>
	       <div field="orderPrice" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="单价"></div>
	       <div field="orderAmt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="金额"></div>
		   <div field="remark" width="220" headerAlign="center" allowSort="true" header="备注"></div>
      </div>
   </div>
</div>


</body>
</html>
