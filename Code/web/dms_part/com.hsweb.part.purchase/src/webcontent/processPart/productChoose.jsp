<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<!-- 
  - Author(s): Administrator
  - Date: 2019-08-26 08:51:47
  - Description:
-->
<head>
<title>配件成品选择</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/purchasePart/js/processPart/productChoose.js?v=1.0.0"></script>
    
</head>
<body>

<div  class="nui-splitter"  vertical="true" style="width:100%;height:100%;" allowResize="true">
    <!-- 上 -->
    <div size="50%" showCollapseButton="false">
		<div class="nui-fit">
		    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
		  <table style="width:100%;">
		  <tr>
		      <td style="white-space:nowrap;">
		         
		          <input id="partCode" width="120px" emptyText="配件编码" class="nui-textbox"/>
		          <input id="partName" width="120px" emptyText="配件名称" class="nui-textbox"/>
		          
		          <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
		          
		          <span class="separator"></span>
		          <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
		                  <input class="nui-combobox" name="billTypeId" id="billTypeId"
		                       emptyText="票据类型" data="" width="60px" visible="false" />
		                  <input class="nui-combobox" name="settleTypeId" id="settleTypeId" 
		                       emptyText="结算方式" data="" width="60px" visible="false" />
		              </td>
		          </tr>
		      </table>
		  </div>
		  <div class="nui-fit">
		      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
		   showPager="true"
		           dataField="list"
		           idField="detailId"
		           ondrawcell=""
		           sortMode="client"
		           url=""
		           multiSelect="false"
		           allowRowSelect="true"
		           allowCellSelect="true" 
		           pageSize="10000"
		           sizeList="[1000,5000,10000]"
		           onshowrowdetail="onShowRowDetail"
		           totalField="page.count"
		           showSummaryRow="true">
		          <div property="columns">
		              <div type="indexcolumn">序号</div>
		              <div type="checkcolumn" width="30"></div>
		              <div field="partCode" width="50" headerAlign="center" header="配件编码"></div>
		              <div field="partName" width="80" headerAlign="center" header="配件名称"></div>
		              <div field="fullName" width="130" headerAlign="center" header="配件全称"></div>
		              <div field="applyCarModel" width="130" headerAlign="center" header="品牌车型"></div>
		              <div allowSort="true" field="oemCode" headerAlign="center" header="OE码" ></div>
		
		          </div>
		      </div>
		  </div>
		</div>
	</div>
	
	<div showCollapseButton="false">
		
		<div class="nui-fit">
	        <div  id="detailGrid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
	         sortMode="client" showPager="false"
	        totalField="page.count" allowSortColumn="true"   allowCellSelect="true" 
	        allowCellEdit="true"  multiSelect="false" allowCellWrap = true showSummaryRow="true"
	        frozenStartColumn="" frozenEndColumn="">
		        <div property="columns">
		            <div allowSort="true" type="indexcolumn" headerAlign="center" width="30">序号</div> 
		            
		            <div allowSort="true" field="partCode" name="partCode" width="80" headerAlign="center" header="配件编码" summaryType="count"></div>
		            <div allowSort="true" field="partName" name="partName" width="80" headerAlign="center" header="配件名称"></div>
		            <div field="fullName" name="fullName" headerAlign="center" allowSort="true" visible="true" width="150" header="配件全称"></div>
		            <div field="qty" headerAlign="center" allowSort="true" visible="true" width="50" summaryType="sum" header="数量"></div>
		            <div field="ratio" headerAlign="center" allowSort="true" visible="true" width="50" summaryType="sum" header="成本比例"></div>
		            <div field="remark" id="remark" name="remark" headerAlign="center" allowSort="true" visible="true" width="200" header="备注"></div>
		           
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