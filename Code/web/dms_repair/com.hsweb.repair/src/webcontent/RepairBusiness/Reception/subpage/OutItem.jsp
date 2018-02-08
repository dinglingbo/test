<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 16:52:57
  - Description:
-->
<head>
<title>出单项目/材料</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false" vertical="true">
		<div size="55%" showCollapseButton="false">
			<div class="nui-panel" style="width:100%;height:80pxs" title="出单单据信息">
				<table>
					<tr>
						<td>
							<label>进厂日期：</label>
						</td>
						<td>
							<div class="nui-datepicker" id="date" viewDate="new Date()"></div>
						</td>
						<td>
							<label>离厂日期：</label>
						</td>
						<td>
							<div class="nui-datepicker" id="date" viewDate="new Date()"></div>
						</td>
						<td>
							<label>打印日期：</label>
						</td>
						<td>
							<div class="nui-datepicker" id="date" viewDate="new Date()"></div>
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
				<table style="width: 100%">
					<tr>
						<td style="width: 100%">
							<a class="nui-button" plain="true" iconCls="icon-add" onclick="addItem()">新增</a> 
							<a class="nui-button" plain="true" iconCls="icon-edit" onclick="editItem()">修改</a>
							<a class="nui-button" plain="true" iconCls="icon-remove" onclick="removeItem()">删除</a> 
							<span width="100%"> 出单合计：
								<span id="total">
								</span>
							</span>
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
					style="width: 100%; height: 100%;"
					url=""
					pageSize="20" showPageInfo="true" multiSelect="true"
					showPageIndex="false" showPage="true" showPageSize="false"
					showReloadButton="false" showPagerButtonIcon="false"
					totalCount="total" onselectionchanged="selectionChanged"
					allowSortColumn="true">

					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="100px">项目名称</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="60px">工种</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="60px">工时</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">金额小计</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">班组</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">承修人</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="100px">项目编码</div>
					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
				<table style="width: 100%">
					<tr>
						<td style="width: 100%">
							<a class="nui-button" plain="true" iconCls="icon-add" onclick="addMaterial()">新增</a> 
							<a class="nui-button" plain="true" iconCls="icon-edit" onclick="editMaterial()">修改</a>
							<a class="nui-button" plain="true" iconCls="icon-remove" onclick="removeMaterial()">删除</a> 
						</td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
					style="width: 100%; height: 100%;"
					url=""
					pageSize="20" showPageInfo="true" multiSelect="true"
					showPageIndex="false" showPage="true" showPageSize="false"
					showReloadButton="false" showPagerButtonIcon="false"
					totalCount="total" onselectionchanged="selectionChanged"
					allowSortColumn="true">

					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="120px">零件名称</div>
						<div id="name" field="name" headerAlign="center" allowSort="true"
							visible="true" width="60px">数量</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="100px">单价</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="100px">金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="120px">零件编码</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	
    	function addItem(){
    	    nui.open({
    			url:"./subpage/addEditItem.jsp",
    			title:"维修项目录入",width:450,height:200,
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
    	function editItem(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"./subpage/addEditItem.jsp",
    	            title:"维修项目录入",width:450,height:200,
    	            onload:function(){
    	                var iframe = this.getIFrameEl();
    	                var data = {pageType:"edit",record:{comguest:row}};
    	                //直接从页面获取，不用去后台获取
    	                iframe.contentWindow.setData(data);
    	            },
    	            ondestroy:function(action){
    	                if(action == "saveSuccess"){
    	                    grid.reload();
    	                }
    	            }
    	        });
    	    }else {
    	        nui.alert("请选中一条数据", "系统提示");
    	    }
    	}
    	function addMaterial(){
    		nui.open({
    			url:"./subpage/addEditMaterial.jsp",
    			title:"维修材料录入",width:450,height:200,
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
    	function editMaterial(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"./subpage/addEditMaterial.jsp",
    	            title:"维修材料录入",width:450,height:200,
    	            onload:function(){
    	                var iframe = this.getIFrameEl();
    	                var data = {pageType:"edit",record:{comguest:row}};
    	                //直接从页面获取，不用去后台获取
    	                iframe.contentWindow.setData(data);
    	            },
    	            ondestroy:function(action){
    	                if(action == "saveSuccess"){
    	                    grid.reload();
    	                }
    	            }
    	        });
    	    }else {
    	        nui.alert("请选中一条数据", "系统提示");
    	    }
    	}
    </script>
</body>
</html>