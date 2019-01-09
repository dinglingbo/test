<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-01-06 11:44:32
  - Description:
-->
<head>
<title>储值卡退款</title>

<script
	src="<%=request.getContextPath()%>/manage/settlement/js/refund.js?v=1.1.5"></script>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
        <style type="text/css">
    	.tips {
    	width:100%;
    color: #8a6d3b;
    background-color: #fcf8e3;
    border-color: #faebcc;
}
body,
		div,
		dl,
		dt,
		dd,
		ul,
		ol,
		li,
		h1,
		h2,
		h3,
		h4,
		h5,
		h6,
		p {
			margin: 0;
			padding: 0;
			font-family: "微软雅黑", "宋体", "黑体", Arial, simsun, Verdana, Lucida, Helvetica, sans-serif;
			font-size: 14px;
			font-style: normal;
			font-weight: normal;
			font-variant: normal;
			list-style-type: none;
		}
    </style>
</head>
<body>
			<div id="dataform1" >
				<table width="100%" height="85%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tbody>
						<tr>
							<td colspan="4">
								<div class="tips">
								<span class="fa fa-exclamation-triangle fa-lg" style="margin-left: 10px;"></span>退款会清空赠送金额并只能退赠送金额除外的余额<br>
								<span class="fa fa-exclamation-triangle fa-lg" style="margin-left: 10px;"></span>您只用输入退款金额，其余系统计算得出<br>
								<span class="fa fa-exclamation-triangle fa-lg" style="margin-left: 10px;"></span>退款请对清明细，谨慎操作！<br>
								</div>
							</td>
						</tr>
						<tr>
							<td align="right">
								客户：	
							</td>
							<td align="left">
								<input class="nui-textbox" id="guestName" name="guestName" width="100"  />
							</td>
						</tr>
						
						<tr>
							<td align="right">
								会员卡名称：		
							</td>
							<td align="left">
								<input class="nui-textbox" id="cardName" name="cardName" width="100"  />
							</td>
							<td align="right">
								剩余金额：
							</td>
							<td align="left">
								<input class="nui-textbox" id="balaAmt" name="balaAmt" width="100"  />		
							</td>
						</tr>
						<tr>
							<td align="right">
								充值金额：
							</td>
							<td align="left">
									<input class="nui-textbox" id="rechargeAmt" name="rechargeAmt" width="100"  />		

							</td>
							<td align="right">
								赠送金额：	

							</td>
							<td align="left">
								<input class="nui-textbox" id="giveAmt" name="giveAmt" width="100"  />	
							</td>
						</tr>

						<tr>
							<td align="right">
								退款金额<span style="color: red;">*</span>：		
							</td>
							<td align="left">
								<input class="mini-spinner" id="yrefundAmt" minValue="0" maxValue="100000" name="yrefundAmt" width="100" showButton="false" onvaluechanged="onrefundAmt()";/>		
							</td>
							<td align="right">
								退款后剩余金额：							
							</td>
							<td align="left">
								<input class="nui-textbox" id="trefundAmt" name="trefundAmt" width="100"  />								
							</td>
							</tr>
							<tr>
							<td align="right">
								已退款金额：							
							</td>
							<td align="left">
								<input class="nui-textbox" id="refundAmt" name="refundAmt" width="100"  />								
							</td>							
						</tr>
					</tbody>
				</table>
			</div>
		<div style="background-color: #cfddee;position:fixed; top:85%;width:100%;height: 15%; z-index:900;">
			 <table style="width:100%;" id="table1">
                    <tr>
                        <td style="width:100%;">
                          <a id="wxbtnsettle" style="    width: 70px;
							height: 40px;
							font-size: 18px;
							margin-top: 5px;
							background: #FFF;
							color: #333;
							text-align: center;
							display: block;
							border-radius: 5px;
							line-height: 2;
							float:right;
								margin-right:0px;
								margin-left:10px;
							text-decoration: none;" 
							href="javascript:void(0)" onclick="onClose()" >取消</a>
							
						 <a id="wxbtnsettle1" style="    width: 100px;
							height: 40px;
							font-size: 18px;
							background: #2ac476;
							color: #FFF;
							text-align: center;
							display: block;
							border-radius: 5px;
							margin-top: 5px;
							line-height: 2;
								float:right;
								margin-right:0px;
							text-decoration: none;" 
							href="javascript:void(0)" onclick="refundAmtPay()" >退款</a>
                           
                        </td>
                    </tr>
              </table>
		</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>