<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 18:03:07
  - Description:
-->
<head>
<title>本店套餐</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>

<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-toolbar" style="height:30px">
				<table>
					<tr>
						<td>
							<label style="font-family:Verdana;">快速查询：</label>
						</td>
						<td>
							<span class="form_label" id="lookup_type_name">品牌：</span>
						<td colspan="1">
							<input class="nui-combobox" name="isDisabled" style="width: 170px;" />
						</td>
						<td class="form_label" id="lookup_type_name">
							类型：
						</td>
						<td colspan="1">
							<input class="nui-combobox" name="isDisabled" style="width: 170px;" /> 
						</td>
						<td>
							<a class="nui-button" onclick="search()" plain="true">查询（Q）</a>
						</td>
					</tr>
				</table>
			</div>
	

	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px; height: 30px">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" iconCls="icon-ok" onclick="onOk()" plain="true">选择（C）</a> 
					<a class="nui-button" iconCls="icon-no" onclick="onNo()" plain="true">关闭（D）</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false" showHandleButton="false">
		<div size="25%" showCollapseButton="false">
			<!-- 套餐信息 -->
			<div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
					style="width: 100%; height:90%;"
					url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
					pageSize="20" showPageInfo="true" multiSelect="true"
					showPageIndex="false" showPage="true" showPageSize="false"
					showReloadButton="false" showPagerButtonIcon="false"
					totalCount="total" onselectionchanged="selectionChanged"
					allowSortColumn="true">
					<div property="columns">
						<div id="id" field="id" headerAlign="center" allowSort="true"
							visible="true" width="30px"></div>
						<div header="套餐信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="30%">套餐名称</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true" width="30%">品牌</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="30%">车型</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="30%">套餐金额</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div showCollapseButton="false">
			<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false" showHandleButton="false" vertical="true">
				<div size="35%" showCollapseButton="false">
					<!-- 基本信息 -->
					<div style="width: 100%; height: 100%;">
						<!-- 车辆品牌信息 -->
						<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height: 100%;" plain="false" onactivechanged="">
							<div title="基本信息" >
								<div class="nui-fit">
									<span style="margin-left: 20px; margin-top: 5px;">套餐名称：</span> <input
										class="nui-textbox" style="width: 60%; margin-top: 5px;" /></br> <span
										style="margin-left: 20px; margin-top: 5px;">套餐类别：</span> <input
										class="nui-combobox" allowInput="true" textField="text"
										valueField="id" value="cn" showNullItem="true"
										style="width: 14%; margin-top: 5px;" /> <span
										style="margin-left: 20px; margin-top: 5px;">市场金额：</span> <input
										class="nui-textbox" style="width: 14%; margin-top: 5px;" /> <span
										style="margin-left: 20px; margin-top: 5px;">套餐金额：</span> <input
										class="nui-textbox" style="width: 12.1%; margin-top: 5px;" /></br> <span
										style="margin-left: 20px; margin-top: 5px;">适用品牌：</span> <input
										class="nui-combobox" allowInput="true" textField="text"
										valueField="id" value="cn" showNullItem="true"
										style="width: 14%; margin-top: 5px;" /> <span
										style="margin-left: 20px; margin-top: 5px;">是否共享：</span> <input
										class="nui-checkbox" trueValue="Y" falseValue="N" /></br> <span
										style="margin-left: 20px; margin-top: 5px;">适用车型：</span> <input
										class="nui-combobox" allowInput="true" textField="text"
										valueField="id" value="cn" showNullItem="true"
										style="width: 60%; margin-top: 5px;" /></br> <span
										style="margin-left: 20px; margin-top: 5px;">套餐说明：</span> <input
										class="nui-TextArea" style="width: 60%; margin-top: 5px;" /></br> <span
										style="margin-left: 20px; margin-top: 5px;">套餐编码：</span> <input
										class="nui-textbox" style="width: 60%; margin-top: 5px;" />
								</div>
							</div>
						</div>
					</div>
				</div>
				<div showCollapseButton="false">
					<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false" showHandleButton="false">
						<div size="60%" showCollapseButton="false">
							<!-- 工时信息 -->
							<div class="nui-toolbar" id="div_2"
								style="border-bottom: 0; padding: 0px;">
								<table style="width: 100%">
									<tr>
										<td style="width: 100%">
											<a class="nui-button" plain="true" iconCls="icon-add" onclick="addClass()">添加工时</a> 
											<a class="nui-button" plain="true" iconCls="icon-remove" onclick="forbidden()">删除工时</a>
										</td>
									</tr>
								</table>
							</div>
							<div class="nui-fit">
								<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
									style="width: 100%; height: 84%;"
									url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
									pageSize="20" showPageInfo="true" multiSelect="true"
									showPageIndex="false" showPage="true" showPageSize="false"
									showReloadButton="false" showPagerButtonIcon="false"
									totalCount="total" onselectionchanged="selectionChanged"
									allowSortColumn="true">
									<div property="columns">
										<div id="id" field="id" headerAlign="center" allowSort="true"
											visible="true" width="30px">序号</div>
										<div header="车系信息" headerAlign="center">
											<div property="columns">
												<div id="type" field="type" headerAlign="center"
													allowSort="true" visible="true" width="25%">工时编码</div>
												<div id="type" field="type" headerAlign="center"
													allowSort="true" visible="true" width="35%">工时名称</div>
												<div id="isDisabled" field="isDisabled" headerAlign="center"
													allowSort="true" visible="true" width="10%">工种</div>
												<div id="isDisabled" field="isDisabled" headerAlign="center"
													allowSort="true" visible="true" width="20%">标准工时</div>
												<div id="isDisabled" field="isDisabled" headerAlign="center"
													allowSort="true" visible="true" width="20%">工时单价</div>
												<div id="isDisabled" field="isDisabled" headerAlign="center"
													allowSort="true" visible="true" width="20%">工时费</div>
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
						<div showCollapseButton="false">
							<!-- 零件信息 -->
							<div class="nui-toolbar" id="div_2"
								style="border-bottom: 0; padding: 0px;">
								<table style="width: 100%">
									<tr>
										<td style="width: 100%">
											<a class="nui-button" plain="true" iconCls="icon-add" onclick="addClass()">添加配件</a> 
											<a class="nui-button" plain="true" iconCls="icon-remove" onclick="forbidden()">删除配件</a>
										</td>
									</tr>
								</table>
							</div>
							<div class="nui-fit">
								<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
									style="width: 100%; height: 84%;"
									url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
									pageSize="20" showPageInfo="true" multiSelect="true"
									showPageIndex="false" showPage="true" showPageSize="false"
									showReloadButton="false" showPagerButtonIcon="false"
									totalCount="total" onselectionchanged="selectionChanged"
									allowSortColumn="true">
									<div property="columns">
										<div id="id" field="id" headerAlign="center" allowSort="true"
											visible="true" width="30px">序号</div>
										<div header="零件信息" headerAlign="center">
											<div property="columns">
												<div id="type" field="type" headerAlign="center"
													allowSort="true" visible="true" width="25%">零件编码</div>
												<div id="type" field="type" headerAlign="center"
													allowSort="true" visible="true" width="35%">零件名称</div>
											</div>
										</div>
										<div header="价格信息" headerAlign="center">
											<div property="columns">
												<div id="type" field="type" headerAlign="center"
													allowSort="true" visible="true" width="25%">数量</div>
												<div id="type" field="type" headerAlign="center"
													allowSort="true" visible="true" width="35%">单价</div>
												<div id="isDisabled" field="isDisabled" headerAlign="center"
													allowSort="true" visible="true" width="15%">金额</div>
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



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>