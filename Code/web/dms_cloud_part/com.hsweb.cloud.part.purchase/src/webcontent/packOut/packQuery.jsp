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
<script src="<%=webPath + contextPath%>/purchase/js/packOut/packQuery.js?v=1.0.78"></script>
   
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


<div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
    <!-- 上 -->
    <div size="60%" showCollapseButton="false">
     <div class="nui-fit">
     
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
                
				<a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                	<li iconCls="" onclick="quickSearch()" id="type">所有</li>
                    <li iconCls="" onclick="quickSearch(12)" id="type12">草稿</li>
                    <li iconCls="" onclick="quickSearch(13)" id="type13">待发货</li>
                    <li iconCls="" onclick="quickSearch(14)" id="type14">待收货</li>
                    <li iconCls="" onclick="quickSearch(15)" id="type15">已入库</li>
                </ul>


				<label style="font-family:Verdana;">打包日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 

                <input id="serviceId" width="120px" emptyText="订单单号" class="nui-textbox"/>

                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />

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
            <div type="indexcolumn">序号</div>
            <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
            <div header="订单信息" headerAlign="center">
                <div property="columns">
                	<div field="billStatusId" width="90" name = "billStatusId" headerAlign="center" header="状态"></div>
                    <div allowSort="true" field="serviceId" width="160" summaryType="count" headerAlign="center" header="订单单号"></div>
                    <div field="guestName" name="guestName" width="220" headerAlign="center" header="客户"></div>
                    <div field="packMan" width="90" name = "packMan" headerAlign="center" header="发货员"></div>
                    <div allowSort="true" field="payType"  name="payType" width="90" headerAlign="center" header="付款方式"></div>
                    <div allowSort="true" field="settleTypeId" name="settleTypeId" width="90" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="createDate" width="130" headerAlign="center" header="订货日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                </div>
            </div>

            <div header="数量金额" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" summaryType="sum" field="packItem" width="60" headerAlign="center" header="总包数"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="orderAmt" width="60" headerAlign="center" header="代收货款"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="orderAmt" width="60" headerAlign="center" header="保价声明"></div>
                </div>
            </div>
    
            <div header="其他" headerAlign="center">
                <div property="columns">

                    <div allowSort="true" field="detailRemark" width="80" headerAlign="center" header="备注"></div>
                    <div field="creator" width="90" name="creator" headerAlign="center" header="创建人"></div>
                    <div allowSort="true" field="createDate" width="130" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm" ></div>
                    <div field="operator" width="60"  name="operator" headerAlign="center" header="修改人"></div>
                    <div allowSort="true" field="operateDate" width="130" headerAlign="center" header="修改日期" dateFormat="yyyy-MM-dd HH:mm" ></div>  
                </div>
            </div>
        </div>
    </div> 
</div>

<div id="editFormDetail" style="display:none;padding:5px;position:relative;">

   <div id="innerGrid"
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
		   <div field="comOemCode" width="100" headerAlign="center" allowSort="true" header="OEM码"></div>
		   <div field="comSpec" width="100" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>
	   	   <div field="comApplyCarModel" id="comApplyCarModel" width="140" headerAlign="center" header="品牌车型"></div>
		   <div field="storeId" width="100" headerAlign="center" allowSort="true" header="仓库"></div>
		   <div field="storeShelf" width="100" headerAlign="center" allowSort="true" header="仓位"></div>
		   <div field="remark" width="100" headerAlign="center" allowSort="true" header="备注"></div>
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
	               frozenStartColumn="0"
	               frozenEndColumn="10"
	               ondrawcell="onRightGridDraw"
	               allowCellSelect="true"
	               allowCellEdit="true"
	               oncellcommitedit="onCellCommitEdit"
	               oncelleditenter="onCellEditEnter"
	               ondrawsummarycell=""
	               onselectionchanged=""
	               oncellbeginedit="OnrpMainGridCellBeginEdit"
	               showModified="false"
	               editNextOnEnterKey="true"
	               url="">
	              <div property="columns">
	                  <div type="indexcolumn">序号</div>
	                  <div header="配件信息" headerAlign="center">
	                      <div property="columns">
	                          <div field="operateBtn" name="operateBtn" width="50" headerAlign="center" header="操作" align="center"></div>
	                          <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码">
	                              <input property="editor" class="nui-textbox" />
	                          </div>
	                          <div field="comPartName" headerAlign="center" header="配件名称"></div>
	                          <div field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
	                          <div field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
	                          <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
	                      </div>
	                  </div>
	                  <div header="数量金额信息" headerAlign="center">
	                      <div property="columns">
	                          <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="数量">
	                              <input property="editor" vtype="float" class="nui-textbox"/>
	                          </div>
	                          <div field="orderPrice" numberFormat="0.0000" width="50" headerAlign="center" header="单价">
	                              <input property="editor" vtype="float" class="nui-textbox"/>
	                          </div>
	                          <div field="orderAmt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="金额">
	                              <input property="editor" vtype="float" class="nui-textbox"/>
	                          </div>
	                          <div field="remark" width="80" headerAlign="center" allowSort="true">
	                          备注<input property="editor" class="nui-textbox"/>
	                          </div>
	                      </div>
	                  </div>
	                  <div header="辅助信息" headerAlign="center">
	                      <div property="columns">
	                          <div type="comboboxcolumn" field="storeId" width="60" headerAlign="center" allowSort="true">
	                          仓库<input  property="editor" enabled="true" name="storehouse" dataField="storehouse" class="nui-combobox" valueField="id" textField="name" 
	                                  url="" data="storehouse"
	                                  onvaluechanged="" emptyText=""  vtype="required"
	                                  /> 
	                          </div>  
	                           <div field="storeShelf" width="60" headerAlign="center" allowSort="true">
	                          		仓位<input property="editor" class="nui-textbox"/>
	                          </div>  
	                          <div field="stockOutQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="缺货数量">
	                          </div>
	                          <div type="checkboxcolumn" field="isMarkBatch" trueValue="1" falseValue="0" width="40" headerAlign="center" header="批次">
	                          </div>
	                          <div field="occupyQty" visible="false" width="60" headerAlign="center" allowSort="true" header="占用数量"></div>
	                          <div field="comOemCode" width="60" headerAlign="center" allowSort="true" header="OEM码"></div>   
	                          <div field="comSpec" width="100" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>                                                        
	                      </div>
	                  </div>
	              </div>
	          </div>
	          
	 </div>
</div>

</div>
</body>
</html>
