<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 16:06:48
  - Description:
-->
<head>
<title>投诉登记</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#cl{
    		width:316px
    	}
    	#c1{
    		width:124px
    	}
    	#cs{
    		width:160px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<fieldset style="width: 618px;height: 140px;margin:5px;border: 1px solid #AAAAAA;">
		<table>
			<tr style=" display:block;margin:0">
				<td style="width: 60px">
					<label>投诉分店：</label>
				</td>
				<td>
					<input id="cl" class="nui-combobox" textField="" url="" valueField=""/>
				</td>
				<td style="width: 60px">
					<label>投诉分类：</label>
				</td>
				<td>
					<input id="cs" class="nui-combobox" textField="" url="" valueField=""/>
				</td>
			</tr>
			<tr style=" display:block;margin:0">
				<td style="width: 60px">
					<label>投诉级别：</label>
				</td>
				<td>
					<input id="c1" class="nui-combobox" textField="" url="" valueField=""/>
				</td>
				<td style="width: 60px">
					<label>投诉日期：</label>
				</td>
				<td>
					<input id="c1" class="nui-datepicker" viewDate="new Date()" format="yyyy-MM-dd HH:mm:ss"  showTime="true"/>
				</td>
				<td style="width: 60px">
					<label>投诉原因：</label>
				</td>
				<td>
					<input id="cs" class="nui-combobox" textField="" url="" valueField=""/>
				</td>
			</tr>
			<tr style=" display:block;margin:0">
				<td style="width: 60px">
					<label>工单号：</label>
				</td>
				<td>
					<input id="cl" class="nui-buttonedit" />
				</td>
				<td style="width: 60px">
					<label>投诉状态：</label>
				</td>
				<td>
					<input id="cs" class="nui-combobox" textField="" url="" valueField=""/>
				</td>
			</tr>
			<tr style=" display:block;margin:0">
				<td style="width: 60px">
					<label>维修顾问：</label>
				</td>
				<td>
					<input id="c1" class="nui-textbox" textField="" url="" valueField=""/>
				</td>
				<td style="width: 60px">
					<label>客户名称：</label>
				</td>
				<td>
					<input id="c1" class="nui-buttonedit" />
				</td>
				<td style="width: 60px">
					<label>联系电话：</label>
				</td>
				<td>
					<input id="cs" class="nui-textbox" textField="" url="" valueField=""/>
				</td>
			</tr>
			<tr style=" display:block;margin:0">
				<td style="width: 60px">
					<label>车牌号：</label>
				</td>
				<td>
					<input id="c1" class="nui-textbox" textField="" url="" valueField=""/>
				</td>
				<td style="width: 60px">
					<label>品牌：</label>
				</td>
				<td>
					<input id="c1" class="nui-combobox" textField="" url="" valueField="" />
				</td>
				<td style="width: 60px">
					<label>车型：</label>
				</td>
				<td>
					<input id="cs" class="nui-textbox" />
				</td>
			</tr>
		</table>
	</fieldset>
	<div style="margin-left:5px">
		<label>客户陈诉：</label>
	</div>
	<div>
		<input class="nui-textarea" style="width: 638px;height: 190px;margin:0 5px"/>
	</div>
	<div style="text-align:right;padding:10px;margin-top:0">               
		<a class="nui-button" onclick="onOk" style="margin-right:10px;width:60px">保存(S)</a>       
		<a class="nui-button" onclick="onCancel" style="width:60px">取消(C)</a>       
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>