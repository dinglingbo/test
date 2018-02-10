<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-09 11:13:12
  - Description:
-->
<head>
<title>常见故障</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0;padding: 0;width: 100%;height: 100%">
	<div  class="nui-toolbar"  style="height:26px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-3px 0">
					<td>
						<label style="font-family:Verdana;">快速查询：</label>
					</td>
					<td>
						<label class="form_label" >故障名称：</label>
					</td>
					<td>
						<input class="nui-textbox" emptyText="请输入..." width="100px"/> 
					</td>
					<td>
						<label class="form_label" >故障名称：</label>
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
	<div class="nui-splitter" style="width: 100%; height: 90.5%;" allowResize="false" showHandleButton="false">
		<div size="20%" showCollapseButton="false">
			<div class="nui-toolbar" style="padding: 0px; height: 25px;border-bottom-color: #BBBBBB">
				<div style="padding-left: 8px">品牌/车型</div>
			</div>
			<div class="nui-fit">
			<!-- 树形联动 -->
				<div class="nui-fit">
					<ul id="tree1" class="nui-tree" url="" style="width: 100%;"
						showTreeIcon="true" textField="name" idField="id"
							parentField="pid" resultAsTree="false">

					</ul>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div  class="nui-panel" showToolbar="false" title="故障现象及解决方案列表" showFooter="false" style="width:100%;height:100%">
				<div class="nui-fit">
					<div id="datagrid1" dataField="types" class="nui-datagrid" style="width: 100%; height: 100%;"
						url=""
						pageSize="20" multiSelect="true"  totalCount="total" allowSortColumn="true"
						frozenStartColumn="0" frozenEndColumn="4"
					>

						<div property="columns">
							<div field="" headerAlign="center" allowSort="true" width="40px">序号</div>
							<div header="故障常见现象" headerAlign="center">
								<div property="columns">
									<div field="" headerAlign="center" allowSort="true" width="100px">故障名称</div>
									<div field="" headerAlign="center" allowSort="true" width="80px">故障现象</div>
									<div field="" headerAlign="center" allowSort="true" width="70px">系统分类</div>
									<div field="" headerAlign="center" allowSort="true" width="70px">故障分类</div>
								</div>
							</div>
							<div header="故障解决方案" headerAlign="center">
								<div property="columns">
									<div field="" headerAlign="center" allowSort="true" width="80px">故障解决方案</div>
									<div field="" headerAlign="center" allowSort="true" width="60px">主要备件</div>
									<div field="" headerAlign="center" allowSort="true" width="60px">预计工时</div>
									<div field="" headerAlign="center" allowSort="true" width="60px">预计费用</div>
									<div field="" headerAlign="center" allowSort="true" width="60px">费用备注</div>
								</div>
							</div>
							<div header="车辆信息" headerAlign="center">
								<div property="columns">
									<div field="" headerAlign="center" allowSort="true" width="80px">品牌</div>
									<div field="" headerAlign="center" allowSort="true" width="80px">车型</div>
								</div>
							</div>
							<div header="记录信息" headerAlign="center">
								<div property="columns">
									<div field="" headerAlign="center" allowSort="true" width="60px">记录人</div>
									<div field="" headerAlign="center" allowSort="true" width="70px">记录日期</div>
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
    	
    	function add(){
    		nui.open({
    		url:"./subpage/addEdit.jsp",
    			title:"故障登记-新增",width:650,height:380,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"add"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	function edit(){
    		nui.open({
    		url:"./subpage/addEdit.jsp",
    			title:"故障登记-修改",width:650,height:380,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"edit"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	function query(){
    		nui.open({
    		url:"./subpage/addEdit.jsp",
    			title:"故障登记-查看",width:650,height:380,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"query"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    </script>
</body>
</html>