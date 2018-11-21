<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 19:19:48
  - Description:
-->
<head>
<title>更新保养提醒</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/sysCommon.jsp"%>
    
    <style type="text/css">
	 	table{
	   		margin-left:15px;
	   	}
	   	td{
	   		padding-top:3px;
	   	}
    </style>
</head>
<body>
	<div class="nui-fit">
		<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
						<a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('cancle')"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
	
	<div style="margin-bottom:8px;" class="nui-form" id="form" style="width:100%; height:100%;">
		<table>
			<tr>
				<td>客单价：</td>
				<td><input width="100%" enabled="" class="nui-textbox" id="partCode" name="partCode" type="text"></td>
			</tr>
			<tr>
				<td>提前多少天通知：</td>
				<td><input width="100%" enabled="" class="nui-textbox" id="partCode" name="partCode" type="text"></td>
			</tr>
			<tr>
				<td>是否启用：</td>
				<td><div class="nui-radiobuttonlist"
                     repeatItems="2"
                     repeatLayout="table" 
                     textField="text" valueField="id" value="1" data="[{id:0,text:'否'},{id:1,text:'是'}]">
                	</div>
                </td>
			</tr>
			<tr>
				<td>发送内容：</td>
				<td rowspan="5"><input width="100%"style="height:150px;" enabled="" class="nui-textarea" id="partCode" name="partCode" type="text"></td>
			</tr>
			
		</table>
	</div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>