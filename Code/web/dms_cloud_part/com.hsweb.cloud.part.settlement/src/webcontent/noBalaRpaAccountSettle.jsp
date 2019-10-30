<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-27 17:06:26
  - Description:
-->
<head>
<title>未对账业务单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/settlement/js/noBalaRpaAccountSettle.js?v=1.0.66"></script>
</head>
<body>
<div class="nui-fit">
	<div  class="nui-splitter" vertical="true" style="width:100%;height:100%;" style="border:0;" handlerSize="0">
        <div size="60%" showCollapseButton="false">
        
        	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
			    <table style="width:100%;">
			        <tr>
			            <td style="white-space:nowrap;">
			             	<label style="font-family:Verdana;">快速查询：</label>
			            	
			               
			                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本周</a>
			
			                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
			                    <li iconCls="" onclick="quickSearch(0)" id="type0">全部</li>
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
			
			                <label style="font-family:Verdana;">日期 从：</label>
			                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
			                <label style="font-family:Verdana;">至</label>
			                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
			               
			                <span class="separator"></span> 
 		                    <input id="guestName" width="120px" emptyText="客户" onEnter="onSearch()" class="nui-textbox" visible="false"/> 
							<input class="nui-combobox" id ="orgids" name="orgids" value="" allowInput="true" showNullItem="false" 
			            		 valueFromSelect="true" nullitemtext="请选择..." emptyText="选择公司" data="" width="200px"
			            		 textField="name" valueField="orgid" onEnter="onSearch()" />
			            	 <input name="settleTypeId"
                                             id="settleTypeId"
                                             class="nui-combobox width1"
                                             textField="name"
                                             valueField="customid"
                                             valueFromSelect="true"
                                             emptyText="请选择结算方式..."
                                             url=""
                                             allowInput="true"
                                             showNullItem="false"
                                             width="100px"
                                             nullItemText="请选择结算方式..."
                                             onvalidation=""/>	 
			                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
			                <a class="nui-button" iconCls="" plain="true" onclick="onPurExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出采购单</a>
			                <a class="nui-button" iconCls="" plain="true" onclick="onSellExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出销售单</a>
			                
			            </td>
			        </tr>
			    </table>
			</div>
			
			 <div id="mainGrid" class="nui-datagrid" style="width:100%;height:90%;"
		         showPager="true"
		         dataField="detailList"
		         sortMode="client"
		         ondrawcell="onMainDrawCell"
		         showReloadButton="false"
		         pageSize="50" 
		         multiSelect="false"				
				 totalField="total"
		         pageSize="50"
		         selectOnLoad="true"
		         onrowclick="onMainGridClick"
		         showSummaryRow="true"
		         ondrawsummarycell="onDrawSummaryCell(e)"
		         sizeList="[50,100,200]">
		        <div property="columns">
		            <div type="indexcolumn"  width="10">序号</div>
		            <div field="fullName" width="120" headerAlign="center" header="往来单位"></div>
		            <div field="purchaseEnterAmt" width="55px" headerAlign="center" allowSort="true" header="采购入库金额"summaryType="sum"datatype="float" numberFormat="0.00" visible=""></div>
		            <div field="purchaseRtnAmt" width="55px" headerAlign="center" allowSort="true" header="采购退货金额"summaryType="sum"datatype="float" numberFormat="0.00" visible=""></div>
		            <div field="sellOutAmt" width="55px" headerAlign="center" allowSort="true" header="销售出库金额"summaryType="sum"datatype="float" numberFormat="0.00" visible=""></div>
		            <div field="sellRtnAmt" width="55px" headerAlign="center" allowSort="true" header="销售退货金额"summaryType="sum"datatype="float" numberFormat="0.00" visible=""></div>
		            <div field="allotApplyAmt" width="55px" headerAlign="center" allowSort="true" header="调拨入库金额"summaryType="sum"datatype="float" numberFormat="0.00" visible=""></div>
		            <div field="allotInRtnAmt" width="55px" headerAlign="center" allowSort="true" header="调入退货金额"summaryType="sum"datatype="float" numberFormat="0.00" visible=""></div>
		            <div field="allotAcceptAmt" width="55px" headerAlign="center" allowSort="true" header="调拨出库金额"summaryType="sum"datatype="float" numberFormat="0.00" visible=""></div>  
		            <div field="allotOutRtnAmt" width="55px" headerAlign="center" allowSort="true" header="调出退货金额"summaryType="sum"datatype="float" numberFormat="0.00" visible=""></div>    
		            <div field="rAmt" width="55px" headerAlign="center" allowSort="true" header="应收金额"summaryType="sum"datatype="float" numberFormat="0.00" visible="false"></div>
		            <div field="pAmt" width="55px" headerAlign="center" allowSort="true" header="应付金额" summaryType="sum" datatype="" numberFormat="0.00"  visible="false"></div>
		            <div field="billAmt" width="55px" headerAlign="center" allowSort="true" header="未对账金额" summaryType="sum" datatype="float" numberFormat="0.00"></div>
		        </div>
		     </div>
			
        </div>
        
        <div size="40%" showCollapseButton="false">
        
        	<div class="nui-fit">
        	
        	 <div id="mainTabs" class="nui-tabs" name="mainTabs"
                    activeIndex="0" 
                    style="width:100%; height:100%;" 
                    plain="false" 
                    onactivechanged="">
                
                <!-- 1 -->
                  <div title="采购入库" id="purEnterTab" name="purEnterTab"receiveTab"" url="" >
                
                	<div id="purEnterGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="detailList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="true">
				        <div property="columns">
				            <div type="indexcolumn">序号</div>
				            <div allowSort="true" field="serviceId" width="180" summaryType="count" headerAlign="center" header="订单单号"></div>
				            <div field="guestFullName" width="150" headerAlign="center" header="供应商"></div>
				            <div allowSort="true" width="150"field="enterDate" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div> 
				            <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>-->
				            <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
				            <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
				            <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
				            <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
				            <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
				            <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
				            <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
				            <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可出库数量"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="采购员"></div>
				            <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
				         <!--   <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
				            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
				            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
				            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
				            <div field="noTaxPrice" width="80" headerAlign="center" header="不含税单价"></div>
				            <div field="noTaxAmt" width="80" headerAlign="center" summaryType="sum" header="不含税金额"></div>-->
				            <div allowSort="true" field="manualCode" width="180" headerAlign="center" header="手工单号"></div>
				            <div field="auditor" width="80" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" width="120"field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				        </div>
				    </div>
                      
                </div> 
                    
                 <!-- 3 -->
                <div title="采购退货" id="purRtnTab" name="purRtnTab" url="" >
               	                	
                      <div id="purRtnGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="detailList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 multiSelect="true"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="true">
				        <div property="columns">
				            <div type="indexcolumn">序号</div>
				          <!--  <div type="checkcolumn" width="20"></div>-->
				            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="订单单号"></div>
				            <div field="guestFullName" width="150" headerAlign="center" header="客户"></div>
				            <div allowSort="true" field="outDate" headerAlign="center" header="出库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div> 
				            <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>-->
				            <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
				            <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
				            <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
				            <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
				            <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
				            <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="单价"></div>
				            <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="销售员"></div>
				            <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
				            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            
				        </div>
				    </div>
                	
                	
                </div>
                
                 <!-- 2 -->
                <div title="销售出库" id="sellOutTab" name="sellOutTab"receiveTab"" url="" >
                
                	<div id="sellOutGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="detailList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="true">
		               <div property="columns">
				            <div type="indexcolumn">序号</div>
				          <!--  <div type="checkcolumn" width="20"></div>-->
				            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="订单单号"></div>
				            <div field="guestFullName" width="150" headerAlign="center" header="客户"></div>
				            <div allowSort="true" field="outDate" headerAlign="center" header="出库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div> 
				            <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>-->
				            <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
				            <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
				            <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
				            <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
				            <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
				            <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="单价"></div>
				            <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="销售员"></div>
				            <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
				            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            
				        </div>
				    </div>
                      
                </div>
                
                <!-- 4 -->
                <div title="销售退货" id="sellRtnrTab" name="sellRtnrTab"receiveTab"" url="" >
                
                	<div id="sellRtnGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="detailList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="true">
				        <div property="columns">
				            <div type="indexcolumn">序号</div>
				            <div allowSort="true" field="serviceId" width="180" summaryType="count" headerAlign="center" header="订单单号"></div>
				            <div field="guestFullName" width="150" headerAlign="center" header="供应商"></div>
				            <div allowSort="true" width="150"field="enterDate" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div> 
				            <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>-->
				            <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
				            <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
				            <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
				            <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
				            <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
				            <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
				            <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
				            <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可出库数量"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="采购员"></div>
				            <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
				         <!--   <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
				            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
				            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
				            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
				            <div field="noTaxPrice" width="80" headerAlign="center" header="不含税单价"></div>
				            <div field="noTaxAmt" width="80" headerAlign="center" summaryType="sum" header="不含税金额"></div>-->
				            <div allowSort="true" field="manualCode" width="180" headerAlign="center" header="手工单号"></div>
				            <div field="auditor" width="80" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" width="120"field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				        </div>
				    </div>
                      
                </div>
                
                <!-- 5 -->
                <div title="调拨入库" id="allotApplyTab" name="allotApplyTab" url="" >
               	                	
                      <div id="allotApplyGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="pjAllotApplyDetails"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="true">
				        <div property="columns">
				            <div type="indexcolumn">序号</div>
				            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="订单单号"></div>
				            <div field="orgName" width="150" headerAlign="center" header="调出方"></div>
				            <div allowSort="true" field="finishDate" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <div allowSort="true" field="systemUnitId" width="40" headerAlign="center" header="单位"></div>		
		                	<div allowSort="true" datatype="float" summaryType="sum" field="hasInQty" width="60" headerAlign="center" header="数量"  visible="true"></div>
		                	<div allowSort="true" datatype="float" summaryType="sum" field="orderPrice" width="60" headerAlign="center" header="单价" visible="true"></div>
		                	<div allowSort="true" datatype="float" summaryType="sum" field="orderAmt" width="60" headerAlign="center" header="金额" visible="true"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
				            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
				            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            
				        </div>
				    </div>
                	
                	
                </div> 
                
                <!-- 8 -->
                <div title="调入退货" id="allotInRtnTab" name="allotInRtnTab" url="" >
               	                	
                      <div id="allotInRtnGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="pjAllotAcceptMainList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 multiSelect="true"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="true">
				        <div property="columns">
				            <div type="indexcolumn">序号</div>
				           <!-- <div type="checkcolumn" width="20"></div>-->
				            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="订单单号"></div>
				            <div field="orgName" width="150" headerAlign="center" header="调入方"></div>
				            <div allowSort="true" field="finishDate" headerAlign="center" header="出库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <div allowSort="true" field="systemUnitId" width="40" headerAlign="center" header="单位"></div>
				            <div allowSort="true" datatype="float" summaryType="sum" field="hasOutQty" width="60" headerAlign="center" header="数量" visible="true"></div>
                			<div allowSort="true" datatype="float" summaryType="sum" field="orderPrice" width="60" headerAlign="center" header="单价" visible="true"></div>
                			<div allowSort="true" datatype="float" summaryType="sum" field="orderAmt" width="60" headerAlign="center" header="金额" visible="true"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
				            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
				            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            
				        </div>
				    </div>
                	
                	
                </div>
                
                <!--6 -->
                <div title="调拨出库" id="allotAcceptTab" name="allotAcceptTab" url="" >
               	                	
                      <div id="allotAcceptGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="pjAllotAcceptMainList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 multiSelect="true"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="true">
				        <div property="columns">
				            <div type="indexcolumn">序号</div>
				           <!-- <div type="checkcolumn" width="20"></div>-->
				            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="订单单号"></div>
				            <div field="orgName" width="150" headerAlign="center" header="调入方"></div>
				            <div allowSort="true" field="finishDate" headerAlign="center" header="出库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <div allowSort="true" field="systemUnitId" width="40" headerAlign="center" header="单位"></div>
				            <div allowSort="true" datatype="float" summaryType="sum" field="hasOutQty" width="60" headerAlign="center" header="数量" visible="true"></div>
                			<div allowSort="true" datatype="float" summaryType="sum" field="orderPrice" width="60" headerAlign="center" header="单价" visible="true"></div>
                			<div allowSort="true" datatype="float" summaryType="sum" field="orderAmt" width="60" headerAlign="center" header="金额" visible="true"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
				            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
				            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            
				        </div>
				    </div>
                	
                	
                </div>
                
                 <!--7 -->
                <div title="调出退货" id="allotOuRtnTab" name="allotOuRtnTab" url="" >
               	                	
                      <div id="allotOutRtnGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="pjAllotApplyDetails"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="true">
				        <div property="columns">
				            <div type="indexcolumn">序号</div>
				            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="订单单号"></div>
				            <div field="orgName" width="150" headerAlign="center" header="调出方"></div>
				            <div allowSort="true" field="finishDate" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <div allowSort="true" field="systemUnitId" width="40" headerAlign="center" header="单位"></div>		
		                	<div allowSort="true" datatype="float" summaryType="sum" field="hasInQty" width="60" headerAlign="center" header="数量"  visible="true"></div>
		                	<div allowSort="true" datatype="float" summaryType="sum" field="orderPrice" width="60" headerAlign="center" header="单价" visible="true"></div>
		                	<div allowSort="true" datatype="float" summaryType="sum" field="orderAmt" width="60" headerAlign="center" header="金额" visible="true"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
				            <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
				            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            
				        </div>
				    </div>
                	
                	
                </div>
                
                
                
             </div>
           </div>
             
      </div>
</div>

<!-- 销售 -->
<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
      
        <tr>  
            <td colspan="1" align="center">客户/供应商名称</td>
            <td colspan="1" align="center">公司编号</td>
            <td colspan="1" align="center">厂牌</td>
            <td colspan="1" align="center">审核单号</td>
            <td colspan="1" align="center">审核日期</td>
            <td colspan="1" align="center">零件编码</td>
            <td colspan="1" align="center">零件名</td>
            <td colspan="1" align="center">数量</td>
            <td colspan="1" align="center">单价</td>
            <td colspan="1" align="center">金额</td>
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div>  


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>