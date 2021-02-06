<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-08 15:13:55
  - Description:
-->
<head>
<title>库存设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/config/js/stockParamsSet.js?v=1.0.2"></script>
</head>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
</style>
<body>
<div class="nui-fit">
	<div id="basicInfoForm" class="form" contenteditable="false" >
		<table align= "center">
			<tr>
				<td style="text-align: right;">
					采购退货供应商一致才可退货：
				</td>
				<td>
					<div id="repairPchsRtnFlag" name="repairPchsRtnFlag" 
						class="nui-radiobuttonlist" value="" repeatItems="2" 
						repeatDirection="" repeatLayout="table" 
						textField="text" valueField="id" ></div>
				</td>
			</tr>
			<tr>	 
				<td style="text-align: right;">
					工单结算后服务出库单不可作废：
				</td>
				<td>
					<div id="repairPartOutCancelFlag" name="repairPartOutCancelFlag" 
						class="nui-radiobuttonlist" value="" repeatItems="2" 
						repeatDirection="" repeatLayout="table" 
						textField="text" valueField="id" ></div>
				</td>
			</tr>
			<tr>	 
				<td style="text-align: right;">
					默认仓库：
				</td>
				<td>
					<div id="repairDefaultStore" name="repairDefaultStore" 
						class="nui-combobox" textField="name" valueField="id" valuechanged="aa" ></div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
					<a class="nui-button" onclick="save()"   plain="false" >保存</a>
				</td>
			</tr>
		</table>
	</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>