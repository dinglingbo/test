<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>整车采购退货</title>
<script src="<%=webPath + contextPath%>/sales/inventory/js/carSalesReturn.js?v=1.0.3"></script>
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
                
				<a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                	<li iconCls="" onclick="quickSearch()" id="type">所有</li>
                    <li iconCls="" onclick="quickSearch(12)" id="type12">草稿</li>
                    <li iconCls="" onclick="quickSearch(13)" id="type13">待发货</li>
                    <li iconCls="" onclick="quickSearch(14)" id="type14">待收货</li>
                    <li iconCls="" onclick="quickSearch(15)" id="type15">已入库</li>
                </ul> 


				<label style="font-family:Verdana;">退货日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 
                <input id="serviceId" width="120px" emptyText="订单单号" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">供应商：</label> -->
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <span class="separator"></span>

                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
<!--                 <input id="storeId"
                           name="storeId"
                           class="nui-combobox"
                           textField="name"
                           valueField="id"
                           emptyText="仓库"
                           url="" width="80"
                           valueFromSelect="true"
                           allowInput="false"
                           showNullItem="false"
                           nullItemText="请选择..."/> -->
<!--                 <input id="" name="" width="80px" emptyText="经办人" class="nui-textbox"/>
                <input id="" name="" width="80px" emptyText="组织机构" class="nui-textbox"/> -->
                <input id="" name="" width="80px" emptyText="车型名称" class="nui-textbox"/>
<!--                 <input class="nui-combobox" id="search-type" width="100px" textField="name" valueField="id" value="0" data="statusList" allowInput="false" />
	            <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="80px" onenter="search()" /> -->
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
<!--                 <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                <a class="nui-button" iconCls="" plain="true" onclick="del()" id="deletBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a>

            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
	<input class="nui-hidden" name="auditSign" id="auditSign"/>
	<input class="nui-hidden" name="billStatusId" id="billStatusId"/>
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="cssFactoryReturn"
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
            <div field="status" width="90" name = "orderMan" headerAlign="center" header="状态"></div> 
                    <div field="serviceCode" allowSort="true"  width="160" summaryType="count" headerAlign="center" header="退货单号"></div>
                    <div field="guestFullName" name="guestFullName" width="220" headerAlign="center" header="供应商"></div>                    
                    <div field="returnMen" width="90" name = "returnMen" headerAlign="center" >退货员</div>                     
                    <div allowSort="true" field="billTypeId"  name="billTypeId" width="90" headerAlign="center" header="票据类型"></div>   
                    <div allowSort="true" field="payMode" name="payMode" width="90" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="transportId" name="transportId" width="90" headerAlign="center" header="运输方式"></div>                                                                                                
                    <div field="returnAmt" allowSort="true" datatype="float" summaryType="sum"  width="60" headerAlign="center" header="退货金额"></div>
                    <div field="returnDate" allowSort="true"  width="130" headerAlign="center" header="退货日期" dateFormat="yyyy-MM-dd HH:mm" ></div>                    
                    <div field="remark" allowSort="true"  width="220" headerAlign="center" header="备注"></div>
                    <div field="recorder" width="90" name="recorder" headerAlign="center" header="创建人"></div>
                    <div field="recordDate" allowSort="true"  width="130" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm" ></div>  
                    <div field="modifier" width="90" name="modifier" headerAlign="center" header="修改人"></div>
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
           <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
	       <div field="comPartName" headerAlign="center" header="配件名称"></div>
	       <div field="comPartBrandId" id="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
	       <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
	       <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="数量"></div>
	       <div field="orderPrice" numberFormat="0.0000" width="60" headerAlign="center" header="单价"></div>
	       <div field="orderAmt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center"header="金额" ></div>
	       <div field="sellPrice" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center"header="建议售价" ></div>
		   <div field="comOemCode" width="100" headerAlign="center" allowSort="true" header="OEM码"></div>
		   <div field="comSpec" width="100" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>
	   	   <div field="comApplyCarModel" id="comApplyCarModel" width="140" headerAlign="center" header="品牌车型"></div>
		   <div field="storeId" width="100" headerAlign="center" allowSort="true" header="仓库"></div>
		   <div field="storeShelf" width="100" headerAlign="center" allowSort="true" header="仓位"></div>
		   <div field="remark" width="100" headerAlign="center" allowSort="true" header="备注"></div>
      </div>
   </div>
</div>


</body>
</html>
