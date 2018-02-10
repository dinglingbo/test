<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:13:52
  - Description:
-->
<head>
<title>预约分析报表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:50px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-4px 0 0 0">
					<td>
	        	    	<label style="font-family:Verdana;">当前分析维度：</label>
	        	    </td>
	        	    <td>
	        	    	<label style="color:#FF0000">快速查询：</label>
	        	    </td>
	        	</tr>
				<tr style="display: block; margin:-4px 0 0 0">
					<td>
	        	    	<label style="font-family:Verdana;">数据范围：</label>
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
						<a class="nui-button" plain="true" onclick="onMore()" style="color:#0000FF"><u>更多</u></a>
					</td>
					<td>
	        	    	<label style="font-family:Verdana;">快速分析：</label>
	        	    </td>
	        	    <td>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按维修顾问</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按预约类型</u></a>
						<a class="nui-button" plain="true" onclick="onSearch(0)" style="color:#0000FF"><u>按预约项目</u></a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true"  iconCls="icon-print" onclick="print()">打印(P)</a>
					<a class="nui-button" plain="true" 	iconCls="icon-expand" onclick="export()">导出(E)</a> 
				</td>
			</tr>
		</table>
	</div>
	<div  style="width: 100%; height: 380px;">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height:100%;"url=""
			 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
			 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
			 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
		>

			<div property="columns">
				<div header="维度" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">按XX分析（根据快速分析结果）</div>
					</div>
				</div>
				<div header="合计" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">预约总量</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">到期客户量</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">在预约</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">成功报价</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">流失</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">在预约占比</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">成功报价占比</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">流失占比</div>
					</div>
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
					<a class="nui-button" onclick="onCancel" style="margin-right:7px;width:120px;color:#0000FF" plain="true"><u>柱形图（列表）</u></a>       
				</td>
			</tr>
			<tr style="display: block; margin:0">
				<td>
					<a class="nui-textarea"onclick="onCancel" style="margin-left:20px;width:1320px;height: 160px;margin-top:5px"></a>  
				</td>				
			</tr>
		</table>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	
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