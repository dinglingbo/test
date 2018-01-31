<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 10:00:54
  - Description:
-->
<head>
<title>险种信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-splitter" style="width: 100%; height: 100%;">
		<div size="30%" showCollapseButton="false">
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
							visible="true" width="40px">操作</div>
						<div id="type" field="type" headerAlign="center" allowSort="true"
							visible="true" width="100px">保险险种</div>
					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
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
						<div header="" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="40px">操作</div>
							</div>
						</div>
						<div header="险种信息" headerAlign="center">
							<div property="columns">
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="100px">承保险种</div>
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="100px">责任限额（万元）</div>
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="80px">保险费（元）</div>
								<div id="type" field="type" headerAlign="center"
									allowSort="true" visible="true" width="150px">备注</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>