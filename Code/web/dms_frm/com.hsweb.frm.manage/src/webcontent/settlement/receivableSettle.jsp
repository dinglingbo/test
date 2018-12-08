<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-30 15:16:57
  - Description:
-->

<head>
	<title>应收账款管理</title>
	<script src="<%=webPath + contextPath%>/manage/settlement/js/receivableSettle.js?v=1.5.3"></script>
	<style type="text/css">
		.title {
			width: 90px;
			text-align: right;
		}

		.title.required {
			color: red;
		}

		.mini-panel-border {
			/*border-right: 0;*/
		}

		.mini-panel-body {
			padding: 0;
		}

		.panelwidth {
			width: 600px;
		}

		.panelwidth1 {
			width: 300px;
		}

		.vwidth {
			float: left;
			width: 300px;
		}

		.tmargin {
			margin-top: 10px;
			margin-left: 50px;
			margin-bottom: 10px;
		}

		.tmargin1 {
			margin-left: 20px;
		}

		.twidth {
			width: 200px;
		}

		.vpanel {
			border: 1px solid #d9dee9;
			margin: 10px 0px 0px 20px;
			height: 248px;
			float: left;
		}

		.vpanel_heading {
			border-bottom: 1px solid #d9dee9;
			width: 100%;
			height: 28px;
			line-height: 28px;
		}

		.vpanel_heading span {
			margin: 0 0 0 20px;
			font-size: 16px;
			font-weight: normal;
		}

		.vpanel_bodyww {
			padding: 10 10 10 10px !important
		}

		.mini-tab-text {
			display: none;
		}

		.mini-tabs-scrollCt {
			display: none;
		}

		.mini-tabs-bodys {
			padding: 0px !important;
		}
	</style>
</head>

