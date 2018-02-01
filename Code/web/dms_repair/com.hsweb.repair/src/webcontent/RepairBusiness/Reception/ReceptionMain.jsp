<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>维修接待</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:30px">
        <div  class="nui-form1" id="form1" style="height:100%">
        	<input class="nui-hidden" name="criteria/_entity" value=""/>
	        	<table class="table" id="table1" style="height:100% ">
	        		<tr>
	        	   		<td>
	        	    		<label style="font-family:Verdana;">快速查询：</label>
	        	    	
	        	         	<a class="nui-button" plain="true" onclick="onSearch(0)">我接待的车</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(1)">在报价的车</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(2)">在维修的车</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(3)">已完工的车</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(4)">在结算的车</a>
	                	 	
	                	</td>
	        		</tr>
				</table>
		</div>
	</div>
	

	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="icon-reload" onclick="reload()">刷新（R）</a>
					<a class="nui-button" plain="true" iconCls="icon-add" onclick="add()">新增（A）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="save()">产品录入（P）</a>
					<a class="nui-button" plain="true" iconCls="icon-save" onclick="save()">保存（S）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="save()">确定维修（T）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="save()">维修归档（G）</a> 
					<a class="nui-button" plain="true" iconCls="" onclick="save()">审核（V）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="save()">结算（J）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="save()">出单（D）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="save()">返单（F）</a>
					<a class="nui-button" plain="true" iconCls="" onclick="save()">客户（G）</a>
					<a class="nui-MenuButton" plain="true" iconCls="" onclick="save()">其他（O）</a>
					<a class="nui-MenuButton" plain="true" iconCls="icon-print"onclick="print()">打印（P）</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false" id="datagrid1">
			<div size="30%" showCollapseButton="false">
				<div class="nui-fit">
					<div id="datagrid1" dataField="" class="nui-datagrid"
						style="width: 100%; height: 100%;"
						url=""
						pageSize="20" showPageInfo="true" multiSelect="true"
						showPageIndex="false" showPage="true" showPageSize="false"
						showReloadButton="false" showPagerButtonIcon="false"
						totalCount="total" onselectionchanged="selectionChanged"
						allowSortColumn="true">


						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="30%">车牌</div>
							<div id="name" field="name" headerAlign="center" allowSort="true"
								visible="true" width="30%">品牌</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="30%">进程</div>
							<div id="isDisabled" field="isDisabled" headerAlign="center"
								allowSort="true" visible="true" width="30%">维修顾问</div>
							<div id="isDisabled" field="isDisabled" headerAlign="center"
								allowSort="true" visible="true" width="30%">工单号</div>
						</div>
					</div>
				</div>
			</div>
			<div showCollapseButton="false">
				<div id="mainTabs" class="nui-tabs" activeIndex="0"
					style="width: 100%; height: 100%;" plain="false" onactivechanged="">
					<div title="基本信息" url="./subpage/BasicMessage.jsp"></div>
					<div title="产品录入" url="./subpage/ProductInput.jsp"></div>
					<div title="套餐清单" url="./subpage/ComboList.jsp"></div>
					<div title="估算项目/材料 " url="./subpage/EstimateItem.jsp"></div>
					<div title="维修项目/材料 " url="./subpage/RepairItem.jsp"></div>
					<div title="辅料清单 " url="./subpage/PartList.jsp"></div>
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
    			url:"./subpage/Customer.jsp",
    			title:"客户选择",width:900,height:550,
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