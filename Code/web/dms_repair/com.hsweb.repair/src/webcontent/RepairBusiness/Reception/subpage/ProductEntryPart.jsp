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
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/subpage/ProductEntry.js?v=1.2.0"></script>
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
		<input class="nui-hidden" id="ExpenseAccount" name="ExpenseAccount"/>
		<input class="nui-hidden" name="carLevelId"/>
		<input class="nui-hidden" name="carLineId"/>
		<table class="nui-form-table">
			<tr>
				<td>
					<label>车架号(VIN)：</label>
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
					<label>车型：</label>
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
					<label>车型：</label>
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
							<a class="nui-button" plain="false"  onclick="onSearch(2)">查询</a>
							<a class="nui-button" plain="false"  onclick="onOk(2)">选择</a>
						</td>
					</tr>
				</table>
			</div>
			<div  class="nui-fit">
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
    <div class="nui-datagrid" style="width:100%;height:100%"  id="packageGrid" visible="false"></div>
    <div class="nui-datagrid" style="width:100%;height:100%"  id="packageDetail" visible="false"></div>
	<div class="nui-datagrid" style="width:100%;height:100%"  id="itemGrid" visible="false"></div>
</body>
</html>