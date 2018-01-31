<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 09:33:59
  - Description:
-->
<head>
<title>车险登记</title>
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
						style="margin-top: 7px;" plain="true">本日</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[1]/likeRule"
						value="1" /></td>
					<!-- lookup_type_name -->
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">今日</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">本周</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">上周</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">本月</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">上月</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">本年</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">上年</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>

					<td class="form_label" id="lookup_type_name">车牌号：</td>
					<td colspan="3"><input class="nui-textbox" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="form_label" id="lookup_type_name">客户名称：</td>
					<td colspan="3"><input class="nui-textbox" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td property="footer"><a class="nui-button"
						iconCls="icon-search" onclick="search()">查询（Q）</a></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 7px;" plain="true">更多</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>

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
					<a class="nui-button" id="save" iconCls="icon-save"
					onclick="save()">保存（S）</a> <a class="nui-button" id="save"
					iconCls="" onclick="save()">结算（S）</a> <a class="nui-button"
					id="undo" iconCls="icon-undo" onclick="undo()">返单（B）</a> <a
					class="nui-button" id="print" iconCls="icon-print"
					onclick="print()">打印（P）</a></td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div class="nui-splitter" style="width: 100%; height: 100%;">
			<div size="40%" showCollapseButton="false">
				<div class="nui-fit">
					<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
						style="width: 100%; height: 100%;"
						url="com.hsweb.repair.DataBase.class.ClassQuery.biz.ext"
						pageSize="50" showPageInfo="true" multiSelect="true"
						showReloadButton="true" showPagerButtonIcon="true"
						totalCount="total" onselectionchanged="selectionChanged"
						allowSortColumn="true">


						<div property="columns">
							<div id="type" field="type" headerAlign="center" allowSort="true"
								visible="true" width="35px">序号</div>
							<div header="">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="40px">状态</div>
								</div>
							</div>
							<div header="">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="60px">车牌号</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="80px">被保险人</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="60px">品牌</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="60px">车型</div>
								</div>
							</div>
							<div header="交强险" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="100px">购买日期</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="100px">到期日期</div>
								</div>
							</div>
							<div header="商业险" headerAlign="center">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="100px">购买日期</div>
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="100px">到期日期</div>
								</div>
							</div>
							<div header="">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="150px">工单号</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div showCollapseButton="false">
				<div id="mainTabs" class="nui-tabs" activeIndex="0"
					style="width: 100%; height: 100%;" plain="false" onactivechanged="">
					<div title="基本信息" url="./subpage/BasicMessage.jsp"></div>
					<div title="险种信息" url="./subpage/InsuranceType.jsp"></div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>