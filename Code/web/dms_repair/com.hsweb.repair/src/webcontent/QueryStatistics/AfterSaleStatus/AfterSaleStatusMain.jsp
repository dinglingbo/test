<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:15:02
  - Description:
-->
<head>
<title>售后状况表</title>
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
						<span style="width:0;height:100%;border: 0.6px solid #AAAAAA;margin:5px" ></span>
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
						<a class="nui-button" plain="true" onclick="onMore()" style="color:#0000FF"><u>更多</u></a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;	">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true"  iconCls="icon-print" onclick="print()">打印(P)</a>
					<a class="nui-button" plain="true" 	iconCls="icon-expand" onclick="export()">导出(E)</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div  class="nui-tabs" style="width:100%;height:60%;" activeIndex="0">
			<div title="售后状况数据" >
		       <div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					>
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="维度" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">分店名称</div>
							</div>
						</div>
						<div header="车次数据" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">报价车次</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">维修车次</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">事故车次</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">完工车次</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">结算车次</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">结算金额</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">首次到店客户</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">报价维修</div>
							</div>
						</div>
						<div header="在修车数据" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">事故车次</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="100px">事故车维修金额</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">普通车次</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="100px">普通车维修金额</div>
							</div>
						</div>
						<div header="毛利" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">毛利</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">毛利率</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div title="车次日线图">
		        <div style="margin:7px" >
		        	<div  class="nui-toolbar" style="width:1302px;height: 30px;margin-left:20px;">
		        		<table style="width:100%;height: 100%;margin-top: -5px;">
		        			<tr>
		        				<td style="text-align:right;">
									<a class="nui-button" onclick="onChoice()" style="margin-right:10px;width:70px" plain="true">选择样式</a>  
									<span style="width:0;height:100%;border: 0.6px dashed #AAAAAA;margin:5px" ></span>
									<a class="nui-button" onclick="onCancel" style="margin:7px;color:#0000FF" width="120px" plain="true"><u>柱形图（列表）</u></a>       
		        				</td>
		        			</tr>
		        		</table>
					</div>
					<div>
						<a class="nui-textarea"onclick="onCancel" style="margin-left:20px;width:1310px;height: 600px;margin-top:5px"></a>  
					</div>
				</div>
		    </div>
		    <div title="新客户走势图">
		        <div style="margin:7px" >
		        	<div  class="nui-toolbar" style="width:1302px;height: 30px;margin-left:20px;">
		        		<table style="width:100%;height: 100%;margin-top: -5px;">
		        			<tr>
		        				<td style="text-align:right;">
									<a class="nui-button" onclick="onChoice()" style="margin-right:10px;width:70px" plain="true">选择样式</a>  
									<span style="width:0;height:100%;border: 0.6px dashed #AAAAAA;margin:5px" ></span>
									<a class="nui-button" onclick="onCancel" style="margin:7px;color:#0000FF" plain="true"><u>柱形图（列表）</u></a>       
		        				</td>
		        			</tr>
		        		</table>
					</div>
					<div>
						<a class="nui-textarea"onclick="onCancel" style="margin-left:20px;width:1310px;height: 600px;margin-top:5px"></a>  
					</div>
				</div>
		    </div>
		</div>
		<div style="margin:10px 0" >
			<table style="width:100%;margin-top:0;">
				<tr >
					<td style="text-align:right;">
						<a class="nui-button" onclick="onChoice()" style="margin-right:10px;width:70px">选择样式</a>  
						<span style="width:0;height:100%;border: 0.6px dashed #AAAAAA;margin:5px" ></span>
						<a class="nui-button" onclick="onCancel" style="margin-right:7px;width:100px;color:#0000FF" plain="true"><u>柱形图（列表）</u></a>       
					</td>
				</tr>
				<tr style="display: block; margin:0">
					<td>
						<a class="nui-textarea"onclick="onCancel" style="margin-left:20px;width:1320px;height: 180px;margin-top:5px"></a>  
					</td>				
				</tr>
			</table>
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
    	
    	function onChoice(){
    		nui.open({
    			url:"./subpage/onChoice.jsp",
    			title:"定制",width:200,height:300,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"onChoice"};
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