<body>
	<div class="nui-fit">

		<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
			<table style="width: 100%;">
				<tr>
					<td style="white-space: nowrap;">
						<label style="font-family: Verdana;">快速查询：</label>
						<a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

						<ul id="popupMenuDate" class="nui-menu" style="display: none;">
							<li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
							<li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
							<li class="separator"></li>
							<li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
							<li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
							<li class="separator"></li>
							<li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
							<li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
							<li class="separator"></li>
							<li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
							<li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
						</ul>
						<label style="font-family: Verdana;">转单日期 从：</label>
						<input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false"
						 showOkButton="false" showClearButton="false" />
						<label style="font-family: Verdana;">至</label>
						<input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false"
						 showOkButton="false" showClearButton="false" />
						<span class="separator"></span>
						<input id="serviceId" width="120px" emptyText="业务单号" class="nui-textbox" onenter="onSearch()" />
						<a class="nui-button" iconCls="" plain="true" onclick="onSearch()">
							<span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
						<input id="proId" width="120px" visible="false" emptyText="业务单号" class="nui-combobox" />
						<span class="separator"></span>
						<a class="nui-button" plain="true" onclick="advancedSearch()">
							<span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
						<span class="separator"></span>
						<a class="nui-button" iconCls="" visible="false" plain="true" onclick="doBalance()">
							<span class="fa fa-check fa-lg"></span>&nbsp;确认对账</a>
						<!-- 							<a class="nui-button"
						iconCls="" plain="true" onclick="doPay()"><span
							class="fa fa-check fa-lg"></span>&nbsp;结算</a> -->
						<a class="nui-button" iconCls="" plain="true" onclick="doSettle()">
							<span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
						<a class="nui-button" iconCls="" plain="true" onclick="openOrderDetail()">
							<span class="fa fa-search fa-lg"></span>&nbsp;详情</a>
						<a class="nui-button" iconCls="" plain="true" onclick="doDelete()">
							<span class="fa fa-trash fa-lg"></span>&nbsp;作废</a>
					</td>
				</tr>
			</table>
		</div>
		<div class="nui-fit">

			<div id="mainTabs" class="nui-tabs" name="mainTabs" activeIndex="0" style="width: 100%; height: 100%;" plain="false" onactivechanged="">

				<div title="应收结算" name="rRightTab">
					<div class="nui-fit">
						<div id="rRightGrid" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="true" dataField="detailList" idField="detailId"
						 ondrawcell="onDrawCell" sortMode="client" allowCellSelect="true" allowCellEdit="true" url="" multiSelect="false" showModified="false"
						 pageSize="100" sizeList="[100,500,1000]" onshowrowdetail="onShowRowDetail" oncellclick="onRGridbeforeselect" onheadercellclick="onRGridheadercellclick"
						 oncellcommitedit="onCellCommitEdit" showSummaryRow="false">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div type="checkcolumn" field="check" width="20"></div>
								<!-- <div type="expandcolumn" width="20">#</div> -->
								<div field="guestName" width="150" headerAlign="center" header="结算单位"></div>
								<div field="carNo" width="80" headerAlign="center" header="车牌号"></div>
								<div allowSort="true" summaryType="count" field="billServiceId" width="120" summaryType="count" headerAlign="center" header="业务单号"></div>
								<div field="billTypeId" width="100" headerAlign="center" header="收支项目"></div>
								<div field="remark" width="120" headerAlign="center" header="业务备注"></div>
								<div field="rpAmt" width="60" headerAlign="center" align="right" numberFormat="0.00" header="应收金额"></div>
								<div field="nowAmt" width="60" headerAlign="center" align="right" numberFormat="0.00" header="结算金额">
									<input property="editor" vtype="float" class="nui-textbox" />
								</div>
								<div field="nowVoidAmt" visible="false" width="60" headerAlign="center" align="right" numberFormat="0.00" header="优惠金额">
									<input property="editor" vtype="float" class="nui-textbox" />
								</div>
								<div allowSort="true" field="createDate" headerAlign="center" header="转单日期" dateFormat="yyyy-MM-dd HH:mm"></div>
								<div field="settleStatus" width="60" headerAlign="center" header="结算状态"></div>
								<div field="charOffAmt" width="60" headerAlign="center" align="right" numberFormat="0.00" header="已结金额"></div>
								<!-- <div field="balanceSign" type="checkboxcolumn" trueValue="1" falseValue="0" width="60" headerAlign="center" header="是否对账"></div>
                        <div field="balancer" width="60" headerAlign="center" header="对账人"></div>
                        <div allowSort="true" field="balanceDate" headerAlign="center" header="对账日期" dateFormat="yyyy-MM-dd HH:mm"></div> -->

							</div>
						</div>
					</div>
				</div>
				<div title="结算单查询" name="qRightTab" visible="false">
					<div class="nui-fit">
						<div id="qRightGrid" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="true" dataField="detailList" idField="detailId"
						 ondrawcell="onDrawCell" sortMode="client" url="" multiSelect="true" pageSize="1000" sizeList="[100,500,1000]" onshowrowdetail="onShowRowDetail"
						 showSummaryRow="false">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div type="checkcolumn" width="20"></div>
								<div type="expandcolumn" width="20">#</div>
								<div field="guestName" width="150" headerAlign="center" header="结算单位"></div>
								<div allowSort="true" summaryType="count" field="billServiceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
								<div field="billTypeId" width="100" headerAlign="center" header="收支项目"></div>
								<div field="remark" width="120" headerAlign="center" header="业务备注"></div>
								<div field="rpAmt" width="60" headerAlign="center" header="应收金额"></div>
								<div field="nowAmt" width="60" headerAlign="center" header="结算金额"></div>
								<div field="nowVoidAmt" width="60" headerAlign="center" header="优惠金额"></div>
								<div allowSort="true" field="createDate" headerAlign="center" header="转单日期" dateFormat="yyyy-MM-dd HH:mm"></div>
								<div field="settleStatus" width="60" headerAlign="center" header="结算状态"></div>
								<div field="charOffAmt" width="60" headerAlign="center" header="已结金额"></div>
								<!-- <div field="balanceSign" width="60" headerAlign="center" header="是否对账"></div>
                        <div field="balancer" width="60" headerAlign="center" header="对账人"></div>
                        <div allowSort="true" field="balanceDate" headerAlign="center" header="对账日期" dateFormat="yyyy-MM-dd HH:mm"></div> -->

							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>


	<!-- <div id="editFormPchsEnterDetail" style="display:none;"> -->
	<div id="pchsEnterWin" class="nui-window" title="入库明细" style="width: 900px; height: 500px;" showModal="true" allowResize="true"
	 allowDrag="true">
		<div id="innerPchsEnterGrid" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="false" dataField="pjPchsOrderDetailList"
		 idField="detailId" ondrawcell="onDrawCell" sortMode="client" url="" showSummaryRow="true">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
				<div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
				<div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
				<div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
				<div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="车型"></div>
				<div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
				<div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
				<div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
				<div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
				<div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
				<div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
			</div>
		</div>
	</div>

	<div id="pchsEnterWinCopy" class="nui-window" title="采购入库明细" style="width: 900px; height: 500px;" showModal="true" allowResize="false"
	 allowDrag="true">
		<div id="innerPchsEnterGridCopy" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="false" dataField="pjEnterDetailList"
		 idField="detailId" ondrawcell="onDrawCell" sortMode="client" url="" showSummaryRow="true">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
				<div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
				<div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
				<div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
				<div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="车型"></div>
				<div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
				<div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
				<div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="采购数量"></div>
				<div allowSort="true" datatype="float" field="enterPrice" width="60" headerAlign="center" header="采购单价"></div>
				<div allowSort="true" datatype="float" field="enterAmt" summaryType="sum" width="60" headerAlign="center" header="采购金额"></div>
				<div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
			</div>
		</div>
	</div>

	<!-- <div id="editFormPchsRtnDetail" style="display:none;"> -->
	<div id="pchsRtnWin" class="nui-window" title="采购入库明细" style="width: 900px; height: 500px;" showModal="true" allowResize="false"
	 allowDrag="true">
		<div id="innerPchsRtnGrid" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="false" dataField="pjSellOrderDetailList"
		 idField="detailId" ondrawcell="onDrawCell" sortMode="client" url="" showSummaryRow="true">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
				<div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
				<div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
				<div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
				<div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="车型"></div>
				<div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
				<div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
				<div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
				<div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
				<div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
				<div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
			</div>
		</div>
	</div>

	<!-- <div id="editFormSellOutDetail" style="display:none;"> -->
	<div id="sellOutWin" class="nui-window" title="采购入库明细" style="width: 900px; height: 500px;" showModal="true" allowResize="false"
	 allowDrag="true">
		<div id="innerSellOutGrid" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="false" dataField="pjSellOutDetailList"
		 idField="detailId" ondrawcell="onDrawCell" sortMode="client" url="" showSummaryRow="true">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
				<div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
				<div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
				<div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
				<div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="车型"></div>
				<div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
				<div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
				<div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
				<div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="销售单价"></div>
				<div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
				<div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>

			</div>
		</div>
	</div>

	<!-- <div id="editFormSellRtnDetail" style="display:none;"> -->
	<div id="sellRtnWin" class="nui-window" title="采购入库明细" style="width: 900px; height: 500px;" showModal="true" allowResize="false"
	 allowDrag="true">
		<div id="innerSellRtnGrid" class="nui-datagrid" style="width: 100%; height: 100%;" showPager="false" dataField="pjEnterDetailList"
		 idField="detailId" ondrawcell="onDrawCell" sortMode="client" url="" showSummaryRow="true">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
				<div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
				<div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
				<div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
				<div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="车型"></div>
				<div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
				<div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
				<div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
				<div allowSort="true" datatype="float" field="rtnPrice" width="60" headerAlign="center" header="退货单价"></div>
				<div allowSort="true" datatype="float" field="rtnAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
				<div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>

			</div>
		</div>
	</div>

	<div id="editFormStatementDetail" style="display: none;">
		<div id="innerStatementGrid" class="nui-datagrid" style="width: 100%; height: 150px" showPager="false" dataField="detailList"
		 idField="id" showSummaryRow="true" frozenStartColumn="0" frozenEndColumn="10" ondrawcell="onStateDrawCell" oncellbeginedit=""
		 onrowdblclick="onStatementDbClick" showModified="false" multiSelect="true" editNextOnEnterKey="true" onshowrowdetail=""
		 url="">
			<div property="columns">
				<div type="indexcolumn" width="20">序号</div>
				<!-- <div type="checkcolumn" width="20"></div>
          <div type="expandcolumn" width="20" >#</div> -->
				<div field="typeCode" width="60" headerAlign="center" header="业务类型"></div>
				<div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div>
				<div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
				<div allowSort="true" field="billDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
				<div field="remark" width="120" headerAlign="center" header="备注"></div>
				<div allowSort="true" summaryType="count" field="billServiceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
			</div>
		</div>
	</div>

	<div id="advancedSearchWin" class="nui-window" title="高级查询" style="width: 416px; height: 230px;" showModal="true" allowResize="false"
	 allowDrag="false">
		<div id="advancedSearchForm" class="form">
			<table style="width: 100%;">
				<tr>
					<td class="title">结算单位:</td>
					<td colspan="3">
						<input id="btnEdit2" name="guestId" class="nui-buttonedit" emptyText="请选择供应商..." onbuttonclick="selectSupplier('btnEdit2')"
						 width="100%" selectOnFocus="true" />
					</td>
				</tr>
				<tr>
					<td class="title">转单日期:</td>
					<td>
						<input name="sCreateDate" width="100%" class="nui-datepicker" />
					</td>
					<td class="">至:</td>
					<td>
						<input name="eCreateDate" class="nui-datepicker" format="yyyy-MM-dd" timeFormat="H:mm:ss" showTime="false" showOkButton="false"
						 width="100%" showClearButton="false" />
					</td>
				</tr>
				<!-- <tr>
                <td class="title">对账人:</td>
                <td>
                    <input class="nui-textbox" name="balancer" width="100%" />
                </td>
            </tr>
            </tr>
            <tr>
                <td class="title">状态:</td>
                <td>
                    <input class="nui-combobox" name="balanceSign" value="0"
                     nullitemtext="请选择..." emptyText="对账状态" data="balanceList" width="100%" />
                </td>
            </tr> -->
				<tr>
					<td class="title">结算状态:</td>
					<td>
						<input class="nui-combobox" name="settleStatus" value="0" nullitemtext="请选择..." emptyText="结算状态" data="settleStatusList"
						 width="100%" />
					</td>
				</tr>
				<!-- <tr>
                <td class="title">对账日期:</td>
                <td>
                    <input name="sBalanceDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eBalanceDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr> -->
			</table>
			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="onAdvancedSearchOk" style="width: 60px; margin-right: 20px;">确定</a>
				<a class="nui-button" onclick="onAdvancedSearchCancel" style="width: 60px;">取消</a>
			</div>
		</div>
	</div>

	<div id="auditWin" class="nui-window" title="对账确认" style="width: 350px; height: 300px;" showModal="true" allowResize="false"
	 allowDrag="false">
		<div id="advancedSearchForm" class="form">


			<div class="vpanel panelwidth1" style="height: auto;">
				<div class="vpanel_body">
					<table class="tmargin tmargin1">
						<tr>
							<td id="balanceGuestName" style="text-align: left;" colSpan="2">对账单位：</td>
						</tr>
						<tr>
							<td id="balanceBillCount" style="text-align: left;">对账单据数：</td>
						</tr>
					</table>

				</div>
			</div>

			<div class="vpanel panelwidth1" style="height: auto;">
				<div class="vpanel_heading" style="background-color: #f3f4f6; color: #2d95ff;">
					<span>应收</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr>
							<td style="text-align: center; width: 50%">合计应收:</td>
							<td id="rAmt" style="text-align: left; width: 50%; color: blue; text-decoration: underline"></td>
						</tr>
					</table>

				</div>
			</div>

			<div class="vpanel panelwidth1" style="height: auto;">
				<div class="vpanel_heading" style="background-color: #f3f4f6; color: #2d95ff;">
					<span>应付</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr>
							<td style="text-align: center; width: 50%">合计应付:</td>
							<td id="pAmt" style="text-align: left; width: 50%; color: blue; text-decoration: underline"></td>
						</tr>
					</table>

				</div>
			</div>

			<!-- <table style="width:100%;" >
            <tr>
                <td id="balanceGuestName" style="text-align:left;" colSpan="2">对账单位：</td>
            </tr>
            <tr>
                <td id="balanceBillCount" style="text-align:left;">对账单据数：</td>
            </tr>
            <tr>
                <td style="text-align:left;width:50%">&nbsp;&nbsp;&nbsp;&nbsp;应收</td>
            </tr>
            <tr>
                <td style="text-align:center;width:50%">合计应收:</td>
                <td id="rAmt" style="text-align:left;width:50%;color:blue;text-decoration:underline"></td>
            </tr>
            <tr>
                <td style="text-align:left;width:50%">&nbsp;&nbsp;&nbsp;&nbsp;应付</td>
            </tr>
            <tr>
                <td style="text-align:center;width:50%">合计应付:</td>
                <td id="pAmt" style="text-align:left;width:50%;color:blue;text-decoration:underline"></td>
            </tr>
        </table> -->
			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="balanceOK" style="width: 60px; margin-right: 20px;">确定</a>
				<a class="nui-button" onclick="balanceCancel" style="width: 60px;">取消</a>
			</div>
		</div>
	</div>

	<div id="settleWin" class="nui-window" title="结算" style="width: 650px; height: 500px;" showModal="true" allowResize="false"
	 allowDrag="false">
		<div id="settleSearchForm" class="form">
			<div id="toolbar1" class="mini-toolbar">
				车辆:
				<input class="nui-textbox" enabled="false" width="10%" id="car" name="car" /> 客户:
				<input class="nui-textbox" enabled="false" width="10%" id="guest" name="guest" /> 挂账:
				<input class="nui-textbox" enabled="false" width="10%" id="" name="" />
				<font size=4 style="color: red;">代收金额:</font>
				<input class="nui-textbox" enabled="false" width="10%" id="mtAmt" name="mtAmt" />
			</div>
			<div id="rtTr" class="vpanel panelwidth" style="height: auto;">
				<div id="rtTr" class="vpanel_heading" style="background-color: #f3f4f6; color: #2d95ff;">
					<span>使用优惠</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr>
							<td style="text-align: center" width="60px">额外优惠(-)</td>
							<td>
								<input class="nui-textbox" width="20%" id="packageSubtotal" name="packageSubtotal" />
							</td>
						</tr>
					</table>

				</div>
			</div>

			<div id="ctTr" class="vpanel panelwidth" style="height: auto;">
				<div id="ctTr" class="vpanel_heading" style="background-color: #f3f4f6; color: #2d95ff;">
					<span>储值卡 (余额: </span>
					<span id="rechargeBalaAmt"></span>
					<span>)
					</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="ccTr">
							<!--  <td style="text-align:center" style="width:100px">余额:<input class="nui-textbox" id="ye" /></td> -->


							<td style="text-align: center" style="width:30%">抵扣金额:
								<input class="nui-textbox" id="dk" style="width: 60px" onvaluechanged="onChanged" />
							</td>


						</tr>
					</table>

				</div>
			</div>

			<div id="ptTr" class="vpanel panelwidth" style="height: auto;">
				<div id="ptTr" class="vpanel_heading" style="background-color: #f3f4f6; color: #2d95ff;">
					<span>应付</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="pcTr">
							<td style="text-align: center" width="60px">应付金额:</td>
							<td id="pRPAmt" style="text-align: center; color: blue; text-decoration: underline" width="60px"></td>

							<td style="text-align: center" width="60px">实付金额:</td>
							<td id="pTrueAmt" style="text-align: center; color: blue; text-decoration: underline" width="60px"></td>

							<td style="text-align: center; display: none;" width="60px">免付金额:</td>
							<td id="pVoidAmt" style="text-align: center; color: blue; text-decoration: underline; display: none;" width="60px"></td>

							<td style="text-align: center" width="60px">未结金额:</td>
							<td id="pNoCharOffAmt" style="text-align: center; color: blue; text-decoration: underline" width="60px"></td>
						</tr>
					</table>

				</div>
			</div>

			<div class="vpanel panelwidth" style="height: auto;">
				<div class="vpanel_heading" style="background-color: #f3f4f6; color: #2d95ff;">
					<span>合计</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr>
							<td style="text-align: center" width="60px">合计金额:</td>
							<td id="rpAmt" style="text-align: center; color: blue; text-decoration: underline" width="60px"></td>
						</tr>
					</table>

				</div>
			</div>


			<div class="vpanel_body">
				<table class="tmargin">
					<tr>
						<td style="text-align: center" width="60px">备注:</td>
						<td id="rpRemark" style="text-align: left;" width="500px">
							<input id="rpTextRemark" width="80%" emptyText="" class="nui-textbox" />
						</td>
					</tr>
				</table>

			</div>



			<div style="text-align: center; padding: 10px;">
				<a class="nui-button" onclick="settleOK" style="width: 60px; margin-right: 20px;">确定</a>
				<a class="nui-button" onclick="settleCancel" style="width: 60px;">取消</a>
			</div>
		</div>
	</div>



</body>

</html>