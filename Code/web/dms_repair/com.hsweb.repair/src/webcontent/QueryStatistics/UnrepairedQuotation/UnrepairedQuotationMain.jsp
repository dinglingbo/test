<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:04
  - Description:
-->
<head>
<title>报价未修查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:26px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-4px 0 0 0">
					<td>
	        	    	<label style="font-family:Verdana;">快速查询：</label>
	        	    </td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本日</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>昨日</u></a>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本周</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上周</u></a>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本月</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上月</u></a>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本年</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上年</u></a>
					</td>
					<td>
						<label>单据类型：</label>
						<input class="nui-combobox" textField="" url="" valueField=""/>
					</td>
					<td>
						<label>车牌号：</label>
						<input class="nui-textbox"/>
					</td>
					<td>
						<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onQuery()">查询(Q)</a>
						<a class="nui-button" plain="true" onclick="onMore()" style="color:#0000FF"><u>更多</u></a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" 	iconCls="icon-expand" onclick="export()">导出(E)</a> 
				</td>
			</tr>
		</table>
	</div>
	<div  class="nui-splitter" style="width:100%;height:91%;" vertical="true" allowResize="false">
	    <div size="65%" showCollapseButton="false">
	       	<div class="nui-fit">
				<div id="datagrid1" dataField="" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
				>
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="辅助信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="100px">工单号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
							</div>
						</div>
						<div header="基本信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">品牌</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">车型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">客户名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">业务类型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修类型</div>
							</div>
						</div>
						<div header="未修信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">操作人</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">报价时间</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">确定未修时间</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">未修类型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">未修原因</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	    </div>
	    <div showCollapseButton="false">
	        <div  class="nui-splitter" style="width:100%;height:100%;" allowResize="false">
			    <div size="50%" showCollapseButton="false">
			        <div class="nui-fit">
						<div id="datagrid1" dataField="" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
							 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
							 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
							 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
						>
				
							<div property="columns">
								<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="120px">项目名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">工种</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">工时</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">金额小计</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">状态</div>
							</div>
						</div>
					</div>
			    </div>
			    <div showCollapseButton="false">
			        <div class="nui-fit">
						<div id="datagrid1" dataField="" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
							 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
							 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
							 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
						>
				
							<div property="columns">
								<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">零件编码</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">零件名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">数量</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">单价</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">金额</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">状态</div>
							</div>
						</div>
					</div>
			    </div>
			</div>
		</div>
	</div>





	<script type="text/javascript">
    	nui.parse();
    	
    	function onMore(){
    		nui.open({
    			url:"./subpage/More.jsp",
    			title:"高级查询",width:400,height:250,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"more"};
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