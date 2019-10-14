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
<title>物流订单查询</title>
<script src="<%=webPath + contextPath%>/purchase/js/packOut/packQuery.js?v=1.0.29"></script>
   
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

<input name="billTypeId"id="billTypeId"  visible="false"class="nui-combobox" />
<input name="settleTypeId" id="settleTypeId"  visible="false" class="nui-combobox"/>
<input name="payType" id="payType"  visible="false" class="nui-combobox"/>
<div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
    <!-- 上 -->
    <div size="60%" showCollapseButton="false">
     <div class="nui-fit">
     
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
<!--                     <li class="separator"></li> -->
<!--                     <li iconCls="" onclick="quickSearch(6)" id="type10">本年</li> -->
<!--                     <li iconCls="" onclick="quickSearch(7)" id="type11">上年</li> -->
                </ul>
                
                <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                	<li iconCls="" onclick="quickSearch(8)" id="type8">所有</li>
                    <li iconCls="" onclick="quickSearch(9)" id="type9">已打包</li>
                    <li iconCls="" onclick="quickSearch(10)" id="type10">已发货</li>
                    <li iconCls="" onclick="quickSearch(11)" id="type11">已到货</li>
              

                </ul>


				<label style="font-family:Verdana;">打包日期 从：</label>
                <input class="nui-datepicker" id="startDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 

                <input id="serviceId" width="160px" emptyText="打包单号" class="nui-textbox"/>
                <input id="billServiceId" width="160px" emptyText="销售单号" class="nui-textbox"/>
				<input id="guestName" width="120px" emptyText="客户名称" class="nui-textbox"/>


                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>


            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
	<input class="nui-hidden" name="auditSign" id="auditSign"/>
	<input class="nui-hidden" name="billStatusId" id="billStatusId"/>
    <div id="packGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="list"
         idField="detailId"
         sortMode="client"
         url=""
         totalField="page.count"
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         selectOnLoad="true"
         ondrawcell="onPackGridDrawCell"
         onshowrowdetail="onShowRowDetail"
         allowCellWrap = true
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
            <div header="订单信息" headerAlign="center">
                <div property="columns">
                	<div field="billStatusId" width="90" name = "billStatusId" headerAlign="center" header="状态"></div>
                    <div allowSort="true" field="serviceId" width="160" summaryType="count" headerAlign="center" header="打包单号"></div>
                    <div allowSort="true" field="logisticsNo" width="160" summaryType="count" headerAlign="center" header="物流单号"></div>
                    <div allowSort="true" field="logisticsName" width="160" summaryType="count" headerAlign="center" header="物流公司"></div>
                    <div allowSort="true" field="destinationStation" width="80" summaryType="count" headerAlign="center" header="目的站"></div>
                    <div allowSort="true" field="receiveMan" width="80" summaryType="count" headerAlign="center" header="收货人"></div>
                    <div field="guestName" name="guestName" width="120" headerAlign="center" header="客户"></div>
                    <div field="packMan" width="90" name = "packMan" headerAlign="center" header="发货员"></div>
                    <div allowSort="true" field="payType"  name="payType" width="90" headerAlign="center" header="付款方式"></div>
                    <div allowSort="true" field="settleTypeId" name="settleTypeId" width="90" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="createDate" width="130" headerAlign="center" header="打包日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                </div>
            </div>

            <div header="数量金额" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" summaryType="sum" field="packItem" width="60" headerAlign="center" header="总包数"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="packPayAmt" width="60" headerAlign="center" header="运费"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="collectMoney" width="60" headerAlign="center" header="代收货款"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="valuationStatement" width="60" headerAlign="center" header="保价声明"></div>
                </div>
            </div>
    
            <div header="其他" headerAlign="center">
                <div property="columns">

                    <div allowSort="true" field="detailRemark" width="80" headerAlign="center" header="备注"></div>
                    <div field="creator" width="90" name="creator" headerAlign="center" header="创建人"></div>
                    <div allowSort="true" field="createDate" width="130" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm" ></div>
                    <div allowSort="true" field="auditDate" width="130" headerAlign="center" header="发货日期" dateFormat="yyyy-MM-dd HH:mm" ></div>  
                    <div allowSort="true" field="arriveDate" width="130" headerAlign="center" header="到货日期" dateFormat="yyyy-MM-dd HH:mm" ></div>   
                    <div field="operator" width="60"  name="operator" headerAlign="center" header="修改人"></div>
                    <div allowSort="true" field="operateDate" width="130" headerAlign="center" header="修改日期" dateFormat="yyyy-MM-dd HH:mm" ></div> 
                </div>
            </div>
        </div>
    </div> 
</div>

<div id="editFormDetail" style="display:none;padding:5px;position:relative;">

   <div id="innerGrid"
       dataField="detailList"
       allowCellWrap = true
       class="nui-datagrid"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
          <div type="indexcolumn">序号</div>
          <div allowSort="true" summaryType="count" field="billServiceId" width="150" summaryType="count" headerAlign="center" header="销售单号"></div>
          <div field="orderMan" width="60" headerAlign="center" header="业务员"></div><!-- 
          <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div> -->
          <div allowSort="true" width="120" field="billDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
          <div field="remark" width="120" headerAlign="center" header="备注"></div>
      </div>
   </div>
</div>

</div>
</div>

<div showCollapseButton="false">
	 <div class="nui-fit">
           <div id="detailGrid" class="nui-datagrid" style="width:100%;height:100%;"
	               showPager="false"
	               dataField="pjSellOrderDetailList"
	               idField="id"
	               showSummaryRow="true"
	               ondrawcell="onDetailGridDrawCell"
	               allowCellSelect="true"
	               allowCellEdit="true"
	               ondrawsummarycell=""
	               showModified="false"
	               editNextOnEnterKey="true"
	               url="">
	              <div property="columns">
	                  <div type="indexcolumn">序号</div>
		                  <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码"></div>
			              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
			              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
			              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
			              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
			              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
			              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
			              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
			              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="销售单价"></div>
			              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
			              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
	          </div>
	          
	 </div>
</div>

</div>
</body>
</html>
