<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 17:02:48
  - Description:
-->
<head>
<title>品牌车行</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script
	src="<%= request.getContextPath() %>/repair/js/DataBase/Brand/BrandMain.js?v=1.0.1"></script>


</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-toolbar" id="form1" style="height: 30px">

		<input class="nui-hidden" name="criteria/_entity" value="com.hsapi.repair.common.ComCarBrand" />
		<table class="table" id="table1" style="height: 100%">
			<tr>
				<td>
					<label style="font-family: Verdana;">快速查询：</label> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(0)"><u>已启用</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(1)"><u>已禁用</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(2)"><u>全部</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(3)"><u>同步品牌</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(4)"><u>同步车系</u></a> 
					<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(5)"><u>同步车型</u></a>
				</td>
			</tr>
		</table>

	</div>




	<!-- 左右 -->
	<div class="nui-splitter" handlerSize="2" showHandleButton="false"
		style="width: 100%; height: 100%;" borderStyle="border:0">
		<div style="width: 100%; height: 100%;" size="40%">
			<!-- 左边的上下 -->
			<div class="nui-splitter" handlerSize="2" showHandleButton="false"
				style="width: 100%; height: 100%;" borderStyle="border:0"
				vertical="true">
				<div style="width: 100%; height: 100%;" size="50%">
					<!-- 车辆品牌信息 -->
					<div class="nui-toolbar" id="tb1"
						style="border-bottom: 0; padding: 0px;">
						<table style="width: 100%">
							<tr>
								<td style="width: 100%"><a class="nui-button" id="add"
									iconCls="icon-add" onclick="addBrand()" plain="true">新增品牌（A）</a>
									<a class="nui-button" id="update" iconCls="icon-edit"
									onclick="editBrand()" plain="true">修改品牌（E）</a> <a
									class="nui-button" id="no" iconCls="icon-no" onclick="no()"
									plain="true">禁用品牌（D）</a></td>
							</tr>
						</table>
					</div>
					<div class="nui-fit">
						<div id="datagrid1" dataField="brands" class="nui-datagrid"
							style="width: 100%; height: 100%;"
							url="com.hsapi.repair.brand.queryBrand.biz.ext" pageSize="20"
							showPageInfo="true" multiSelect="true" showPageIndex="false"
							showPage="true" showPageSize="false" showReloadButton="false"
							showPagerButtonIcon="false" totalCount="total"
							onselectionchanged="selectionChanged" allowSortColumn="true">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div header="车辆品牌信息" headerAlign="center">
									<div property="columns">
										<div field="carBrandZh" headerAlign="center" allowSort="true"
											visible="true" width="60%">名称</div>
										<div field="isDisabled" headerAlign="center" allowSort="true"
											visible="true" width="30%">是否禁用</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div>
					<!-- 车系信息 -->
					<div class="nui-toolbar" id="div_2"
						style="border-bottom: 0; padding: 0px;">
						<table style="width: 100%">
							<tr>
								<td style="width: 100%"><a class="nui-button" id="add"
									iconCls="icon-add" onclick="addSeries()" plain="true">新增车系（S）</a>
									<a class="nui-button" id="update" iconCls="icon-edit"
									onclick="editSeries()" plain="true">修改车系（D）</a></td>
							</tr>
						</table>
					</div>
					<div class="nui-fit">
						<div id="datagrid1" dataField="seriess" class="nui-datagrid"
							style="width: 100%; height: 90%;"
							url="com.hsapi.repair.brand.querySeries.biz.ext" pageSize="20"
							showPageInfo="true" multiSelect="true" showPageIndex="false"
							showPage="true" showPageSize="false" showReloadButton="false"
							showPagerButtonIcon="false" totalCount="total"
							onselectionchanged="selectionChanged" allowSortColumn="true">
							<div property="columns">
								<div type="indexcolumn">序号</div>
								<div header="车系信息" headerAlign="center">
									<div property="columns">
										<div id="name" field="name" headerAlign="center"
											allowSort="true" visible="true" width="60%">名称</div>
										<div id="isDisabled" field="isDisabled" headerAlign="center"
											allowSort="true" visible="true" width="30%">是否禁用</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
		<div>
			<!-- 车型车系信息 -->
			<div class="nui-toolbar" id="div_1"
				style="border-bottom: 0; padding: 0px;">
				<table style="width: 100%">
					<tr>
						<td style="width: 100%"><a class="nui-button"
							iconCls="icon-add" onclick="addModel()" plain="true">新增车型（N）</a>
							<a class="nui-button" iconCls="icon-edit" onclick="editModel()"
							plain="true">修改车型（M）</a> <a class="nui-button" iconCls="icon-no"
							onclick="forbiddenModel()" plain="true">禁用车型（C）</a></td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="datagrid1" dataField="models" class="nui-datagrid"
					style="width: 100%; height: 95%;"
					url="com.hsapi.repair.brand.queryModel.biz.ext" pageSize="20"
					showPageInfo="true" multiSelect="true" showPageIndex="false"
					showPage="true" showPageSize="false" showReloadButton="false"
					showPagerButtonIcon="false" totalCount="total"
					onselectionchanged="selectionChanged" allowSortColumn="true">
					<div property="columns">
						<div type="indexcolumn">序号</div>
						<div header="车型车系信息" headerAlign="center">
							<div property="columns">
								<div field="carFactoryName" headerAlign="center"
									allowSort="true" visible="true" width="15%">厂商</div>
								<div field="carSeriesName" headerAlign="center" allowSort="true"
									width="15%">车系</div>
								<div field="carModel" headerAlign="center" allowSort="true"
									width="50%">车型</div>
								<div field="isDisabled" headerAlign="center" allowSort="true"
									visible="true" width="20%">是否禁用</div>
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
    	
    	function addBrand(){
    		nui.open({
    			url:"CarBrandDetail.jsp",
    			title:"新增品牌",width:400,height:200,
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
    	
    	function editBrand(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"CarBrandDetail.jsp",
    	            title:"修改品牌",
    	            width:400,
    	            height:200,
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
    	
    	function addSeries(){
    		nui.open({
    			url:"CarSeriesDetail.jsp",
    			title:"新增车系",width:400,height:280,
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
    	
    	function editSeries(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"CarSeriesDetail.jsp",
    	            title:"修改车系",
    	            width:400,
    	            height:280,
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
    	
    	function addModel(){
    		nui.open({
    			url:"CarModelDetail.jsp",
    			title:"新增车型",width:400,height:280,
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
    	
    	function editModel(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"CarModelDetail.jsp",
    	            title:"修改车型",
    	            width:400,
    	            height:280,
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
    	
    	//重新刷新页面
    	function refresh(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false);
    		grid.load(json);
    		nui.get("update").enable();
    	}
    	//查询
    	function search(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false)
    		grid.load(json);
    	}
    	//重置查询条件
    	function reset(){
    		var form = new nui.Form("#form1");
    		grid.reset();
    	}
    	//enter键触发
    	function onKeyEnter(e){
    		search();
    	}
    	//选择列（判定，大于一编辑禁用）
    	function selectionChanged(){
    	    var rows = grid.getSelecteds();
    	    if(rows.length>1){
    	        nui.get("update").disable();
    	    }else{
    	        nui.get("update").enable();
    	    }
    	}
    	function onIsDisabled(e) {
        if (e.value == 1) return "禁用";
        if (e.value == 0) return "启用";
    }
    </script>
</body>
</html>