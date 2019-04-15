<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

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
<script src="<%= request.getContextPath() %>/repair/js/DataBase/Item/RepairItemDetail.js?v=1.1.21"></script>
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
	<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a>
                            <a class="nui-button" onclick="onCancel" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</ a>
                        </td>
                    </tr>
                </table>
            </div>
	<div id="mainTabs" class="nui-tabs" name="mainTabs"
		activeIndex="0" 
		style="width:100%; height:85%;" 
		plain="false" >
		
		<div title="项目设置" id="itemTab" name="itemTab" >
				<div id="basicInfoForm" class="form">
					<input name="id" class="nui-hidden"/>
					<input name="orgid" class="nui-hidden"/>
					<div class="nui-panel" showToolbar="false" title="基本信息" showFooter="false"
						style="width:calc(100% - 20px);">
						<table class="nui-form-table" border=0>
							<tr>
								<td class="form_label required">
									<label>项目名称：</label>
								</td>
								<td  style="width:35%">
									<input class="nui-textbox" name="name" width="100%" maxlength="50"/>
								</td>
								<td class="form_label required">
									<label>业务类型：</label>
								</td>
								<td colspan="1">
							
			                      <input name="serviceTypeId"
			                             id="serviceTypeId"
			                             class="nui-combobox"
			                             textField="name"
			                             valueField="id"
			                             allowInput="true"
			                             width="100%"
			                             
			                            />
						     	</td>
							</tr>
							<tr>
							<td class="form_label required">
									<label>项目类型：</label>
								</td>
								<td colspan="1">
								
									<input class="nui-combobox" name="type" id="type"
											valueField="customid"
											textField="name"
											valueFromSelect="true"
											allowInput="true"
											width="100%"/>
						     	</td>
								<td class="form_label required">
									<label>项目编码：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="code" width="100%" maxlength="20"/>
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
											width="100%" popupHeight="100%"
											allowInput="true"
											valueFromSelect="true"
											/>
								</td>
								
							  <td class="form_label">
									<label>车系：</label>
								</td>
								<td>
									<input class="nui-combobox" name="carSeriesId" id="carSeriesId"
											valueField="carSeriesId"
											textField="carSeriesName"
											onValuechanged="initCarModel('carModelId', '', e.value)"
											width="100%" popupHeight="100%"
											allowInput="true"
											valueFromSelect="true"
											/>
								</td>
								
							</tr>
							<tr>
							   <td class="form_label">
									<label>品牌车型：</label>
								</td>
								<td colspan="3">
									<input class="nui-combobox" name="carModelId" id="carModelId"
											valueField="carModelId"
											textField="carModel"
											width="100%" popupHeight="100%"
											allowInput="true"
											valueFromSelect="true"
											/>
								</td>
							</tr>
							<tr>
							    <td align="right">
								<label>使用热度：</label>
								</td>
								<td colspan="3">
									<input class="nui-spinner"
											name="useTimes"
											id="useTimes"
											onvaluechanged="calc('useTimes')"
											format="0"
											value="0" maxValue="1000000000"
											changeOnMousewheel="true" showButton="false"
											width="20%"  selectOnFocus="true"/>
								    <label id="isCalTimes">是否禁用热度：</label>
								   <input name="isCalTimes" class="nui-checkbox" trueValue="1" falseValue="0" width="10%"/>
								   <label id="isShareTd">是否共享：</label> 
								   <input id="isShare" name="isShare" class="nui-checkbox" trueValue="1" falseValue="0" width="10%"/>
								   <label id="isCanOrderTd">是否可预约：</label>
								   <input name="isCanOrder" class="nui-checkbox" trueValue="1" falseValue="0" width="10%"/>
								   <label id="isDisabledTd">是否禁用：</label>
								   <input name="isDisabled" class="nui-checkbox" trueValue="1" falseValue="0" width="10%"/>
								</td>
							</tr>
							
							<tr>
							<td class="form_label" >
									<label>服务周期：</label>
							</td>
								<td>
									<input class="nui-spinner" name="serviceCycle" width="100%" format="0" value="0" maxValue="1000000000"/>
								</td>
								
							  <td class="form_label">
									<label>回访天数：</label>
								</td>
								<td>
									<input class="nui-spinner" name="visitDays" width="100%" format="0" value="0" maxValue="1000000000"/>
								</td>
							</tr>
							<tr>
							<td class="form_label">
									<label>间隔公里：</label>
								</td>
								<td>
									<input class="nui-spinner" name="intervalMile" width="100%" format="0" value="0" maxValue="1000000000"/>
								</td>
								
							  <td class="form_label">
									<label>间隔天数：</label>
								</td>
								<td>
									<input class="nui-spinner" name="intervalDays" width="100%" format="0" value="0" maxValue="1000000000"/>
								</td>
							</tr>
							
						</table>
					</div>
					<div class="nui-panel" showToolbar="false" title="项目价格信息" showFooter="false"
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
											width="100%" inputStyle="text-align:right;" selectOnFocus="true"/>
								</td>
								<td class="form_label">
									<label>单价：</label>
								</td>
								<td colspan="1">
									<input class="nui-spinner" name="unitPrice" id="unitPrice" format="0.00" value="0" maxValue="1000000000" selectOnFocus="true"
									onvaluechanged="calc('unitPrice')"	changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
								</td>
							</tr>            
							<tr>
								<td class="form_label">
									<label>金额：</label>
								</td>
								<td colspan="1">
									<input class="nui-spinner" name="amt" id="amt" format="0.00" value="0" maxValue="1000000000" selectOnFocus="true"
									onvaluechanged="calc('amt')"	changeOnMousewheel="true" showButton="false" width="100%" inputStyle="text-align:right;"/>
								</td>
							</tr>
						</table>
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
							<input class="nui-textbox" name="salesDeductValue" id="salesDeductValue" value="" onvalidation="onRateValidation" width="50px"/><span>%</span>
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
							<input class="nui-textbox" name="techDeductValue" id="techDeductValue" value="" onvalidation="onRateValidation" width="50px"/><span>%</span>
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
							<input class="nui-textbox" name="advisorDeductValue" id="advisorDeductValue" value="" onvalidation="onRateValidation" width="50px"/><span>%</span>
						</td>
					</tr>
				</table>
			</div>
		</div> 

	</div>
</div>

	
</body>
</html>