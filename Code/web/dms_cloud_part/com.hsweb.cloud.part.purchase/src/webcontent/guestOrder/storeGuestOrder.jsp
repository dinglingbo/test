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
<title>预销售单受理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/purchase/js/guestOrder/storeGuestOrder.js?v=1.0.3"></script>
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
			                <input class="nui-combobox" id ="status" name="status" value="" allowInput="true" showNullItem="false" 
		            		 valueFromSelect="true" nullitemtext="请选择..." emptyText="选择订单状态" data="" width="100px" data="statusList" dataField="statusList"
		            		 textField="name" valueField="id" onEnter="onSearch()" />
		               
 		                    <input id="guestName" width="120px" emptyText="客户" onEnter="onSearch()" class="nui-textbox"/> 
							
							<input class="nui-combobox" id ="orgids" name="orgids" value="" allowInput="true" showNullItem="false" 
			            		 valueFromSelect="true" nullitemtext="请选择..." emptyText="选择公司" data="" width="200px"
			            		 textField="name" valueField="orgid" onEnter="onSearch()" />
			            		 
			                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
			                <span class="separator"></span>
        			        <a class="nui-button" iconCls="" plain="true" onclick="audit()" visible=""  id="auditBtn"><span class="fa fa-check fa-lg""></span>&nbsp;受理</a>
			                
			            </td>
			        </tr>
			    </table>
			</div>
			
			 <div id="mainGrid" class="nui-datagrid" style="width:100%;height:90%;"
		         showPager="true"
		         dataField="guestOrderMainList"
		         ondrawcell="onMainDrawCell"
		         sortMode="client"
		         showReloadButton="false"
		         pageSize="50" 
		         multiSelect="false"				
				 totalField="page.count"
		         pageSize="50"
		         selectOnLoad="true"
		       
		         onselectionchanged="onMainGridSelectionChanged"
		         sizeList="[50,100,200]">
		        <div property="columns">
		            <div type="indexcolumn">序号</div>
		            <div field="id" width="40" visible="false" headerAlign="center" header="id"></div>
		            <div field="orgid" width="40" visible="false" headerAlign="center" header="id"></div>
		            <div field="orgName" width="60" headerAlign="center" header="公司"></div>
		            <div field="guestFullName" width="120" headerAlign="center" header="客户"></div>
		            <div field="serviceId" width="120px" headerAlign="center" allowSort="true" header="预售单号"></div>
		            <div field="status" width="40px" headerAlign="center" allowSort="true" header="状态"></div>
		            <div field="storeId" width="55px" headerAlign="center" allowSort="true" header="仓库" visible="false"></div>
		            <div field="orderQty" width="30px" headerAlign="center" allowSort="true" header="订单数量"></div>
		            <div field="orderAmt" width="40px" headerAlign="center" allowSort="true" header="订单金额"></div>
		            <div field="auditDate" width="80px" headerAlign="center" allowSort="true" header="提交日期"  dateFormat="yyyy-MM-dd HH:mm"></div>
		            <div field="planSendDate" width="85px" headerAlign="center" allowSort="true" header="预计发货日期"  dateFormat="yyyy-MM-dd HH:mm"></div>
		            <div field="planArriveDate" width="85px" headerAlign="center" allowSort="true" header="预计到货日期"  dateFormat="yyyy-MM-dd HH:mm"></div>
		            <div field="remark" width="55px" headerAlign="center" allowSort="true" header="备注"></div>  
		            <div field="pchsMainCode" width="100px" headerAlign="center" allowSort="true" header="采购单号"></div>
		            <div field="settleMan" width="80px" headerAlign="center" allowSort="true" header="受理人"></div>
		            <div field="settleDate" width="80px" headerAlign="center" allowSort="true" header="受理日期" dateFormat="yyyy-MM-dd HH:mm"></div>
		        </div>
		     </div>
			
        </div>
        
        <div size="40%" showCollapseButton="false">
        
        	<div class="nui-fit">
               	                	
                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="false"
				         dataField="guestOrderDetailList"
				         idField="detailId"
				         ondrawcell="onDrawCell"
				         sortMode="client"
				         url=""
				         totalField="page.count"
				         showSummaryRow="true"
						 pageSize="100"
						 sizeList=[100,200,500,1000]
				         showSummaryRow="false">
				        <div property="columns">
				            <div type="indexcolumn" >序号</div>
				            <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码" summaryType="count"></div>
                            <div field="comPartName" visible="false" headerAlign="center" header="配件名称"></div>
                            <div field="fullName"  width="200" headerAlign="center" header="配件全称"></div>
                            <div field="comPartBrandId" visible="false"width="60" headerAlign="center" header="品牌"></div>
                            <div field="comApplyCarModel" width="80" headerAlign="center" header="品牌车型"></div>
                            <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
				            <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="数量"></div>
                            <div field="orderPrice" numberFormat="0.0000" width="90" headerAlign="center" header="单价"></div>
                            <div field="orderAmt" summaryType="sum" numberFormat="0.0000" width="95" headerAlign="center" header="金额"> </div>
                            <div field="remark" width="130" headerAlign="center" allowSort="true" header="备注"></div>
				            
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