<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-08 09:57:49
  - Description:
-->
<head>
<title>索赔登记（登记和处理）</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#textarea{
    		width: 780px;
    		height: 136px;
    	}
    	#basetd1{
    		width:120px
    	}
    	#basetd2{
    		width:62px
    	}
    </style>
</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="width:100%;height:24px">
		<a class="nui-button" iconCls="icon-save" onclick="save()" plain="true">保存</a>
		<a class="nui-button" iconCls="icon-ok" onclick="ok()" plain="true">过账</a>
		<a class="nui-button" iconCls="icon-no" onclick="onClose()" plain="true" >关闭</a>
	</div>
	<div  class="nui-panel" showToolbar="false" title="基本信息" showFooter="false" style="width:99%;height:100px;margin: 4px;">
		<table>
			<tr style="display: block; margin:0">
				<td width="60px">
					<label>索赔单号：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd1" /> 
				</td>
				<td width="60px">
					<label>索赔类型：</label>
				</td>
				<td>
					<input class="nui-combobox" id="basetd1" /> 
				</td>
				<td width="60px">
					<label>业务单号：</label>
				</td>
				<td>
					<input class="nui-buttonedit" onclick="repairCustomer()" width="250px"/> 
				</td>
			</tr>
			<tr style="display: block; margin: 3px 0 -1px 0">
				<td width="60px">
					<label>车牌号：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd1" /> 
				</td>
				<td width="60px">
					<label>车辆厂牌：</label>
				</td>
				<td>
					<input class="nui-combobox" id="basetd1" /> 
				</td>
				<td width="60px">
					<label>车型：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd1" />  
				</td>
				<td width="60px">
					<label>维修顾问：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd2" />  
				</td>
				<td >
					<label>联系人：</label>
				</td>
				<td>
					<input class="nui-textbox" id="basetd2" />  
				</td>
			</tr>
		</table>
	</div>
	<div id="mainTabs" class="nui-tabs" activeIndex="0" style="width:99%; height: 76.5%;margin: 4px" plain="false" onactivechanged="">
		<div title="索赔描述" >
			<table>
				<tr style="display: block; margin:0">
					<td width="60px">
						<label>客户描述：</label>
					</td>
					<td>
						<input class="nui-textarea" id="textarea" /> 
					</td>
				</tr>
				<tr style="display: block; margin:0">
					<td width="60px">
						<label>处理描述：</label>
					</td>
					<td>
						<input class="nui-textarea" id="textarea" /> 
					</td>
				</tr>
				<tr style="display: block; margin:0">
					<td width="60px">
						<label>防范措施：</label>
					</td>
					<td>
						<input class="nui-textarea" id="textarea" /> 
					</td>
				</tr>
			</table>
		</div>
		<div title="索赔项目" >
			<div  class="nui-splitter" style="width:100%;height:100%;" vertical="true" allowResize="false">
			    <div size="50%" showCollapseButton="false">
			        <div class="nui-fit">
						<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
							pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
							showReloadButton="false" showPagerButtonIcon="false"
							totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true">
		
							<div property="columns">
								<div  field="name" headerAlign="center" allowSort="true"
									visible="true" width="120px">项目名称</div>
								<div  field="captainName" headerAlign="center"
									allowSort="true" visible="true" width="70px">收费类型</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="50px">工种</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="50px">工时</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="70px">金额小计</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="70px">班组</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="60px">承修人</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="120px">项目编码</div>
							</div>
						</div>
		    		</div>
		    	</div>
			    <div showCollapseButton="false">
			        <div>
			        	<table>
			        		<tr>
			        			<td>
				        			<a class="nui-button" iconCls="icon-ok" onclick="save()" plain="true">选择索赔</a>
									<a class="nui-button" iconCls="icon-remove" onclick="ok()" plain="true">删除</a>
			        			</td>
			        		</tr>
			        	</table>
			        </div>
			        <div class="nui-fit">
						<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"style="width: 100%; height: 100%;"
							url=""
							pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
							showReloadButton="false" showPagerButtonIcon="false" totalCount="total"
							allowSortColumn="true" virtualScroll="true" virtualColumns="true">
		
							<div property="columns">
								<div  field="name" headerAlign="center" allowSort="true"
									visible="true" width="160px">项目名称</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="60px">工种</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="80px">班组</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="60px">主修人</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="90px">金额</div>
								<div  field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" width="150px">备注</div>
							</div>
						</div>
		    		</div>
			    </div>
			</div>
		</div>
		<div title="索赔配件" >
			<div  class="nui-splitter" style="width:100%;height:100%;" vertical="true" allowResize="false">
			    <div size="50%" showCollapseButton="false">
			        <div class="nui-fit">
						<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"url=""
							pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
							showReloadButton="false" showPagerButtonIcon="false"
							totalCount="total" allowSortColumn="true" virtualScroll="true" virtualColumns="true">
		
							<div property="columns">
								<div  field="name" headerAlign="center" allowSort="true" visible="true" width="130px">零件名称</div>
								<div  field="captainName" headerAlign="center" allowSort="true" visible="true" width="80px">收费类型</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="80px">数量</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="100px">单价</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="100px">金额</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="130px">零件编码</div>
							</div>
						</div>
		    		</div>
			    </div>
			    <div showCollapseButton="false">
			        <div>
			        	<table>
			        		<tr>
			        			<td>
				        			<a class="nui-button" iconCls="icon-ok" onclick="save()" plain="true">选择索赔</a>
									<a class="nui-button" iconCls="icon-remove" onclick="ok()" plain="true">删除</a>
			        			</td>
			        		</tr>
			        	</table>
			        </div>
			        <div class="nui-fit">
						<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"style="width: 100%; height: 100%;"
							url=""
							pageSize="20" showPageInfo="false" multiSelect="true" showPageIndex="false" showPageSize="false"
							showReloadButton="false" showPagerButtonIcon="false" totalCount="total"
							allowSortColumn="true" virtualScroll="true" virtualColumns="true">
		
							<div property="columns">
								<div  field="name" headerAlign="center" allowSort="true"
									visible="true" width="160px">零件名称</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="70px">数量</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="80px">单价</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="100px">金额</div>
								<div  field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="150px">备注</div>
							</div>
						</div>
		    		</div>
			    </div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	
    	
    	function repairCustomer(){
    		nui.open({
    			url:"../../common/RepairCustomer.jsp",
    			title:"维修客户选择",width:880,height:500,
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
    	
    </script>
</body>
</html>