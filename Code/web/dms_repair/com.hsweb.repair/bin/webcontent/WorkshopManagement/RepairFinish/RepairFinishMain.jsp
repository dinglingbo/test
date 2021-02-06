<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-08 16:04:12
  - Description:
-->
<head>
<title>维修完工</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/WorkshopManagement/RepairFinish/RepairFinishMain.js?v=1.0.3"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 84px;
	text-align: right;
}

.required {
	color: red;
}

.mini-radiobuttonlist-item {
	margin-right: 30px;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="border-bottom: 0; ">
	<div class="nui-form1" id="queryForm">
		<table class="table" id="table1" style="">
			<tr>
				<td>
					<label>快速查询：</label>
				</td>
				<td>
					<label class="form_label">车牌号：</label>
					<input class="nui-textbox" emptyText="" id="carNo-search"/>
					<a class="nui-button" iconCls="icon-search" onclick="onSearch()" plain="true">查询</a>
				</td>
			</tr>
		</table>
	</div>
</div>
<div class="nui-toolbar" style="border-bottom: 0; ">
	<table style="width: 100%">
		<tr>
			<td style="width: 100%">
				<a class="nui-button" plain="true" iconCls="icon-reload" onclick="reloadLeftGrid()">刷新</a>
				<a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印</a>
			</td>
		</tr>
	</table>
</div>
<div class="nui-fit">
	<div class="nui-splitter" style="width: 100%; height: 100%;"
		 borderStyle="border:0"
		 allowResize="false">
		<div size="300" showCollapseButton="false" style="border:0;">
			<div id="leftGrid" dataField="list" class="nui-datagrid"
				 style="width: 100%; height: 100%;"
				 pageSize="20"
				 showPageInfo="true"
				 multiSelect="true"
				 showPageIndex="true"
				 showPage="true"
				 showPageSize="false"
				 selectOnLoad="true"
				 showReloadButton="false"
				 showPagerButtonIcon="true"
				 totalField="page.count"
				 allowSortColumn="true">
				<div property="columns">
					<div field="carNo" headerAlign="center" allowSort="true"
						 visible="true" width="50">车牌
					</div>
					<div field="status" headerAlign="center"
						 allowSort="true" visible="true" width="60">进程
					</div>
					<div field="serviceCode" headerAlign="center"
						 allowSort="true" visible="true">工单号
					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="false" style="border:0;">
			<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width:100%; height:100%;" plain="false"
				 onactivechanged="">
				<div title="完工处理">
					<div class="nui-toolbar" style="border-bottom: 0; ">
						<table>
							<tr>
								<td>
									<a class="nui-button" iconCls="icon-ok" onclick="selectAll()" plain="true">全选</a>
									<a class="nui-button" iconCls="icon-ok" onclick="itemFinish()" plain="true">项目完工</a>
									<a class="nui-button" iconCls="icon-cancel" onclick="cancelItemFinish()" plain="true">取消完工</a>
								</td>
							</tr>
						</table>
					</div>
					<div class="nui-fit">
						<div id="itemGrid" dataField="list" class="nui-datagrid" style="width: 100%; height:100%;"
							 showPager="false"
							 allowRowSelect="true"
							 multiSelect="true"
							 allowSortColumn="true">
							<div property="columns">
								<div type="checkcolumn" headerAlign="center" width="30">选择</div>
								<div header="基本信息" headerAlign="center">
									<div property="columns">
										<div field="itemName" headerAlign="center" allowSort="true" visible="true"
											 width="100">维修项目
										</div>
										<div field="itemKind" headerAlign="center" allowSort="true" visible="true">工种
										</div>
										<div field="itemTime" headerAlign="center" allowSort="true" visible="true">工时
										</div>
										<div field="className" headerAlign="center" allowSort="true" visible="true">维修班组
										</div>
										<div field="worker" headerAlign="center" allowSort="true" visible="true">承修人
										</div>
										<div field="beginDate" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd HH:mm">开始时间
										</div>
									</div>
								</div>
								<div header="完工信息" headerAlign="center">
									<div property="columns">
										<div field="finishAuditor" headerAlign="center" allowSort="true" visible="true">
											完工审核人
										</div>
										<div field="finishDate" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd HH:mm">完工时间
										</div>
										<div field="status" headerAlign="center" allowSort="true" visible="true">状态
										</div>
									</div>
								</div>
								<div header="其他信息" headerAlign="center">
									<div property="columns">
										<div field="remark" headerAlign="center" allowSort="true" visible="true">
											备注
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div title="审核领料单">
					<div class="nui-toolbar" style="border-bottom: 0; ">
						<table>
							<tr>
								<td>
									<a class="nui-button" iconCls="icon-ok" onclick="checkAll()" plain="true">全选</a>
									<a class="nui-button" iconCls="icon-cancel" onclick="inverse()" plain="true">反选</a>
									<a class="nui-button" iconCls="icon-node" onclick="partAudit()" plain="true">领料审核</a>
									<a class="nui-button" iconCls="icon-cancel" onclick="antiPartAudit()" plain="true">取消审核</a>
								</td>
							</tr>
						</table>
					</div>
					<div class="nui-fit">
						<div id="repairOutGrid" dataField="list" class="nui-datagrid" style="width: 100%; height:100%;"
							 pageSize="20" multiSelect="true"
							 totalCount="page.total" allowSortColumn="true">
							<div property="columns">
								<div type="checkcolumn" headerAlign="center" width="30">选择</div>
								<div header="零件信息" headerAlign="center">
									<div property="columns">
										<div field="partCode" headerAlign="center" allowSort="true" visible="true"
											 width="100">零件编码
										</div>
										<div field="partName" headerAlign="center" allowSort="true" visible="true"
											 width="50">零件名称
										</div>
										<div field="outQty" headerAlign="center" allowSort="true" visible="true"
											 width="50">数量
										</div>
									</div>
								</div>
								<div header="领料信息" headerAlign="center">
									<div property="columns">
										<div field="pickMan" headerAlign="center" allowSort="true" visible="true" width="90">
											领料人
										</div>
										<div field="pickDate" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd"
											 width="90">领料时间
										</div>
										<div type="checkboxcolumn" field="outSign" headerAlign="center" width="40" trueVaule="1" falseValue="0">出库标记</div>
										<div field="auditor" headerAlign="center" allowSort="true" visible="true"
											 width="60">审核人
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div title="工单信息">
					<div class="nui-form" id="basicInfoForm">
						<input class="nui-hidden" name="id"/>
						<div class="nui-panel" title="基本信息" borderStyle="border-bottom: 0; " style="width: 100%; ">
							<table class="nui-form-table">
								<tr>
									<td class="form_label">
										<label>业务类型：</label>
									</td>
									<td>
										<input class="nui-combobox" name="serviceTypeId"
											   valueField="customid" textField="name"
											   id="serviceTypeId"/>
									</td>
									<td class="form_label">
										<label>维修类型：</label>
									</td>
									<td>
										<input class="nui-combobox" name="mtType"
											   valueField="customid" textField="name"
											   id="mtType"/>
									</td>
									<td class="form_label">
										<label>维修顾问：</label>
									</td>
									<td>
										<input class="nui-textbox" name="mtAdvisor"
											   allowInput="false"/>
									</td>
								</tr>
								<tr>
									<td class="form_label">
										<label>油量：</label>
									</td>
									<td>
										<input class="nui-combobox" name="enterOilMass"
											   valueField="customid" textField="name"
											   id="enterOilMass" allowInput="false"/>
									</td>
									<td class="form_label">
										<label>里程数：</label>
									</td>
									<td>
										<input class="nui-Spinner"
											   minValue="0" maxValue="100000000"
											   name="enterKilometers" allowNull="false"
											   showButton="false"/>
									</td>
									<td class="form_label">
										<label>进厂日期：</label>
									</td>
									<td>
										<input name="enterDate" class="nui-datepicker" value="" nullValue="null"
											   format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
									</td>
								</tr>
								<tr>
									<td class="form_label">
										<label>报价日期：</label>
									</td>
									<td>
										<input name="quoteDate" class="nui-datepicker" value="" format="yyyy-MM-dd HH:mm"
											   nullValue="null" timeFormat="HH:mm:ss" showTime="true"
											   showOkButton="false" showClearButton="true"/>
									</td>
									<td class="form_label">
										<label>预计交车：</label>
									</td>
									<td>
										<input name="planFinishDate" class="nui-datepicker" value="" format="yyyy-MM-dd HH:mm"
											   nullValue="null" timeFormat="HH:mm:ss" showTime="true"
											   showOkButton="false" showClearButton="true"/>
									</td>
									<td class="form_label">
										<label>维修日期：</label>
									</td>
									<td>
										<input name="sureMtDate" class="nui-datepicker" enabled="false" format="yyyy-MM-dd"
											   timeFormat="HH:mm:ss" showTime="false"
											   showOkButton="false" showClearButton="true"/>
									</td>
								</tr>
								<tr>
									<td class="form_label">
										<label>完工日期：</label>
									</td>
									<td>
										<input name="checkDate" class="nui-datepicker" enabled="false"
											   format="yyyy-MM-dd " showOkButton="false" showClearButton="true"/>
									</td>
									<td class="form_label">
										<label>备注：</label>
									</td>
									<td colspan="3">
										<input class="nui-textbox" name="remark" style="width: 100%;"/>
									</td>
								</tr>
							</table>
						</div>
						<div class="nui-panel" title="描述信息"
							 borderStyle="border-bottom: 0; "
							 style="border-bottom: 0; width: 100%; ">
							<table class="nui-form-table" style="margin:0;width: 100%">
								<tr>
									<td>
										<label>客户描述：</label>
									</td>
									<td>
										<label>故障现象：</label>
									</td>
									<td>
										<label>解决措施：</label>
									</td>
								</tr>
								<tr>
									<td>
                                        <textarea class="nui-textarea" name="guestDesc"
												  style="width:100%;height: 80px;"></textarea>
									</td>
									<td>
                                        <textarea class="nui-textarea" name="faultPhen"
												  style="width:100%;height: 80px;"></textarea>
									</td>
									<td>
                                        <textarea class="nui-textarea" name="solveMethod"
												  style="width:100%;height: 80px;"></textarea>
									</td>
								</tr>
							</table>
						</div>
						<div class="nui-panel" title="车辆信息" style="border-bottom: 0;width: 100%;">
							<table class="nui-form-table">
								<tr>
									<td class="form_label">
										<label>车牌号：</label>
									</td>
									<td>
										<input class="nui-textbox" name="carNo" id="carNo" enabled="false"/>
									</td>
									<td class="form_label">
										<label>品牌：</label>
									</td>
									<td>
										<input class="nui-combobox" name="carBrandId"
											   valueField="id" textField="nameCn"
											   id="carBrand"/>
									</td>
									<td class="form_label">
										<label>品牌车型：</label>
									</td>
									<td colspan="1">
										<input class="nui-textbox" name="carModel" style="width: 100%" enabled="false"/>
									</td>
								</tr>
								<tr>
									<td class="form_label">
										<label>底盘号：</label>
									</td>
									<td>
										<input class="nui-textbox" name="carVin" enabled="false"/>
									</td>
									<td class="form_label">
										<label>发动机号：</label>
									</td>
									<td>
										<input class="nui-textbox" name="engineNo" enabled="false"/>
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
</body>
</html>