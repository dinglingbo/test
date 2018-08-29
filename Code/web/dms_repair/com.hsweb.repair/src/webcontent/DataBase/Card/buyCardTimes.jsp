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
<title>计次卡购买</title>
<script
	src="<%=request.getContextPath()%>/repair/js/Card/buyCardTimes.js?v=1.0.3"></script>
</head>
<body>
<div class="nui-fit">
	<fieldset style="border: solid 1px #aaa; position: relative; margin: 5px 2px 0px 2px;">
		<legend> 选择客户 </legend>
		<div id="dataform2" style="padding-top: 5px;" >	
		<table style="width: 100%; height:60%;table-layout: fixed;"
				class="nui-form-table">	
				<input class="nui-hidden" name="guestId" id="guestId" />	
				 <tr>
				 <!-- hidden域 -->			
                        <td class="form_label" style="width:15%;" align="right">
                            <label>客户名称:</label>
                        </td>
                        <td style="width:25%;">
                            <input class="nui-buttonedit" id="contactorName" name="contactorName" textname="contactorName" 
                            emptyText="请选择..." onbuttonclick="selectCustomer"  allowInput="false"
                            selectOnFocus="true" required="true" />
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
                    <td class="form_label" align="right">结算金额:</td>
					<td colspan="1">
                    <input class="nui-textbox" name="sellAmt" vtype="float" readonly="readonly" id = "sellAmt"/>					
					</td>	
                 </tr>
          </table>	
		</div>
		<div style="padding: 0px;" borderStyle="border:0;">
			<table width="100%">
				<tr >
				<td style="text-align:center;" colspan="1"  >
					<!-- <a	class="nui-button" iconCls="icon-save" onclick="readyPay()" id = "readyPay"> 转预结算 </a> 
					<spand>&nbsp;&nbsp;&nbsp;</spand> -->
					<a class="nui-button"  onclick="payOk()" id = "payOk" >结算收款</a> 
				</td>
				</tr>
			</table>
		</div>
		</fieldset>
	</div>

	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>