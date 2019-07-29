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
<title>客户回款报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/report/js/guestReceive.js?v=1.0.62"></script>
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
			            	<input class="nui-combobox" id ="orgids" name="orgids" value="" allowInput="true" showNullItem="false" 
			            		 valueFromSelect="true" nullitemtext="请选择..." emptyText="选择公司" data="" width="200px"
			            		 textField="name" valueField="orgid" onEnter="onSearch()" />
			               
			                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">全部</a>
			
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
 		                    <input id="guestName" width="120px" emptyText="客户" onEnter="onSearch()" class="nui-textbox"/> 
	
			                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
			                
			            </td>
			        </tr>
			    </table>
			</div>
			
			 <div id="mainGrid" class="nui-datagrid" style="width:100%;height:92%;"
		         showPager="true"
		         dataField="list"
		         sortMode="client"
		         showReloadButton="false"
		         pageSize="50" 
		         multiSelect="false"				
				 totalField="page.count"
		         pageSize="50"
		         sizeList="[50,100,200]">
		        <div property="columns">
		            <div type="indexcolumn">序号</div>
		            <div field="guestName" width="120" headerAlign="center" header="客户"></div>
		            <div field="rAmt" width="55px" headerAlign="center" allowSort="true" header="应收金额"></div>
		            <div field="pAmt" width="55px" headerAlign="center" allowSort="true" header="应付金额"></div>
		            <div field="rpAmt" width="55px" headerAlign="center" allowSort="true" header="对账金额"></div>
		            <div field="voidAmt" width="55px" headerAlign="center" allowSort="true" header="优惠金额"></div>
		            <div field="trueRpAmt" width="55px" headerAlign="center" allowSort="true" header="应结金额"></div>
		            <div field="receiveAmt" width="55px" headerAlign="center" allowSort="true" header="回款金额"></div>
		            <div field="dueAmt" width="55px" headerAlign="center" allowSort="true" header="欠款金额"></div>
		            <div field="receiveRate" width="55px" headerAlign="center" allowSort="true" header="回款率%"></div>
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
                <div title="应收" id="receiveTab" name="receiveTab" url="" >
               	                	
                      <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="detailList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="false">
				        <div property="columns">
				            <div type="indexcolumn">序号</div>
				            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="销售单号"></div>
				            <div field="guestFullName" width="150" headerAlign="center" header="客户"></div>
				            <div allowSort="true" field="outDate" headerAlign="center" header="出库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div> 
				            <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>-->
				            <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
				            <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
				            <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
				            <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
				            <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
				            <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="销售单价"></div>
				            <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="销售员"></div>
				            <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
				            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            
				        </div>
				    </div>
                	
                	
                </div>
                <div title="应付" id="payTab" name=""receiveTab"" url="" >
                
                	<div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="detailList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
						 pageSize="100"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="false">
				        <div property="columns">
				            <div type="indexcolumn">序号</div>
				            <div allowSort="true" field="serviceId" width="150" summaryType="count" headerAlign="center" header="采购单号"></div>
				            <div field="guestFullName" width="150" headerAlign="center" header="供应商"></div>
				            <div allowSort="true" field="enterDate" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				            <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div> 
				            <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>-->
				            <div allowSort="true" field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
				            <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
				            <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
				            <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
				            <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="采购数量"></div>
				            <div allowSort="true" datatype="float" field="enterPrice" width="60" headerAlign="center" header="采购单价"></div>
				            <div allowSort="true" datatype="float" field="enterAmt" summaryType="sum" width="60" headerAlign="center" header="采购金额"></div>
				            <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可出库数量"></div>
				            <div field="orderMan" width="60" headerAlign="center" header="采购员"></div>
				            <div allowSort="true" field="detailRemark" width="60" headerAlign="center" header="备注"></div>
				            <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
				            <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
				            <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
				            <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
				            <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
				            <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
				            <div allowSort="true" field="manualCode" width="150" headerAlign="center" header="手工单号"></div>
				            <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
				            <div allowSort="true" field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				        </div>
				    </div>
                      
                </div>
                
             </div>
           </div>
             
      </div>
</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>