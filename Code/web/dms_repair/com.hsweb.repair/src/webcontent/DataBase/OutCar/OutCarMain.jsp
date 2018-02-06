<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 11:14:08
  - Description:
-->
<head>
<title>出车报告</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar" height="15px">
		<label>出车报告</label>
	</div>
	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px; height: 30px">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%"><a class="nui-button"  plain="true" iconCls="icon-add" onclick="addClass()">新增（A）</a> 
					<a class="nui-button" plain="true"" iconCls="icon-edit" onclick="edit()">修改（E）</a>
					<a class="nui-button" plain="true" iconCls="icon-remove" onclick="remove()">删除（D）</a> 
					<a class="nui-button" plain="true" iconCls="icon-save" onclick="save()">保存（S）</a> 
					<a class="nui-button" plain="true" iconCls="icon-cancel" onclick="cancel()">取消（C）</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 100%;"
		showHandleButton="false">
		<div size="20%" showCollapseButton="false">
			<div class="nui-fit">
				<div size="240" showCollapseButton="false">
					<!-- 树形联动 -->
					<div class="nui-fit">
						<ul id="tree1" class="nui-tree" url="" style="width: 100%;"
							showTreeIcon="true" textField="name" idField="id"
							parentField="pid" resultAsTree="false">

						</ul>
					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-splitter" style="width: 100%; height: 100%;"
				showHandleButton="false">
				<div size="60%" showCollapseButton="false">
					<div class="nui-fit">
						<div id="datagrid1" dataField="types" class="nui-datagrid"
							style="width: 100%; height: 100%;"
							url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
							pageSize="20" showPageInfo="true" multiSelect="true"
							showPageIndex="false" showPage="true" showPageSize="false"
							showReloadButton="false" showPagerButtonIcon="false"
							totalCount="total" onselectionchanged="selectionChanged"
							allowSortColumn="true">

							<div property="columns">
								<div id="id" field="id" headerAlign="center" allowSort="true"
									visible="true" width="40px">序号</div>
								<div header="出车报告列表" headerAlign="center">
									<div property="columns">
										<div id="type" field="type" headerAlign="center"
											allowSort="true" visible="true">报告类型</div>
										<div id="name" field="name" headerAlign="center"
											allowSort="true" visible="true">报告内容</div>

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div showCollapseButton="false">
					<span
						style="margin-left: 20px; margin-top: 5px; height: 30px; display: inline-block;">报告类型：</span></br>
					<span style="margin: 10px 0px 10px 20px;"> <input
						class="nui-combobox" property="editor"
						style="width: 90%; height: 30px; display: inline-block;"
						data="Genders" />
					</span></br> <span
						style="margin-left: 20px; height: 30px; color: #FF0000; display: inline-block;">报告类型：</span></br>
					<input class="nui-TextArea"
						style="margin-left: 20px; width: 90%; height: 75%" />

				</div>
			</div>

		</div>
	</div>

	<div id="layout1" class="nui-layout"
		style="width: 100%; height: 83%; margin: 0px 0;"
		borderStyle="border:solid 0px #aaa;">


		<!-- 出车报告类型 -->
		<div id="west" title="出车报告类型" region="west" width="250%"
			showHeader="true" showCollapseButton="false"></div>


		<!-- 出车报告列表 -->
		<div id="center" region="center" title="出车报告列表" width="300%"
			showHeader="true" showCollapseButton="false"></div>

		<!-- 报告内容编辑 -->
		<div id="east" title="报告内容编辑" region="east" width="500%"
			showHeader="true" showCollapseButton="false"></div>
	</div>
	</div>


	<script type="text/javascript">
    	nui.parse();
    	
    	var tree = nui.get("tree1");
        var grid = nui.get("grid1");
        
        
        tree.on("nodeselect", function (e) {
        
            if (e.isLeaf) {
                grid.load({ dept_id: e.node.id });
            } else {
                grid.setData([]);
                grid.setTotalCount(0);
            }
        });
        var Genders = [{ id: 1, text: '男' }, { id: 2, text: '女'}];
        function onGenderRenderer(e) {
            for (var i = 0, l = Genders.length; i < l; i++) {
                var g = Genders[i];
                if (g.id == e.value) return g.text;
            }
            return "";
        }
    </script>
</body>
</html>