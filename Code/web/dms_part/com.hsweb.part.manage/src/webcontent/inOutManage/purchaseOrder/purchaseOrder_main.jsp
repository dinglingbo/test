<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>采购订单查询</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/purchaseOrder/purchaseOrderMain.js?v=1.0.43"></script>
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

<!-- 				<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(12)">草稿</a> -->
<!-- 				<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(13)">待发货</a> -->
<!--                 <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(14)">待收货</a> -->
<!--                 <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(15)">已入库</a> -->
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
                
				<a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">草稿</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(12)" id="type12">草稿</li>
                    <li iconCls="" onclick="quickSearch(13)" id="type13">待发货</li>
                    <li iconCls="" onclick="quickSearch(14)" id="type14">待收货</li>
                    <li iconCls="" onclick="quickSearch(15)" id="type15">已入库</li>
                </ul>


				<label style="font-family:Verdana;">创建日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 

<!--                 <input id="partNameAndPY" width="100px" emptyText="配件名称/拼音" class="nui-textbox"/> -->
<!--                 <label style="font-family:Verdana;">配件编码：</label> -->
<!--                 <input id="partCode" width="100px" emptyText="配件编码" class="nui-textbox"/> -->
                <!-- <label style="font-family:Verdana;">订单单号：</label> -->
                <input id="serviceId" width="80px" emptyText="订单单号" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">供应商：</label> -->
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <span class="separator"></span>

                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
<!--                 <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>

            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="pjPchsOrderMainList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         selectOnLoad="true"
         onshowrowdetail="onShowRowDetail"
         allowCellWrap = true
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
            <div header="订单信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="serviceId" width="100" summaryType="count" headerAlign="center" header="订单单号"></div>
                    <div field="guestFullName" width="150" headerAlign="center" header="供应商"></div>
                    <div field="orderMan" width="60" headerAlign="center" header="采购员"></div>
                    <div field="billStatusId" width="60" headerAlign="center" header="状态"></div>
                    <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
                    <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="createDate" headerAlign="center" header="订货日期" dateFormat="yyyy-MM-dd H:mm"></div>
                    <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div>
                    <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>
                    <div allowSort="true" field="settType" width="60" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div> -->
                    <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
                </div>
            </div>
<!--             <div header="配件信息" headerAlign="center"> -->
<!--                 <div property="columns"> -->
<!--                     <div allowSort="true" field="comPartCode" headerAlign="center" header="配件编码"></div> -->
<!--                     <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div> -->
<!--                     <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div> -->
<!--                     <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div> -->
<!--                     <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" header="车型"></div> -->
<!--                     <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div> -->
<!--                 </div> -->
<!--             </div> -->
            <div header="数量单价" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" summaryType="sum" field="orderQty" width="60" headerAlign="center" header="订单数量"></div>
                    <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="订单单价"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="orderAmt" width="60" headerAlign="center" header="订单金额"></div>
                    <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
                </div>
            </div>
            <!-- <div header="含税信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
                    <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
                    <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
                    <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
                </div>
            </div>
            <div header="不含税信息" headerAlign="center">
                <div property="columns">
                    <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
                    <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
                </div>
            </div> -->
            <div header="其他" headerAlign="center">
                <div property="columns">
                	<!-- <div allowSort="true" datatype="float" summaryType="sum" field="trueEnterQty" width="60" headerAlign="center" header="已入库数量"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="notEnterQty" width="60" headerAlign="center" header="未入库数量"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="adjustQty" width="60" headerAlign="center" header="调整数量"></div> -->
                    <div field="creator" width="60" headerAlign="center" header="创建人"></div>
                    <div allowSort="true" field="createDate" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd H:mm"></div> 
                </div>
            </div>
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
           <div headerAlign="center" type="indexcolumn" width="20">序号</div>
           <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
	       <div field="comPartName" headerAlign="center" header="配件名称"></div>
	       <div field="comPartBrandId" id="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
	       <div field="comApplyCarModel" id="comApplyCarModel" width="140" headerAlign="center" header="车型"></div>
	       <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
	       <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="数量"></div>
	       <div field="orderPrice" numberFormat="0.0000" width="60" headerAlign="center" header="单价"></div>
	       <div field="orderAmt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center"header="金额" ></div>
		   <div field="remark" width="100" headerAlign="center" allowSort="true" header="备注"></div>
		   <div field="storeId" width="100" headerAlign="center" allowSort="true" header="仓库"></div>
		   <div field="storeShelf" width="100" headerAlign="center" allowSort="true" header="仓位"></div>
		   <div field="comOemCode" width="100" headerAlign="center" allowSort="true" header="OEM码"></div>
		   <div field="comSpec" width="100" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>
      </div>
   </div>
</div>


</body>
</html>
