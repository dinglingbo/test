<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 13:52:31
  - Description:
-->
<head>
<title>维修项目/材料</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false" >
		<div size="50%" showCollapseButton="false">
			<div class="nui-toolbar"  style="border-bottom: 0; padding: 0px;">
				<table style="width: 100%">
					<tr>
						<td style="width: 100%">
							<a class="nui-button" plain="true" iconCls="icon-add" onclick="addItem()">新增</a> 
							<a class="nui-button" plain="true" iconCls="icon-edit" onclick="editItem()">修改</a> 
							<a class="nui-button" plain="true" iconCls="icon-remove" onclick="removeItem()">删除</a>
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
						<div id="name" field="name" headerAlign="center" allowSort="true"
							visible="true" width="80px">收费类型</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="60px">工种</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="60px">工时</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">优惠</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">小计</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="100px">项目编码</div>
					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-toolbar" id="div_1"
				style="border-bottom: 0; padding: 0px;">
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
					style="width: 100%; height: 100%"
					url=""
					pageSize="20" showPageInfo="true" multiSelect="true"
					showPageIndex="false" showPage="true" showPageSize="false"
					showReloadButton="false" showPagerButtonIcon="false"
					totalCount="total" onselectionchanged="selectionChanged"
					allowSortColumn="true">

					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="100px">零件名称</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">收费类型</div>
						<div id="name" field="name" headerAlign="center" allowSort="true"
							visible="true" width="60px">数量</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="80px">单价</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">优惠</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="80px">小计</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="100px">零件编码</div>
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
    			title:"维修项目录入",width:450,height:260,
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
    	            title:"维修项目录入",width:450,height:270,
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
    			title:"维修材料录入",width:530,height:230,
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
    	            title:"维修材料录入",width:500,height:250,
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