<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-10-10 11:22:57
  - Description:
-->
<head>
<title>Title</title>
<script
	src="<%=webPath + contextPath%>/manage/settlement/js/receivable.js?v=1.0.3"></script>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<style>
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
</head>
<body>
<div style=" overflow:scroll; width:100%; height:100%;">
	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;">
		车辆<input class="nui-textbox" enabled="false" id="carNo" name="carNo" />
		客户<input class="nui-textbox" enabled="false" id="guest" name="guest" />
		挂账<input class="nui-textbox" enabled="false" id="" name="" /> 
		<fontsize=4 style="color: red;">代收金额</font><input class="nui-textbox" enabled="false" id="totalAmt" name="totalAmt" />
	</div>
			<div id="rtTr" class="vpanel panelwidth" style="height: auto;">
				<div class="vpanel_heading" style="background-color: #f3f4f6; color: #2d95ff;">
					<span>使用优惠</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td>额外优惠(-)</td>
							<td></td>
							<td><input class="nui-textbox"  id="rRPAmt"
								name=""></td>
						</tr>
					</table>
				</div>
				
				<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>套餐抵扣</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>
				
				<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>商城订单抵扣</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>
				
				<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>余额抵扣</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td>余额：<input class="nui-textbox" enabled="false" id="rechargeBalaAmt" name="rechargeBalaAmt"/></td>
							<td>抵扣：<input class="nui-textbox"  id="deductible" name="deductible"/></td>
							<td></td>
						</tr>
					</table>
				</div>

							<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>其他会员卡</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>
			
							<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>优惠券抵扣</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>

							<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>佣金抵扣</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>



				<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>积分抵扣</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>

			
			<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>收款方式</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>

			
			<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>备注</span>
				</div>
				<div class="vpanel_body">
					<table class="tmargin">
						<tr id="rcTr">
							<td>收款时间：<input  class="mini-datepicker"/></td>
							<td>收款备注：<input  class="mini-textbox"/></td>
							<td></td>
						</tr>
					</table>
				</div>

			
			<div class="vpanel_heading"
					style="background-color: #f3f4f6; color: #2d95ff;">
					<span>结算</span>
				</div>
				<div class="vpanel_body">
					<table >
						<tr >
							<td><font size=4 style="color: red;">代收金额</font><input class="nui-textbox" enabled="false" id="" name="" />元</td>
							<td><input type="checkbox"/>微信通知车主<input type="checkbox"/>短信通知车主</td>
							<td><font size=4 style="color: red;">剩余应收</font><input class="nui-textbox" enabled="false" id="" name="" />元</td>
						</tr>
						<tr>
							<td colspan="3">
								<div style="text-align: center; padding: 10px;">
								 	<a class="nui-button" onclick="settleOK" style="width: 60px; margin-right: 20px;">结算</a>
								 	<a class="nui-button" onclick="settleCancel" style="width: 60px;">取消</a>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
</div>
			<script type="text/javascript">
				nui.parse();
			</script>
</body>
</html>