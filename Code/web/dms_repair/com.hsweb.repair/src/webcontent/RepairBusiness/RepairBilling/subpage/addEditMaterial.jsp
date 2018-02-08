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
<title>新增和修改材料(维修开单)</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
<style type="text/css">
    	#data{
    		width:75px
    	}
    	#d{
    		width:445px
    	}
    </style>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<input name="pageType" class="nui-hidden"/>
	<div  class="nui-fit" style="margin: 0; height: 100%; width: 100%; overflow: hidden">
		<table>
			<tr style="display: block;margin:4px 0 0 5px;">
				<td width="60px">
					<label>零件编码：</label>
				</td>
				<td>
					<input class="nui-textbox" id="d"   /> 
				</td>
			</tr>
			<tr style="display: block;margin:4px 0 0 5px;">
				<td width="60px">
					<label style="color:#FF0000;" >零件名称：</label>
				</td>
				<td>
					<input class="nui-textbox" id="d"   /> 
				</td>
			</tr>
			<tr style="display: block;margin:4px 0 0 5px;">
				<td width="60px">
					<label>收费类型：</label>
				</td>
				<td>
					<input class="nui-combobox" id="data" allowInput="false" /> 
				</td>
				<td width="60px" style="text-align:right">
					<label>数量：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data"  allowNull="true" value="&nbsp"  showButton="false"  maxValue="100000000"/> 
				</td>
				<td width="60px" style="text-align:right">
					<label >单价：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data" allowNull="true" value="&nbsp" format="￥0.00" showButton="false"  maxValue="100000000"/> 
				</td>
				<td width="36px" style="text-align:right">
					<label >单位：</label>
				</td>
				<td>
					<input class="nui-textbox" width="40px"    /> 
				</td>
			</tr>
			<tr style="display: block;margin:4px 0 0 5px;">
				<td width="60px" style="text-align:right">
					<label>金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data" allowNull="true" value="&nbsp"   format="￥0.00" showButton="false"  maxValue="100000000"/> 
				</td>
				<td width="60px">
					<label >优惠金额：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data" allowNull="true" value="&nbsp"  format="￥0.00" showButton="false"  maxValue="100000000"/> 
				</td>
				<td width="60px">
					<label >零件小计：</label>
				</td>
				<td>
					<input class="nui-spinner" id="data" allowNull="true" value="&nbsp"  format="￥0.00" showButton="false"  maxValue="100000000"/> 
				</td>
			</tr>
			<tr style="display: block;margin:4px 0 0 5px;">
				<td width="60px" style="text-align:right">
					<label>备注：</label>
				</td>
				<td>
					<input class="nui-textbox" id="d"   /> 
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