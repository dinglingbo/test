<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-02 14:20:21
  - Description:
-->
<head>
<title>标准化产品查询</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/subpage/ProductEntry.js?v=1.1.12"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.asLabel .mini-textbox-border,.asLabel .mini-textbox-input,.asLabel .mini-buttonedit-border,.asLabel .mini-buttonedit-input,.asLabel .mini-textboxlist-border
	{
	border: 0;
	background: none;
	cursor: default;
}

.asLabel .mini-buttonedit-button,.asLabel .mini-textboxlist-close {
	display: none;
}

.asLabel .mini-textboxlist-item {
	padding-right: 8px;
}

.point input {
	color: red;
	font-size: 12px;
	font-weight: 600;
}
</style>

</head>
<body>
<div  class="nui-panel" showToolbar="false" title="车型信息" showFooter="false" style="width:100%;">
	<div id="carInfoForm">
		<input class="nui-hidden" name="carLevelId"/>
		<input class="nui-hidden" name="carLineId"/>
		<table class="nui-form-table">
			<tr>
				<td>
					<label>车架号（VIN）：</label>
				</td>
				<td>
					<input class="nui-textbox" name="vin" id="vin" width="150px"/>
				</td>
				<td>
					<label>品牌：</label>
				</td>
				<td>
					<input class="nui-combobox" allowInput="false"
						   name="carBrandId" id="carBrandId"
						   valueField="id" textField="nameCn"/>
				</td>
				<td>
					<label>品牌车型：</label>
				</td>
				<td colspan="3">
					<input class="nui-combobox" name="carModelId" id="carModelId"
						   width="100%"
						   valueField="carModelId" textField="carModel"/>
				</td>
			</tr>
			<tr>
				<td>
					<label>品牌：</label>
				</td>
				<td class="point">
					<input class="nui-textbox asLabel" readOnly="true" name="carBrandName"/>
				</td>
				<td>
					<label>等级：</label>
				</td>
				<td class="point">
					<input class="nui-textbox asLabel" readOnly="true" name="carLevelName"/>
				</td>
				<td>
					<label>车系：</label>
				</td>
				<td class="point">
					<input class="nui-textbox asLabel" readOnly="true" name="carLineName"/>
				</td>
				<td>
					<label>品牌车型：</label>
				</td>
				<td class="point">
					<input class="nui-textbox asLabel" readOnly="true" name="carModelName"/>
				</td>
			</tr>
			<tr>
				<td>
					<label>发动机：</label>
				</td>
				<td class="point">
					<input class="nui-textbox asLabel" readOnly="true" name=""/>
				</td>
				<td>
					<label>变速箱：</label>
				</td>
				<td colspan="3" class="point">
					<input class="nui-textbox asLabel" width="100%" readOnly="true" name=""/>
				</td>
			</tr>
		</table>
	</div>
