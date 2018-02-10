<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-09 09:40:17
  - Description:
-->
<head>
<title>完工总检</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#combo{
    		width:140px
    	}
    	td.mini-radiobuttonlist-td {
			padding-left:10px;
			width: 90px;
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
							<span style="color:#0000FF;margin-left: 10px;">维修顾问：</span>
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
				</tr>
				<tr style="display: block; margin:-3px 0">
					<td>
						<label style="font-family:Verdana;">快速查询：</label>
					</td>
					<td>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>在维修</u></a>
						<a class="nui-button"  style="color:#0000FF" plain="true"><u>完工总检</u></a>
					</td>
					<td>
						<span style="widht:0;height:100%;border:0.6px solid #AAAAAA;margin:0 10px 0 0" ></span>
					</td>
					<td>
						
						<label class="form_label" >车牌号（客户）：</label>
						<input class="nui-textbox" emptyText="请输入..." /> 
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
					<a class="nui-button" plain="true" 	iconCls="icon-reload" onclick="reloadData()">刷新(R)</a> 
					<a class="nui-button" plain="true"  iconCls="" onclick="onFinnish()">完工总检</a> 
					<a class="nui-button" plain="true"  iconCls="icon-print"  onclick="print()">打印(P)</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false">
		<div size="24%" showCollapseButton="false">
	        <div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 87.5%;"
					url=""
					pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false"  showPageSize="false"
					showReloadButton="false" showPagerButtonIcon="false" totalCount="total" allowSortColumn="true">
		
					<div property="columns">
						<div  field="type" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
						<div  field="name" headerAlign="center" allowSort="true" visible="true" width="60px">进程</div>
						<div  field="captainName" headerAlign="center" allowSort="true" visible="true" width="100px">工单号</div>
					</div>
				</div>
			</div>	
		</div>
		<div showCollapseButton="false">
	        <div id="mainTabs" class="nui-tabs" activeIndex="0" style="width:100%; height: 87.5%;" plain="false" onactivechanged="">
				<div title="派工处理" >
					<div class="nui-fit">
						<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
							pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
							showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
							totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true">
		
							<div property="columns">
								<div header="基本信息" headerAlign="center">
									<div property="columns">
										<div  field="name" headerAlign="center" allowSort="true" visible="true" width="100px">维修项目</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="50px">工种</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="50px">工时</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="70px">维修班组</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="60px">承修人</div>
										<div  field="captainName" headerAlign="center" allowSort="true" visible="true" width="80px">开始时间</div>
									</div>
								</div>
								<div header="完工信息" headerAlign="center">
									<div property="columns">
										<div  field="name" headerAlign="center" allowSort="true" visible="true" width="90px">完工审核人</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="90px">完工时间</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="60px">状态</div>
									</div>
								</div>
								<div header="其他信息" headerAlign="center">
									<div property="columns">
										<div  field="name" headerAlign="center" allowSort="true" visible="true" width="80px">备注</div>
									</div>
								</div>
							</div>
						</div>
					</div>
		    	</div>
				<div title="审核领料单" >
					<div class="nui-fit">
						<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
							pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
							showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
							totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true">
		
							<div property="columns">
								<div header="零件信息" headerAlign="center">
									<div property="columns">
										<div  field="name" headerAlign="center" allowSort="true" visible="true" width="100px">零件编码</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="50px">零件名称</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="50px">数量</div>
									</div>
								</div>
								<div header="领料信息" headerAlign="center">
									<div property="columns">
										<div  field="name" headerAlign="center" allowSort="true" visible="true" width="90px">领料人</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="90px">领料时间</div>
										<div  class="nui-checkbox" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="60px">出库标记</div>
										<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="60px">审核人</div>
									</div>
								</div>
							</div>
						</div>
					</div>
		    	</div>	    
				<div title="基本信息" >
					<div  class="nui-panel" showToolbar="false" title="维修信息" showFooter="false" style="width:100%;height:33%;margin: 0 0 4px 0;">
						<table>
							<tr style="display: block; margin:7px 0 0 0">
								<td width="60px" style="text-align: right;">
									<label>业务类型：</label>
								</td>
								<td>
									<input class="nui-combobox" id="basetd1" textField="" url="" valueField="" allowInput="false"/> 
								</td>
								<td width="60px" style="text-align: right;">
									<label>维修类型：</label>
								</td>
								<td>
									<input class="nui-combobox" id="basetd1" textField="" url="" valueField="" allowInput="false"/> 
								</td>
								<td width="60px" style="text-align: right;">
									<label>维修顾问：</label>
								</td>
								<td>
									<input class="nui-textbox" id="basetd1"/> 
								</td>
							</tr>
							<tr style="display: block; margin:7px 0 0 0">
								<td width="60px" style="text-align: right;">
									<label>油量：</label>
								</td>
								<td>
									<input class="nui-combobox" id="basetd1" textField="" url="" valueField="" allowInput="false"/> 
								</td>
								<td width="60px" style="text-align: right;">
									<label>里程数：</label>
								</td>
								<td>
									<input class="nui-spinner" id="basetd1" maxValue="100000000" changeOnMousewheel="false" showbutton="false" allowNull="true" value="&nbsp"/>
								</td>
								<td width="60px" style="text-align: right;">
									<label>进厂日期：</label>
								</td>
								<td>
									<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time"  viewDate="new Date()"/>
								</td>
							</tr>
							<tr style="display: block; margin:7px 0 0 0">
								<td width="60px" style="text-align: right;">
									<label>报价日期：</label>
								</td>
								<td>
									<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time"  viewDate="new Date()"/>
								</td>
								<td width="60px" style="text-align: right;">
									<label>预计交车：</label>
								</td>
								<td>
									<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time" viewDate="new Date()"/>
								</td>
								<td width="60px" style="text-align: right;">
									<label>维修日期：</label>
								</td>
								<td>
									<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd HH:mm:ss" timeFormat="HH:mm:ss" showTime="time"  viewDate="new Date()"/>
								</td>
							</tr>
							<tr style="display: block; margin:7px 0 0 0">
								<td width="60px" style="text-align: right;">
									<label>完工日期：</label>
								</td>
								<td>
									<input class="nui-datepicker" id="basetd1" format="yyyy-MM-dd "  viewDate="new Date()"/>
								</td>
								<td width="60px" style="text-align: right;">
									<label>备注：</label>
								</td>
								<td>
									<input class="nui-textbox" id="basetd2"/>
								</td>
							</tr>
						</table>
					</div>
					<div  class="nui-panel" showToolbar="false" title="描述信息" showFooter="false" style="width:100%;height:47%;margin: 0 0 4px 0;">
						<table style="margin:0 0 -3px 0">
							<tr style="display: block; margin:0">
								<td width="">
									<div>客户描述：</div>
									<div>
										<input class="nui-textarea" id="textarea" /> 
									</div>
								</td>
								<td width="">
									<div>故障现象：</div>
									<div>
										<input class="nui-textarea" id="textarea" /> 
									</div>
								</td>
								<td width="">
									<div>解决措施：</div>
									<div>
										<input class="nui-textarea" id="textarea" /> 
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div  class="nui-panel" showToolbar="false" title="车辆信息" showFooter="false" style="width:100%;height:18%;margin: 4px 0 0 0;">
						<table>
							<tr style="display: block; margin:3px 0 0 0">
								<td width="60px" style="text-align: right;">
									<label>车牌号：</label>
								</td>
								<td width="60px" style="text-align: right;">
									<input id="text1" class="nui-textbox" />
								</td>
								<td width="60px" style="text-align: right;">
									<label>品牌：</label>
								</td>
								<td>
									<input class="nui-combobox" id="text1" textField="" url="" valueField="" allowInput="false"/> 
								</td>
								<td width="60px" style="text-align: right;">
									<label>车型：</label>
								</td>
								<td width="60px" style="text-align: right;">
									<input id="text1" class="nui-textbox" />
								</td>
							</tr>
							<tr style="display: block; margin:3px 0 0 0">
								<td width="60px" style="text-align: right;">
									<label>底盘号：</label>
								</td>
								<td width="60px" style="text-align: right;">
									<input id="text1" class="nui-textbox" />
								</td>
								<td width="60px" style="text-align: right;">
									<label>发动机号：</label>
								</td>
								<td width="60px" style="text-align: right;">
									<input id="text1" class="nui-textbox" />
								</td>
							</tr>
						</table>
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