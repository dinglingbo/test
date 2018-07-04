<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-02 18:46:38
  - Description:
-->
<head>
<title>开票单</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
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
	#left {
	display:inline-block;
	float:left;
	}
	#right {
	display:inline-block;
	float:right;
	}
</style>
<body>
<div class="nui-fit">
	<div style="width: 100%; height: 250px;">
		<div>
			<h2><span id="left">开票单</span></h2>
			<span id="right">2018.07.02</span>
		</div>
		<br>
		<div><span><h2>发票信息</h2></span></div>
		<form id="form">
			<table>
				<tr>
					<td>
						发票类型
						<input class="nui-combobox" style="width:100%">
					</td>
					<td>
						税率
						<input class="nui-textbox" style="width:100%">
					</td>
				</tr>
				<tr>
					<td>
						发票号
						<input class="nui-textbox" style="width:100%">
					</td>
					<td>
						发票抬头
						<input class="nui-textbox" style="width:100%">
					</td>
				</tr>
				<tr>
					<td>
						开票备注：
						<input class="nui-textarea" style="width:100%">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="nui-fit">
		<a class="nui-button" iconCls="icon-add" onclick="">添加开票单据</a>
		<span><h2>单据信息</h2></span>
		<div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url=""allowcellwrap="true" style="width:100%;height:50%;">
			<div property="columns">
				<div field="" name="" headeralign="center" align="center">单号</div>
				<div field="" name="" headeralign="center" >客户名称</div>
				<div field="" id="" name="" headeralign="center" align="center" >车牌号</div>
				<div field="" id="" name="" headeralign="center" align="center">发票类型</div>
				<div field="" id="" name="" headeralign="center" align="center">税率</div>
				<div field="" id="" name="" headeralign="center" align="center">发票金额</div>
				<div field="" id="" name="" headeralign="center" align="center">税额</div>
				<div field="" id="" name="" headeralign="center" align="center">删除</div>
			</div>
		</div>
		<div style="height: 20px;"></div>
		<span><h2>金额合计</h2></span>
		<div>
			<span>开票金额</span>		
		</div>
		<div>
			<span>税额</span>
		</div>
		<div align="right">
			<a class="nui-button" iconcls="" id="" name="" onclick="">开票</a>
			<a class="nui-button" iconcls="icon-blueReturn"  id="" name=""onclick="">退出</a>
		</div>
	</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>