</div>
<div class="nui-fit">
	<div class="nui-splitter" style="width:100%;height:100%;"
		  borderStyle="border:0"
		  allowResize="false">
		<div size="180" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-toolbar" style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
					<label>产品分组</label>
				</div>
				<div class="nui-fit">
					<ul id="tree" class="nui-tree" url="" style="width: 100%;height:100%;"
						dataField="rs" showTreeIcon="true" textField="name"
						idField="id" parentField="parentId" resultAsTree="false">
					</ul>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-toolbar" style="padding: 2px; border: 0;;">
				<table class="nui-form-table">
					<tr>
						<td>
							<label>查询项：</label>
						</td>
						<td>
							<input class="nui-combobox" id="queryItem"
								   data="[{id:0,text:'编码'},{id:1,text:'名称'},{id:2,text:'拼音'}]" value="1"/>
						</td>
						<td>
							<label>查询值：</label>
						</td>
						<td>
							<input class="nui-textbox" id="queryValue"/>
						</td>
						<td>
							<div class="nui-radiobuttonlist" valueField="id" repeatItems="3" textField="text" repeatLayout="table"
								 id="queryTabId"
								  data="[{ id: 0, text: '套餐'},{ id: 1, text: '项目' },{ id: 2, text: '配件' }]" value="0">
							</div>
						</td>
						<td>
							<a class="nui-button" plain="false"  onclick="onSearch()">查询</a>
							<a class="nui-button" plain="false"  onclick="onOk()">选择</a>
						</td>
					</tr>
				</table>
			</div>
			<div  class="nui-fit">
				<div class="nui-tabs"
					 id="mainTab"
					 activeIndex="0" style="width: 100%; height: 100%;" plain="false" borderStyle="border:0;">
					<div title="标准套餐" borderStyle="border:0;">
						<div class="nui-datagrid" style="width:100%;height:100%;"
							 id="packageGrid"
							 dataField="rs"
							 idField="id"
							 showPager="true"
							 totalField="page.count"
							 pageSize="20"
							 allowSortColumn="true"
							 sortMode="client"
							 frozenStartColumn="0"
							 frozenEndColumn="0">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div type="expandcolumn" >#</div>
								<div header="基本信息" headerAlign="center">
									<div property="columns" >
										<div field="PackageName" width="180" headerAlign="center" allowSort="true" header="套餐名称"></div>
									</div>
								</div>
								<div header="价格信息" headerAlign="center">
									<div property="columns">
										<div field="PackageAmt" width="100" headerAlign="center" allowSort="true" header="套餐金额"></div>
										<div field="Package4SAmt" width="100" headerAlign="center" allowSort="true" header="市场金额"></div>
									</div>
								</div>
								<div header="其他信息" headerAlign="center">
									<div property="columns">
										<div field="CarbrandName" headerAlign="center" allowSort="true" header="品牌"></div>
										<div field="CarLineName" headerAlign="center" allowSort="true" header="车系"></div>
										<div field="CarLevelName" width="80" headerAlign="center" allowSort="true" header="车型等级"></div>
										<div field="CarModelName" width="80" headerAlign="center" allowSort="true" header="品牌车型"></div>
										<div field="" width="80" headerAlign="center" allowSort="true" header="技术工艺"></div>
										<div field="" width="150" headerAlign="center" allowSort="true" header="备注"></div>
										<div field="PackageTypeId" headerAlign="center" allowSort="true" header="类型"></div>
										<div field="PackageId" width="80" headerAlign="center" allowSort="true" header="套餐编码"></div>
										<div field="PaintQty" headerAlign="center" allowSort="true" header="幅数"></div>
										<div field="UseCount" width="80" headerAlign="center" allowSort="true" header="使用频率"></div>
									</div>
								</div>
							</div>
						</div>
						<div id="detailGrid_Form" style="display:none;">
							<div id="packageDetail" class="nui-datagrid" style="width:100%;"
								dataField="rs" showPager="false">
								<div property="columns">
									<div field="type" width="60" headerAlign="center" allowSort="true" header="类型"></div>
									<div field="itemCode" width="120" headerAlign="center" allowSort="true" header="项目/配件名称编码"></div>
									<div field="itemName" width="120" headerAlign="center" allowSort="true" header="名称"></div>
									<div field="itemKind" width="120" headerAlign="center" allowSort="true" header="工种"></div>
									<div field="qty" width="120" headerAlign="center" allowSort="true" header="工时/数量"></div>
									<div field="price" width="120" headerAlign="center" allowSort="true" header="单价"></div>
									<div field="amt" width="120" headerAlign="center" allowSort="true" header="金额"></div>
									<div field="partBrandId" width="120" headerAlign="center" allowSort="true" header="配件品牌"></div>
								</div>
							</div>
						</div>
					</div>
					<div title="标准项目">
						<div class="nui-datagrid" style="width:100%;height:100%"
							 id="itemGrid"
							 dataField="rs"
							 pageSize="20"
							 totalField="page.count"
							 allowSortColumn="true"
							 frozenStartColumn="0"
							 frozenEndColumn="2">
							<div property="columns">
								<div type="indexcolumn" width="35">序号</div>
								<div header="项目基本信息" headerAlign="center" >
									<div property="columns" >
										<div field="itemCode" width="70" headerAlign="center" allowSort="true" header="项目编码"></div>
										<div field="itemName" width="180" headerAlign="center" allowSort="true" header="项目名称"></div>
									</div>
								</div>
								<div header="标准项目" headerAlign="center">
									<div property="columns">
										<div field="astandTime" width="100" headerAlign="center" allowSort="true" header="时间（h）/（副）"></div>
									</div>
								</div>
								<div header="项目金额" headerAlign="center">
									<div property="columns">
										<div field="astandSum" headerAlign="center" allowSort="true" header="项目金额"></div>
										<div field="4sSum" headerAlign="center" allowSort="true" header="市场金额"></div>
									</div>
								</div>
								<div header="" headerAlign="center">
									<div property="columns">
										<div field="itemKind" width="40" headerAlign="center" allowSort="true" header="工种"></div>
										<div field="carModelName" width="120" headerAlign="center" allowSort="true" header="品牌车型"></div>
										<div field="typeId" width="80" headerAlign="center" allowSort="true" header="项目类型"></div>
										<div field="factoryName" width="150" headerAlign="center" allowSort="true" header="参考名称"></div>
										<div field="useCount" width="70" headerAlign="center" allowSort="true" header="使用频率"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div title="标准配件">
						<div class="nui-splitter" style="width:100%;height:100%;" borderStyle="0" allowResize="false">
							<div size="60%" showCollapseButton="false" style="border:0;">
								<div>
									<label>原厂配件编码：</label>
								</div>
								<div class="nui-fit">
									<div class="nui-datagrid" style="width:100%;height:100%"
										 id="partGrid" dataField="rs"
										 pageSize="20"
										 totalField="page.count"
										 allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="0">
										<div property="columns">
											<div type="indexcolumn">序号</div>
											<div field="code" width="100" headerAlign="center" allowSort="true" header="配件编码"></div>
											<div field="name" width="180" headerAlign="center" allowSort="true" header="原厂名称"></div>
											<div field="stdName" width="100" headerAlign="center" allowSort="true" header="标准名称"></div>
											<div field="sellPrice4s" width="180" headerAlign="center" allowSort="true" header="市场金额"></div>
											<div field="sellPriceStd" width="80" headerAlign="center" allowSort="true" header="建议销价"></div>
											<div field="remark" width="80" headerAlign="center" allowSort="true" header="备注"></div>
											<div field="parentGroupCode" width="180" headerAlign="center" allowSort="true" header="主组别编码"></div>
											<!--<div field="parentGroupId" headerAlign="center" allowSort="true" header="主组别"></div>-->
											<div field="groupCode" width="100" headerAlign="center" allowSort="true" header="子组别编码"></div>
											<!--<div field="groupId" width="100" headerAlign="center" allowSort="true" header="子组别"></div>-->
											<div field="id" headerAlign="center" allowSort="true" header="内码"></div>
										</div>
									</div>
								</div>
							</div>
							<div showCollapseButton="false" style="border:0;">
								<div>
									<label>互换配件编码：</label>
								</div>
								<div class="nui-fit">
									<div class="nui-datagrid" style="width:100%;height:100%"
										 id="brandPartGrid" dataField="rs"
										 pageSize="20"
										 totalField="page.count"
										 allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="0">
										<div property="columns">
											<div type="indexcolumn">序号</div>
											<div field="name" width="80" headerAlign="center" allowSort="true" header="品牌"></div>
											<div field="code" width="100" headerAlign="center" allowSort="true" header="配件编码"></div>
											<div field="hotIndex" width="100" headerAlign="center" allowSort="true" header="热度"></div>
										</div>
									</div>
								</div>
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