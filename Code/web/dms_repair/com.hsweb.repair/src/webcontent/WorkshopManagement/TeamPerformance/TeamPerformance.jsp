<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-09 15:07:35
  - Description:
-->
<head>
<title>班组业绩</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0;padding: 0;width: 100%;height: 100%">
	<div  class="nui-toolbar"  >
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-4px 0 0 0">
					<td>
	        	    	<label style="font-family:Verdana;">快速查询：</label>
	        	    </td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本月</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上月</u></a>
					</td>
					<td>
						<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
					</td>
					<td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>本年</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>上年</u></a>
					</td>
					<td>
						<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
					</td>
					<td>
						<label class="form_label" >结算日期：</label>
					</td>
					<td>
						<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd "  viewDate="new Date()" showClearButton="false"/>
					</td>
					<td>
						<label class="form_label" >至：</label>
					</td>
					<td>
						<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd "  viewDate="new Date()" showClearButton="false"/>
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
				<td style="width: 100%">
					<a class="nui-menuButton" plain="true" iconCls="icon-print" menu="#printMenu">打印(P)</a>
					<a class="nui-menuButton" plain="true" iconCls="icon-node" menu="#exportMenu">导出(E)</a> 
				</td>
			</tr>
		</table>
	</div>
	<div  class="nui-splitter" style="width:100%;height:90%;" allowResize="false">
	    <div size="18%" showCollapseButton="false">
	        <ul id="tree1" class="nui-tree" resultAsTree="false" style="width:100%;height:100%;" idField="id" parentField="pid" textField="text" url="">
			</ul>
	    </div>
	    <div showCollapseButton="false">
	        <div  class="nui-splitter" style="width:100%;height:100%;" allowResize="false" vertical="true">
			    <div size="50%" showCollapseButton="false">
			        <div  class="nui-datagrid" dataField="data" url="" style="height: 100%;width: 100%" showPager="false">
					    <div property="columns">
					    	<div type="indexcolumn" headerAlign="center" width="30px" allowSort="true">序号</div>
					    	<div header="基本信息" headerAlign="center">
					    		<div property="columns">
					        		<div field="" width="160px" headerAlign="center" allowSort="true">班组</div>
					        		<div field="" width="100px" headerAlign="center" allowSort="true">维修单数</div>
					        		<div field="" width="80px" headerAlign="center" allowSort="true">人数</div>
					        	</div>
					    	</div>
					    	<div header="项目金额" headerAlign="center">
					    		<div property="columns">
					        		<div field="" width="100px" headerAlign="center" allowSort="true">项目金额</div>
					        		<div field="" width="100px" headerAlign="center" allowSort="true">人均工时</div>
					        		<div field="" width="100px" headerAlign="center" allowSort="true">项目提成</div>
					        		<div field="" width="100px" headerAlign="center" allowSort="true">人均提成</div>
					        	</div>
					    	</div>
					    </div>
					</div>
			    </div>
			    <div showCollapseButton="false">
			        <div  class="nui-datagrid" dataField="data" url="" style="height: 100%;width: 100%" showPager="false">
					    <div property="columns">
					    	<div type="indexcolumn" headerAlign="center" width="30px" allowSort="true">序号</div>
					    	<div header="班组项目信息" headerAlign="center">
					    		<div property="columns">
					        		<div field="" width="140px" headerAlign="center" allowSort="true">工单号</div>
					        		<div field="" width="70px" headerAlign="center" allowSort="true">车牌号</div>
					        		<div field="" width="90px" headerAlign="center" allowSort="true">结算日期</div>
					        		<div field="" width="90px" headerAlign="center" allowSort="true">项目名称</div>
					        		<div field="" width="60px" headerAlign="center" allowSort="true">工种</div>
					        		<div field="" width="60px" headerAlign="center" allowSort="true">班组</div>
					        		<div field="" width="60px" headerAlign="center" allowSort="true">承修人</div>
					        		<div field="" width="70px" headerAlign="center" allowSort="true">项目金额</div>
					        		<div field="" width="60px" headerAlign="center" allowSort="true">优惠率</div>
					        		<div field="" width="70px" headerAlign="center" allowSort="true">项目小计</div>
					        		<div field="" width="90px" headerAlign="center" allowSort="true">班组提成金额</div>
					        	</div>
					    	</div>
					    </div>
					</div>
			    </div>
			</div>
		</div>
	</div>


	<ul id="printMenu" class="nui-menu" style="display:none;">
		<li class="separator"></li>
        <li>打印班组业绩</li>
        <li>打印班组业绩明细</li>
	</ul>
    <ul id="exportMenu" class="nui-menu" style="display:none;">
		<li class="separator"></li>
        <li>导出班组业绩</li>
        <li>导出班组业绩明细</li>
	</ul>
    
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>