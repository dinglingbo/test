<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
<head>
<title>套餐明细</title>
<script
	src="<%=request.getContextPath()%>/repair/js/Card/packageDetail.js?v=1.1.7"></script>
</head>
<body>
		<fieldset
		style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;">
		<legend> 套餐 </legend>
		<div id="dataform1" style="padding-top: 5px;" >
			<!-- hidden域 -->
			<input class="nui-hidden" name="" id="" /> <input class="nui-hidden"
				name="id" id="id" />
			<table style="width: 100%; table-layout: fixed;"
				class="nui-form-table">
				<tr>
					<td class="form_label" style="width: 15%;" align="right" >套餐名称:</td>
					<td colspan="1" style="width: 35%;"><input class="nui-textbox"
						name="name" readonly="readonly"/></td>
					<td class="form_label" style="width: 13%;" align="right">套餐类型:</td>
					<td colspan="2" style="width: 37%;"><input class="nui-textbox"
						name="serviceTypeId"   readonly="readonly"/></td>
				</tr>
				<tr>
					<td class="form_label" align="right">适用车辆品牌:</td>
					<td colspan="1"><input class="nui-textbox" name="carBrandId"
						readonly="readonly" /></td>
					<td class="form_label" align="right">适用车系:</td>
					<td colspan="2"><input class="nui-textbox" name="carSeriesId"
						readonly="readonly" /></td>
				</tr>
				<tr>
					<td class="form_label" align="right">适用车型:</td>
					<td colspan="1"><input class="nui-textbox" name="carModelId"
						readonly="readonly" /></td>
					<td class="form_label" align="right">市场金额:</td>
					<td colspan="2"><input class="nui-textbox" name="total"
						readonly="readonly" /></td>
				</tr>
				<tr>
						<td class="form_label" align="right">套餐金额:</td>
						<td colspan="1"><input class="nui-textbox" name="amount"
							readonly="readonly" /></td>
					</tr>
				<tr>
					<td class="form_label" align="right">状态:</td>
					<td colspan="2">

						<div class="mini-radiobuttonlist" repeatItems="1"
							repeatLayout="table" repeatDirection="vertical" name="isDisabled"
							textField="text" valueField="value"
							data="[{value:'0',text:'启用',},{value:'1',text:'禁用'}]" value="0">
						</div>
				</tr>
				<tr>
					<td class="form_label" align="right">套餐说明:</td>
					<td colspan="1"><input class="nui-TextArea" name="description"
						style="width: 330px; height: 50px;" readonly="readonly"/></td>
				</tr>	
			</table>
		</div>
	</fieldset>	
	
<table cellspacing="200px" bgcolor="#FOF8FF" >  
<div id="tabs1" class="mini-tabs" activeIndex="0" style="width: 100%;height: 100%;" plain="false" >
    <div title="项目明细" >
	<div id="item" class="nui-datagrid" style="width: 100%;height: 100%;"
						showPager="false" sortMode="client" allowCellEdit="true"
						allowCellSelect="true" multiSelect="true" showSummaryRow="true"
						editNextOnEnterKey="true" onDrawCell="onDrawCell">
						<div property="columns">
							<div field="prdtId" class="nui-hidden" allowSort="true"
								align="left" headerAlign="center" width="" visible="false">
								工时ID 
							</div>
							<div field="itemName" allowSort="true" align="left"
								headerAlign="center" width="">项目名称</div>
							<div field="itemTime" allowSort="true" align="left"
								headerAlign="center" width="">工时</div>
							<div field="truePrice" allowSort="true" align="left"
								headerAlign="unit_price" width="" headerAlign="center">
								单价 
							</div>
							<div field="trueAmt" allowSort="true" align="left"
								headerAlign="center" width="" summaryType="sum">
								金额 
							</div>
							<div field="remark" allowSort="true" align="left"
								headerAlign="center" width="">
								备注 
							</div>
						</div>
					</div>
    	</div>
    
    
    	<div title="配件明细"  >
					<div id="part" class="nui-datagrid" style="width: 100%; height: 100%;"
						showPager="false" sortMode="client" allowCellEdit="true"
						allowCellSelect="true" multiSelect="true" showSummaryRow="true"
						editNextOnEnterKey="true" onDrawCell="onDrawCell">
						<div property="columns">
							<div field="prdtId" class="nui-hidden" allowSort="true"
								align="left" headerAlign="center" width="" visible="false">
								配件ID 
							</div>
							<div field="partName" allowSort="true" align="left"
								headerAlign="center" width="">配件名称</div>
							<div field="qty" allowSort="true" align="left"
								headerAlign="center" width="">数量</div>
							<div field="trueAmt" allowSort="true" align="left"
								headerAlign="center" width="">
								单价 
							</div>
							<div field="unit" allowSort="true" align="left"
								headerAlign="center" width="">
								单位 
							</div>
							<div field="truePrice" allowSort="true" align="left"
								headerAlign="center" width="" summaryType="sum">
								金额
							</div>
							<div field="remark" allowSort="true" align="left"
								headerAlign="center" width="">
								备注 
							</div>
						</div>
					</div>
   	 	</div>
</div>
</table>			
	


	<input class="nui-combobox" visible="false" name="serviceTypeId" id="serviceTypeId"
										   valueField="id" allowInput="true" valueFromSelect="true"
										   textField="name"/>
				
</body>
</html>
