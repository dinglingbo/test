<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-05 14:57:07
  - Description:
-->
<head>
<title>修改套餐</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-toolbar"  style="padding:0; width:97.7%;margin:5px 7px ">
		<table style="width:100%;margin-top:0;">
			<tr>
				<td style="text-align:left;">
					<a class="nui-button" iconCls="icon-save" plain="true" onclick="onSave()" style="margin-left:5px;">保存(S)</a>      
					<a class="nui-button" iconCls="icon-no" plain="true" onclick="onClose" style="margin-left:10px;">关闭(C)</a>       
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-panel" title="套餐项目" style="width:98%;height:90px;margin:0 7px 5px 7px" >
		<table>
			<tr style="display: block;margin:-3px 0 -2px 0">
				<td style="width: 60px">
					<label>套餐名称：</label>
				</td>
				<td>
					<input class="nui-textbox" width="545px"/>
				</td>
			</tr>
			<tr style="display: block;margin:0 0 -3px 0">
				<td style="width: 60px">
					<label>套餐金额：</label>
				</td>
				<td>
					<input class="nui-textbox" width="150px" style="margin-right: 5px"/>
				</td>
				<td style="width: 60px;">
					<label>套餐小计：</label>
				</td>
				<td>
					<input class="nui-textbox" width="150px"/>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit" >
		<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 98%; height: 100%;margin:0 7px"  plain="false" onactivechanged="">
			<div title="工时" >
				<div  class="nui-datagrid" dataField="data" url="" style="width:100%;height: 100%" showPager="false">
				    <div property="columns">
				    	<div width="" type="indexcolumn" headerAlign="center" allowSort="true">
				    		序号
				    	</div>
				    	<div header="&nbsp" headerAlign="centers">
					    	<div property="columns"   >
						        <div field="" width="150px" headerAlign="center" allowSort="true">
						        	工时名称
						    	</div>
						    	<div field="" width="90px" headerAlign="center" allowSort="true">
						        	备注
						    	</div>
						    	<div field="" width="60px" headerAlign="center" allowSort="true">
						        	工种
						    	</div>
						    	<div field="" width="60px" headerAlign="center" allowSort="true">
						        	工时
						    	</div>
						    	<div field="" width="100px" headerAlign="center" allowSort="true">
						        	工时金额
						    	</div>
						    	<div field="" width="70px" headerAlign="center" allowSort="true">
						        	必要性
						    	</div>
					    	</div>
				        </div>
				    </div>
				</div>
			</div>
			<div title="配件" >
				<div  class="nui-datagrid" dataField="data" url="" style="width:100%;height: 100%" showPager="false">
				    <div property="columns">
				    	<div width="" type="indexcolumn" headerAlign="center" allowSort="true">
				    		序号
				    	</div>
				    	<div header="&nbsp" headerAlign="centers">
					    	<div property="columns"   >
						        <div field="" width="130px" headerAlign="center" allowSort="true">
						        	配件名称
						    	</div>
						    	<div field="" width="80px" headerAlign="center" allowSort="true">
						        	品牌
						    	</div>
						    	<div field="" width="100px" headerAlign="center" allowSort="true">
						        	配件编码
						    	</div>
						    	<div field="" width="60px" headerAlign="center" allowSort="true">
						        	数量
						    	</div>
						    	<div field="" width="60px" headerAlign="center" allowSort="true">
						        	单价
						    	</div>
						    	<div field="" width="60px" headerAlign="center" allowSort="true">
						        	金额
						    	</div>
						    	<div field="" width="70px" headerAlign="center" allowSort="true">
						        	必要性
						    	</div>
					    	</div>
				        </div>
				    </div>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>