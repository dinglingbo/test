<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>

<!-- 
  - Author(s): Administrator
  - Date: 2019-08-19 18:00:10
  - Description:
-->
<head>
<title>对账单导出(主)</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/settlement/js/statementMains.js?v=1.0.72"></script>
    
</head>
<body>

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
           dataField="list"
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
              <div field="guestName" width="160" headerAlign="center" header="客户名称" visible="true"></div>
              <div allowSort="true" field="serviceId" width="150"  headerAlign="center" header="对账单号"></div>
              <div field="rpAmt" width="60" headerAlign="center" summaryType="sum" header="对账金额"></div>
              <div field="voidAmt" width="60" headerAlign="center" summaryType="sum" header="优惠金额"></div>
              <div field="trueRpAmt" width="60" headerAlign="center" summaryType="sum" header="应结金额"></div>
              <div field="rAmt" width="60" headerAlign="center" summaryType="sum" header="应收金额"></div>
              <div field="pAmt" width="60" headerAlign="center" summaryType="sum" header="应付金额"></div>
              <div field="stateMan" width="60" headerAlign="center" header="对账员"></div>
              <div allowSort="true" field="auditDate" headerAlign="center" header="对账日期" dateFormat="yyyy-MM-dd HH:mm"></div>
              <div field="remark" width="120" headerAlign="center" header="备注"></div>
          </div>
      </div>
      
</div>

	
  <div id="editFormOrderDetail" style="display:none;">
      <div id="innerOrderGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="data"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="partCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="fullName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="oemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="partBrandName" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="carModel" width="60" headerAlign="center" header="品牌车型"></di
              <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
              <div allowSort="true" datatype="" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
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
 			


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>