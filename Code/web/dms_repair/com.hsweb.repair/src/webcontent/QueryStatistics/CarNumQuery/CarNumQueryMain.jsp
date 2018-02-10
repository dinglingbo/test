<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 09:36:22
  - Description:
-->
<head>
<title>车辆基盘数量查询</title>
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
						<input class="nui-spinner" maxValue="2100" minValue="2000" showButton="false" changeOnMousewheel="false" value="&nbsp" allowNull="true"/>
					</td>
					<td>
						<label >年</label>
					</td>
					<td>
						<input class="nui-spinner" maxValue="12" minValue="1" showButton="false" changeOnMousewheel="false" value="&nbsp" allowNull="true"/>
					</td>
					<td>
						<label >月</label>
					</td>
					<td>
						<input class="nui-spinner" maxValue="31" minValue="1" showButton="false" changeOnMousewheel="false" value="&nbsp" allowNull="true"/>
					</td>
					<td>
						<label >日</label>
					</td>
					<td>
						<a class="nui-button" plain="true"  iconCls="icon-search" onclick="search()">打印(P)</a>
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
		<div  class="nui-tabs" style="width:100%;height:100%;" activeIndex="0">
			<div title="车辆汇总">
		       <div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					 frozenStartColumn="0" frozenEndColumn="6">
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="100px">公司名称</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">期初车辆</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">期末车辆</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">流入车辆</div>
							<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">流出车辆</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">回流车辆</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">新车客户</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">期初流失</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">期末流失</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">净流失</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">流失率</div>
					</div>
				</div>
			</div>
			<div title="车辆走势图">
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
						<a class="nui-textarea"onclick="onCancel" style="margin-left:20px;width:1310px;height: 500px;margin-top:5px"></a>  
					</div>
				</div>
		    </div>
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