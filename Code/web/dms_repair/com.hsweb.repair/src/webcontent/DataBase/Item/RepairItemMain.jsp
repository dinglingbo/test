<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-23 17:00:58
  - Description:
-->
<head>
<title>维修项目</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script
	src="<%= request.getContextPath() %>/js/DataBase/Team/TeamMain.js?v=1.0.1"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">

	<div class="nui-toolbar" id="form1"
		style="height: 30px; padding: 2px; border-bottom: 0;">
		<input class="nui-hidden" name="criteria/_entity"
			value="com.hsweb.repair.DataBase.RpbItem" />
		<table class="table" id="table1" style="height: 100%">
			<tr>
				<td>
					<label style="font-family: Verdana;">快速查询：</label> 
					<label style="font-family: Verdana;">工种：</label> 
					<input id="search-brandName" class="nui-combobox width1" textField="text" valueField="id" emptyText="请选择..." url="" 
						   allowInput="true" showNullItem="true" nullItemText="请选择..." /> 
					<label style="font-family: Verdana;">品牌：</label> 
					<input id="search-brandName" class="nui-combobox width1" textField="text"
						   valueField="id" emptyText="请选择..." url="" allowInput="true"
						   showNullItem="true" nullItemText="请选择..." /> 
					<label style="font-family: Verdana;">项目编码：</label> 
					<input class="nui-textbox" name="isDisabled" /> 
					<label style="font-family: Verdana;">项目名称：</label> 
					<input class="nui-textbox" name="isDisabled" /> 
					<a class="nui-button" plain="true" iconCls="icon-search" onclick="onSearch()">查询（Q）</a> 
					<a class="nui-button" plain="true" onclick="onClean()">清空（C）</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px; height: 30px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" id="add" iconCls="icon-add" onclick="add()" plain="true">新增项目（A）</a>
					<a	class="nui-button" id="update" iconCls="icon-edit" onclick="edit()"	plain="true">修改项目（E）</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 100%;"
		showHandleButton="false">
		<div size="20%" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-toolbar"
					style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
					<span>项目类型</span>
				</div>
				<div class="nui-fit">
					<ul id="tree1" class="nui-tree" url="" style="width: 100%;"
						dataField="rpbItems" ondrawnode="onDrawNode"
						onnodedblclick="onNodeDblClick" showTreeIcon="true"
						textField="name" idField="id" parentField="parentid"
						resultAsTree="false">
					</ul>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-fit">
				<div id="datagrid1" dataField="rpbItems" class="nui-datagrid"
					style="width: 100%; height: 91%;"
					url="com.hsapi.repair.item.queryRepairItem.biz.ext" pageSize="20"
					showPageInfo="true" multiSelect="true" showPageIndex="false"
					showPage="true" showPageSize="false" showReloadButton="false"
					showPagerButtonIcon="false" totalCount="total"
					onselectionchanged="selectionChanged" allowSortColumn="true">
					<div property="columns" >
						<div type="indexcolumn">序号</div>
						<div header="项目基本信息" headerAlign="center">
							<div property="columns">
								<div type="code" headerAlign="center" width="100px">项目编号</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" width="150px">项目名称</div>
								<div id="itemKind" field="itemKind" headerAlign="center"
									allowSort="true" width="40px">工种</div>
								<div id="type" field="type" headerAlign="center"
									allowSort="true" width="100px">项目类型</div>
								<div id="carBrandId" field="carBrandId" headerAlign="center"
									allowSort="true" width="60px">品牌</div>
								<div id="carModel" field="carModel" headerAlign="center"
									allowSort="true" width="60px">车型</div>
							</div>
						</div>
						<div header="项目价格信息" headerAlign="center">
							<div property="columns">
								<div id="itemTime" field="itemTime" headerAlign="center"
									allowSort="true" visible="true" width="70px">工时</div>
								<div id="unitPrice" field="unitPrice" headerAlign="center"
									allowSort="true" width="80px">工时单价</div>
								<div id="amt" field="amt" headerAlign="center" allowSort="true"
									width="80px">工时费</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var formData = new nui.Form("#form1").getData(false, false);
    	grid.load(formData);
    	
    	function add(){
    		nui.open({
    			url:"RepairItemDetail.jsp",
    			title:"新增维修项目",
    			width:450,
    			height:500,
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
    	
    	function edit(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"RepairItemDetail.jsp",
    	            title:"修改维修项目",
    	            width:450,
    	            height:500,
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