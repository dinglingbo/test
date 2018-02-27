<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-09 14:42:57
  - Description:
-->
<head>
<title>在线故障</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0;padding: 0;width: 100%;height: 100%">
	<div  class="nui-toolbar"  >
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-4px 0 0 0">
					<td width="800px" >
						<label style="color: #FF0000">在线故障不定期更新，让您的维修技术走在最前沿。在线故障将在：【2018-03-13 16:22:29】终止使用，请提前联系软件服务商！</label>
					</td>
				</tr>
				<tr style="display: block; margin:-3px 0">
					<td>
						<label style="font-family:Verdana;">快速查询：</label>
					</td>
					<td>
						<label class="form_label" >故障描述：</label>
					</td>
					<td>
						<input class="nui-textbox" emptyText="请输入..." width="100px"/> 
					</td>
					<td>
						<label class="form_label" >系统分类：</label>
					</td>
					<td>
						<input class="nui-combobox" width="100px" textField="" url="" valueField=""/>
					</td>
					<td>
						<label class="form_label" >故障分类：</label>
					</td>
					<td>
						<input class="nui-combobox" width="100px" textField="" url="" valueField=""/>
					</td>
					<td>
						<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">查询（Q）</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px; height: 30px">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%"><a class="nui-button"  plain="true" iconCls="icon-add" onclick="add()">新增(N)</a> 
					<a class="nui-button" plain="true" iconCls="icon-edit" onclick="edit()">修改(E)</a>
					<a class="nui-button" plain="true" iconCls="icon-search" onclick="query()">查看(L)</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 87%;" allowResize="false" showHandleButton="false">
		<div size="16%" showCollapseButton="false">
			<div class="nui-toolbar" style="padding: 0px; height: 25px;border-bottom-color: #BBBBBB">
				<div style="text-align: center">车型</div>
			</div>
			<div class="nui-fit">
			<!-- 树形联动 -->
				<div class="nui-fit">
					<ul id="tree1" class="nui-tree" url="" style="width: 100%;" showTreeIcon="true" textField="name" 
							idField="id" parentField="pid" resultAsTree="false">

					</ul>
				</div>
			</div>
		</div>
		
		<div showCollapseButton="false">
			<div class="nui-fit">
				<div id="datagrid1" dataField="types" class="nui-datagrid" style="width: 100%; height: 100%;"
					url=""
					pageSize="20" multiSelect="true"  totalCount="total" allowSortColumn="true"
				>

					<div property="columns">
						<div field="" headerAlign="center" allowSort="true" width="40px">序号</div>
						<div header="&nbsp" headerAlign="center">
							<div property="columns">
								<div field="" headerAlign="center" allowSort="true" width="70px">车型</div>
								<div field="" headerAlign="center" allowSort="true" width="70px">系统分类</div>
								<div field="" headerAlign="center" allowSort="true" width="70px">故障分类</div>
								<div field="" headerAlign="center" allowSort="true" width="120px">故障现象描述</div>
								<div field="" headerAlign="center" allowSort="true" width="120px">故障原因</div>
								<div field="" headerAlign="center" allowSort="true" width="120px">故障解决方案</div>
								<div field="" headerAlign="center" allowSort="true" width="70px">主要配件</div>
								<div field="" headerAlign="center" allowSort="true" width="60px">预计工时</div>
								<div field="" headerAlign="center" allowSort="true" width="50px">内码</div>
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