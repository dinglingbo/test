<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 18:03:07
  - Description:
-->
<head>
<title>本店套餐</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Package/PackageMain.js?v=2.5.10"></script>
 <!-- <style type="text/css">
 .required {
            color: red;
        }
 </style> -->
</head>

<body>
<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
	<div id="queryForm">
		<table>
			<tr>
				<td>
					<label class="form_label">名称：</label>
					<input class="nui-textbox" name="name" id="name-search" onenter="onSearch()"/>
					<label class="form_label">品牌：</label>
					<input class="nui-combobox" name="carBrandId" id="carBrandId-search" valueField="id" textField="nameCn" allowInput="true" valueFromSelect="true" onenter="onSearch()"/>
					<label class="form_label">业务类型：</label>
					<input class="nui-combobox" name="serviceTypeId" id="type-serviceTypeId" valueField="id" textField="name" allowInput="true" valueFromSelect="true" onenter="onSearch()"
					   valueFromSelect="true"/>
					<a class="nui-button" plain="true" iconCls="" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
					<input name="type"  id="type" visible="false"
                                             class="nui-combobox width1"
                                             textField="name"
                                             valueField="customid"/>
				</td>
			</tr>
		</table>
	</div>
</div>
<div class="nui-toolbar" style="border-bottom: 0; padding: 0px; height: 30px;">
	<table>
		<tr>
			<td>
				<a class="nui-button" id="add" iconCls="" onclick="addPackage()" plain="true"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
				<a class="nui-button" id="save" iconCls="" onclick="save()" plain="true"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
			</td>
		</tr>
	</table>
