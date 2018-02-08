<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-08 16:36:01
  - Description:
-->
<head>
<title>车间效率分析</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<style type="text/css">
    	#combo{
    		width:140px
    	}
    	td.mini-radiobuttonlist-td {
			width: 75px;
			
		}
		#basetd1{
    		width:166px
    	}
    	#basetd2{
    		width:400px
    	}
    	#text1{
    		width:166px
    	}
    	#textarea{
    		width: 330px;
    		height: 200px;
    	}
    	
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:26px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-2px 0">
					<td>
						<label style="font-family:Verdana;">快速查询：</label>
					</td>
					<td>
						<label >年份：</label>
					</td>
					<td>
						<input class="nui-spinner" maxValue="2100" showButton="false" changeOnMousewheel="false" value="&nbsp" allowNull="true"/>
					</td>
					<td>
						<label >月份：</label>
					</td>
					<td>
						<input class="nui-spinner" maxValue="12" showButton="false" changeOnMousewheel="false" value="&nbsp" allowNull="true"/>
					</td>
					<td>
						<div  class="nui-radiobuttonlist" valueField="id" repeatItems="4" textField="text"  repeatLayout="table"
							  data="[{ id: 0, text: '工时' },{ id: 1, text: '工时费' }]">
						</div>
					</td>
					<td>
						<label>统计日期:</label>
					</td>
					<td>
						
						<div  class="nui-radiobuttonlist" valueField="id" repeatItems="4" textField="text"  repeatLayout="table"
							  data="[{ id: 0, text: '维修日期' },{ id: 1, text: '结算日期' }]">
						</div>
					</td>
					<td>
						<span style="widht:0;height:100%;border:0.6px solid #AAAAAA;margin:0 10px 0 0"></span>
						<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">统计</a>
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
					<a class="nui-button" plain="true" 	iconCls="icon-expand" onclick="export()">导出</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-toolbar" style="width: 100%;background: #DDD;">
		<label>把列标题拖放到此处使记录按此列进行分组</label>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
			 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
			 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
			 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
			 frozenStartColumn="0" frozenEndColumn="3">

			<div property="columns">
				<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
				<div header="基本信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="100px">分店名称</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">班组名称</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">成员名称</div>
					</div>
				</div>
				<div header="工时信息" headerAlign="center">
					<div property="columns">
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">1号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">2号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">3号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">4号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">5号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">6号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">7号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">8号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">9号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">10号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">11号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">12号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">13号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">14号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">15号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">16号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">17号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">18号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">19号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">20号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">21号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">22号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">23号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">24号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">25号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">26号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">27号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">28号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">29号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">30号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">31号</div>
						<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">合计</div>
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