<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-06 16:42:02
  - Description:
-->
<head>
<title>话术录入</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
     <style type="text/css">
    	#cl{
    		width:364px
    	}
    	#c1{
    		width:148px
    	}
    	#cs{
    		width:148px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<table>
		<tr style=" display:block;margin:0 5px">
			<td style="width: 60px">
				<label>话术来源：</label>
			</td>
			<td>
				<input id="cs" class="nui-textbox" />
			</td>
			<td style="width: 60px">
				<label style="color: #FF0000">话术类别：</label>
			</td>
			<td>
				<input id="cs" class="nui-combobox" textField="" url="" valueField="" allowInput="false"/>
			</td>
		</tr>
		<tr style=" display:block;margin:0 5px">
			<td style="width: 60px">
				<label>话术主题：</label>
			</td>
			<td>
				<input id="cl" class="nui-textbox" />
			</td>
		</tr>
		<tr style=" display:block;margin:0 5px">
			<td style="width: 60px">
				<label style="color: #FF0000">话术内容：</label>
			</td>
			<td>
				<input class="nui-textarea" style="width: 364px;height: 110px;margin:0"/>
			</td>
		</tr>
		<tr style=" display:block;margin:0 5px">
			<td style="width: 60px">
				<label>建档人：</label>
			</td>
			<td>
				<input id="c1" class="nui-textbox" />
			</td>
			<td style="width: 60px">
				<label >建档日期：</label>
			</td>
			<td>
				<input id="c1" class="nui-datepicker" viewDate="new Date()" format="yyyy-MM-dd HH:mm:ss"  showTime="true"/>
			</td>
		</tr>
		<tr style=" display:block;margin:0 5px">
			<td style="width: 60px">
				<label>修改人：</label>
			</td>
			<td>
				<input id="c1" class="nui-textbox" />
			</td>
			<td style="width: 60px">
				<label >修改日期：</label>
			</td>
			<td>
				<input id="c1" class="nui-datepicker" viewDate="new Date()" format="yyyy-MM-dd HH:mm:ss"  showTime="true"/>
			</td>
		</tr>
	</table>
	<div style="text-align:right;padding:5px 9px 0 9px;margin-top:0">               
		<a class="nui-button" onclick="onOk" style="margin-right:10px;width:60px">确定(O)</a>       
		<a class="nui-button" onclick="onCancel" style="width:60px">关闭(C)</a>       
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>