</div>
<div class="nui-fit">
	<div class="nui-splitter"
		 style="width: 100%; height: 100%;"
		 allowResize="false"
		 borderStyle="border:0"
		 showHandleButton="false">
		<div size="300" showCollapseButton="false" style="border: 0;">
			<!-- 套餐信息 -->
			<div class="nui-fit">
				<div id="leftGrid" dataField="list" class="nui-datagrid"
					 style="width: 100%; height:100%;"
					 showPager="true"
					 selectOnLoad="true"
					 pageSize="50"
         			 sizeList="[20,50,100]"
         			 totalField="page.count"
					 allowSortColumn="true">
					<div property="columns">
						<div header="套餐信息" headerAlign="center">
							<div property="columns">
								<div field="name" headerAlign="center" width="120px" visible="true">套餐名称</div>
								<div field="serviceTypeId" headerAlign="center" width="50px" visible="true">套餐类别</div>
								<div field="amount" headerAlign="center" width="55px" visible="true">套餐金额</div>
								<div field="orgid" headerAlign="center" width="40px" visible="true">所属</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="false" style="border: 0;">
			<div class="nui-tabs" activeIndex="0"  style="width:100%;height:100%;" plain="false">
				<div title="基本信息">
					<!-- 基本信息 -->
					<div class="form" id="basicInfoForm">
						<input class="nui-hidden" name="id"/>
						<table class="nui-form-table" style="width: inherit;">
							<tr>
								<td class="form_label">
									<label><font color="red">套餐名称：</font></label>
								</td>
								<td colspan="9">
									<input name="name" class="nui-textbox" width="100%"/>
								</td>
							</tr>
							<tr>
								<td class="form_label">
									<label><font color="red">套餐业务类型：</font></label>
								</td>
								<td>
									<input class="nui-combobox" name="serviceTypeId" id="serviceTypeId"
										   valueField="id" allowInput="true" valueFromSelect="true"
										   textField="name"/>
								</td>
								<td class="form_label">
									<label>市场金额：</label>
								</td>
								<td colspan="1">
									<input name="total" class="nui-spinner" enabled="false" id="sAmt"
										   format="￥0.00" allowInput="false" showButton="false"
										   inputStyle="text-align:right;"
										   minValue="0" maxValue="1000000000"
										   changeOnMousewheel="false" value=""/>
								</td>
								<td class="form_label">
									<label>套餐金额：</label>
								</td>
								<td colspan="1">
									<input name="amount" enabled="false" id="tAmt"
										   class="nui-spinner"
										   format="￥0.00"
										   showButton="false"
										   inputStyle="text-align:right;"
										   minValue="0" maxValue="1000000000"
										   changeOnMousewheel="false" value=""/>
								</td>
								<td class="form_label">
									<label>套餐编码：</label>
								</td>
								<td colspan="3">
									<input name="id" class="nui-textbox" enabled="false" width="100%"/>
								</td>
							</tr>
							<tr>
								<td class="form_label">
									<label>适用品牌：</label>
								</td>
								<td>
									<input name="carBrandId" id="carBrandId" class="nui-combobox" allowInput="false"
										   textField="nameCn"
										   valueField="id" showNullItem="false"
										   onvaluechanged="onCarBrandChange"									   
										   />
								</td>
								<td class="form_label">
									<label>适用车型：</label>
								</td>
								<td colspan="3">
									<input name="carModelId" id="carModelId" class="nui-combobox" allowInput="false"
										   textField="carModel"
										   width="100%"
										   valueField="carModelId" showNullItem="false"/>
								</td>
								<td colspan="2" style="width:50px;">
									<label id="isShareTd" >是否共享：</label>
									<input id="isShare" name="isShare" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/>
									<label>是否禁用：</label>
									<input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/><br/>
									
									<label>是否允许优惠：</label>
									<input name="isCanRate" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/>
								</td>
							</tr>
							<tr>
								<td class="form_label">
									<label>套餐说明：</label>
								</td>
								<td colspan="9">
									<textarea name="description" class="nui-textarea" width="100%"></textarea>
								</td>
							</tr>
						</table>
					</div>				
					<div class="nui-fit">
						<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false"
							 borderStyle="border:0"
							 showHandleButton="false">
							<div size="55%" showCollapseButton="false" style="border:0;">
								<!-- 工时信息 -->
								<div class="nui-toolbar" id="div_2"
									 style="border-bottom: 0; padding: 0px; height: 30px;">
									<table>
										<tr>
											<td>
												<a class="nui-button" plain="true" iconCls="" onclick="addItem()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加项目</a>
												<a class="nui-button" plain="true" iconCls="" onclick="removeItem()"><span class="fa fa-trash-o"></span>&nbsp;删除项目</a>
											</td>
										</tr>
									</table>
								</div>
								<div class="nui-fit">
									<div id="itemGrid"
										 dataField="rpbItime"
										 class="nui-datagrid"
										 style="width: 100%; height:100%;" allowCellEdit="true"  
										 showPager="false"
										 idField="itemId"
										 allowCellEdit="true" showSummaryRow="true" showGroupSummary="true"
										 allowCellSelect="true"
										 allowSortColumn="true">
										<div property="columns" >
											<div type="indexcolumn" width="40" summaryType="count">序号</div>
											<div header="项目信息" headerAlign="center" >
												<div property="columns">
													<div field="itemCode" headerAlign="center" width="60" visible="true">项目编码</div>
													<div field="itemName" headerAlign="center" width="60"  visible="true">项目名称</div>
													<!-- <div field="itemKind" headerAlign="center"  width="60"  visible="true">工种</div> -->
													<div field="type" headerAlign="center" width="80"  visible="true">项目类型</div>
													<div field="itemTime" headerAlign="center" width="55"  visible="true">工时/数量</div>
													<div field="unitPrice" headerAlign="center" width="55"  visible="true">原价</div>
													<div field="truePrice"  align="left" headerAlign="center" width="55">
														销价 <input class="nui-spinner" name="sellPrice" property="editor" minValue="0" dataType="float" showButton="false" maxValue="100000000" onvaluechanged ="onValueChangedSellPrice"/>
													</div>
													<div field="amt" headerAlign="center" width="55"  visible="true" summaryType="sum">原金额</div>
													<div field="trueAmt" headerAlign="center" width="55"  visible="true" summaryType="sum">销售金额</div>
													<div  field="techDeductType" headerAlign="center"  width="90"  visible="true" >提成类型</div>
													<div field="techDeductValue" headerAlign="center" width="55"  visible="true">提成值</div>
												</div>
											</div>
										</div>
									</div>
								</div>	
							</div>
							<div showCollapseButton="false" style="border: 0;">
								<!-- 零件信息 -->
								
								<div class="nui-toolbar" style="border-bottom: 0; padding: 0px; height: 30px;">
									<table>
										<tr>
											<td>
												<a class="nui-button" plain="true" iconCls="" onclick="addPart()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加配件</a>
												<a class="nui-button" plain="true" iconCls="" onclick="removePart()"><span class="fa fa-trash-o"></span>&nbsp;删除配件</a>
											</td>
										</tr>
									</table>
								</div>
								<div class="nui-fit">
									<div id="rightPartGrid" dataField="rpbPart" class="nui-datagrid"
										 style="width: 100%; height: 100%;"
										 showPager="false"
										 idField="partId"
										 allowCellEdit="true" showSummaryRow="true" showGroupSummary="true"
										 allowCellSelect="true"
										 allowSortColumn="true">
										<div property="columns">
											<div type="indexcolumn" width="40" summaryType="count">序号</div>
											<div header="零件信息" headerAlign="center">
												<div property="columns">
													<div field="partCode" headerAlign="center"  visible="true" width="60">配件编码</div>
													<div field="partName" headerAlign="center"  visible="true" width="60">配件名称</div>
												</div>
											</div>
											<div header="价格信息" headerAlign="center">
												<div property="columns">
													<div field="qty" headerAlign="center"  visible="true" header="数量"  width="50" dataType="int">
														<input property="editor" class="nui-spinner"  minValue="1" maxValue="100000000" style="width:100%;"
															   decimalPlaces="0"
															   allowNull="false"/>
													</div>
													<div field="unitPrice" headerAlign="center"  visible="true" header="原价"  width="60" dataType="float">
														<input property="editor" class="nui-spinner"  minValue="0" maxValue="100000000" showButton="false" width="55"
															   allowNull="false" style="width:100%;" decimalPlaces="2"/>
													</div>
													<div field="truePrice" headerAlign="center"  visible="true" header="销价"  width="55" dataType="float">
														<input property="editor" class="nui-spinner"  minValue="0" maxValue="100000000" showButton="false"
															   allowNull="false" style="width:100%;" decimalPlaces="2"/>
													</div>
													<div field="amt" headerAlign="center"  visible="true" decimalPlaces="2" dataType="float"  width="55" summaryType="sum">原金额</div>
												<div field="trueAmt" headerAlign="center"  visible="true" decimalPlaces="2" dataType="float"  width="55" summaryType="sum">销售金额</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
						<div title="提成设置" id="deductTab" name="deductTab" >
			<div id="deductForm" class="form">
					<div class="form" id="basicInfoForm1">
				<!-- <input name="id" class="nui-hidden"/> -->
				<table class="dtable" border="0" cellspacing="0" cellpadding="0" align="center" width="100%" height="80%">
					<tr>
						<td rowspan="2" width="11%" align="center">
							<font size="4">销售</font>
						</td>
						<td width="7%">
							提成类型:
						</td>
						<td width="65%">
							<div id="salesDeductType" name="salesDeductType" 
								class="nui-radiobuttonlist" value="2" repeatItems="4" 
								repeatDirection="" repeatLayout="table"
								textField="text" valueField="id" onvaluechanged="hidePercent"></div>
						</td>
					</tr>
					<tr>
						<td >
							<label>提成金额:</label>
						</td>
						<td>
							<input class="nui-textbox" name="salesDeductValue" id="salesDeductValue" value="0" onvalidation="onRateValidation" width="50px"/><span>%</span>
						</td>
					</tr>
				<!-- 	<tr style="height:5px;">
						<td colspan="3">
							
						</td>
					</tr>
					<tr>
						<td rowspan="2" class="d_label" align="center">
						<font size="4">施工</font>
						</td>
						<td class="d_label">
							<label>提成类型:</label>
						</td>
						<td>
							<div id="techDeductType" name="techDeductType" 
								class="nui-radiobuttonlist" value="2" repeatItems="4" 
								repeatDirection="" repeatLayout="table" 
								textField="text" valueField="id" onvaluechanged="hidePercent"></div>
						</td>
					</tr>
					<tr>
						<td class="d_label">
							<label>提成金额:</label>
						</td>
						<td>
							<input class="nui-textbox" name="techDeductValue" id="techDeductValue" value="0" onvalidation="onRateValidation" width="50px"/><span>%</span>
						</td>
					</tr> -->
					<tr style="height:5px;">
						<td colspan="3">
							
						</td>
					</tr>
					<tr>
						<td rowspan="2" class="d_label" align="center">
						<font size="4">服务顾问</font>
						</td>
						<td class="d_label">
							<label>提成类型:</label>
						</td>
						<td>
							<div id="advisorDeductType" name="advisorDeductType" 
								class="nui-radiobuttonlist" value="2" repeatItems="4" 
								repeatDirection="" repeatLayout="table" 
								textField="text" valueField="id" onvaluechanged="hidePercent"></div>
						</td>
					</tr>
					<tr>
						<td class="d_label">
							<label>提成金额:</label>
						</td>
						<td>
							<input class="nui-textbox" name="advisorDeductValue" id="advisorDeductValue" value="0" onvalidation="onRateValidation" width="50px"/><span>%</span>
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