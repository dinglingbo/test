<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-09 10:32:41
  - Description:
-->
<head>
<title>维修车辆</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%;">
	<div  class="nui-toolbar"  style="height:50px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-5px 0">
					<td width="80px">
						<span style="color:#0000FF;">工单号：</span>
					</td>
					<td>
						<label field="" style="color:#0000FF;width: 200px; " /></label>
					</td>
					<td width="80px">
						<span style="color:#0000FF;margin-left: 10px;">车牌号：</span>
					</td>
					<td>
						<label field="" style="color:#0000FF;width:120px; " /></label>
					</td>
					<td width="80px">
						<span style="color:#FF0000;margin-left: 10px;">进程：</span>
					</td>
					<td>
						<label field="" style="color:#0000FF;width:120px; " /></label>
					</td>
					<td width="80px">
						<span style="color:#FF0000;margin-left: 10px;">来厂次数：</span>
					</td>
					<td>
						<label field="" style="color:#0000FF;width:120px; " /></label>
					</td>
				</tr>
				<tr style="display: block; margin:-3px 0">
					<td>
						<label style="font-family:Verdana;">快速查询：</label>
					</td>
					<td>
						<label class="form_label" >车牌号：</label>
					</td>
					<td>
						<input class="nui-textbox" emptyText="请输入..." /> 
					</td>
					<td>
						<label class="form_label" >工单号：</label>
					</td>
					<td>
						<input class="nui-textbox" emptyText="请输入..." /> 
					</td>
					<td>
						<label class="form_label" >车辆状态</label>
					</td>
					<td>
						<div  class="nui-radiobuttonlist" valueField="id" repeatItems="4" textField="text"  repeatLayout="table"
							  data="[{ id: 0, text: '在修' },{ id: 1, text: '已离厂' }]">
						</div>
					</td>
					<td>
						<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">查询（Q）</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true"  iconCls="icon-node" onclick="history()">维修历史(W)</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 87.2%;" allowResize="false" vertical="true">
		<div size="50%" showCollapseButton="false">
	        <div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"
					url=""
					pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false"  showPageSize="false"
					showReloadButton="false" showPagerButtonIcon="false" totalCount="total" allowSortColumn="true">
		
					<div property="columns">
						<div type="indexcolumn" width="30px" headerAlign="center">序号</div>
						<div  field="type" headerAlign="center" allowSort="true" visible="true" width="70px">车牌号</div>
						<div  field="name" headerAlign="center" allowSort="true" visible="true" width="60px">进程</div>
						<div  field="captainName" headerAlign="center" allowSort="true" visible="true" width="120px">工单号</div>
						<div  field="type" headerAlign="center" allowSort="true" visible="true" width="60px">品牌</div>
						<div  field="name" headerAlign="center" allowSort="true" visible="true" width="100px">车型</div>
						<div  field="captainName" headerAlign="center" allowSort="true" visible="true" width="80px">维修顾问</div>
						<div  field="type" headerAlign="center" allowSort="true" visible="true" width="100px">进厂时间</div>
						<div  field="name" headerAlign="center" allowSort="true" visible="true" width="100px">预计交车时间</div>
					</div>
				</div>
			</div>	
		</div>
		<div showCollapseButton="false">
           <div  class="nui-splitter" style="width:100%;height:100%;" allowResize="false" >
			    <div size="50%" showCollapseButton="false">
			        <div class="nui-fit">
						<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"
							url=""
							pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false"  showPageSize="false"
							showReloadButton="false" showPagerButtonIcon="false" totalCount="total" allowSortColumn="true">
				
							<div property="columns">
								<div type="indexcolumn" width="30px" headerAlign="center">序号</div>
								<div  field="type" headerAlign="center" allowSort="true" visible="true" width="80px">项目编码</div>
								<div  field="name" headerAlign="center" allowSort="true" visible="true" width="80px">项目名称</div>
								<div  field="captainName" headerAlign="center" allowSort="true" visible="true" width="50px">工种</div>
								<div  field="type" headerAlign="center" allowSort="true" visible="true" width="50px">工时</div>
								<div  field="name" headerAlign="center" allowSort="true" visible="true" width="60px">金额小计</div>
								<div  field="captainName" headerAlign="center" allowSort="true" visible="true" width="60px">班组</div>
								<div  field="type" headerAlign="center" allowSort="true" visible="true" width="60px">承修人</div>
							</div>
						</div>
					</div>	
			    </div>
			    <div showCollapseButton="false">
			        <div class="nui-fit">
						<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height:100%;"
							url=""
							pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false"  showPageSize="false"
							showReloadButton="false" showPagerButtonIcon="false" totalCount="total" allowSortColumn="true">
				
							<div property="columns">
								<div type="indexcolumn" width="30px" headerAlign="center">序号</div>
								<div  field="type" headerAlign="center" allowSort="true" visible="true" width="80px">零件编码</div>
								<div  field="name" headerAlign="center" allowSort="true" visible="true" width="100px">零件名称</div>
								<div  field="captainName" headerAlign="center" allowSort="true" visible="true" width="60px">数量</div>
								<div  field="type" headerAlign="center" allowSort="true" visible="true" width="80px">单价</div>
								<div  field="name" headerAlign="center" allowSort="true" visible="true" width="80px">金额</div>
							</div>
						</div>
					</div>	
			    </div>
			</div>
 		 </div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	
    	function history(){
    		nui.open({
    			url:"../../common/History.jsp",
    			title:"维修历史",width:850,height:640,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"history"};
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