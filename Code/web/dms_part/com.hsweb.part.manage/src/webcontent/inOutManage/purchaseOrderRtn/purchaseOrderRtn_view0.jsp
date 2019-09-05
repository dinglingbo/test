<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>采购退货</title>
<script
	src="<%=webPath + contextPath%>/manage/js/inOutManage/purchaseOrderRtn/purchaseOrderRtn.js?v=1.2.2"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.title.wide {
	width: 100px;
}

.mini-panel-border {
	border: 0;
}

.mini-panel-body {
	padding: 0;
}

body .mini-grid-row-selected {
	background: #89c3d6 !important;
}
</style>
</head>
<body>

	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
		<table style="width: 100%;">
			<tr>

				<td style="width: 100%;"><span id="bServiceId" style="">采退单号：新采退单</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="nui-button" iconCls="" plain="true" onclick="add()"
					id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a> <a
					class="nui-button" iconCls="" plain="true" onclick="save()"
					id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a> <a
					class="nui-button" iconCls="" plain="true" onclick="audit()"
					id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;退货</a> <a
					class="nui-button" iconCls="" plain="true" onclick="onPrint()"
					id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a></td>
			</tr>
		</table>
	</div>


	<fieldset id="fd1" style="width: 99.5%; height: 85px;">
		<legend>
			<span>采购退货信息</span>
		</legend>
		<div class="fieldset-body">
			<div id="basicInfoForm" class="form" contenteditable="false">
				<input class="nui-hidden" name="id" /> <input class="nui-hidden"
					name="operateDate" /> <input class="nui-hidden" name="versionNo" />
				<input class="nui-hidden" name="storeId" id="storeId" /> <input
					class="nui-hidden" name="taxRate" id="taxRate" /> <input
					class="nui-hidden" name="taxSign" id="taxSign" /> <input
					class="nui-hidden" name="orderAmt" id="orderAmt" /> <input
					class="nui-hidden" name="auditSign" id="auditSign" /> <input
					class="nui-hidden" name="guestFullName" id="guestFullName" /> <input
					class="nui-hidden" name="serviceId" id="serviceId" />
				<table style="width: 100%;">
					<tr>
						<td class="title required"><label>供应商：</label></td>
						<td colspan="3"><input id="guestId" name="guestId"
							enabled="true" class="nui-buttonedit" emptyText="请选择供应商..."
							onbuttonclick="selectSupplier('guestId')"
							onvaluechanged="onGuestValueChanged" width="100%"
							placeholder="请选择供应商" selectOnFocus="true" /></td>
						<td class="title required" style="width: 6%"><label>退货原因：</label>
						</td>
						<td><input name="rtnReasonId" id="rtnReasonId"
							class="nui-combobox width1" textField="name"
							valueField="customid" emptyText="请选择..." url="" allowInput="true"
							showNullItem="false" width="100%" valueFromSelect="true"
							onvaluechanged="" nullItemText="请选择..." /></td>
						<td class="title required" style="width: 6%"><label>结算方式：</label>
						</td>
						<td><input name="settleTypeId" id="settleTypeId"
							class="nui-combobox width1" textField="name"
							valueField="customid" emptyText="请选择..." url="" enabled="true"
							valuefromselect="true" allowInput="true" selectOnFocus="true"
							showNullItem="false" width="100%" nullItemText="请选择..." /></td>

						<td class="title required"><label>退货员：</label></td>
						<td colspan="1"><input class="nui-combobox" id="orderMan"
							name="orderMan" textField="empName" valueField="empId"
							emptyText="请选择..." url="" required="true" allowInput="true"
							valueFromSelect="false" width="100%"></td>

					</tr>
					<tr>
						<td class="title" style="width: 6%"><label>创建日期：</label></td>
						<td width="140"><input name="createDate" id="createDate"
							width="100%" enabled="false" showTime="true"
							class="nui-datepicker" enabled="false" format="yyyy-MM-dd HH:mm" />
						</td>
						<td class="title" style="width: 6%"><label>采退单号：</label></td>
						<td><input class="nui-textbox" width="100%" id="serviceId"
							name="serviceId" enabled="false" placeholder="新销售订单" /></td>
						<td class="title"><label>状态：</label></td>
						<td><input allowInput="false" class="nui-textbox"
							width="100%" id="AuditSign" name="AuditSign" /></td>
						<td class="title"><label>备注：</label></td>
						<td colspan="3"><input class="nui-textbox"
							selectOnFocus="true" width="100%" id="remark" name="remark"
							enabled="true" /></td>
						<td class="title required" style="display: none;"><label>票据类型：</label>
						</td>
						<td style="display: none;"><input name="billTypeId"
							id="billTypeId" class="nui-combobox width1" textField="name"
							valueField="customid" emptyText="请选择..." url="" allowInput="true"
							showNullItem="false" width="100%" valueFromSelect="true"
							onvaluechanged="" nullItemText="请选择..." /></td>
					</tr>
				</table>
			</div>

		</div>
	</fieldset>
	<div class="nui-toolbar" style="padding: 2px; border-left: 0;">
		<table style="width: 100%;">
			<tr>
				<td style="white-space: nowrap;"><a class="nui-button"
					plain="true" iconCls="" onclick="addPart()" id="addPartBtn"><span
						class="fa fa-plus fa-lg"></span>&nbsp;选择采购订单</a> <a class="nui-button"
					plain="true" iconCls="" onclick="addEnterPart()"
					id="addEnterPartBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择入库单</a>
					<a class="nui-button" plain="true" iconCls=""
					onclick="deletePart()" id="deletePartBtn"><span
						class="fa fa-remove fa-lg"></span>&nbsp;删除</a></td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="rightGrid" class="nui-datagrid"
			style="width: 100%; height: 100%;" showPager="false"
			dataField="pjSellOrderDetailList" idField="id" showSummaryRow="true"
			frozenStartColumn="0" frozenEndColumn="10"
			ondrawcell="onRightGridDraw" allowCellSelect="true"
			allowCellEdit="true" oncellcommitedit="onCellCommitEdit"
			oncelleditenter="onCellEditEnter" onselectionchanged=""
			oncellbeginedit="OnrpMainGridCellBeginEdit" showModified="false"
			editNextOnEnterKey="true" url="">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div header="配件信息" headerAlign="center">
					<div property="columns">
						<div field="operateBtn" name="operateBtn" width="50"
							headerAlign="center" header="删除"></div>
						<div field="comPartCode" name="comPartCode" width="100"
							headerAlign="center" header="配件编码">
							<input property="editor" class="nui-textbox" />
						</div>
						<div field="comPartName" headerAlign="center" header="配件名称"></div>
						<div field="comPartBrandId" width="60" headerAlign="center"
							header="品牌"></div>
						<div field="comApplyCarModel" width="60" headerAlign="center"
							header="品牌车型"></div>
						<div field="comUnit" name="comUnit" width="40"
							headerAlign="center" header="单位"></div>
					</div>
				</div>
				<div header="数量金额信息" headerAlign="center">
					<div property="columns">
						<div field="orderQty" name="orderQty" summaryType="sum"
							numberFormat="0.00" width="50" headerAlign="center" header="数量">
							<input property="editor" vtype="float" class="nui-textbox" />
						</div>
						<div field="orderPrice" numberFormat="0.0000" width="50"
							headerAlign="center" header="单价">
							<input property="editor" vtype="float" class="nui-textbox" />
						</div>
						<div field="orderAmt" summaryType="sum" numberFormat="0.0000"
							width="60" headerAlign="center" header="金额">
							<input property="editor" vtype="float" class="nui-textbox" />
						</div>
						<div field="remark" width="80" headerAlign="center"
							allowSort="false" header="备注">
							<input property="editor" class="nui-textbox" />
						</div>
					</div>
				</div>
				<div header="辅助信息" headerAlign="center">
					<div property="columns">
						<div type="comboboxcolumn" field="storeId" width="60"
							headerAlign="center" allowSort="false">
							仓库<input property="editor" enabled="true" id="storehouse"
								name="storehouse" class="nui-combobox" valueField="id"
								textField="name" url="" data="storehouse" dataField="storehouse"
								onvaluechanged="" emptyText="" vtype="required" />
						</div>
						<div field="stockOutQty" summaryType="sum" numberFormat="0.00"
							width="50" headerAlign="center" header="缺货数量"></div>
						<div field="comOemCode" width="60" headerAlign="center"
							allowSort="false" header="OEM码"></div>
						<div field="comSpec" width="100" headerAlign="center"
							allowSort="false" header="规格/方向/颜色"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	</div>
	</div>

	<div id="advancedSearchWin" class="nui-window" title="高级查询"
		style="width: 416px; height: 330px;" showModal="true"
		allowResize="false" allowDrag="true">
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
					<td class="title">退货日期:</td>
					<td><input id="sOrderDate" name="sCreateDate" width="100%"
						class="nui-datepicker" /></td>
					<td class="">至:</td>
					<td><input id="eOrderDate" name="eCreateDate"
						class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss"
						showTime="false" showOkButton="false" width="100%"
						showClearButton="false" /></td>
				</tr>
				<tr>
					<td class="title">审核日期:</td>
					<td><input name="sAuditDate" width="100%"
						class="nui-datepicker" /></td>
					<td class="">至:</td>
					<td><input name="eAuditDate" class="nui-datepicker"
						format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false"
						showOkButton="false" width="100%" showClearButton="false" /></td>
				</tr>
				<tr>
					<td class="title"><span style="letter-spacing: 6px;">供应</span>商:
					</td>
					<td colspan="3"><input id="advanceGuestId" name="guestId"
						class="nui-buttonedit" emptyText="请选择供应商..."
						onbuttonclick="selectSupplier('advanceGuestId')" width="100%"
						selectOnFocus="true" /></td>
				</tr>
				<tr>
					<td class="title">退货单号:</td>
					<td colspan="3"><textarea class="nui-textarea" emptyText=""
							width="100%" style="height: 60px;" id="serviceIdList"
							name="serviceIdList"></textarea></td>
				</tr>
				<tr>
					<td class="title">配件编码:</td>
					<td colspan="3"><textarea class="nui-textarea" emptyText=""
							width="100%" style="height: 60px;" id="partCodeList"
							name="partCodeList"></textarea></td>
				</tr>
				<tr>
					<td class="title">配件名称:</td>
					<td colspan="3"><input id="partName" name="partName"
						class="nui-textbox" width="100%" /></td>
				</tr>
			</table>
			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="onAdvancedSearchOk"
					style="width: 60px; margin-right: 20px;">确定</a> <a
					class="nui-button" onclick="onAdvancedSearchCancel"
					style="width: 60px;">取消</a>
			</div>
		</div>
	</div>

	<div id="advancedMorePartWin" class="nui-window" title="配件选择"
		style="width: 700px; height: 350px;" showModal="true"
		allowResize="false" allowDrag="true">
		<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;"><a class="nui-button" iconCls=""
						plain="true" onclick="addSelectPart" id="saveBtn"><span
							class="fa fa-check fa-lg"></span>&nbsp;选入</a> <a class="nui-button"
						iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span
							class="fa fa-close fa-lg"></span>&nbsp;取消</a></td>
				</tr>
			</table>
		</div>
    <div class="nui-fit">
          <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField=""
               frozenStartColumn="0"
               frozenEndColumn="1"
               sortMode="client"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div field="code" name="code" width="100" headerAlign="center" header="配件编码"></div>
                <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
                <div field="name" name="name" width="100" headerAlign="center" header="配件名称"></div>
                <div field="partBrandId" name="partBrandId" width="100" headerAlign="center" header="品牌"></div>
                <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
                <div allowSort="true" datatype="float" name="outableQty" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div>
                <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
                <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
                <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div>
              </div>
          </div>
    </div>
</div>

	<div id="advancedAddWin" class="nui-window" title="快速录入配件"
		style="width: 400px; height: 200px;" showModal="true"
		allowResize="false" allowDrag="true">
		<div id="advancedAddForm" class="form">
			<table style="width: 100%;">

				<tr>
					<td colspan="3"><textarea class="nui-textarea"
							emptyText="格式:编码*数量*单价" width="100%" style="height: 110px;"
							id="fastCodeList" name="fastCodeList"></textarea></td>
				</tr>

			</table>
			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="onAdvancedAddOk"
					style="width: 60px; margin-right: 20px;">确定</a> <a
					class="nui-button" onclick="onAdvancedAddCancel"
					style="width: 60px;">取消</a>
			</div>
		</div>
	</div>

</body>
</html>
