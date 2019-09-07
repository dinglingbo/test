<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-09-04 09:58:43
  - Description:
-->
<head>
<title>配件组装明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
      <script src="<%=webPath + contextPath%>/purchasePart/js/processPart/partAssemblyReport.js?v=1.0.0"></script>
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
			
							<label style="font-family:Verdana;">审核日期 从：</label>
			                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
			                <label style="font-family:Verdana;">至</label>
			                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
			                <span class="separator"></span> 
			
			                <input id="partNameAndPY" width="100px" emptyText="配件名称/拼音" class="nui-textbox"/>
			                <!-- <label style="font-family:Verdana;">配件编码：</label> -->
			                <input id="partCode" width="100px" emptyText="配件编码" class="nui-textbox"/>
			                <!-- <label style="font-family:Verdana;">订单单号：</label> -->
			                <input id="serviceId" width="100px" emptyText="订单单号" class="nui-textbox"/>
			               
			                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
			
			            </td>
			        </tr>
			    </table>
			</div>
			
			<div class="nui-fit">
			    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
			         selectOnLoad="true"
			         showPager="true"
			         dataField="data"
			         idField="detailId"
			         ondrawcell="onDrawCell"
			         sortMode="client"
			         url=""
			         onrowclick="onRightGridClick"
			         totalField="page.count"
			         pageSize="10000"
			         sizeList="[1000,5000,10000]"
			         showSummaryRow="true">
			        <div property="columns">
			            <div type="indexcolumn">序号</div>
			            <div header="订单信息" headerAlign="center">
			                <div property="columns">
			                    <div allowSort="true" field="serviceId" width="160" summaryType="count" headerAlign="center" header="订单单号"></div>
			                    <div allowSort="true" field="createDate" width="120"headerAlign="center" header="订单日期" dateFormat="yyyy-MM-dd HH:mm"></div>
			                    <div allowSort="true" field="storeId" width="90" headerAlign="center" header="仓库"></div>
			                </div>
			            </div>
			            <div header="配件信息" headerAlign="center">
			                <div property="columns">
			                    <div allowSort="true" field="partCode" headerAlign="center" header="配件编码"></div>
			                    <div allowSort="true" field="partName" headerAlign="center" header="配件名称"></div>
			                    <div allowSort="true" field="oemCode" headerAlign="center" header="OE码"></div>
			                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
			                    <div allowSort="true" field="applyCarModel" width="220" headerAlign="center" header="品牌车型"></div>
			                    <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
			                </div>
			            </div>
			            <div header="数量单价" headerAlign="center">
			                <div property="columns">
			                    <div allowSort="true" datatype="float" summaryType="sum" field="orderQty" width="40" headerAlign="center" header="数量"></div>
			                    <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
			                    <div allowSort="true" datatype="float" summaryType="sum" field="orderAmt" width="60" headerAlign="center" header="金额"></div>
			                    <div allowSort="true" field="detailRemark" width="150" headerAlign="center" header="备注"></div>
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
			                    <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
			                    <div allowSort="true" field="auditDate"width="120" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
			                    <div allowSort="true" datatype="float" field="enterQty" width="60" headerAlign="center" header="入库数量"></div>
	                            <div allowSort="true" datatype="float" summaryType="sum" field="outableQty" width="80" headerAlign="center" header="可出库数量"></div>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
			
		</div>
		
		 <div  showCollapseButton="false">
		 	<div class="nui-fit">
		<!-- 		<div>明细</div>-->
		 		<div id="detailGrid" class="nui-datagrid" style="width:100%;height:100%;"
                       showPager="false"
                           dataField="data"
                           idField="id"
                           frozenStartColumn=""
                           frozenEndColumn=""
                           showSummaryRow="true"
                           ondrawcell="onDrawCell"
   						   sortMode="client"
                           editNextOnEnterKey="true"
                           allowCellWrap = "true"
                           url="">
                	<div property="columns">
                		<div type="indexcolumn">序号</div>
                		<div field="partCode" visible="" headerAlign="center" header="配件编码"></div>
                		<div field="partName" visible="false" headerAlign="center" header="配件名称"></div>
                        <div field="fullName"  width="200" headerAlign="center" header="配件全称"></div>
                        <div field="applyCarModel" width="80" headerAlign="center" header="品牌车型"></div>
                        <div field="unit" name="comUnit" width="60" headerAlign="center" header="单位"></div>
                		<div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="数量"></div>
		                <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
	                    <div allowSort="true" datatype="float" summaryType="sum" field="orderAmt" width="60" headerAlign="center" header="金额"></div>
	                    
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