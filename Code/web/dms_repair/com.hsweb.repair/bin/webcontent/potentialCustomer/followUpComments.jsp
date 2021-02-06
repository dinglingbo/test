<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 09:26:10
  - Description:
-->
<head>
<title>跟进批注</title>
<script src="<%= request.getContextPath() %>/repair/js/potentialCustomer/addVisitRecords.js?v=1.0.0"></script>
<style type="text/css">
/* table {
	table-layout: fixed;
	font-size: 12px;
	width: 100%;
} */
.dtable{
	table-layout: fixed;
	font-size: 12px;
	height: 100%;
	width: 100%;
}

.form_label {
	width: 60px;
	text-align: right;
}

.d_label {
	width: 80px;
	text-align: center;
}

/* .mini-panel {
	 margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	width: calc(100% - 20px) !important; 
} */

.required {
	color: red;
}
</style>
</head>
<body>
	<div class="nui-splitter" vertical="true"
		style="width: 100%; height: 100%;" allowResize="true">
		<!-- 上 -->
		
		<div size="70%" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-toolbar" style="padding: 2px; height: 35px">
					<table id="table1">
						<tr>
							 <td style="width:100%;">
				                <label style="font-family:Verdana;">快速查询：</label>
				                <a class="nui-menubutton" plain="false" iconCls="" id="menunamedate" menu="#popupMenu" >本日</a>
				                <ul id="popupMenu" class="nui-menu" style="display:none;">
				                    <li iconCls="" onclick="quickSearch(0)">本日</li>
				                    <li iconCls="" onclick="quickSearch(1)">昨日</li>
				                    <li iconCls="" onclick="quickSearch(2)">本周</li>
				                    <li iconCls="" onclick="quickSearch(3)">上周</li>
				                    <li iconCls="" onclick="quickSearch(4)">本月</li>
				                    <li iconCls="" onclick="quickSearch(5)">上月</li>
				                    <li iconCls="" onclick="quickSearch(6)">本年</li>
				                    <li iconCls="" onclick="quickSearch(7)">上年</li>
				                </ul>
				                <label style="font-family:Verdana;">销售顾问：</label>
				                <input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
				                    emptyText="销售顾问" url=""  allowInput="true" showNullItem="false" width="80" valueFromSelect="true"  onenter="onenterMtAdvisor(this.value)"/>
				                <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
				                <span class="separator"></span>
				                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
				                <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
				                <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-remove fa-lg"></span>&nbsp;客户资料</a>
				                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;精品信息</a>
				                <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-dollar fa-lg"></span>&nbsp;购车预算</a>
				                <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-remove fa-lg"></span>&nbsp;导出</a>
				            </td>
						</tr>
					</table>
				</div>
				<div class="nui-fit">
					<div id="datagrid1" dataField="data" class="nui-datagrid"
						pageSize="500" onDrawCell="onDrawCell" 
						sizeList="[1000,1000,2000]" sortMode="client"
						onselectionchanged="selectionChanged" onrowclick=""
						allowSortColumn="true" 
						style="width: 100%; 
						height: 100%;"
						showSummaryRow = "true"
						>
						<div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div header="来访信息" headerAlign="center">
                  	 <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
	                  <div field="mtAdvisor" name="mtAdvisor" width="80" headerAlign="center" allowsort="true" header="销售顾问"></div>
	                  <div field="outDate" name="outDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="来访时间"></div>
	                  <div field="serviceTypeName" name="serviceTypeName" width="60" headerAlign="center" allowsort="true" header="来访类型"></div>
	                  <div field="serviceCode" name="serviceCode" width="60" headerAlign="center" allowsort="true" header="状态" summaryType="count"></div>
	                  <div field="serviceCode" name="serviceCode" width="170" headerAlign="center" allowsort="true" header="批示内容(可填写)" summaryType="count"></div>
	                 </div>
                  </div>
                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
                  <div header="客户信息" headerAlign="center">
	                  <div property="columns" > 
	                 	  <div field="guestFullName" name="guestFullName" width="100" headerAlign="center"  allowsort="true" header="客户名称" allowsort="ture"></div> 
		                  <div field="carNo" name="carNo" width="80" headerAlign="center" header="客户来源" allowsort="true"></div>
		                  <div field="outDate" name="outDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="离店时间"></div>
		                  <div field="outDate" name="outDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="下次跟踪"></div>
	                  </div>
                  </div>
                  <div header="意向信息" headerAlign="center">
	                  <div property="columns" >	 
	                      <div field="packageAmt" name="packageAmt" width="90" headerAlign="center" allowsort="true"  header="品牌"></div>
	                  	  <div field="packageAmt" name="packageAmt" width="90" headerAlign="center" allowsort="true"  header="车型"></div>
  		                  <div field="packageAmt" name="packageAmt" width="90" headerAlign="center" allowsort="true"  header="规格"></div>
  		                  <div field="packageAmt" name="packageAmt" width="90" headerAlign="center" allowsort="true"  header="车身颜色"></div>
  		                  <div field="packageAmt" name="packageAmt" width="90" headerAlign="center" allowsort="true"  header="内饰颜色"></div>
  		                  <div field="packageAmt" name="packageAmt" width="90" headerAlign="center" allowsort="true"  header="预算金额"></div>
  		                  <div field="packageAmt" name="packageAmt" width="90" headerAlign="center" allowsort="true"  header="零售价"></div>
  	
	                  	</div>
		           </div>       
                   <div header="其他" headerAlign="center">
	                  <div property="columns" >
	                  	  <div field="remark" name="enterKilometers" width="150" headerAlign="center" header="备注"></div>
		                  <div field="orgid" name="orgid" width="130" headerAlign="center"  header="工单号" allowsort="true"></div>
		                  <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
	                  </div>
                  </div>
              </div>	
			</div>
		  </div>
		</div>
	 </div>
        
		<!-- 下 -->
		<div showCollapseButton="false">
			<div class="nui-fit">
			   <div class="nui-tabs" activeIndex="0"  style="width:100%;height:100%;" plain="false">
				 <div title="跟踪列表">
				   <div  id="datagrid2" dataField="data" class="nui-datagrid" 
					style="width: 100%; height: 100%;"  sortMode="client"
					allowSortColumn="true" showPager="false" allowCellWrap=true>
					 <div property="columns">
						<div type="indexcolumn" headerAlign="center" width="30">序号</div>
						<div field="carNo" headerAlign="center" allowSort="true" width="70px">跟进人</div>
						<div field="carModel" headerAlign="center" allowSort="true" width="220px">跟进日期</div>
						<div field="carVin" headerAlign="center" allowSort="true" width="120px">车架号(VIN)</div>
						<div field="serviceTypeName" name = "serviceTypeName" headerAlign="center" allowSort="true" width="60px">跟进方式</div>
						<div field="mtAdvisor" headerAlign="center" allowSort="true" width="60px">跟进状态</div>
						<div field="serviceCode" headerAlign="center" allowSort="true" width="120px">跟进结果</div>
						<div field="consumeAmt" headerAlign="center" allowSort="true" width="60px" dataType="float">关系阶段</div>
						<div field="cardAmt" headerAlign="center" allowSort="true" width="60px" dataType="float">需求内容
						</div>
						<div field="recorder" headerAlign="center" allowSort="true" width="80px">行动内容
						</div>
						<div field="recorder" headerAlign="center" allowSort="true" width="80px">后续措施
						</div>
						<div field="recorder" headerAlign="center" allowSort="true" width="80px">战败原因
						</div>
						<div field="recordDate" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:ss" width="110px">消费日期</div>							
					 </div>
				 </div>
			    </div>
			  <!--   <div title="其他意向车型" id="deductTab" name="deductTab" >
			    <div  id="datagrid2" dataField="data" class="nui-datagrid" 
					style="width: 100%; height: 100%;"  sortMode="client"
					allowSortColumn="true" showPager="false" allowCellWrap=true>
					 <div property="columns">
						<div type="indexcolumn" headerAlign="center" width="30">序号</div>
						<div field="carNo" headerAlign="center" allowSort="true" width="70px">车型信息</div>
					 </div>
				 </div>
			    </div> -->
			 </div>
			</div>
		</div>
	</div>
</body>
</html>