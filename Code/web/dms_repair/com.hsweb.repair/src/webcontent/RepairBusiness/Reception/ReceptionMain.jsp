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
	<div class="nui-panel" showToolbar="false" title="" showFooter="true"
		style="width: 100%; height: 12%">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsweb.repair.DataBase.RpbClass" />
			<!-- 排序 -->
			<input class="nui-hidden" name="criteria/_orderby[1]/_property"
				value="id" /> <input class="nui-hidden"
				name="criteria/_orderby[1]/_sort" value="arc">
			<table class="table" id="table1" style="height: 100%;">
				<tr style="width: 100%; height: 12%; line-height: 12%;">
					<td>
						<h4>快速查询：</h4>
					</td>
					<!-- lookup_type_code -->
					<td class="nui-button" id="lookup_type_code"
						style="margin-top: 5px;" plain="true">我接待的车</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[1]/likeRule"
						value="1" /></td>
					<!-- lookup_type_name -->
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">在报价的车</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">在维修的车</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">已完工的车</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>


					<td class="form_label" id="lookup_type_name">车牌号：</td>
					<td colspan="3"><input class="nui-textbox" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td property="footer"><a class="nui-button"
						iconCls="icon-search" onclick="search()">查询（Q）</a></td>

					<!-- 超链接模式 -->
					<!-- 
        	        <td>
        	        	<a href="../../index.html">首页</a> 
        	        </td>
        	         -->
				</tr>
			</table>
		</div>
	</div>

	<div class="nui-toolbar" id="div_1"
		style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%"><a class="nui-button" id="save"
					iconCls="icon-reload" onclick="reload()">刷新（R）</a> <a
					class="nui-button" id="add" iconCls="icon-add" onclick="add()">新增（A）</a>
					<a class="nui-button" id="save" iconCls="" onclick="save()">产品录入（P）</a>
					<a class="nui-button" id="save" iconCls="icon-save"
					onclick="save()">保存（S）</a> <a class="nui-button" id="save"
					iconCls="" onclick="save()">确定维修（T）</a> <a class="nui-button"
					id="save" iconCls="" onclick="save()">维修归档（G）</a> <a
					class="nui-button" id="save" iconCls="" onclick="save()">审核（V）</a>
					<a class="nui-button" id="save" iconCls="" onclick="save()">结算（J）</a>
					<a class="nui-button" id="save" iconCls="" onclick="save()">出单（D）</a>
					<a class="nui-button" id="save" iconCls="" onclick="save()">返单（F）</a>
					<a class="nui-button" id="save" iconCls="" onclick="save()">客户（G）</a>
					<a class="nui-MenuButton" id="save" iconCls="" onclick="save()">其他（O）</a>
					<a class="nui-MenuButton" id="save" iconCls="icon-print"
					onclick="print()">打印（P）</a></td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
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
    </script>
</body>
</html>