<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 17:41:14
  - Description:
-->
<head>
<title>产品录入</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">

	<div class="nui-splitter" style="width: 100%; height: 100%;" vertical="true" allowResize="false" handlerSize="0">
		<div size="6%" showCollapseButton="false">
			<div class="nui-toolbar" style="height:100%">
				<table>
					<tr>
						<td>
							<span class="form_label" id="lookup_type_name">编码：</span>
						<td colspan="1">
							<input class="nui-textbox" name="isDisabled" style="width: 80px;" />
						</td>
						<td class="form_label" id="lookup_type_name">
							名称：
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="isDisabled" style="width: 80px;" /> 
						</td>
						<td class="form_label" id="lookup_type_name">
							拼音：
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="isDisabled" style="width: 80px;" /> 
						</td>
						<td class="form_label" id="lookup_type_name">
							车型：
						</td>
						<td colspan="1">
							<input class="nui-textbox" name="isDisabled" style="width: 80px;" /> 
						</td>

						<td>
							<a class="nui-button" id="search" iconCls="icon-search" onclick="search()" plain="true">查询</a>
						</td>
						<td>
							<a class="nui-button" id="downgrade" iconCls="icon-downgrade" onclick="downgrade()" plain="true">下一页</a>
						</td>
						<td>
							<a class="nui-button" id="change" iconCls="icon-ok" onclick="change()" plain="true">选择</a>
						</td>
						<td>
							<a class="nui-button" id="new" iconCls="icon-new" onclick="onInput()" plain="true">套餐录入</a>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-splitter" style="width: 100%; height: 100%;" >
				<div size="25%" showCollapseButton="false">
					<div id="datagrid1" dataField="rpbclass" class="nui-datagrid" style="width: 100%; height: 100%;"
						url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
						pageSize="20" showPageInfo="true" multiSelect="true"
						showPageIndex="false" showPage="true" showPageSize="false"
						showReloadButton="false" showPagerButtonIcon="false"
						totalCount="total" onselectionchanged="selectionChanged"
						allowSortColumn="true">

						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true">项目类型</div>
						</div>
					</div>
				</div>
				<div showCollapseButton="false">
					<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
						style="width: 100%; height: 100%;"
						url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
						pageSize="20" showPageInfo="true" multiSelect="true"
						showPageIndex="false" showPage="true" showPageSize="false"
						showReloadButton="false" showPagerButtonIcon="false"
						totalCount="total" onselectionchanged="selectionChanged"
						allowSortColumn="true">

						<div property="columns">
							<div header="项目基本信息" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="80px">名称</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="50px">工种</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="60px">类型</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="50px">厂牌</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="50px">车型</div>
								</div>
							</div>
							<div header="工时费" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="50px">4S店</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="50px">本店</div>
								</div>
							</div>
							<div header="标准工时" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="50px">4S店</div>
								</div>
							</div>
							<div header="工时单价" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="50px">4S店</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="70px">本店（6折）</div>
								</div>
							</div>
							<div header="">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="70px">编码</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>








	<script type="text/javascript">
    	nui.parse();
    	
    	function onInput(){
    		nui.open({
    			url:"./subpage/PackgeDetail.jsp",
    			title:"本店套餐",width:1200,height:690,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"customer"};
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