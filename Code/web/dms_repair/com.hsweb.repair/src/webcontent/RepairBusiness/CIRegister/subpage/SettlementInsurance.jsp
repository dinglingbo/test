<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-07 15:52:16
  - Description:
-->
<head>
<title>保险结算</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#data{
    		width:340px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<table style="margin:5px;">
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>交强险：</label>
			</td>
			<td>
				<input class="nui-spinner" id="data" format="￥0.00"  showButton="false" style="text-align:right" maxValue="100000000"/> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>商业险：</label>
			</td>
			<td>
				<input class="nui-spinner" id="data" format="￥0.00"  showButton="false" style="text-align:right" maxValue="100000000"/> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>车船税：</label>
			</td>
			<td>
				<input class="nui-spinner" id="data" format="￥0.00"  showButton="false" style="text-align:right" maxValue="100000000"/> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>保费：</label>
			</td>
			<td>
				<input class="nui-spinner" id="data" format="￥0.00"  showButton="false" style="text-align:right" maxValue="100000000"/> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>交强险佣金率：</label>
			</td>
			<td>
				<input class="nui-spinner" id="data" format="0"   style="text-align:right" maxValue="100000000"/> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>商业险佣金率：</label>
			</td>
			<td>
				<input class="nui-spinner" id="data" format="0"   style="text-align:right" maxValue="100000000"/> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>佣金：</label>
			</td>
			<td>
				<input class="nui-spinner" id="data" format="￥0.00"  showButton="false" style="text-align:right" maxValue="100000000"/> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>返利：</label>
			</td>
			<td>
				<input class="nui-spinner" id="data" format="￥0.00"  showButton="false" style="text-align:right" maxValue="100000000"/> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>其他费用：</label>
			</td>
			<td>
				<input class="nui-spinner" id="data" format="￥0.00"  showButton="false" style="text-align:right" maxValue="100000000"/> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>备注：</label>
			</td>
			<td>
				<input class="nui-textbox" id="data" /> 
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td width="84px">
				<label>公式说明：</label>
			</td>
		</tr>
		<tr style=" display:block;margin:0">
			<td>
				<input class="nui-textarea" style="width: 428px;height: 130px"/>
			</td>
		</tr>
	</table>
	<div style="text-align:right;padding:0 10px;margin-top:0">               
		<a class="nui-button" onclick="onSave" style="margin-right:10px;width:60px">保存(C)</a>  
		<a class="nui-button" onclick="onOk" style="margin-right:10px;width:60px">提交(C)</a>       
		<a class="nui-button" onclick="onCancel" style="width:60px">取消(C)</a>      
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>