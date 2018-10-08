<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-15 17:18:09
  - Description:
-->
<head>
<title>工单结算</title>
<script src ="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/billSettle.js?v=1.0.1">
</script>
<style type="text/css">
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
a.optbtn {
	width: 44px;
	/* height: 26px; */
	border: 1px #d2d2d2 solid;
	background: #f2f6f9;
	text-align: center;
	display: inline-block;
	/* line-height: 26px; */
	margin: 0 4px;
	color: #000000;
	text-decoration: none;
	border-radius: 5px;
}
</style>
<div id="rtTr" class="vpanel panelwidth" style="height: auto;">
	<div id="rtTr" class="vpanel_heading"
		style="background-color: #f3f4f6; color: #2d95ff;">
		<span>明细</span>
	</div>
	<div id="sellForm" class="form">
		<table style="width:100%">
			<tr >
				<td>套餐金额:<input class="nui-textbox" enabled="false" width="50%" id="packageSubtotal" name="packageSubtotal"/></td>

				<td>工时金额:<input class="nui-textbox" enabled="false" width="50%" id="itemSubtotal" name="itemSubtotal"/></td>

				<td>配件金额:<input class="nui-textbox" enabled="false" width="50%" id="partSubtotal" name="partSubtotal"/></td>
			</tr>
			
 			<tr >
				<td>套餐优惠:<input class="nui-textbox" enabled="false" width="50%" id="packagePrefAmt" name="packagePrefAmt"/></td>

				<td>工时优惠:<input class="nui-textbox" enabled="false" width="50%" id="itemPrefAmt" name="itemPrefAmt"/></td>

				<td>配件优惠:<input class="nui-textbox" enabled="false" width="50%" id="partPrefAmt" name="partPrefAmt"/></td>
			</tr>


			<tr>
				<td>储值余额:<input class="nui-textbox" enabled="false" id="rechargeBalaAmt" name="rechargeBalaAmt" width="50%"  /></td>
				<td ><font  style=" color: red;">储值抵扣:</font><input class="mini-spinner" id="deductible" name="deductible" width="50%" minValue="0" maxValue="1000000" showbutton="false" allowNull="false" onvaluechanged="onChanged" /></td>
				<td ><font  style=" color: red;">优惠金额:</font><input class="mini-spinner" id="PrefAmt" name="PrefAmt" width="50%" minValue="0" maxValue="1000000" showbutton="false" allowNull="false" onvaluechanged="onChanged" /></td>
			</tr>
		</table>
		
	</div>
</div>
<div class="nui-fit">
	<div class="nui-fit">
		<div class="" style="width:100%;height:auto;" >
			<div id="receiveGrid"
				borderStyle="border-bottom:1;"
				class="nui-datagrid"
				dataField="" style="width: 100%; height:100px;"
				showPager="false"showModified="false" allowSortColumn="true"
				>
				<div property="columns">
					<div type="indexcolumn" headerAlign="center" name="index" visible="true" width="15">序号</div>
					<div header="其他收入">
						<div property="columns">
							<div field="optBtn" name="optBtn" width="40" headerAlign="center" header="操作" align="center" ></div>
							<div field="billTypeId" type="comboboxcolumn" width="100" headerAlign="center" header="收入项目">
								<input  property="editor" enabled="true" id="billTypeList" name="list" data="list" dataField="list" class="nui-combobox" valueField="id" onvaluechanged="onbillTypeChange" textField="name" url="" emptyText=""  vtype="required"/> 
							</div>
							<div field="charOffAmt" width="60" summaryType="sum" headerAlign="center" header="收入金额">
								<input property="editor" vtype="float" class="nui-textbox"/>
							</div>
							<div field="remark" width="80" headerAlign="center" header="备注">
								<input property="editor" class="nui-textbox"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="" style="width:100%;height:auto;" >
			<div id="payGrid"
				borderStyle="border-bottom:1;"
				class="nui-datagrid"
				dataField="" style="width: 100%; height:100px;"
				showPager="false"showModified="false" allowSortColumn="true"
				>
				<div property="columns">
					<div type="indexcolumn" headerAlign="center" name="index" visible="true" width="15">序号</div>
					<div header="费用支出">
						<div property="columns">
							<div field="optBtn" name="optBtn" width="40" headerAlign="center" header="操作" align="center" ></div>
							<div field="billTypeId" type="comboboxcolumn" width="100" headerAlign="center" header="费用科目">
								<input  property="editor" enabled="true" id="billTypeList" name="list" data="list" dataField="list" class="nui-combobox" valueField="id" onvaluechanged="onbillTypeChange" textField="name" url="" emptyText=""  vtype="required"/> 
							</div>
							<div field="charOffAmt" width="60" summaryType="sum" headerAlign="center" header="支出金额">
								<input property="editor" vtype="float" class="nui-textbox"/>
							</div>
							<div field="remark" width="80" headerAlign="center" header="备注">
								<input property="editor" class="nui-textbox"/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<table style="width:100%; height:auto;">
		<tr>
			<td colspan="3"><div id="rtTr" class="vpanel_heading" style="background-color: #f3f4f6; color: #2d95ff;"><span>收款</span></div></td>
		</tr>

		<tr >
			<td colspan="3" align="center" ><font size=4 style=" color: red;">应收:</font><input class="nui-textbox" enabled="false" width="" id="mtAmt" name="mtAmt"/></td>
		</tr>
		<tr >
			<td colspan="3" align="center"  ><font size=4 style=" color: red;">实收:</font><input class="nui-textbox" enabled="false" width="" id="amount" name="amount"/></td>
		</tr>
		<tr>
			<td colspan="3" align="center">
					结算方式:<div class="mini-radiobuttonlist" repeatItems="1"
					repeatLayout="table" repeatDirection="vertical" id="payType" name="payType"
					textField="text" valueField="value"
					data="[{value:'020101',text:'现金',},{value:'020102',text:'刷卡'},{value:'020104',text:'微信/支付宝'}]"
					value="020101" ></div>
			</td>
		</tr>
	</table>
</div>



<div style="padding: 0px;" borderStyle="border:0;">
	<table width="100%">
		<tr>
			<td style="text-align: center;" colspan="1">
				<!-- <a	class="nui-button" iconCls="icon-save" onclick="readyPay()" id = "readyPay"> 转预结算 </a> 
					<spand>&nbsp;&nbsp;&nbsp;</spand> --> <a class="nui-button"
				onclick="noPay()" id="noPay">转预结算</a> <a class="nui-button"
				onclick="pay()" id="pay">结算收款</a>
			</td>
		</tr>
	</table>
</div>
</body>
<script type="text/javascript">
	
</script>
</html>