<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-03 11:09:20
  - Description:
-->
<head>
<title>新增和修改材料</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
<style type="text/css">
    	#data{
    		width:75px
    	}
    </style>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<input name="pageType" class="nui-hidden"/>
	<div  class="nui-fit" style="margin: 0; height: 100%; width: 100%; overflow: hidden">
		<table>
			<tr style="display: block;margin:4px 0 0 5px;">
				<td width="60px">
					<label style="color:#FF0000;" >零件名称：</label>
				</td>
				<td>
					<input class="nui-textbox" id="data"  width="360px" /> 
				</td>
			</tr>
			<tr style="display: block;margin:4px 0 0 5px;">
				<td width="60px">
					<label>收费类型：</label>
				</td>
				<td>
					<input class="nui-combobox" id="data" allowInput="false" /> 
				</td>
				<td width="60px">
					<label>项目进程：</label>
				</td>
				<td>
					<input class="nui-combobox" id="data" allowInput="false" /> 
				</td>
			</tr>
			<tr style="display: block;margin:4px 0 0 5px;">
				<td width="60px">
					<label >数量：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"   format="0.00"  showButton="false" style="text-align:right" maxValue="100000000"/> 
				</td>
				<td width="60px">
					<label >单价：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"    format="￥0.00" showButton="false" style="text-align:right" maxValue="100000000"/> 
				</td>
				<td width="60px">
					<label >金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"   format="￥0.00" showButton="false" style="text-align:right" maxValue="100000000"/> 
				</td>
			</tr>
			<tr style="display: block;margin:4px 0 0 5px;">
				<td width="60px">
					<label >项目备注：</label>
				</td>
				<td>
					<input class="nui-textbox" id="data"  width="360px" /> 
				</td>
			</tr>
			<tr >
	        	<td>
	        		<div style="text-align:right;padding:2px 5px;">
		        		<a class="nui-button"  onclick="onSearch(0)" >上一条(P)</a>
		                <a class="nui-button"  onclick="onSearch(1)" >下一条(N)</a>
		                <a class="nui-button"  onclick="onSearch(2)" >继续添加(J)</a>
		                <a class="nui-button"  onclick="onSearch(3)" >保存(S)</a>
		                <a class="nui-button"  onclick="onSearch(4)" >关闭(C)</a>
	            	</div> 	 	
	       		</td>
	        </tr>
		</table>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>