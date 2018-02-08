<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 13:52:54
  - Description:
-->
<head>
<title>辅料清单</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
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
			style="width: 100%; height: 100%;"
			url=""
			pageSize="20" showPageInfo="true" multiSelect="true"
			showPageIndex="false" showPage="true" showPageSize="false"
			showReloadButton="false" showPagerButtonIcon="false"
			totalCount="total" onselectionchanged="selectionChanged"
			allowSortColumn="true">

			<div property="columns">
				<div id="type" field="type" headerAlign="center" allowSort="true"
					visible="true" width="120px">辅料编码</div>
				<div id="name" field="name" headerAlign="center" allowSort="true"
					visible="true" width="330px">辅料名称</div>
				<div id="captainName" field="captainName" headerAlign="center"
					allowSort="true" visible="true" width="70px">数量</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">单价</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">金额</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">优惠</div>
				<div id="isDisabled" field="isDisabled" headerAlign="center"
					allowSort="true" visible="true" width="100px">小计</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	
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