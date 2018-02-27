<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
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
<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/repair/js/DataBase/OutCar/outCarReportMain.js"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div class="nui-toolbar"  style="border-bottom: 0; padding: 0px; height: 30px">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%"><a class="nui-button"  plain="true" iconCls="icon-add" onclick="addClass()">新增（A）</a> 
					<a class="nui-button" plain="true" iconCls="icon-edit" onclick="edit()">修改（E）</a>
					<a class="nui-button" plain="true" iconCls="icon-remove" onclick="remove()">删除（D）</a> 
					<a class="nui-button" plain="true" iconCls="icon-save" onclick="save()">保存（S）</a> 
					<a class="nui-button" plain="true" iconCls="icon-cancel" onclick="cancel()">取消（C）</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-splitter" style="width: 100%; height: 95.5%;" showHandleButton="false" allowResize="false">
		<div size="20%" showCollapseButton="false">
			<div class="nui-fit">
				<div class="nui-toolbar"
					style="padding: 2px; border-top: 0; border-left: 0; border-right: 0; text-align: center;">
					<span>出车报告类型</span>
				</div>
				<!-- 树形联动 -->
				<div class="nui-fit">
					<ul id="tree1" class="nui-tree" url="" style="width: 100%;" dataField="datas"
						showTreeIcon="true" textField="name" idField="id" parentField="parentId"
						resultAsTree="false"
						
						onrowclick="onOutCarRowClick"
						selectOnLoad="true"
					>

					</ul>
				</div>
			</div>
		</div>
		<div showCollapseButton="false">
			<div class="nui-splitter" style="width: 100%; height: 100%;" showHandleButton="false" allowResize="false">
				<div size="60%" showCollapseButton="false">
					<div  class="nui-panel" showToolbar="false" title="出车报告类型"  showFooter="false" style="width:100%;height:100%;">
						<div class="nui-fit">
							<div id="datagrid1" dataField="outs" class="nui-datagrid"
								style="width: 100%; height: 100%;"
								url=""
								showPageInfo="false" multiSelect="true"
								showPageIndex="false" showPageSize="false"
								showReloadButton="false" showPagerButtonIcon="false"
								
								onrowclick="onOutCarDataRowClick"
								selectOnLoad="true"
								allowSortColumn="true"
							>
	
								<div property="columns">
									<div type="indexcolumn" headerAlign="center" width="40px">序号</div>
									<div header="出车报告列表" headerAlign="center">
										<div property="columns">
											<div field="type" headerAlign="center" allowSort="true" visible="true">报告类型</div>
											<div field="content" headerAlign="center" allowSort="true" visible="true">报告内容</div>
	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div showCollapseButton="false">
					<div id="dataform1" class="form" >
						<input name="id" class="nui-hidden"/>
						<div  class="nui-panel" showToolbar="false" title="报告内容编辑"  showFooter="false" style="width:100%;height:100%;">
							<span
								style="margin-left: 20px; margin-top: 5px; height: 30px; display: inline-block;">报告类型：</span></br>
							<span style="margin: 10px 0px 10px 20px;"> 
							<input class="nui-combobox" property="editor"
								style="width: 90%; height: 30px; display: inline-block;"
								 />
							</span>
							</br> 
							<span style="margin-left: 20px; height: 30px; color: #FF0000; display: inline-block;">报告内容：</span></br>
							<input class="nui-TextArea" name="content" style="margin-left: 20px; width: 90%; height: 480px" />
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>

	


	
</body>
</html>