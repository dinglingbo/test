<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 10:54:58
  - Description:
-->
<head>
<title>维修项目/材料</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-splitter" style="width: 100%; height: 100%"
		vertical="true">
		<div size="50%" showCollapseButton="false">
			<div class="nui-toolbar" id="div_1"
				style="border-bottom: 0; padding: 0px;">
				<span> <a class="nui-button" id="edit" iconCls="icon-edit"
					onclick="eidt()">修改</a> <a class="nui-button" id="add"
					iconCls="icon-remove" onclick="remove()">删除</a>
				</span> <span width="100%"> 维修合计：<span id="total"></span>
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
					allowSortColumn="true" virtualScroll="true" virtualColumns="true">

					<div property="columns">
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="5%">序号</div>
						<div id="name" field="name" headerAlign="center" allowSort="true"
							visible="true" width="20%">项目名称</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="10%">收费类型</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">优惠率</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">优惠金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">小计</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">工时</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">工种</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">班组</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">承修人</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="15%">项目编码</div>

					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-toolbar" id="div_1"
				style="border-bottom: 0; padding: 0px;">
				<span> <a class="nui-button" id="edit" iconCls="icon-edit"
					onclick="eidt()">修改</a> <a class="nui-button" id="add"
					iconCls="icon-remove" onclick="remove()">删除</a>
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
						<div id="name" field="name" headerAlign="center" allowSort="true"
							visible="true" width="20%">零件名称</div>
						<div id="captainName" field="captainName" headerAlign="center"
							allowSort="true" visible="true" width="10%">收费类型</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">数量</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">单价</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">优惠率</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="10%">优惠金额</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center"
							allowSort="true" visible="true" width="15%">零件编码</div>

					</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	//金额合计
    	var total = document.getElementById("total");
	    total.innerHTML = new Date().getTime();
	
	    
    </script>
</body>
</html>