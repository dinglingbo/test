<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-07 10:46:46
  - Description:
-->
<head>
<title>预约跟踪</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	.mini-panel-header{
    		height:20px;
    		
    	}
    	.mini-panel-title{
    		margin-top: -3px;
    	}
    	#cs{
    		width:130px
    	}
    	#c1{
    		width:100px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-panel" showToolbar="false" title="客户预约信息" showFooter="false" style="width:98%;height:195px;margin:3px  5px">
		<table style="width:100%;">
			<tr style=" display:block;margin:-3px 0 0 0">
				<td style="width:60px">
					<label>车牌号：</label>
				</td>
				<td>
					<input id="cs" class="nui-textbox" />
				</td>
				<td style="width:72px">
					<label>品牌：</label>
				</td>
				<td>
					<input id="cs" class="nui-combobox" textField="" url="" valueField=""/>
				</td>
			</tr>
			<tr style=" display:block;margin:-2px 0 0 0">
				<td style="width:60px">
					<label>车型：</label>
				</td>
				<td>
					<input  class="nui-textbox" style="width: 462px;"/>
				</td>
			</tr>
			<tr style=" display:block;margin:-2px 0 0 0">
				<td style="width:60px">
					<label>联系人：</label>
				</td>
				<td>
					<input id="cs" class="nui-textbox" />
				</td>
				<td style="width:72px">
					<label>联系人电话：</label>
				</td>
				<td>
					<input id="cs" class="nui-textbox" />
				</td>
			</tr>
			<tr style=" display:block;margin:-4px 0 0 0">
				<td style="width: 60px">
					<label>客户描述：</label>
				</td>
			</tr>
			<tr style=" display:block;margin:-4px 0 0 0">
				<td>
					<input class="nui-textarea" style="width: 525px;height: 55px;margin:0"/>
				</td>
			</tr>
		</table>
	</div>
	<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width:98%;height:50%;margin-left:5px;"      
		 plain="false" onactivechanged="" 
	>
		<div title="预约跟踪" >   
			<div style="overflow: hidden">
			 <table style="width:100%;height:100%;" >
				<tr style=" display:block;margin:0">
					<td style="width:60px">
						<label>跟踪方式：</label>
					</td>
					<td>
						<input id="c1" class="nui-combobox" textField="" url="" valueField=""/>
					</td>
					<td style="width:84px;text-align: right">
						<label>跟踪人：</label>
					</td>
					<td>
						<input id="c1" class="nui-textbox" />
					</td>
					<td style="width:60px">
						<label>跟踪日期：</label>
					</td>
					<td>
						<input id="c1" class="nui-datepicker" viewDate="new Date()"/>
					</td>
				</tr>
				<tr style=" display:block;margin:0">
					<td style="width:60px">
						<label>跟踪结果：</label>
					</td>
					<td>
						<input id="c1" class="nui-textbox" />
					</td>
					<td style="width:84px">
						<label>下次跟踪日期：</label>
					</td>
					<td>
						<input id="c1" class="nui-datepicker" viewDate="new Date()"/>
					</td>
				</tr>
				<tr style=" display:block;margin:0">
					<td style="width: 500px">
						<label>跟踪内容（Enter换行，描述不能超过500字）：</label>
					</td>
				</tr>
				<tr style=" display:block;margin:0">
					<td >
						<input class="nui-textarea" style="width: 525px;height:103px;margin: 0"/>
					</td>
				</tr>
			</table>  
			</div>  
		</div>
	</div>
	<div style="text-align:right;padding:5px 5px;margin-top:0">               
		<a class="nui-button" onclick="onOk" style="margin-right:10px;width:60px">保存(S)</a>       
		<a class="nui-button" onclick="onCancel" style="width:60px">取消(C)</a>      
	</div>




	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>