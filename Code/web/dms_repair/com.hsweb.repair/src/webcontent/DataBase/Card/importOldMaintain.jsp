<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
	<%@include file="/common/commonRepair.jsp"%>
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<html>
		<%--
    - Author(s): huang
    - Date: 2014-08-13 12:27:01
    - Description:
  --%>

			<head>
				<title>导入维修历史查询维修历史</title>
				<script src="<%=request.getContextPath()%>/repair/js/Card/importOldMaintain.js?v=1.0.0"></script>
			</head>

			<body>

				<div class="nui-toolbar" style="padding:2px;height: 35px;">
					<table>
						<tr>
							<td>
								<input class="nui-textbox" id="carNo" name="carNo" emptyText="车牌号" width="120" onenter="onSearch" />
								<input class="nui-textbox" id="guestName" name="guestName" emptyText="客户名称" width="120" onenter="onSearch" />
								<input class="nui-textbox" id="serviceCode" name="serviceCode" emptyText="工单号" width="120" onenter="onSearch" />
								<a class="nui-button" iconCls="" plain="true" onclick="onSearch">
									<span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
							</td>
						</tr>
					</table>
				</div>


				<div class="nui-splitter" vertical="true" style="width: 100%; height: 95%;" allowResize="true">
					<div size="35%" showCollapseButton="true">
						<div class="nui-fit">
							<div id="datagrid1" dataField="oldMaintain" class="nui-datagrid" showPager="false" onDrawCell="onDrawCell" onselectionchanged="selectionChanged"
							onrowclick="" allowSortColumn="true" style="width: 100%; height: 100%;" selectOnLoad="false">
								<div property="columns">
									<div type="indexcolumn" width="40px" header="序号"></div>
									<div field="id" headerAlign="center" allowSort="true" visible="false">工单ID</div>
									<div field="serviceCode" headerAlign="center" allowSort="true" width="160px">工单号</div>
									<div field="guestName" headerAlign="center" allowSort="true" width="70px">
										客户姓名</div>
									<div field="mobile" headerAlign="center" allowSort="true" width="100px">
										客户电话</div>
									<div field="carNo" headerAlign="center" allowSort="true" width="80px">
										车牌号</div>
									<div field="enterDate" width="160px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										进店日期</div>
									<div field="distance" headerAlign="center" allowSort="true" width="60px">
										里程数</div>
									<div field="carVin" headerAlign="center" allowSort="true" width="120px">
										车架号（VIN）</div>
									<div field="itemAmt" headerAlign="center" allowSort="true" width="60px">
										工时金额</div>
									<div field="partAmt" headerAlign="center" allowSort="true" width="60px">
										配件金额</div>
									<div field="packageAmt" headerAlign="center" allowSort="true" width="60px">
										套餐金额</div>
									<div field="agiosum" headerAlign="center" allowSort="true" width="60px">
										优惠金额</div>
									<div field="banlansum" headerAlign="center" allowSort="true" width="60px">
										结算金额</div>
									<div field="outDate" width="160px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										结算日期</div>
									<div field="mtAdvisor" headerAlign="center" allowSort="true" width="60px">
										维修顾问</div>
									<div field="remark" renderer="onstatus" headerAlign="center" allowSort="true" width="120px">备注</div>
									<!-- 									<div field="recorder" headerAlign="center" allowSort="true" width="100px">建档人</div>
										<div field="recordDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
											建档日期</div> -->
								</div>
							</div>
						</div>
					</div>
					<div size="60%" showCollapseButton="true">
						<div class="nui-fit">
							<div id="datagrid2" dataField="oldPart" class="nui-datagrid" showPager="false" onDrawCell="onDrawCell" onrowclick="" allowSortColumn="true"
							 style="height: 50%" allowRowSelect="false">
								<div property="columns">
									<div type="indexcolumn" width="40px" header="序号"></div>
									<!-- 				<div type="checkcolumn" >选择</div> -->
									<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>


									<div field="partName" headerAlign="center" allowSort="true" width="90px">
										配件名称</div>
									<div field="partBrandId" headerAlign="center" allowSort="true" width="80px">
										配件品牌</div>
									<div field="unitPrice" headerAlign="center" allowSort="true" width="60px">
										单价</div>
									<div field="qty" headerAlign="center" allowSort="true" width="100px">
										数量</div>
									<div field="unit" headerAlign="center" allowSort="true" width="60px">
										单位</div>
									<!-- 									<div field="amt" headerAlign="center" allowSort="true" width="60px">
										金额</div> -->
									<div field="subtotal" headerAlign="center" allowSort="true" width="60px">
										小计</div>
									<div field="saleMan" headerAlign="center" allowSort="true" width="60px">
										销售员</div>
									<!-- 									<div field="recorder" headerAlign="center" allowSort="true" width="60px">建档人</div>
									<div field="recordDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										建档日期</div> -->
								</div>
							</div>
							<div id="datagrid3" dataField="oldItem" class="nui-datagrid" showPager="false" onDrawCell="onDrawCell" onrowclick="" allowSortColumn="true"
							 style="height: 50%" allowRowSelect="false">
								<div property="columns">
									<div type="indexcolumn" width="40px" header="序号"></div>
									<!-- 				<div type="checkcolumn" >选择</div> -->
									<div field="id" headerAlign="center" allowSort="true" visible="false">ID</div>


									<div field="itemName" headerAlign="center" allowSort="true" width="80px">
										项目名称</div>
									<!-- 									<div field="itemTime" headerAlign="center" allowSort="true" width="60px">
										项目时间</div> -->
									<div field="unitPrice" headerAlign="center" allowSort="true" width="60px">
										项目单价</div>
									<!-- 									<div field="amt" headerAlign="center" allowSort="true" width="60px">
										项目金额</div> -->
									<!-- 									<div field="rate" headerAlign="center" allowSort="true" width="60px">
										优惠率</div>
									<div field="discountAmt" headerAlign="center" allowSort="true" width="60px">
										优惠金额</div> -->
									<!-- 									<div field="partAmt" headerAlign="center" allowSort="true" width="60px">
										配件金额</div> -->
									<div field="subtotal" headerAlign="center" allowSort="true" width="60px">
										项目小计</div>
									<div field="workers" headerAlign="center" allowSort="true" width="60px">
										维修人</div>
									<div field="beginDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										开始时间</div>
									<div field="finishDate" name="planFinishDate" width="110px" headerAlign="center" dateFormat="  yyyy-MM-dd HH:mm">
										完工时间</div>
									<div field="saleMan" renderer="onstatus" headerAlign="center" allowSort="true" width="60px">销售员</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</body>

		</html>