<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 15:40:23
  - Description:
-->
<head>
<title>入库审核</title>
<script
	src="<%=webPath + contextPath%>/purchasePart/js/reviewMgr/enterReview.js?v=1.0.5"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>
	<input class="nui-combobox" visible="false" id="settType"/>
	<input class="nui-combobox" visible="false" id="billTypeId"/>
	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
		<div class="form" id="queryForm">
			<table style="width: 100%;">
				<tr>
					<td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
					<a class="nui-menubutton " iconCls="icon-date" menu="#popupMenuDate" id="menuBtnDateQuickSearch">本日</a>
					<ul id="popupMenuDate" class="nui-menu" style="display:none;">
						<li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 0, '本日')" id="type0">本日</li>
						<li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 1, '昨日')" id="type1">昨日</li>
						<li class="separator"></li>
						<li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 2, '本周')" id="type2">本周</li>
						<li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 3, '上周')" id="type3">上周</li>
						<li class="separator"></li>
						<li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 4, '本月')" id="type4">本月</li>
						<li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 5, '上月')" id="type5">上月</li>
					</ul>
                    <label style="font-family:Verdana;">入库单号：</label>
                    <input class="nui-textbox" name="id">
					<label style="font-family:Verdana;">仓库：</label>
						<input id="storeId"
							   name="storeId"
							   class="nui-combobox width1"
							   textField="name"
							   valueField="id"
							   emptyText="请选择..."
							   url=""
							   allowInput="false"
							   showNullItem="false"
							   nullItemText="请选择..."/>
                    <label style="font-family:Verdana;">入库日期：</label>
                    <input name="startDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           allowInput="false"
                           timeFormat=""/>
                    <label style="font-family:Verdana;">至：</label>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat=""
                           showTime="false"
                           allowInput="false"
                           showOkButton="false"
                           showClearButton="true"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
					<span class="separator"></span>
					<a class="nui-button" iconCls="icon-ok" plain="true" onclick="review()" enabled="false" id="reViewBtn">审核</a>
                </td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit">
		<div class="nui-splitter" allowResize="false"
			style="width: 100%; height: 100%;">
			<div size="210" showCollapseButton="false">
				<div class="nui-fit">
					<ul id="tree1" class="nui-tree" url="" style="width: 100%;"
						onnodedblclick="onNodeDblClick" showTreeIcon="true"
						textField="name" idField="id" parentField="parentid"
						resultAsTree="false">
					</ul>
				</div>
			</div>
			<div showCollapseButton="false">
				<div class="nui-fit">
					<div id="rightGrid1" class="nui-datagrid"
						style="width: 100%; height: 50%;" showPager="false"
						dataField="ptsEnterMainList" idField="id"
						ondrawcell="onRightGrid1DrawCell"
						onrowclick="onRightGrid1RowClick" sortMode="client" url="">
						<div property="columns">
							<div type="indexcolumn">序号</div>
							<div header="" headerAlign="center">
								<div property="columns">
									<div allowSort="true" field="enterCode" width="150"
										headerAlign="center" header="工单号"></div>
									<div allowSort="true" field="guestFullName" width="150"
										headerAlign="center" header="往来单位"></div>
									<div allowSort="true" field="storeId" width="150"
										 headerAlign="center" header="仓库"></div>
									<div allowSort="true" field="enterDate" headerAlign="center"
										width="80" header="入库日期" dateFormat="yyyy-MM-dd"></div>
									<!--<div field="billStatus" width="60" headerAlign="center" header="单据状态"></div>-->
									<div allowSort="true" field="billTypeId" width="60"
										headerAlign="center" header="票据类型"></div>
									<div allowSort="true" field="settType" width="60"
										headerAlign="center" header="结算方式"></div>
									<div allowSort="true" field="auditor" width="60"
										headerAlign="center" header="审核人"></div>
								</div>
							</div>
							<div header="金额信息" headerAlign="center">
								<div property="columns">
									<div allowSort="true" datatype="float" field="payableAmt"
										width="80" headerAlign="center" header="应付金额" align="right"></div>
								</div>
							</div>
							<div header="操作信息" headerAlign="center">
								<div property="columns">
									<div allowSort="true" field="modifier" width="60"
										headerAlign="center" header="操作员"></div>
									<div allowSort="true" field="modifyDate" headerAlign="center"
										width="80" header="操作日期" dateFormat="yyyy-MM-dd"></div>
								</div>
							</div>
							<div header="其他" headerAlign="center">
								<div property="columns">
									<div allowSort="true" field="remark" width="100"
										headerAlign="center" header="备注"></div>
								</div>
							</div>
						</div>
					</div>
					<div id="rightGrid2" class="nui-datagrid"
						style="width: 100%; height: 50%;" showPager="false"
						dataField="enterDetailList" idField="detailId" sortMode="client"
						url="">
						<div property="columns">
							<div type="indexcolumn">序号</div>
							<div header="零件信息" headerAlign="center">
								<div property="columns">
									<div allowSort="true" field="partCode" width="60"
										headerAlign="center" header="配件编码"></div>
									<div allowSort="true" field="partFullName" headerAlign="center"
										header="配件名称"></div>
									<div allowSort="true" field="unit" width="40"
										headerAlign="center" header="单位"></div>
									<div allowSort="true" type="checkboxcolumn" field="taxSign"
										width="40" headerAlign="center" header="含税" trueValue="1"
										falseValue="0"></div>
								</div>
							</div>
							<div header="数量单价" headerAlign="center">
								<div property="columns">
									<div allowSort="true" datatype="float" field="noTaxUnitPrice"
										width="40" headerAlign="center" header="单价" align="right"></div>
									<div allowSort="true" datatype="float" field="taxRate"
										width="40" headerAlign="center" header="税率" align="right"></div>
									<div allowSort="true" datatype="float" field="noTaxAmt"
										width="40" headerAlign="center" header="金额" align="right"></div>
								</div>
							</div>
							<div header="" headerAlign="center">
								<div property="columns">
									<div allowSort="true" datatype="float" field="suggestPrice"
										width="80" headerAlign="center" header="建议销价/退货价"
										align="right"></div>
									<div allowSort="true" datatype="float" field="suggestAmt"
										width="100" headerAlign="center" header="建议销销售金额/退货金额"
										align="right"></div>
								</div>
							</div>
							<div header="其他" headerAlign="center">
								<div property="columns">
									<div allowSort="true" field="remark" width="60"
										headerAlign="center" header="备注"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>
