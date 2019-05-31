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
<script src="<%= request.getContextPath() %>/sales/customer/js/followUpComments.js?v=1.0.0"></script>
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
					<input name="specialCare"
		             id="specialCare"
		             class="nui-combobox"
		             textField="name"
		             valueField="id"
		             allowInput="true"
		             width="100%"
		             visible="false"
		            />
		          <input name="intentLevel"
		             id="intentLevel"
		             class="nui-combobox"
		             textField="name"
		             valueField="id"
		             allowInput="true"
		             width="100%"
		             visible="false"
		            />
		            <input name="comeTypeId"
	                 id="comeTypeId"
	                 class="nui-combobox"
	                 textField="name"
	                 valueField="id"
	                 allowInput="true"
	                 width="100%"
	                 visible="false"
	                />
	              <input name="interialColorId"
	                 id="interialColorId"
	                 class="nui-combobox"
	                 textField="name"
	                 valueField="id"
	                 allowInput="true"
	                 width="100%"
	                 visible="false"
	                />
	                 <input name="frameColorId"
	                 id="frameColorId"
	                 class="nui-combobox"
	                 textField="name"
	                 valueField="id"
	                 allowInput="true"
	                 width="100%"
	                 visible="false"
	                />
	                <input name="source"
			         id="source"
			         class="nui-combobox"
			         textField="name"
			         valueField="id"
			         allowInput="true"
			         width="100%"
			         visible="false"
			       />
			       <input name="scoutModeId"
			         id="scoutModeId"
			         class="nui-combobox"
			         textField="name"
			         valueField="id"
			         allowInput="true"
			         width="100%"
			         visible="false"
			        />
			        <input name="status"
			         id="status"
			         class="nui-combobox"
			         textField="name"
			         valueField="id"
			         allowInput="true"
			         width="100%"
			         visible="false"
			        />
			        <input name="isUsabled"
			         id="isUsabled"
			         class="nui-combobox"
			         textField="name"
			         valueField="id"
			         allowInput="true"
			         width="100%"
			         visible="false"
			        />
					<table id="table1">
						<tr>
							 <td style="width:100%;">
				                <label style="font-family:Verdana;">快速查询：</label>
				                <a class="nui-menubutton" plain="false" iconCls="" id="menunamedate" menu="#popupMenu" >待今日跟进</a>
				                <ul id="popupMenu" class="nui-menu" style="display:none;">
				                    <li iconCls="" onclick="quickSearch(0)">待今日跟进</li>
				                    <li iconCls="" onclick="quickSearch(1)">今日归档</li>
				                    <li iconCls="" onclick="quickSearch(2)">超期未跟进</li>
				                    <li iconCls="" onclick="quickSearch(3)">所有需跟进</li>
				                </ul>
				                <label style="font-family:Verdana;">销售顾问：</label>
				                <input name="saleAdvisorId" id="saleAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
				                    emptyText="销售顾问" url=""  allowInput="true" showNullItem="false" width="80" valueFromSelect="true"  onenter="doSearch"/>
				                <a class="nui-button" iconCls="" plain="true" onclick="doSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
				                <span class="separator"></span>
				               <!--  <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a> -->
				                <a class="nui-button" onclick="saveBath()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
				                <a class="nui-button" onclick="guestInfo" plain="true"  style="width: 100px;"><span class="fa fa-user-plus fa-lg"></span>&nbsp;客户资料</a>
				                <a class="nui-button" iconCls="" plain="true" onclick="giftInfo()" id="addBtn"><span class="fa fa-shopping-bag fa-lg"></span>&nbsp;精品信息</a>
				                <a class="nui-button" onclick="buyCarCount" plain="true"  style="width: 80px;"><span class="fa fa-dollar fa-lg"></span>&nbsp;购车预算</a>
				               <!--  <a class="nui-button" onclick="onCancel" plain="true"  style="width: 80px;"><span class="fa fa-check fa-lg"></span>&nbsp;导出</a> -->
				            </td>
						</tr>
					</table>
				</div>
				<div class="nui-fit">
					 <div id="mainGrid" dataField="list" class="nui-datagrid"
						pageSize="200" onDrawCell="onDrawCell" 
						sizeList="[100,300,500]" sortMode="client"
						 onrowclick=""
						allowSortColumn="true" 
						style="width: 100%; 
						height: 100%;"
						showSummaryRow = "true"
						allowcelledit="true"
						allowCellSelect="true"
						allowCellWrap="true"
						totalField="page.count"
						>
				  <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div header="来访信息" headerAlign="center">
                  	 <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
	                  <div field="saleAdvisor" name="saleAdvisor" width="80" headerAlign="center" allowsort="true" header="销售顾问"></div>
	                  <div field="comeDate" name="comeDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="来访时间"></div>
	                  <div field="comeTypeId" name="comeTypeId" width="60" headerAlign="center" allowsort="true" header="来访类型"></div>
	                  <div field="status" name="status" width="60" headerAlign="center" allowsort="true" header="状态" summaryType="count"></div>
	                  <!--回访备注  -->
	                  <!-- <div field="scoutRemark" name="scoutRemark" width="170" headerAlign="center" allowsort="true" header="批示内容(可填写)" summaryType="count"></div> -->
	                 </div>
                  </div>
                  <div header="批注" headerAlign="center">
                      <!--回访备注  -->
                      <div property="columns" >
	                  <div field="scoutRemark" name="scoutRemark" width="170" headerAlign="center" allowsort="false" header="批示内容(可填写)">
	                     <input class="nui-textarea" property="editor">
	                  </div>
	                 </div>
                  </div>
                  
                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>
                  <div header="客户信息" headerAlign="center">
	                  <div property="columns" > 
	                 	  <div field="fullName" name="fullName" width="100" headerAlign="center"  allowsort="true" header="客户名称" allowsort="ture"></div> 
		                  <div field="source" name="source" width="80" headerAlign="center" header="客户来源" allowsort="true"></div>
		                  <div field="leaveDate" name="leaveDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="离店时间"></div>
		                  <div field="nextScoutDate" name="nextScoutDate" width="120" headerAlign="center" allowsort="true" dateFormat="yyyy-MM-dd HH:mm" header="下次跟踪"></div>
	                  </div>
                  </div>
                  <div header="意向信息" headerAlign="center">
	                  <div property="columns" >	 
	                      <div field="carModelName" name="carModelName" width="120" headerAlign="center" allowsort="true"  header="车型名称"></div>
	                  	  <!-- <div field="carModelId" name="carModelId" width="90" headerAlign="center" allowsort="true"  header="车型"></div> -->
  		                  <!-- <div field="packageAmt" name="packageAmt" width="90" headerAlign="center" allowsort="true"  header="规格"></div> -->
  		                  <div field="frameColorId" name="frameColorId" width="60" headerAlign="center" allowsort="true"  header="车身颜色"></div>
  		                  <div field="interialColorId" name="interialColorId" width="60" headerAlign="center" allowsort="true"  header="内饰颜色"></div>
  		                  <div field="expectPrice" name="expectPrice" width="60" headerAlign="center" allowsort="true"  header="预算金额"></div>
  		                  <!-- <div field="expectPrice" name="packageAmt" width="90" headerAlign="center" allowsort="true"  header="零售价"></div> -->
	                  	</div>
		           </div>       
                   <div header="其他" headerAlign="center">
	                  <div property="columns" >
	                  	  <div field="remark" name="enterKilometers" width="150" headerAlign="center" header="备注"></div>
		                  <div field="serviceCode" name="serviceCode" width="130" headerAlign="center"  header="工单号" allowsort="true"></div>
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
				   <div  id="datagrid" dataField="list" class="nui-datagrid" 
					style="width: 100%; height: 100%;"  sortMode="client"
					allowSortColumn="true" showPager="false" allowCellWrap=true>
					 <div property="columns">
						<div type="indexcolumn" headerAlign="center" width="30">序号</div>
						<div field="recorder" headerAlign="center" allowSort="true" width="60px">跟进人</div>
						<div field="recordDate" headerAlign="center" allowSort="true" width="60px">跟进日期</div>
						<div field="scoutModeId" name = "scoutModeId" headerAlign="center" allowSort="true" width="60px">跟进方式</div>
						<div field="status" headerAlign="status" allowSort="true" width="60px">跟进状态</div>
						<div field="serviceCode" headerAlign="center" allowSort="true" width="120px">跟进结果</div>
						<div field="isUsabled" headerAlign="isUsabled" allowSort="true" width="60px" dataType="float">关系阶段</div>
						<div field="scoutContent" headerAlign="scoutContent" allowSort="true" width="120px" dataType="float">需求内容
						</div>
						<!-- <div field="recorder" headerAlign="center" allowSort="true" width="80px">行动内容
						</div>
						<div field="recorder" headerAlign="center" allowSort="true" width="80px">后续措施
						</div> -->
						<div field="failReasonId" headerAlign="center" allowSort="true" width="120px">战败原因
						</div>
						<!-- <div field="recordDate" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:ss" width="110px">消费日期</div> -->	
						<div field="nextOrderDate" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:ss" width="60px">下次跟进日期</div>						
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