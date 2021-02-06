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
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/subpage/ProductEntryPkg.js?v=1.2.9"></script>
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
<div  class="nui-panel" showToolbar="false" title="快速查询" showFooter="false" style="width:100%;display:none;">
	<div id="carInfoForm">
	    <input class="nui-hidden" id="ExpenseAccount" name="ExpenseAccount"/>
		<input class="nui-hidden" name="carLevelId"/>
		<input class="nui-hidden" name="carLineId"/>
		<table class="nui-form-table">
			<tr>
			</tr>
			<tr style="display:none;">
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
					<label>品牌车型：</label>
				</td>
				<td colspan="3">
					<input class="nui-combobox" name="carModelId" id="carModelId"
						   width="100%"
						   valueField="carModelId" textField="carModel"/>
				</td>
			</tr>
			<tr style="display:none;">
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
			<tr style="display:none;">
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
					<label>套餐类型</label>
				</div>
				<div class="nui-fit">
					<ul id="tree" class="nui-tree" url="" style="width: 100%;height:100%;"
						dataField="rs" showTreeIcon="true" textField="name" expandOnLoad="0"
						idField="id" ajaxData="setToken" parentField="" resultAsTree="false">
					</ul>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-toolbar" style="padding: 2px; border: 0;;">
				<table class="nui-form-table">
					<tr>
						<!--<td>
							<label>查询项：</label>
						</td>
						<td>
							<input class="nui-combobox" id="queryItem"
								   data="[{id:0,text:'编码'},{id:1,text:'名称'},{id:2,text:'拼音'}]" value="1"/>
						</td>-->
						<td>
							<label>套餐名称：</label>
						</td>
						<td>
							<input class="nui-textbox" id="queryValue"/>
						</td>
						<td>
							<a class="nui-button" plain="true"  onclick="onSearch(0)"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
							<a class="nui-button" plain="true"  onclick="onOk(0)"><span class="fa fa-check fa-lg"></span>&nbsp;选择</a>
						</td>
					</tr>
				</table>
		</div>
	  <div  class="nui-fit">		
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
						<!--<div field="" width="80" headerAlign="center" allowSort="true" header="技术工艺"></div>-->
						<div field="Remark" width="150" headerAlign="center" allowSort="true" header="备注"></div>
						<!--<div field="packageTypeId" headerAlign="center" allowSort="true" header="类型"></div>-->
						<!--<div field="packageId" width="80" headerAlign="center" allowSort="true" header="套餐编码"></div>-->
						<!--<div field="paintQty" headerAlign="center" allowSort="true" header="幅数"></div>
						<div field="useCount" width="80" headerAlign="center" allowSort="true" header="使用频率"></div>-->
					</div>
				</div>
		  </div>
		</div>
		   <div id="detailGrid_Form" style="display:none;">
					<div id="packageDetail" class="nui-datagrid" style="width:600px;"
						dataField="rs" showPager="false">
						<div property="columns">
							<div field="type" width="60" headerAlign="center" allowSort="true" header="类型"></div>
							<div field="itemCode" visible="false" width="120" headerAlign="center" allowSort="true" header="项目/配件名称编码"></div>
							<div field="itemName" width="150" headerAlign="center" allowSort="true" header="名称"></div>
							<div field="itemKind" width="60" headerAlign="center" allowSort="true" header="工种"></div>
							<div field="qty" width="120" headerAlign="center" allowSort="true" header="工时/数量"></div>
							<div field="price" width="120" headerAlign="center" allowSort="true" header="单价"></div>
							<div field="amt" width="120" headerAlign="center" allowSort="true" header="金额"></div>
							<div field="partBrandId" visible="false" width="120" headerAlign="center" allowSort="true" header="配件品牌"></div>
						</div>
					</div>
		         </div>				
            </div>
		 </div>
  </div>
    <div class="nui-datagrid" style="width:100%;height:100%"  id="itemGrid" visible="false"></div>
	<div class="nui-datagrid" style="width:100%;height:100%"  id="partGrid" visible="false"></div>
	<div class="nui-datagrid" style="width:100%;height:100%"  id="brandPartGrid" visible="false"></div>
</div>
</body>
</html>