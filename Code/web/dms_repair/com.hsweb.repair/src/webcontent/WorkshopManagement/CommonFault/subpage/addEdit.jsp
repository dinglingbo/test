<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-09 11:56:56
  - Description:
-->
<head>
<title>常见故障（新增和修改）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#basetd1{
    		width:118px
    	}
    	#basetd2{
    		width:304px
    	}
    	#basetd3{
    		width:562px
    	}
    	#basetd4{
    		width:190px
    	}
    	#textarea{
    		width: 626px;
    		height: 70px;
    	}
    </style>
</head>
<body style="margin: 0;padding: 0;width: 100%;height: 100%">
	<div  class="nui-fit" style="overflow: hidden;">
		<table>
			<tr style="display: block; margin:3px 0 0 5px">
				<td width="60px" style="text-align: right;">
					<label>品牌</label>
				</td>
				<td>
					<input class="nui-combobox" id="basetd1" textField="" url="" valueField="" allowInput="false"/> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>车型：</label>
				</td>
				<td>
					<input class="nui-combobox" id="basetd1" textField="" url="" valueField="" allowInput="false"/> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>系统分类：</label>
				</td>
				<td>
					<input class="nui-combobox" id="basetd4" textField="" url="" valueField="" allowInput="false"/> 
				</td>
			</tr>
			<tr style="display: block; margin:0 0 0 5px">
				<td width="60px" style="text-align: right;">
					<label style="color: #FF0000">故障名称：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd2" /> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>故障分类：</label>
				</td>
				<td>
					<input class="nui-combobox" id="basetd4" textField="" url="" valueField="" allowInput="false"/>
				</td>
			<tr style="display: block; margin:0 0 0 5px">
				<td width="">
					<div style="color: #FF0000">故障现象：</div>
					<div>
						<input class="nui-textarea" id="textarea" /> 
					</div>
				</td>
			</tr>
			<tr style="display: block; margin:0 0 0 5px">
				<td width="">
					<div style="color: #FF0000">故障解决方案：</div>
					<div>
						<input class="nui-textarea" id="textarea" /> 
					</div>
				</td>
			</tr>
			<tr style="display: block; margin:0 0 0 5px">
				<td width="60px" style="text-align: right;">
					<label>主要备件：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd1" /> 
				</td>
				<td width="60px" style="text-align: right;">
					<label>预计工时：</label>
				</td>
				<td>
					<input class="nui-spinner" id="basetd1" maxValue="1000000000" minValue="-1000000000"/>
				</td>
				<td width="60px" style="text-align: right;">
					<label>预计费用：</label>
				</td>
				<td>
					<input class="nui-spinner" id="basetd4" maxValue="1000000000" minValue="-1000000000" showButton="false"/>
				</td>
			</tr>
			<tr style="display: block; margin:0 0 0 5px">
				<td width="60px" style="text-align: right;">
					<label>费用备注：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd3"/>
				</td>
			</tr>
		</table>
	</div>
	<div style="margin-top:0" >
		<table style="width:100%;margin-top:-7px;">
			<tr >
				<td style="text-align:right;">
					<a class="nui-button" onclick="onSave()" style="margin-right:10px;width:60px">保存(S)</a>      
					<a class="nui-button" onclick="onCancel" style="margin-right:10px;width:60px">取消(C)</a>       
				</td>
			</tr>
		</table>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>