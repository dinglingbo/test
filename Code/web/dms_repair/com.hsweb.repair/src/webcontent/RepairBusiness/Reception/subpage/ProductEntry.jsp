<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-02 14:20:21
  - Description:
-->
<head>
<title>产品录入</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
    <style type="text/css">
    	label{
    		margin: 0 0 0 10px;
    	}
    </style>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	
	<div  class="nui-splitter" style="width:100%;height:100%;" allowResize="false" vertical="true" >
	    <div size="18%" showCollapseButton="false" >
	    	<div  class="nui-panel" showToolbar="false" title="车型信息" showFooter="false" style="width:100%;height:100%;" >
				<div  class="nui-fit" style="margin: 0; height: 100%; width: 100%; overflow: hidden">
					<table class="nui-form-table" style="margin:0;height:100%;width:100%;">
						<tr style="display: block; margin:2px 0 0 0">
							<td width="103px">
								<span style="margin-left: 10px;">车架号（VIN）：</span>
							</td>
							<td>
								<input class="nui-textbox" style="width: 150px; " /> 
							</td>
							<td width="50px">
								<span style="margin-left: 10px;">品牌：</span>
							</td>
							<td>
								<input class="nui-combobox" style="width: 60px;" allowInput="false"/> 
							</td>
							<td width="50px">
								<span style="margin-left: 10px;">车型：</span>
							</td>
							<td>
								<input class="nui-combobox"   style="width: 350px;" /> 
							</td>
						</tr>
						<tr style="display: block; margin:2px 0 0 0">
							<td width="103px">
								<span style="margin-left: 10px;">品牌：</span>
							</td>
							<td>
								<label field="" style="color:#FF0000;width: 70px; " /></label>
							</td>
							<td width="50px">
								<span style="margin-left: 10px;">等级：</span>
							</td>
							<td>
								<label field="" style="color:#FF0000;width: 70px; " /></label>
							</td>
							<td width="50px">
								<span style="margin-left: 10px;">车系：</span>
							</td>
							<td>
								<label field="" style="color:#FF0000;width: 180px; " /></label>
							</td>
							<td width="60px">
								<span style="margin-left: 10px;">发动机：</span>
							</td>
							<td>
								<label field="" style="color:#FF0000;width: 70px; " /></label>
							</td>
							<td width="60px">
								<span style="margin-left: 10px;">变速箱：</span>
							</td>
							<td>
								<label field="" style="color:#FF0000;width: 250px; " /></label>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
	    </div>
	    <div showCollapseButton="false">
	        <div  class="nui-splitter" style="width:100%;height:100%;" allowResize="false">
			    <div size="20%" showCollapseButton="false">
			        <div class="nui-fit">
						<div class="nui-toolbar" style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
							<span>产品分组</span>
						</div>
						<div class="nui-fit">
							<ul id="tree1" class="nui-tree" url="" style="width: 100%;" dataField="" showTreeIcon="true" textField="name" 
								idField="id" parentField="parentid" resultAsTree="false">
							</ul>
						</div>
					</div>
				</div>
			    <div showCollapseButton="false">
			    	<div class="nui-toolbar" style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;height:22px">
				        <table class="nui-form-table" style="margin:0;height:100%;width:100%;">
							<tr style="display: block; margin:-5px 0 0 0">
								<td width="60px">
									<span style="margin-left: 0;">查询项：</span>
								</td>
								<td>
									<input class="nui-combobox" style="width: 60px; " /> 
								</td>
								<td width="60px">
									<span style="margin-left: 0;">查询值：</span>
								</td>
								<td>
									<input class="nui-textbox" style="width: 170px; " /> 
								</td>
								<td>
									<div  class="nui-radiobuttonlist" valueField="id" repeatItems="3" textField="text" repeatLayout="table" 
										  data="[{ id: 0, text: '套餐'},{ id: 1, text: '工时' },{ id: 2, text: '配件' }]" value="0">
									</div>
								</td>
								<td>
									<a class="nui-button" plain="true"  onclick="onSearch()">查询</a>
						            <a class="nui-button" plain="true"  onclick="onNext()">下一页</a>
						            <a class="nui-button" plain="true"  onclick="onOk()">选择</a>
								</td>
							</tr>
						</table>
					</div>
					<div  class="nui-fit">
						<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width: 100%; height: 100%;" plain="false" onactivechanged="">
							<div title="标准套餐" url="StandardPackage.jsp"></div>
							<div title="标准工时" url="WorkingHours.jsp"></div>
							<div title="标准配件" url="StandardPart.jsp"></div>
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