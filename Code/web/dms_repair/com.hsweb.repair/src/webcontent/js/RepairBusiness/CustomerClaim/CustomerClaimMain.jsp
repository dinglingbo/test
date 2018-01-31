<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 17:32:01
  - Description:
-->
<head>
<title>客户索赔</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-panel" showToolbar="false" title="" showFooter="true"
		style="width: 100%; height: 12%">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsweb.repair.DataBase.RpbClass" />
			<!-- 排序 -->
			<input class="nui-hidden" name="criteria/_orderby[1]/_property"
				value="id" /> <input class="nui-hidden"
				name="criteria/_orderby[1]/_sort" value="arc">
			<table class="table" id="table1" style="height: 100%;">
				<tr style="width: 100%; height: 12%; line-height: 12%;">
					<td>
						<h4>快速查询：</h4>
					</td>
					<!-- lookup_type_code -->
					<td class="nui-button" id="lookup_type_code"
						style="margin-top: 7px;" plain="true">开始日期</td>
					<td colspan="3"><input class="nui-combobox" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[1]/likeRule"
						value="1" /></td>
					<!-- lookup_type_name -->
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">结束日期</td>
					<td colspan="3"><input class="nui-combobox" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="form_label" id="lookup_type_name">车牌号：</td>
					<td colspan="3"><input class="nui-textbox" name="isDisabled"
						emptyText="请输入..." /> <input class="nui-hidden"
						name="criteria/_expr[2]/_op" value="=" /> <input
						class="nui-hidden" name="criteria/_expr[2]/likeRule" value="0" />
					</td>
					<td class="form_label" id="lookup_type_name">结算状态：</td>
					<td colspan="3"><input class="nui-combobox" name="isDisabled"
						emptyText="请选择..." /> <input class="nui-hidden"
						name="criteria/_expr[2]/_op" value="=" /> <input
						class="nui-hidden" name="criteria/_expr[2]/likeRule" value="0" />
					</td>
					<td property="footer"><a class="nui-button"
						iconCls="icon-search" onclick="search()">查询</a></td>

					<!-- 超链接模式 -->
					<!-- 
        	        <td>
        	        	<a href="../../index.html">首页</a> 
        	        </td>
        	         -->
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%"><a class="nui-button" id="add"
					iconCls="icon-add" onclick="add()">登记<a> <a
							class="nui-button" id="ok" iconCls="icon-ok" onclick="ok()">处理</a>
							<a class="nui-button" id="search" iconCls="icon-search"
							onclick="search()">查看</a> <a class="nui-button" id="relist"
							iconCls="icon-undo" onclick="relist()">返单</a> <a
							class="nui-MenuButton" id="save" iconCls="icon-print"
							onclick="print()">打印（P）</a></td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">


		<div class="nui-fit">
			<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
				style="width: 100%; height: 100%;"
				url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
				pageSize="20" showPageInfo="true" multiSelect="true"
				showPageIndex="false" showPage="true" showPageSize="false"
				showReloadButton="false" showPagerButtonIcon="false"
				totalCount="total" onselectionchanged="selectionChanged"
				allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="4">


				<div property="columns">
					<div id="type" field="type" headerAlign="center" allowSort="true"
						visible="true" width="30px">序号</div>
					<div header="基本信息" headerAlign="center">
						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="100px">索赔单号</div>
							<div id="name" field="name" headerAlign="center" allowSort="true"
								visible="true" width="60px">索赔类型</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">预索赔日期</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="60px">结算状态</div>
						</div>
					</div>
					<div header="费用信息" headerAlign="center">
						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="80px">工时金额</div>
							<div id="name" field="name" headerAlign="center" allowSort="true"
								visible="true" width="80px">配件金额</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">其他费用</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">折让金额</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">结算金额</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">机电提成</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">钣金提成</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">喷漆提成</div>
						</div>
					</div>
					<div header="维修业务" headerAlign="center">
						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="80px">业务单号</div>
							<div id="name" field="name" headerAlign="center" allowSort="true"
								visible="true" width="80px">业务顾问</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">维修日期</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">离厂日期</div>
						</div>
					</div>
					<div header="客户信息" headerAlign="center">
						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="80px">客户名称</div>
							<div id="name" field="name" headerAlign="center" allowSort="true"
								visible="true" width="80px">车牌号</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">厂牌</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">车型</div>
						</div>
					</div>
					<div header="仓库审核信息" headerAlign="center">
						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="80px">审核状态</div>
							<div id="name" field="name" headerAlign="center" allowSort="true"
								visible="true" width="80px">审核日期</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">审核人</div>
						</div>
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