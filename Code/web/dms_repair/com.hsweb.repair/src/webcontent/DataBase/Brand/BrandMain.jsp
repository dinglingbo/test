<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 17:02:48
  - Description:
-->
<head>
<title>品牌车行</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Brand/BrandMain.js"  type="text/javascript"></script>


</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-toolbar" id="form1" style="height: 30px">
		<table class="table" id="table1" style="height: 100%">
			<tr>
				<td>
					<label style="font-family: Verdana;">快速查询：</label> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(0)"><u>已启用</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(1)"><u>已禁用</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(2)"><u>全部</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(3)"><u>同步品牌</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(4)"><u>同步车系</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(5)"><u>同步车型</u></a>
				</td>
			</tr>
		</table>

	</div>




	<!-- 左右 -->
	<div class="nui-splitter" handlerSize="2" showHandleButton="false"
		style="width: 100%; height: 100%;" borderStyle="border:0">
		<div style="width: 100%; height: 100%;" size="40%">
			<!-- 左边的上下 -->
			<div class="nui-splitter" handlerSize="2" showHandleButton="false"
				style="width: 100%; height: 100%;" borderStyle="border:0"
				vertical="true">
				<div style="width: 100%; height: 100%;" size="50%">
					<!-- 车辆品牌信息 -->
					<div class="nui-toolbar" id="tb1"
						style="border-bottom: 0; padding: 0px;">
						<table style="width: 100%">
							<tr>
								<td style="width: 100%"><a class="nui-button" id="add"
									iconCls="icon-add" onclick="addBrand()" plain="true">新增品牌（A）</a>
									<a class="nui-button" id="update" iconCls="icon-edit"
									onclick="editBrand()" plain="true">修改品牌（E）</a> 
									<a class="nui-button" id="disabledBrand" iconCls="icon-no" onclick="disableBrand()" plain="true">禁用品牌（D）</a>
									<a class="nui-button" plain="true" iconCls="icon-ok" onclick="enableBrand()" id="enabledBrand" visible="false">启用品牌</a>
								</td>
							</tr>
						</table>
					</div>
					<div class="nui-fit">
						<div id="leftBrandGrid" dataField="brands" class="nui-datagrid"
							style="width: 100%; height: 100%;"
							url=""  showPageInfo="false" 
							multiSelect="true" showPageIndex="false"
							showPageSize="false" showReloadButton="false" allowSortColumn="true"
							showPagerButtonIcon="false" totalCount="total"
							
							ondrawcell="onDrawCell"
							onrowdblclick="editBrand"
							onrowclick="onLeftBrandGridRowClick"
							selectOnLoad="true" 
							
						>
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div header="车辆品牌信息" headerAlign="center">
									<div property="columns">
										<div field="carBrandZh" headerAlign="center" allowSort="true"
											visible="true" width="60%">名称</div>
										<div field="isDisabled" headerAlign="center" allowSort="true"
											visible="true" width="30%">是否禁用</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div>
					<!-- 车系信息 -->
					<div class="nui-toolbar" 
						style="border-bottom: 0; padding: 0px;">
						<table style="width: 100%">
							<tr>
								<td style="width: 100%"><a class="nui-button" id="add"
									iconCls="icon-add" onclick="addSeries()" plain="true">新增车系（S）</a>
									<a class="nui-button" id="update" iconCls="icon-edit"
									onclick="editSeries()" plain="true">修改车系（D）</a>
									<a class="nui-button" iconCls="icon-no" onclick="disableSeries()" plain="true" id="disabledSeries" visible="false">禁用车系</a>
									<a class="nui-button" plain="true" iconCls="icon-ok" onclick="enableSeries()" id="enabledSeries" visible="false">启用车系</a>
								</td>
							</tr>
						</table>
					</div>
					<div class="nui-fit">
						<div id="leftSeriesGrid" dataField="serieses" class="nui-datagrid"
							style="width: 100%; height: 90%;"
							url="" 
							showPageInfo="false" multiSelect="true" showPageIndex="false"
							showPageSize="false" showReloadButton="false"
							showPagerButtonIcon="false" totalCount="total"
							onDrawCell="onDrawCell"
							allowSortColumn="true">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div header="车系信息" headerAlign="center">
									<div property="columns">
										<div id="name" field="name" headerAlign="center"
											allowSort="true" visible="true" width="60%">名称</div>
										<div id="isDisabled" field="isDisabled" headerAlign="center"
											allowSort="true" visible="true" width="30%">是否禁用</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<div>
			<!-- 车型车系信息 -->
			<div class="nui-toolbar" 
				style="border-bottom: 0; padding: 0px;">
				<table style="width: 100%">
					<tr>
						<td style="width: 100%"><a class="nui-button"
							iconCls="icon-add" onclick="addModel()" plain="true">新增车型（N）</a>
							<a class="nui-button" iconCls="icon-edit" onclick="editModel()"
							plain="true">修改车型（M）</a> <a class="nui-button" iconCls="icon-no"
							onclick="disableModel()" plain="true">禁用车型（C）</a>
							<a class="nui-button" plain="true" iconCls="icon-ok" onclick="enableSeries()" id="enabledSeries" visible="false">启用车型</a>
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="rightModelGrid" dataField="models" class="nui-datagrid"
					style="width: 100%; height: 95%;"
					url="" 
					showPageInfo="false" multiSelect="true" showPageIndex="false"
					showPageSize="false" showReloadButton="false"
					showPagerButtonIcon="false" 
					ondrawcell="onDrawCell"
					allowSortColumn="true">
					<div property="columns">
						<div type="indexcolumn">序号</div>
						<div header="车型车系信息" headerAlign="center">
							<div property="columns">
								<div field="carFactoryName" headerAlign="center"
									allowSort="true" visible="true" width="15%">厂商</div>
								<div field="carSeriesName" headerAlign="center" allowSort="true"
									width="15%">车系</div>
								<div field="carModel" headerAlign="center" allowSort="true"
									width="50%">车型</div>
								<div field="isDisabled" headerAlign="center" allowSort="true"
									visible="true" width="20%">是否禁用</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>