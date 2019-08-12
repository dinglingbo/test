<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-23 16:33:32
  - Description:
-->
<head>
<title>客户欠款明细</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/common/js/showDueDetail.js?v=1.0.60"></script>
    
</head>
<body>
<div>
	<div class="nui-fit">
		 <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		    <table style="width:100%;">
		        <tr>
		            <td style="white-space:nowrap;">
		                <label style="font-family:Verdana;">快速查询：</label>
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
		
		                <label style="font-family:Verdana;">转单日期 从：</label>
		                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
		                <label style="font-family:Verdana;">至</label>
		                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
		                <input class="nui-combobox" id ="balanceSign" name="balanceSign" value=""
                     		nullitemtext="请选择..." emptyText="是否对账" data="balanceList" width="100px" />
		                <input class="nui-combobox" id ="settleStatus" name="settleStatus" value=""
                     		nullitemtext="请选择..." emptyText="结算状态" data="settleStatusList" width="100px" />
		
<!-- 		                <span class="separator"></span>  -->
<!-- 		                <input id="serviceId" width="120px" emptyText="业务单号" class="nui-textbox"/> -->

		                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		                <input id="proId" width="120px" visible="false" emptyText="业务单号" class="nui-combobox"/>
		                
		            </td>
		        </tr>
		    </table>
		</div>
		
		 <div id="rightGrid" class="nui-datagrid" style="width:100%;height:92%;"
	         showPager="true"
	         dataField="list"
	         idField="detailId"
	         ondrawcell="onDrawCell"
	         sortMode="client"
	         allowCellSelect="true"
	         allowCellEdit="true"
	         url=""
	         multiSelect="true"
	         showModified="false"
	         totalField="page.count"
	         pageSize="100"
	         sizeList="[100,500,1000]"
	         onshowrowdetail="onShowRowDetail"
	         showSummaryRow="true">
	        <div property="columns">
	            <div type="indexcolumn">序号</div>
	            <div type="expandcolumn" width="20" >#</div>
	            <div field="guestName" width="150" headerAlign="center" header="结算单位"></div>
	            <div allowSort="true" summaryType="count" field="billServiceId" width="160" summaryType="count" headerAlign="center" header="业务单号"></div>
	            <div field="billTypeId" width="80" headerAlign="center" header="收支项目"></div>
	            <div field="remark" width="120" headerAlign="center" header="业务备注" visible="false"></div>
	            <div field="rpAmt" width="80" headerAlign="center" align="right"summaryType="sum"  numberFormat="0.00" header="应收应付金额"></div>
	            <div allowSort="true" width="120" field="createDate" headerAlign="center" header="转单日期" dateFormat="yyyy-MM-dd HH:mm"></div>
	            <div field="settleStatus" width="60" headerAlign="center" header="结算状态"></div>
	            <div field="charOffAmt" width="60" headerAlign="center" align="right"summaryType="sum"  numberFormat="0.00" header="已结金额"></div>

	        </div>
	    </div>
    </div>
    
<div id="editFormStatementDetail" style="display:none;">
    <div id="innerStatementGrid" class="nui-datagrid" style="width:100%;height:150px"
       showPager="false"
       dataField="detailList"
       idField="id"
       showSummaryRow="true"
       frozenStartColumn="0"
       frozenEndColumn="0"
       ondrawcell="onStateDrawCell"
       oncellbeginedit=""
       showModified="false"
       multiSelect="true"
       editNextOnEnterKey="true"
       onshowrowdetail=""
       url="">
      <div property="columns">
          <div type="indexcolumn" width="20">序号</div>
          <!-- <div type="checkcolumn" width="20"></div>-->
<!--           <div type="expandcolumn" width="20" >#</div> -->
          <div field="typeCode" width="60" headerAlign="center" header="业务类型"></div>
          <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div>
          <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
          <div allowSort="true" field="billDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
          <div field="remark" width="120" headerAlign="center" header="备注"></div>
          <div allowSort="true" summaryType="count" field="billServiceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
      </div>
  </div>
</div>
    
</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>