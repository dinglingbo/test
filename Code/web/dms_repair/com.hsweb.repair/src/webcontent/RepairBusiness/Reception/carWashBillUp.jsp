<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
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
    <script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/CustomerProfile/CardUp.js?v=1.1.6"></script>
	        <div id="rtTr" class="vpanel panelwidth" style="height:auto;">
            <div id="rtTr" class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span>应收</span></div>
            <div class="vpanel_body">
                <table class="tmargin">
                    <tr id="rcTr">
                        <td style="text-align:center" width="60px" height="40px">套餐金额:</td>
                        <td id="rRPAmt" style="text-align:center;color:blue;text-decoration:underline" width="60px"></td>

                        <td style="text-align:center" width="60px">工时金额:</td>
                        <td id="rTrueAmt" style="text-align:center;color:blue;text-decoration:underline" width="60px"></td>

                        <td style="text-align:center" width="60px" >配件金额:</td>
                        <td id="rVoidAmt" style="text-align:center;color:blue;text-decoration:underline" width="60px"></td>

                        <td style="text-align:center" width="60px">应收:</td>
                        <td id="rNoCharOffAmt" style="text-align:center;color:blue;text-decoration:underline" width="60px"></td>
                    </tr>
                </table>

            </div>
        </div>

	        <div id="ctTr" class="vpanel panelwidth" style="height:auto;">
            <div id="ctTr" class="vpanel_heading" style="background-color:#f3f4f6;color:#2d95ff;"><span >预存套餐 (余额: </span><span id="rechargeBalaAmt"></span><span >) </span></div>
            <div class="vpanel_body">
                <table class="tmargin">
                    <tr >
                        <td style="text-align:center" style="width:40%; heigth " >储值抵扣:
                        	<input class="nui-textbox" id="dk" style="width: 70px" onvaluechanged="onChanged"/>
                        </td>    
                    </tr>
                    <tr >
                        <td style="text-align:center" style="width:40%" >实收:
                        	<input class="nui-textbox" id="dk" style="width: 70px" onvaluechanged="onChanged"/>
                        </td>    
                    </tr>
                     <tr>
	                    <td class="form_label" align="right">结算方式:</td>
						<td colspan="1">
							<div class="mini-radiobuttonlist" repeatItems="1"
								repeatLayout="table" repeatDirection="vertical" name="payType"
								textField="text" valueField="value"
								data="[{value:'020101',text:'现金',},{value:'020102',text:'刷卡'},{value:'020104',text:'微信/支付宝'}]" value="020101" >
							</div> 
						</td>	
                 </tr>
                 <tr>
                 		<td>
                 			
                 		</td>
                 </tr>
                </table>

            </div>
        </div>

     
		<div style="padding: 0px;" borderStyle="border:0;">
			<table width="100%">
				<tr >
				<td style="text-align:center;" colspan="1"  >
					<!-- <a	class="nui-button" iconCls="icon-save" onclick="readyPay()" id = "readyPay"> 转预结算 </a> 
					<spand>&nbsp;&nbsp;&nbsp;</spand> -->
					<a class="nui-button"  onclick="noPayOk()" id = "noPayOk" >保存</a> 
					<a class="nui-button"  onclick="payOk()" id = "payOk" >结算收款</a> 
				</td>
				</tr>
			</table>
		</div>
</body>
	<script type="text/javascript">

	</script>
</html>