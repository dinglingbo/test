<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-20 19:56:39
  - Description:
-->
<head>
<title>项目提醒设置</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/sysCommon.jsp"%>
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
				<td style="padding-left:30px;">温馨提醒：</td>
				<td>消费<input width="20%" enabled="" class="nui-textbox" id="partCode" name="partCode" type="text">天后提醒</td>
				<td><input width="50%" enabled="" class="nui-checkbox" id="partCode" name="partCode" type="text">结算后立即提醒
                </td>
			</tr>
			<tr >
				<td  colspan="1" rowspan="3 colspan=""></td>
				<td colspan="3" rowspan="3"><input width="100%"style="height:80px;" enabled="" emptyText="提醒内容" class="nui-textarea" id="partCode" name="partCode" type="text"></td>
				
			</tr>		
		</table>
		<table>
			<tr>
				<td  style="padding-left:30px;">保养提醒：</td>
				<td>消费<input width="20%" enabled="" class="nui-textbox" id="partCode" name="partCode" type="text">天后提醒</td>
				<td></td>
			</tr>
			<tr>
				<td  colspan="1" rowspan="3 colspan=""></td>
				<td colspan="3" rowspan="3"><input width="100%"style="height:80px; width:345px" enabled="" emptyText="提醒内容" class="nui-textarea" id="partCode" name="partCode" type="text"></td>
			
			</tr>
		</table>
		<table>
			<tr>
				<td>提醒服务顾问：</td>
				<td>消费<input width="20%" enabled="" class="nui-textbox" id="partCode" name="partCode" type="text">天后提醒</td>
				<td></td>
			</tr>
			<tr>
				<td  colspan="1" rowspan="3 colspan=""></td>
				<td colspan="2" rowspan="3"><input width="100%"style="height:80px;width:345px" enabled="" emptyText="提醒内容" class="nui-textarea" id="partCode" name="partCode" type="text"></td>
				<td></td>
			</tr>
				
		</table>
		
		<table>
			
			<tr>
				<td style="padding-left:30px;">提醒状态：</td>
				<td><div class="nui-radiobuttonlist"
                     repeatItems="2"
                     repeatLayout="table" 
                     textField="text" valueField="id" value="1" data="[{id:0,text:'禁用'},{id:1,text:'启用'}]">
                	</div></td>
			</tr>
		</table>
		
                	
	</div>
</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>