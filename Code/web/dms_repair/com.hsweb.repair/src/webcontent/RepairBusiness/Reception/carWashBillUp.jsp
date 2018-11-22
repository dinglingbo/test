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
<title>洗车工单结算</title>
<script src
	="<%=request.getContextPath()%>/repair/js/RepairBusiness/Reception/subpage/carWashBillUp.js?v=1.1.5">
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
</style>
<div id="rtTr" class="vpanel panelwidth" style="height: auto;">
	<div id="rtTr" class="vpanel_heading"
		style="background-color: #f3f4f6; color: #2d95ff;">
		<span>明细</span>
	</div>
	<div id="sellForm" class="form">
		<table >
			<tr >
				<td>套餐金额:<input class="nui-textbox" enabled="false" width="50%" id="packageSubtotal" name="packageSubtotal"/></td>

				<td>项目金额:<input class="nui-textbox" enabled="false" width="50%" id="itemSubtotal" name="itemSubtotal"/></td>

				<td>配件金额:<input class="nui-textbox" enabled="false" width="50%" id="partSubtotal" name="partSubtotal"/></td>
			</tr>
			
 			<tr >
				<td>套餐优惠:<input class="nui-textbox" enabled="false" width="50%" id="packagePrefAmt" name="packagePrefAmt"/></td>

				<td>项目优惠:<input class="nui-textbox" enabled="false" width="50%" id="itemPrefAmt" name="itemPrefAmt"/></td>

				<td>配件优惠:<input class="nui-textbox" enabled="false" width="50%" id="partPrefAmt" name="partPrefAmt"/></td>
			</tr>


			<tr>
				<td>储值余额:<input class="nui-textbox" enabled="false" id="rechargeBalaAmt" name="rechargeBalaAmt" width="50%"  /></td>
				<td ><font  style=" color: red;">储值抵扣:</font><input class="mini-spinner" id="deductible" name="deductible" width="50%" minValue="0" maxValue="1000000" showbutton="false" allowNull="false" onvaluechanged="onChanged" /></td>
				<td ><font  style=" color: red;">优惠金额:</font><input class="mini-spinner" id="PrefAmt" name="PrefAmt" width="50%" minValue="0" maxValue="1000000" showbutton="false" allowNull="false" onvaluechanged="onChanged" /></td>
			</tr>

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
				<td align="right">结算方式:</td>
				<td colspan="2">
					<div class="mini-radiobuttonlist" repeatItems="1"
						repeatLayout="table" repeatDirection="vertical" id="payType" name="payType"
						textField="text" valueField="value"
						data="[{value:'020101',text:'现金',},{value:'020102',text:'刷卡'},{value:'020104',text:'微信/支付宝'}]"
						value="020101" ></div>
				</td>
			</tr>
		</table>
	</div>
</div>



<div style="padding: 0px;" borderStyle="border:0;">
	<table width="100%">
		<tr>
			<td style="text-align: center;" colspan="1">
				<!-- <a	class="nui-button" iconCls="icon-save" onclick="readyPay()" id = "readyPay"> 转预结算 </a> 
					<spand>&nbsp;&nbsp;&nbsp;</spand> --> <a class="nui-button"
				onclick="noPay()" id="noPay">保存</a> <a class="nui-button"
				onclick="pay()" id="pay">结算收款</a>
			</td>
		</tr>
	</table>
</div>
</body>
<script type="text/javascript">
	
</script>
</html>