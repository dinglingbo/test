<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 09:26:10
  - Description:
-->
<head>
<title>新增和编辑</title>
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Item/RepairItemDetail.js?v=1.1.1"></script>
<style type="text/css">
/* table {
	table-layout: fixed;
	font-size: 12px;
	width: 100%;
} */
.dtable{
	table-layout: fixed;
	font-size: 12px;
	height: 100%;
	width: 100%;
}

.form_label {
	width: 60px;
	text-align: right;
}

.d_label {
	width: 80px;
	text-align: center;
}

.mini-panel {
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	width: calc(100% - 20px) !important;
}

.required {
	color: red;
}
</style>
</head>
<body>

<div class="nui-fit">
	<div id="mainTabs" class="nui-tabs" name="mainTabs"
		activeIndex="0" 
		style="width:100%; height:100%;" 
		plain="false" >
		<div title="工时设置" id="itemTab" name="itemTab" >
				<div id="basicInfoForm" class="form">
					<input name="id" class="nui-hidden"/>
					<div class="nui-panel" showToolbar="false" title="基本信息" showFooter="false"
						style="width:calc(100% - 20px);">
						<table class="nui-form-table" border=0>
							<tr>
								<td class="form_label required">
									<label>工时名称：</label>
								</td>
								<td>
									<input class="nui-textbox" name="name" width="100%"/>
								</td>
								<td class="form_label required">
									<label>工时类型：</label>
								</td>
								<td colspan="1">
									<input class="nui-combobox" name="type" id="type"
											valueField="customid"
											textField="name"
											valueFromSelect="true"
											allowInput="true"
											width="100%"/>
								</td>
							</tr>
							<tr>
								<td class="form_label required">
									<label>工时编码：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="code" width="100%"/>
								</td>
								
								 <td >
									<label>是否共享：</label>
								</td>
								<td colspan="1">
									
									<input name="isShare" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/>
								<label>是否禁用：</label>
								
					
									<input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/>
								</td>
									

								
							</tr>
							<tr>
								<td class="form_label">
									<label>品牌：</label>
								</td>
								<td>
									<input class="nui-combobox" name="carBrandId" id="carBrandId"
											valueField="id"
											textField="nameCn"
											onValuechanged="initCarSeries('carSeriesId', e.value)"
											width="100%"/>
								</td>
								<td class="form_label">
									<label>车系：</label>
								</td>
								<td>
									<input class="nui-combobox" name="carSeriesId" id="carSeriesId"
											valueField="carSeriesId"
											textField="carSeriesName"
											onValuechanged="initCarModel('carModelId', '', e.value)"
											width="100%"/>
								</td>
							</tr>
							<tr>
								<td class="form_label">
									<label>车型：</label>
								</td>
								<td colspan="3">
									<input class="nui-combobox" name="carModelId" id="carModelId"
											valueField="carModelId"
											textField="carModel"
											width="100%"/>
								</td>
							</tr>
						</table>
					</div>
					<div class="nui-panel" showToolbar="false" title="工时价格信息" showFooter="false"
							style="width:calc(100% - 20px);">
						<table class="nui-form-table" border=0>
							<tr>
								<td class="form_label">
									<label>标准工时：</label>
								</td>
								<td colspan="1">
									<input class="nui-spinner"
											name="itemTime"
											id="itemTime"
											onvaluechanged="calc('itemTime')"
											format="0.00"
											value="0" maxValue="1000000000"
											changeOnMousewheel="true" showButton="false"
											width="100%" inputStyle="text-align:right;"/>
								</td>
								<td class="form_label">
									<label>工时单价：</label>
								</td>
								<td colspan="1">
									<input class="nui-spinner" name="unitPrice" id="unitPrice" format="0.00" value="0" maxValue="1000000000"
									onvaluechanged="calc('unitPrice')"	changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
								</td>
							</tr>            
							<tr>
								<td class="form_label">
									<label>工时金额：</label>
								</td>
								<td colspan="1">
									<input class="nui-spinner" name="amt" id="amt" format="0.00" value="0" maxValue="1000000000"
									onvaluechanged="calc('amt')"	changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
								</td>
							</tr>
							<!--
							<tr>
								<td class="form_label">
									<label>提成金额：</label>
								</td>
								<td colspan="1">
									<input class="nui-spinner" name="deductAmt" format="0.00" value=" " maxValue="1000000000"
											changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
								</td>
							</tr>
							-->
						</table>
					<!-- </div>
					<div class="nui-panel" showToolbar="false" title="成本设置" showFooter="false"
							style="width:calc(100% - 20px);">
						<table class="nui-form-table" border=0>			
							<tr>
								<td class="form_label">
									<label>成本分类：</label>
								</td>
								<td colspan="1">
									<input class="nui-combobox" name="costType" id="costType"
												valueField="customid"
												textField="name"
												width="100%"/>
								</td>
								<td class="form_label">
									<label>成本参数：</label>
								</td>
								<td colspan="1">
									<input class="nui-spinner" id="costParam" name="costParam" format="0.00" value="0" maxValue="1000000000"
											changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
								</td>
							</tr>
						</table>
					</div> -->
				</div>
			</div>
		</div>
		<div title="提成设置" id="deductTab" name="deductTab" >
			<div id="deductForm" class="form">
				<input name="id" class="nui-hidden"/>
				<table class="dtable" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td rowspan="2" class="d_label">
							<label>销售</label>
						</td>
						<td class="d_label">
							<label>提成类型:</label>
						</td>
						<td>
							<div id="salesDeductType" name="salesDeductType" 
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
							<input class="nui-textbox" name="salesDeductValue" id="salesDeductValue" value="0" onvalidation="onRateValidation" width="50px"/><span>%</span>
						</td>
					</tr>
					<tr style="height:5px;">
						<td colspan="3">
							<hr/>
						</td>
					</tr>
					<tr>
						<td rowspan="2" class="d_label">
							<label>施工</label>
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
					</tr>
					<tr style="height:5px;">
						<td colspan="3">
							<hr/>
						</td>
					</tr>
					<tr>
						<td rowspan="2" class="d_label">
							<label>服务顾问</label>
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
<div style="text-align:center;padding:10px;">
	<a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>
	<a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>
</div>	
	
</body>
</html>