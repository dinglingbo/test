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
<title>调拨申请受理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/purchase/js/allotAccept/allotApplyAccept.js?v=1.0.22"></script>
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
			                <input class="nui-combobox" id ="status" name="status" value="" allowInput="true" showNullItem="false" 
		            		 valueFromSelect="true" nullitemtext="请选择..." emptyText="选择订单状态" data="" width="100px" data="statusList" dataField="statusList"
		            		 textField="name" valueField="id" onEnter="onSearch()" />
		               
 		                    <input id="guestName" width="120px" emptyText="客户" onEnter="onSearch()" class="nui-textbox"/> 
	
			                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
			                <span class="separator"></span>
        			        <a class="nui-button" iconCls="" plain="true" onclick="audit()" visible=""  id="auditBtn"><span class="fa fa-check fa-lg""></span>&nbsp;受理</a>
        			        <a class="nui-button" iconCls="" plain="true" onclick="refuse()" visible="true" id="refuseBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;拒绝</a>
			                
			            </td>
			        </tr>
			    </table>
			</div>
			
			 <div id="mainGrid" class="nui-datagrid" style="width:100%;height:92%;"
		         showPager="true"
		         dataField="pjAllotApplyMainList"
		         ondrawcell="onMainDrawCell"
		         sortMode="client"
		         showReloadButton="false"
		         pageSize="50" 
		         multiSelect="false"				
				 totalField="page.count"
		         pageSize="50"
		         onselectionchanged="onMainGridSelectionChanged"
		         sizeList="[50,100,200]">
		        <div property="columns">
		            <div type="indexcolumn">序号</div>
		            <div field="id" width="40" visible="false" headerAlign="center" header="id"></div>
		            <div field="orgid" width="40" visible="false" headerAlign="center" header="id"></div>
		            <div field="orgName" width="60" headerAlign="center" header="申请调入公司"></div>
		            <div field="serviceId" width="100px" headerAlign="center" allowSort="true" header="预售单号"></div>
		            <div field="status" width="40px" headerAlign="center" allowSort="true" header="状态"></div>
		            <div field="auditDate" width="65px" headerAlign="center" allowSort="true" header="审核日期"  dateFormat="yyyy-MM-dd HH:mm"></div>
		            <div field="remark" width="55px" headerAlign="center" allowSort="true" header="备注"></div>  
		            <div field="code" width="100px" headerAlign="center" allowSort="true" header="调拨受理单号"></div>
		        </div>
		     </div>
			
        </div>
        
        <div size="40%" showCollapseButton="false">
        
        	<div class="nui-fit">
               	                	
                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
				         showPager="true"
				         dataField="data"
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
				            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
                            <div field="comPartName" visible="false" headerAlign="center" header="配件名称"></div>
                            <div field="fullName"  width="200" headerAlign="center" header="配件全称"></div>
                            <div field="systemUnitId" name="comUnit" width="40" headerAlign="center" header="单位"></div>
				            <div field="applyQty" name="applyQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="申请数量"></div>
                            <div field="hasAcceptQty" name="hasAcceptQty" numberFormat="0.0000" width="50" headerAlign="center" header="已受理数量"></div>
                            <div field="hasCancelQty" summaryType="sum" numberFormat="0.0000" width="50" headerAlign="center" header="已拒绝数量"> </div>
                            <div field="remark" width="30" headerAlign="center" allowSort="true" header="备注"></div>
				            
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