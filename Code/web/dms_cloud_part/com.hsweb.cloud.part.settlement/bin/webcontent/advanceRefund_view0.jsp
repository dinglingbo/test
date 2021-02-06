<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-05 16:13:04
  - Description:
-->
<head>
<title>预收预付退款</title>
    <script src="<%=webPath + contextPath%>/settlement/js/advanceRefund.js?v=1.0.3"></script>
    <style type="text/css">
.title {
  width: 90px;
  height:35px;
  text-align: right;
}

.title.required {
  color: red;
}
.title.tip {
  color: blue;
}

.title.wide {
  width: 100px;
}

.mini-panel-border {
  border: 0;
}

.mini-panel-body {
  padding: 0;
}
.mini-listbox-view{
		height:105px !important;
	}
body .mini-grid-row-selected{
    background:#89c3d6 !important; 
}
.mini-tabs-scrollCt{
	display:none;
}
.mini-tabs-body-top{
	padding:0px;
}

</style>
</head>
<body>
	     <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:100%;">
                <tr>
                    <td style="width:100%;">
                        <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;退款</a>
                        <a class="nui-button" onclick="onCancel()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
 	<fieldset style="border: solid 1px #aaa; position: relative; margin: 5px 2px 20px 2px;height: 200px;">
		<legend> 退款信息</legend>       
		<div id="advancedSearchForm" class="form">
			<input class="nui-hidden" name="id" id="id"/>
			 <input class="nui-hidden" name="guestName" id="guestName"/>
			<table style="width: 100%;">
				<tr>
					<td class="title required">结算账户:</td>
                    <td colspan="3">
                       <input name="balaAccountId"
                       id="balaAccountId"
                       class="nui-combobox"
                       textField="name"
                       valueField="id"
                       valueFromSelect="true"
                       emptyText="请选择..."
                       url=""
                       width="100%"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100%"
                       nullItemText="请选择..."
                       onvaluechanged="onAccountValueChanged"/>
				</tr>	
				<tr>
					<td class="title required">结算方式:</td>
                    <td colspan="3">
                       <input name="balaTypeCode"
                       id="balaTypeCode"
                       class="nui-combobox"
                       textField="customName"
                       valueField="customId"
                       valueFromSelect="true"
                       emptyText="请选择..."
                       url=""
                       width="100%"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100%"
                       nullItemText="请选择..."/>
				</tr>		
				<tr>
	              <td class="title required" >
                      <label>退款金额：</label>
                  </td>
                  <td colspan="1" >
                  		<input class="nui-Spinner"  decimalPlaces="2" minValue="0" maxValue="1000000000"  allowNull="false" showButton="false" width="100px" id="refundAmt" name="refundAmt" />
                  </td>
                  <td class="title required">
                  	<label>结算日期:</label>
                  </td>
                    <td  style="text-align:left;" >
                        <input id="rpSettleDate"
                           name="rpSettleDate"
                           width="100px"
                           allowinput="false"
                           class="nui-datepicker"/>
                    </td>
				</tr>		
				<tr>
				
					<td class="title">
						<label>备注:</label>
					</td>
					<td colspan="3">
						<input name="remark" id="remark" class="nui-TextArea" width="100%" />
					</td>
				</tr>																			
			</table>
		</div>
</fieldset>					
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>