<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 13:49:45
  - Description:
-->
<head>
<title>3DC回访</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-panel" showToolbar="false" title="" showFooter="true"
		style="width: 100%; height: 90px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsweb.repair.DataBase.RpbClass" />
			<!-- 排序 -->
			<input class="nui-hidden" name="criteria/_orderby[1]/_property"
				value="id" /> <input class="nui-hidden"
				name="criteria/_orderby[1]/_sort" value="arc">
			<table class="table" id="table1" style="height: 100%;">
				<tr style="height: 7px; line-height: 7px;">
					<td width="80px">
						<h4>快速查询：</h4>
					</td>
					<!-- lookup_type_code -->
					<td class="nui-button" id="lookup_type_code"
						style="margin-top: 7px;" plain="true">我接待的车辆</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[1]/likeRule"
						value="1" /></td>
					<!-- lookup_type_name -->
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">所有维修车辆</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="form_label" id="lookup_type_name">车牌号：</td>
					<td colspan="3"><input class="nui-textbox" name="isDisabled"
						emptyText="请输入..." /> <input class="nui-hidden"
						name="criteria/_expr[2]/_op" value="=" /> <input
						class="nui-hidden" name="criteria/_expr[2]/likeRule" value="0" />
					</td>
					<td property="footer"><a class="nui-button"
						iconCls="icon-search" onclick="search()">查询（Q）</a></td>
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%"><a class="nui-button" id="save"
					iconCls="icon-reload" onclick="reload()">刷新（R）</a> <a
					class="nui-button" id="undo" iconCls="icon-undo" onclick="undo()">3DC回访（H）</a>
					<a class="nui-button" id="save" iconCls="icon-save"
					onclick="save()">发送短信（F）</a> <a class="nui-button" id="save"
					iconCls="" onclick="save()">维修历史（W）</a> <a class="nui-button"
					id="save" iconCls="" onclick="save()">回访历史（L）</a> <a
					class="nui-button" id="save" iconCls="" onclick="save()">投诉登记（T）</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div class="nui-splitter" style="width: 100%; height: 100%;">
			<div size="25%" showCollapseButton="false">
				<div class="nui-fit">
					<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
						style="width: 100%; height: 100%;"
						url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
						pageSize="20" showPageInfo="true" multiSelect="true"
						showPageIndex="false" showPage="true" showPageSize="false"
						showReloadButton="false" showPagerButtonIcon="false"
						totalCount="total" onselectionchanged="selectionChanged"
						allowSortColumn="true">


						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="30px">序号</div>
							<div header="双击填写回访内容" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="50px">车牌号</div>
									<div id="name" field="name" headerAlign="center"
										allowSort="true" visible="true" width="50px">维修顾问</div>
									<div id="captainName" field="captainName" headerAlign="center"
										allowSort="true" visible="true" width="70px">工单号</div>
									<div id="captainName" field="captainName" headerAlign="center"
										allowSort="true" visible="true" width="50px">离厂天数</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
			<div showCollapseButton="false">
				<div class="nui-splitter" style="width: 100%; height: 100%;"
					vertical="true">
					<div size="50%" showCollapseButton="false">
						<div id="mainTabs" class="nui-tabs" activeIndex="0"
							style="width: 100%; height: 100%;" plain="false"
							onactivechanged="">
							<div title="基本信息" url="./subpage/BasicMessage.jsp"></div>
							<div title="套餐信息 " url="./subpage/PackageMessage.jsp"></div>
							<div title="维修项目信息 " url="./subpage/RepairItem.jsp"></div>
							<div title="维修材料信息 " url="./subpage/RepairMaterial.jsp"></div>
							<div title="估算项目信息" url="./subpage/EstimateItem.jsp"></div>
							<div title="估算材料信息" url="./subpage/EstimateMaterial.jsp">
							</div>
							<div title="出单信息" url="./subpage/OutItem.jsp"></div>
							<div title="出车报告 " url="./subpage/OutCar.jsp"></div>
							<div title="描述信息 " url="./subpage/Description.jsp"></div>
						</div>
					</div>
					<div showCollapseButton="false">
						<div class="nui-panel" showToolbar="false" title="请填写回访内容"
							showFooter="true" style="width: 100%; height: 100%">
							<div class="nui-fit">
								<table>
									<tr>
										<td>
											<div style="padding: 0 10px">
												<div class="nui-panel" showToolbar="false" title="质量满意度评分"
													showFooter="false" style="width: 220px; height: 70px">
													<div class="nui-radiobuttonlist" valueField="id"
														repeatItems="2" repeatLayout="table"
														repeatDirection="vertical" textField="text"
														data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																					   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
													</div>
												</div>
											</div>
										</td>
										<td>
											<div style="padding: 0 10px">
												<div class="nui-panel" showToolbar="false" title="服务满意度评分"
													showFooter="false" style="width: 220px; height: 70px">
													<div class="nui-radiobuttonlist" valueField="id"
														repeatItems="2" repeatLayout="table"
														repeatDirection="vertical" textField="text"
														data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																					   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
													</div>
												</div>
											</div>
										</td>
										<td>
											<div style="padding: 0 10px">
												<div class="nui-panel" showToolbar="false" title="时间满意度评分"
													showFooter="false" style="width: 220px; height: 70px">
													<div class="nui-radiobuttonlist" valueField="id"
														repeatItems="2" repeatLayout="table"
														repeatDirection="vertical" textField="text"
														data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																					   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
													</div>
												</div>
											</div>
										</td>
										<td>
											<div style="padding: 0 10px">
												<div class="nui-panel" showToolbar="false" title="价格满意度评分"
													showFooter="false" style="width: 220px; height: 70px">
													<div class="nui-radiobuttonlist" valueField="id"
														repeatItems="2" repeatLayout="table"
														repeatDirection="vertical" textField="text"
														data="[{ id: 0, text: 0 },{ id: 1, text: 1 },{ id: 2, text: 2 },
																					   { id: 3, text: 3 },{ id: 4, text: 4 },{ id: 5, text: 5 },]">
													</div>
												</div>
											</div>
										</td>
									</tr>

								</table>
								<table style="width: 100%">
									<tr style="margin: 0">
										<td style="width: 60px">
											<div style="margin: 20px 0 20px 0">回访方式：</div>
											<div style="margin: 10px 0 30px 0">回访内容：</div>
											<div style="margin: 33px 0 0 0">回访员：</div>
										</td>
										<td>
											<div style="margin: 20px 0 0 0">
												<input class="nui-combobox"
													style="width: 120px; margin: 0 20px 0 0;" allowInput="true" />

												下次保养日期： <input id="data" class="nui-datepicker" value=""
													nullValue="null" format="yyyy-MM-dd " timeFormat="HH:mm:ss"
													showTime="true" showOkButton="true" showClearButton="false"
													style="width: 150px; margin: 0 20px 0 0;" />

												保养周期： <input id="spinner" class="nui-spinner"
													style="width: 150px; margin: 0 20px 0 0;" />
											</div>
											<div>
												<input class="nui-textarea"
													style="width: 96%; height: 55px; margin: 10px 0 0 0"
													allowInput="true" />
											</div>
											<div style="margin: 10px 0 0 0">
												<input class="nui-textbox"
													style="width: 150px; margin: 0 20px 0 0;" /> 回访时间： <input
													id="data" class="nui-datepicker" value="" nullValue="null"
													format="yyyy-MM-dd " timeFormat="HH:mm:ss" showTime="true"
													showOkButton="true" showClearButton="false"
													style="width: 150px; margin: 0 10px 0 0;" />
												<a class="nui-button" iconCls="" onclick="search()"
													style="margin: 0 10px 0 0;">选择话术</a> <a class="nui-button"
													iconCls="" onclick="search()" style="margin: 0 10px 0 0;">收藏话术</a>
												<a class="nui-button" iconCls="" onclick="search()">保存</a>
											</div>
										</td>
									</tr>
								</table>
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