<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-29 10:34:16
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/settlement/js/statementDetails.js?v=1.0.42"></script>
    
</head>
<body>
<div id="mainTabs" class="nui-tabs" name="mainTabs"
   activeIndex="0" 
   style="width:100%; height:100%;" 
   plain="false" 
   onactivechanged="ontopTabChanged">
          
  <div title="对账单主" id="billMainTab" name="billMainTab" url="" >
             	 
  </div>
          
  <div title="对账单明细" name="billDetailTab" url="" >
 		
 		<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		    <table style="width:100%;">
		        <tr>
		            <td style="white-space:nowrap;">
		            	<input name="billTypeId" visible="false"
		                     id="billTypeId"
		                     class="nui-combobox width1"
		                     textField="name"
		                     valueField="customid"
		                     enabled="false"
		                     valuefromselect="true"
		                     allowInput="true"
		                     selectOnFocus="true"
		                     showNullItem="false"
		                     width="100%"/>
		              <input name="settleTypeId" visible="false"
		                     id="settleTypeId"
		                     class="nui-combobox width1"
		                     textField="name"
		                     valueField="customid"
		                     enabled="false"
		                     valuefromselect="true"
		                     allowInput="true"
		                     selectOnFocus="true"
		                     showNullItem="false"
		                     width="100%"/>
		        
		            	
		                <label style="font-family:Verdana;">快速查询：</label>
		                
		                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本周</a>
		
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
		                    <li iconCls="" onclick="quickSearch(6)" id="type10">本年</li>
		                    <li iconCls="" onclick="quickSearch(7)" id="type11">上年</li>
		                </ul>
						<label style="font-family:Verdana;">日期 从：</label>
		                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
		                <label style="font-family:Verdana;">至</label>
		            	<input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>			               
				        <span class="separator"></span> 
				        <input class="nui-combobox" id ="orgids" name="orgids" value="" allowInput="true" showNullItem="false" 
					            		 valueFromSelect="true" nullitemtext="请选择..." emptyText="选择公司" data="" width="200px"
					            		 textField="name" valueField="orgid" onenter="onSearch()" />
					            		 
		 		        <input id="guestName" width="120px" emptyText="客户" class="nui-textbox" onenter="onSearch()"/> 
		                
		                <a class="nui-button" iconCls="" plain="true" visible="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		         
		            </td>
		            <td style="width:100%;">
		
		                <span class="separator"></span>
		                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="printBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
		           
		            </td>
		        </tr>
		    </table>
		</div>
		
		<div class="nui-fit">
		
			<div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
		           showPager="true"
		           totalField="page.count"
				   pageSize="100"
				   sizeList=[100,200,500,1000]
		           dataField="detailList"
		           idField="id"
		           showSummaryRow="true"
		           ondrawcell="onRightGridDraw"
		           allowCellSelect="true"
		           allowCellEdit="false"
		           oncellcommitedit=""
		           ondrawsummarycell=""
		           onselectionchanged=""
		           oncellbeginedit=""
		           showModified="false"
		           multiSelect="true"
		           editNextOnEnterKey="true"
		           onshowrowdetail="onShowRowDetail"
		           url="">
		          <div property="columns">
		              <div type="indexcolumn">序号</div>
		              <div type="checkcolumn" width="20"></div>
		              <div type="expandcolumn" width="20" >#</div>
		              <div field="guestId" width="60" headerAlign="center" header="客户ID" visible="false"></div>
		              <div field="guestName" width="60" headerAlign="center" header="客户名称" visible="true"></div>
		              <div allowSort="true" field="serviceId" width="150"  headerAlign="center" header="对账单号"></div>
		              <div field="typeCode" width="60" headerAlign="center" header="业务类型"></div>
		              <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div>
		              <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
		              <div allowSort="true" field="billDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
		              <div field="remark" width="120" headerAlign="center" header="备注"></div>
		              <div allowSort="true" summaryType="count" field="billServiceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
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
		              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
		              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
		              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
		              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
		              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
		              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
		              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
		              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
		              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
		          </div>
		      </div>
		  </div>
		
		  <div id="editFormPchsRtnDetail" style="display:none;">
		      <div id="innerPchsRtnGrid" class="nui-datagrid" style="width:100%;height:150px;"
		           showPager="false"
		           dataField="pjSellOrderDetailList"
		           idField="detailId"
		           ondrawcell="onDrawCell"
		           sortMode="client"
		           url=""
		           showSummaryRow="true">
		          <div property="columns">
		              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
		              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
		              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
		              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
		              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
		              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
		              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
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
		           ondrawcell="onDrawCell"
		           sortMode="client"
		           url=""
		           showSummaryRow="true">
		          <div property="columns">
		              <div type="indexcolumn">序号</div>
		              <div allowSort="true" field="showPartCode" width="60" headerAlign="center" header="配件编码"></div>
		              <div allowSort="true" field="showFullName" headerAlign="center" header="配件名称"></div>
		              <div allowSort="true" field="showOemCode" headerAlign="center" header="OE码"></div>
		              <div allowSort="true" field="showBrandName" width="60" headerAlign="center" header="品牌"></div>
		              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></di
		              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
		              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
		              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
		              <div allowSort="true" datatype="float" field="showPrice" width="60" headerAlign="center" header="销售单价"></div>
		              <div allowSort="true" datatype="float" field="showAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
		              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
		        
		          </div>
		      </div>
		  </div>
		
		  <div id="editFormAllotAcceptDetail" style="display:none;">
		      <div id="innerAllotAcceptGrid" class="nui-datagrid" style="width:100%;height:150px;"
		           showPager="false"
		           dataField="pjAllotAcceptMainList"
		           idField="detailId"
		           ondrawcell="onDrawCell"
		           sortMode="client"
		           url=""
		           showSummaryRow="true">
		          <div property="columns">
		              <div type="indexcolumn">序号</div>
		              <div allowSort="true" field="partCode" width="60" headerAlign="center" header="配件编码"></div>
		              <div allowSort="true" field="partName" headerAlign="center" header="配件名称"></div>
		              <div allowSort="true" field="oemCode" headerAlign="center" header="OE码"></div>
		              <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
		              <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" header="品牌车型"></di
		              <div allowSort="true" field="systemUnitId" width="40" headerAlign="center" header="单位"></div>
		              <div allowSort="true" datatype="float" field="acceptQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
		              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
		              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
		              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
		        
		          </div>
		      </div>
		  </div>
			
		  <div id="editFormAllotApplyDetail" style="display:none;">
		      <div id="innerAllotApplyGrid" class="nui-datagrid" style="width:100%;height:150px;"
		           showPager="false"
		           dataField="pjAllotApplyDetails"
		           idField="detailId"
		           ondrawcell="onDrawCell"
		           sortMode="client"
		           url=""
		           showSummaryRow="true">
		          <div property="columns">
		              <div type="indexcolumn">序号</div>
		              <div allowSort="true" field="partCode" width="60" headerAlign="center" header="配件编码"></div>
		              <div allowSort="true" field="partName" headerAlign="center" header="配件名称"></div>
		              <div allowSort="true" field="oemCode" headerAlign="center" header="OE码"></div>
		              <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
		              <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" header="品牌车型"></di
		              <div allowSort="true" field="systemUnitId" width="40" headerAlign="center" header="单位"></div>
		              <div allowSort="true" datatype="float" field="applyQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
		              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
		              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
		              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
		        
		          </div>
		      </div>
		  </div>
			
			
		<div id="exportDiv" style="display:none">  
		    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
		        
		              
		        <tbody id="tableExportContent">
		        </tbody>
		    </table>  
		    <a href="" id="tableExportA"></a>
		</div> 
 			
 	</div>
 	   
</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>