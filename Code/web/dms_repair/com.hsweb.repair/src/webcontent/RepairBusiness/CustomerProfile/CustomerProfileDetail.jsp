<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 16:54:43
  - Description:
-->
<head>
<title>新增和修改</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	<input name="pageType" class="nui-hidden"/>
	<div  class="nui-splitter" style="width:100%;height:100%;" id="dataform1" vertical="true">
	    <div size="30%" showCollapseButton="false">
	    	<div  class="nui-panel" showToolbar="false" title="客户信息" showFooter="false" style="width:500px;height:100%;">
				<table class="nui-form-table">
		        	<tr style=" display:block;margin:0 0 2px 0">
		        		<td width="70px">
		        			<span style="color:#FF0000;margin-left:10px;">客户名称：</span>
		        		</td>
		        		<td>
							<input class="nui-textbox" name="code" width="350px"/>
						</td>
		        	</tr>
		        	
		        	<tr style=" display:block;margin:2px 0">
		        		<td width="70px">
		        			<span style="margin-left:10px;">客户简介：</span>
		        		</td>
		        		<td>
							<input class="nui-textbox" name="code" width="122px"/>
						</td>
						<td width="70px">
		        			<span style="margin-left:10px;">会员卡号：</span>
		        		</td>
		        		<td>
							<input class="nui-textbox" name="code" width="150px"/>
						</td>
		        	</tr>
		        	
		        	<tr style=" display:block;margin:2px 0">
		        		<td width="70px">
		        			<span style="color:#FF0000;margin-left:10px;">手机号码：</span>
		        		</td>
		        		<td>
							<input class="nui-textbox" name="code" width="122px"/>
						</td>
						<td width="70px">
		        			<span style="margin-left:10px;">电话：</span>
		        		</td>
		        		<td>
							<input class="nui-textbox" name="code" width="150px"/>
						</td>
		        	</tr>
		        	
		        	<tr style=" display:block;margin:2px 0">
		        		<td width="70px">
		        			<span style="margin-left:10px;">地址：</span>
		        		</td>
		        		<td>
							<input class="nui-textbox" name="code" width="350px"/>
						</td>
		        	</tr>
		        	
		        	<tr style=" display:block;margin:0 0 2px 0">
		        		<td width="70px">
		        			<span style="margin-left:10px;">备注：</span>
		        		</td>
		        		<td>
							<input class="nui-textbox" name="remark" width="350px"/>
						</td>
		        	</tr>
		        </table>
			</div>


		        
	    </div>
	    <div showCollapseButton="false">
			<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;"      
				 plain="false" onactivechanged=""
			>
				<div title="车辆信息" url="./subpage/Vehicle.jsp" >        
				</div>
				<div title="联系人信息" url="./subpage/Contacts.jsp" >        
				</div>
			</div>
	    </div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>