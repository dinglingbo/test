<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 09:49:46
  - Description:
-->
<head>
<title>套餐清单</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px;">
		<span> 
			<a class="nui-button" plain="true" iconCls="icon-edit"  onclick="add()">修改</a> 
			<a class="nui-button" plain="true" iconCls="icon-remove" onclick="remove()">删除</a> 
			<a class="nui-button" plain="true" iconCls="icon-ok"  onclick="ok()">同意维修</a>
		</span> 
		<span width="100%"> 
			套餐合计： 
			<div id="total"></div>
		</span>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
			style="width: 100%; height: 100%;"
			url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
			pageSize="20" showPageInfo="true" multiSelect="true"
			showPageIndex="false" showPage="true" showPageSize="false"
			showReloadButton="false" showPagerButtonIcon="false"
			totalCount="total" onselectionchanged="selectionChanged"
			allowSortColumn="true">

			<div property="columns">
				<div id="type" field="type" headerAlign="center" allowSort="true"
					visible="true" width="5%">序号</div>
				<div header="套餐信息">
					<div property="columns">
						<div id="name" field="name" headerAlign="center" allowSort="true"
							visible="true" width="40%">套餐名称</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="10%">状态</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="15%">优惠金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="15%">小计金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="15%">4S店金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="25%">备注</div>
					</div>
				</div>

			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	function add(){
    		nui.open({
    			url:"../../common/subpage/EditCombo.jsp",
    			title:"修改套餐",
    			width:650,
    	        height:550,
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
    	
    	function editCombo(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"../../common/subpage/EditCombo.jsp",
    	            title:"修改套餐",
    	            width:500,
    	            height:680,
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