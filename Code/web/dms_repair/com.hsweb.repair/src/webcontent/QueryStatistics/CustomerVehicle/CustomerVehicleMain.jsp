<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:15:59
  - Description:
-->
<head>
<title>客户车辆明细</title>
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
	        	    	<label style="font-family:Verdana;">日期：</label>
	        	    </td>
					<td>
						<input class="nui-datepicker data"   format="yyyy-MM-dd" viewDate="new Date()"/>
					</td>
					<td>
						<a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div  class="nui-tabs" style="width:100%;height:100%;" activeIndex="0">
	    <div title="期初车辆">
	        <div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					 frozenStartColumn="0" frozenEndColumn="11">
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="客户信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">公司名字</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">维修单号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">回访员</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">品牌</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后来厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后离厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">来厂次数</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">离厂天数</div>
							</div>
						</div>
						<div header="车辆信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">底盘号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">保险到期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">年审日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">建档日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">投保公司</div>
							</div>
						</div>
						<div header="其他信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">发动机号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">颜色</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
	    </div>
	    
	    <div title="期末车辆">
	         <div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					 frozenStartColumn="0" frozenEndColumn="11">
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="客户信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">公司名字</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">维修单号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">回访员</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">品牌</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后来厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后离厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">来厂次数</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">离厂天数</div>
							</div>
						</div>
						<div header="车辆信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">底盘号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">保险到期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">年审日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">建档日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">投保公司</div>
							</div>
						</div>
						<div header="其他信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">发动机号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">颜色</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
	    </div>
	    
	    <div title="流入车辆">
	         <div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					 frozenStartColumn="0" frozenEndColumn="10">
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="客户信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">公司名字</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">维修单号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">品牌</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后来厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后离厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">来厂次数</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">离厂天数</div>
							</div>
						</div>
						<div header="车辆信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">底盘号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">保险到期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">年审日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">建档日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">投保公司</div>
							</div>
						</div>
						<div header="其他信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">发动机号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">颜色</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
	    </div>
	    
	    <div title="流出车辆">
	         <div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					 frozenStartColumn="0" frozenEndColumn="10">
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="客户信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">公司名字</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">维修单号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">品牌</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后来厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后离厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">来厂次数</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">离厂天数</div>
							</div>
						</div>
						<div header="车辆信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">底盘号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">保险到期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">年审日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">建档日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">投保公司</div>
							</div>
						</div>
						<div header="其他信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">发动机号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">颜色</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
	    </div>
	    
		<div title="回流车辆">
	         <div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					 frozenStartColumn="0" frozenEndColumn="11">
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="客户信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">公司名字</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">维修单号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">回访员</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">品牌</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后来厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后离厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">来厂次数</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">离厂天数</div>
							</div>
						</div>
						<div header="车辆信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">底盘号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">保险到期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">年审日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">建档日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">投保公司</div>
							</div>
						</div>
						<div header="其他信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">发动机号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">颜色</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
	    </div>
	    
	    <div title="新车客户">
	        <div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					 frozenStartColumn="0" frozenEndColumn="11">
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="客户信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">公司名字</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">维修单号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">回访员</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">品牌</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后来厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后离厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">来厂次数</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">离厂天数</div>
							</div>
						</div>
						<div header="车辆信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">底盘号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">保险到期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">年审日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">建档日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">投保公司</div>
							</div>
						</div>
						<div header="其他信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">发动机号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">颜色</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
	    </div>
	    
		<div title="期初流失车辆">
			<div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					 frozenStartColumn="0" frozenEndColumn="11">
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="客户信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">公司名字</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">维修单号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">回访员</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">品牌</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后来厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后离厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">来厂次数</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">离厂天数</div>
							</div>
						</div>
						<div header="车辆信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">底盘号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">保险到期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">年审日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">建档日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">投保公司</div>
							</div>
						</div>
						<div header="其他信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">发动机号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">颜色</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
	    </div>
	    
	    <div title="期末流失车辆">
			<div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
					 pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
					 showReloadButton="false" showPagerButtonIcon="false" selectOnRightClick="true"
					 totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true"
					 frozenStartColumn="0" frozenEndColumn="11">
		
					<div property="columns">
						<div type="indexcolumn"headerAlign="center" allowSort="true" width="30px">序号</div>
						<div header="客户信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="70px">公司名字</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="90px">维修单号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">客户名称</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">维修顾问</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">回访员</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车牌号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">品牌</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后来厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">最后离厂日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">来厂次数</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">离厂天数</div>
							</div>
						</div>
						<div header="车辆信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="60px">车型</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">底盘号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">保险到期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">年审日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">建档日期</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">投保公司</div>
							</div>
						</div>
						<div header="其他信息" headerAlign="center">
							<div property="columns">
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">发动机号</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份</div>
								<div  field="" headerAlign="center" allowSort="true" visible="true" width="50px">颜色</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
	    </div>
	    <div title="名词解释">
	    	<div  class="nui-panel" showToolbar="false" title="" showHeader="false"showFooter="true" style="width:100%;height:95%">
				<table>
					<tr>
						<td style="width:200px">
							<label>期初车辆</label>
						</td>
						<td style="width:600px">
							<label>查询时间点前150天至前30天在店维修的车辆。</label>
						</td>
					</tr>
					<tr>
						<td style="width:200px">
							<label>期末车辆</label>
						</td>
						<td style="width:600px">
							<label>查询时间点往前120天在店维修的车辆。</label>
						</td>
					</tr>
					<tr>
						<td style="width:200px">
							<label>首次到店车辆</label>
						</td>
						<td style="width:600px">
							<label>首次到连锁任意分店维修的车辆。</label>
						</td>
					</tr>
					<tr>
						<td style="width:200px">
							<label>流出客户</label>
						</td>
						<td style="width:600px">
							<label>本店的车辆转出到其他店维修。</label>
						</td>
					</tr>
					<tr>
						<td style="width:200px">
							<label>流入客户</label>
						</td>
						<td style="width:600px">
							<label>其他店的车辆转入本店维修。</label>
						</td>
					</tr>
					<tr>
						<td style="width:200px">
							<label>流失客户</label>
						</td>
						<td style="width:600px">
							<label>最近出厂时间超过120天的车辆，且不在厂维修。</label>
						</td>
					</tr>
					<tr>
						<td style="width:200px">
							<label>期初流失</label>
						</td>
						<td style="width:600px">
							<label>开店时间至当前时间前30天所有超过120天未来厂客户。</label>
						</td>
					</tr>
					<tr>
						<td style="width:200px">
							<label>期末流失</label>
						</td>
						<td style="width:600px">
							<label>开店时间到当前时间所有超过120天未来厂客户。</label>
						</td>
					</tr>
					<tr>
						<td style="width:200px">
							<label>净流失</label>
						</td>
						<td style="width:600px">
							<label>期末流失-期初流失。</label>
						</td>
					</tr>
					<tr>
						<td style="width:200px">
							<label>回流客户</label>
						</td>
						<td style="width:600px">
							<label>已流失车辆再回厂维修。</label>
						</td>
					</tr>
				</table>
			</div>
		</div>
	    	
	</div>

	



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>