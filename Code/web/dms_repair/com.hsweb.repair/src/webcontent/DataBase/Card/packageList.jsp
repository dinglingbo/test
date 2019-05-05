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
<title>套餐操作</title>
<script src="<%=request.getContextPath()%>/repair/js/Card/packageList.js?v=1.3.32"></script>

</head>

<body>
	<div class="nui-fit">
		<div class="nui-splitter" style="width:100%;height:100%;"
			borderStyle="border:0"
			allowResize="false">
			<div size="150" showCollapseButton="false">
				<div class="nui-fit">
					<div class="nui-fit">
						<div id="typeGrid" dataField="data" class="nui-datagrid"
							showPager="false" showHGridLines="false" allowSortColumn="false"
							style="width: 100%; height: 50%;float:left;" multiSelect="false" >
							 <div property="columns">
								<div field="name" headerAlign="center" allowSort="true" allowSort="false"
									visible="true">本地套餐类型</div>
						     </div> 
					    </div>
					    <!--  <div class="nui-toolbar" >
								<label>套餐类型</label>
							</div>
							<div class="nui-fit">
								<ul id="tree" class="nui-tree" url="" style="width: 100%;height:50%;"
									dataField="rs" showTreeIcon="true" textField="name" expandOnLoad="0"
									idField="id" ajaxData="setToken" parentField="" resultAsTree="false">
								</ul>
							</div> -->
						 
					   <div id="typeGrid2" dataField="result" class="nui-datagrid"
							showPager="false" showHGridLines="false" allowSortColumn="false"
							style="width: 100%; height: 50%;float:left;" multiSelect="false" >
							<div property="columns">
								<div field="pkgTypeName" headerAlign="center" allowSort="true" allowSort="false"
									visible="true">标准套餐类型</div>
						    </div> 
				         </div>
					</div>
				</div>
			</div>
			<div showCollapseButton="false">
					<div id="queryform" class="nui-form">
							<div class="nui-toolbar">
								<input class="nui-textbox" id="expense" visible="false"/>
								
								<input class="nui-hidden" name="criteria/_entity"
									value="com.hsapi.repair.data.rpbse.RpbCardStored">
								<table id="table1">
									<tr>
										<td>套餐名称: <input class="nui-textbox" onenter="search()" 
											name="criteria/_expr[1]/name" id="pkgName"/>
											<input class="nui-combobox" onenter="search()" id="serviceTypeId" visible="false"/>
											 <input class="nui-hidden"
											name="criteria/_expr[1]/_op" value="like"> <input
											class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
											<a class="nui-button" onclick="search()" plain="true"> <span
												class="fa fa-search fa-lg"></span>&nbsp; 查询
										</a> <a id="selectBtn" class="nui-button" onclick="choose()" plain="true"><span
												class="fa fa-check fa-lg"></span>&nbsp;选择 </a>
																		<a class="nui-button" id="lookInfo" onclick="look" plain="true"> <span
												class="fa fa-search fa-lg"></span>&nbsp; 查看详细信息
										</a>
					
										</td>
									</tr>
								</table>
							</div>
						</div>
						
						<div class="nui-fit">
							<div id="datagrid1" dataField="package1" class="nui-datagrid"
								pageSize="20" onDrawCell="onDrawCell"
								onrowclick="" allowSortColumn="true"
								style="width: 70%; height: 100%;float:left;"multiSelect="false" >
								<div property="columns">
									<div type="indexcolumn">序号</div>
									<div type="checkcolumn" visible="false" id="checkcolumn" name="checkcolumn"></div>
									<div field="id" headerAlign="center" allowSort="true"
										visible="false">套餐ID</div>
									<div field="name" headerAlign="center" allowSort="true" width="280">套餐名称</div>
									<div field="serviceTypeId"  headerAlign="center" allowSort="true"  width="80">
																		
										套餐类型</div>
									<div field="amount" headerAlign="center" allowSort="true" width="80">
											套餐金额</div>
									<div field="total" headerAlign="center" allowSort="true" width="80">市场金额</div>
					<!-- 				<div field="isShare" renderer="onstatus" headerAlign="center" -->
					<!-- 					allowSort="true">是否共享</div> -->
									<div field="isDisabled" renderer="onstatus" headerAlign="center"
										allowSort="true" visible="false">状态</div>
							  </div>
							</div>
						   <div class="nui-datagrid" style="width:70%;height:100%;float:left;display:none;"
							     id="packageGrid"
								 dataField="result"
								 idField="id"
								 showPager="true"
								 totalField="page.count"
								 sizeList=[50,100,200]
								 pageSize="50"
								 allowSortColumn="true"
								 sortMode="client"
								 >
								<div property="columns">
									<div type="indexcolumn">序号</div>
									  <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
									  <div field="pkgName" width="180" headerAlign="center" allowSort="true" header="套餐名称"></div>
									  <div field="pkg4sAmt" width="100" headerAlign="center" allowSort="true" header="4S店金额"></div>
									  <div field="pkgAmt" width="100" headerAlign="center" allowSort="true" header="套餐金额"></div>
							    </div>
			                 </div>
							
							<div id="splitDiv" style="float:left;width:1%;height:100%;display:none"></div>
								<div id="tempGrid" class="nui-datagrid" style="float:left;width:29%;height:100%;display:none"
										showPager="false"
										pageSize="1000"
										selectOnLoad="true"
										showModified="false"
										onrowdblclick=""
										multiSelect="true"
										dataField="data"
										url="">
										<div property="columns" >
											<div type="indexcolumn" width="20px" headerAlign="center">序号</div>
											<div header="已添加套餐" headerAlign="left">
												<div property="columns">
													<div type="checkboxcolumn" field="check" trueValue="1" falseValue="0" 
														width="20" headerAlign="center" header="">操作
													</div>
													<div field="packageName" headerAlign="center" allowSort="true" width="80px">套餐名称</div>
													<div field="amt" headerAlign="center" allowSort="true" width="20px">金额</div>								
												</div>
											</div>
									   </div>
								</div>
					</div>
			</div>
		</div>
	</div>
	    <div id="detailGrid_Form" style="display:none;">
			<div id="packageDetail" class="nui-datagrid" style="width:555px;"
				dataField="rs" showPager="false">
				<div property="columns">
					<div field="type" width="50" headerAlign="center" allowSort="true" header="类型"></div>
					<div field="id" visible="false" width="120" headerAlign="center" allowSort="true" header="项目/配件名称编码"></div>
					<div field="itemName" width="150" headerAlign="center" allowSort="true" header="名称"></div>
					<div field="itemKind" width="40" headerAlign="center" allowSort="true" header="工种"></div>
					<div field="qty" width="60" headerAlign="center" allowSort="true" header="工时/数量"></div>
					<div field="price" width="60" headerAlign="center" allowSort="true" header="单价"></div>
					<div field="amt" width="60" headerAlign="center" allowSort="true" header="金额"></div>
					<div field="partBrandId" visible="false" width="120" headerAlign="center" allowSort="true" header="配件品牌"></div>
				</div>
			</div>
	    </div>	
</body>
</html>
