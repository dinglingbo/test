<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-01-31 11:50:10
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/commonPart/js/customerSelect.js?v=1.0.0"></script>
<style type="text/css">
html, body{
            margin:0;padding:0;border:0;width:100%;height:100%;overflow:hidden;
        }
.table-label {
	text-align: right;
}
</style>
</head>
<body>

	<div class="nui-toolbar" style="padding: 2px; border: 0;">
		<table style="width: 100%;">
			<tr>
				<td style="white-space: nowrap;"><label
					style="font-family: Verdana;">名称：</label> <input
					class="nui-textbox" width="100" id="name" /> <label
					style="font-family: Verdana;">编码：</label> <input
					class="nui-textbox" width="100" id="code" /> <label
					style="font-family: Verdana;">电话：</label> <input
					class="nui-textbox" width="100" id="phone" /> <label
					style="font-family: Verdana;">类型：</label> <input id="guestType"
					class="nui-combobox width1" textField="name" valueField="customid"
					emptyText="请选择..." url="" allowInput="true" showNullItem="false"
					nullItemText="请选择..." /> <span class="separator"></span> <label
					style="font-family: Verdana;">显示禁用：</label> <input
					class="nui-checkbox" width="100" id="showDisabled" trueValue="1"
					falseValue="0" /> <span class="separator"></span> <a
					class="nui-button" iconCls="icon-search" plain="true"
					onclick="onSearch()">查询</a> <span class="separator"></span> <a
					class="nui-button" iconCls="icon-ok" plain="true" onclick="onOk()">选择</a>
					<span class="separator"></span> <a class="nui-button" plain="true"
					onclick="advancedSearch()">更多</a> <span class="separator"></span> <a
					class="nui-button" iconCls="icon-close" plain="true"
					onclick="onCancel()">关闭 </a></td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div class="nui-splitter" id="splitter" allowResize="false"
			handlerSize="6" style="width: 100%; height: 100%;">
			<div size="200" showCollapseButton="false">
				<div class="nui-fit">
					<ul id="tree1" class="nui-tree" url=""
						style="width: 100%; height: 100%;" onnodedblclick="onNodeDblClick"
						showTreeIcon="true" textField="name" idField="id">
					</ul>
				</div>
			</div>
			<div showCollapseButton="false"
				style="border-right: 0; border-left: 0;">
				<div class="nui-fit">
					<div id="datagrid1" class="nui-datagrid" allowResize="true"
						style="width: 100%; height: 100%;" url="" idField="id"
						multiSelect="true" pageSize="20" dataField="customers"
						totalField="page.count" ondrawcell="onDrawCell"
						selectOnLoad="true" frozenStartColumn="-1" frozenEndColumn="-1">
						<div property="columns">
							<div type="indexcolumn">序号</div>
							<!--<div type="checkcolumn" ></div>-->
							<div header="往来基本信息" headerAlign="center">
								<div property="columns">
									<div field="shortName" width="80" headerAlign="center"
										header="简称"></div>
									<div field="fullName" width="100" headerAlign="center"
										header="全称"></div>
									<div field="advantageCarbrandId" width="100"
										headerAlign="center" header="优势品牌/产品"></div>
									<div field="billTypeId" width="80" headerAlign="center"
										header="票据类型"></div>
									<div field="settTypeId" width="100" headerAlign="center"
										header="结算方式"></div>
									<div field="manager" width="100" headerAlign="center"
										header="联系人"></div>
									<div field="mobile" width="100" headerAlign="center"
										header="联系电话"></div>
									<div field="contactor" width="80" headerAlign="center"
										header="业务员"></div>
									<div field="contactorTel" width="100" headerAlign="center"
										header="业务员电话"></div>
									<div field="code" width="100" headerAlign="center" header="编码"></div>
									<div field="isDisabled" width="100" headerAlign="center"
										header="状态"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="advancedSearchWin" class="nui-window" title="高级查询"
		style="width: 416px; height: 250px;" showModal="true"
		allowResize="false" allowDrag="false">
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
					<td class="table-label">全称:</td>
					<td><input name="fullName" class="nui-textbox" /></td>
					<td class="table-label">简称:</td>
					<td><input name="shortName" class="nui-textbox" /></td>
				</tr>
				<tr>
					<td class="table-label">编码:</td>
					<td><input name="code" class="nui-textbox" /></td>
					<td class="table-label">单位等级:</td>
					<td><input name="tgrade" class="nui-textbox" /></td>
				</tr>
				<tr>
					<td class="table-label">联系人:</td>
					<td><input name="manager" class="nui-textbox" /></td>
					<td class="table-label">联系人电话:</td>
					<td><input name="mobile" class="nui-textbox" /></td>
				</tr>
				<tr>
					<td class="table-label">会员等级:</td>
					<td><input name="memLevel" class="nui-textbox" /></td>
					<td class="table-label">会员卡号:</td>
					<td><input name="memCarNo" class="nui-textbox" /></td>
				</tr>
				<tr>
					<td class="table-label">省份:</td>
					<td><input name="provinceId" id="provinceId"
						class="nui-combobox" textField="name" valueField="id"
						emptyText="请选择..." url="" allowInput="true" showNullItem="false"
						onvaluechanged="onProvinceSelected('cityId')"
						nullItemText="请选择..." /></td>
					<td class="table-label">城市:</td>
					<td><input name="cityId" id="cityId" class="nui-combobox"
						textField="name" valueField="id" emptyText="请选择..." url=""
						allowInput="true" showNullItem="false" nullItemText="请选择..." /></td>
				</tr>
				<tr>
					<td class="table-label">客户:</td>
					<td><input class="nui-checkbox" name="icClient" trueValue="1"
						falseValue="0" /></td>
					<td class="table-label">是否禁用:</td>
					<td><input class="nui-checkbox" name="showDisabled"
						trueValue="1" falseValue="0" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 10px;">
				<a class="mini-button" onclick="onAdvancedSearchOk"
					style="width: 60px; margin-right: 20px;">确定</a> <a
					class="mini-button" onclick="onAdvancedSearchCancel"
					style="width: 60px;">取消</a>
			</div>
		</div>
	</div>


</body>
</html>
