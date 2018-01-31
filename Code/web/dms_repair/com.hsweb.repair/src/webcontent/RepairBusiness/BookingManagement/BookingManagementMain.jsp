<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 11:24:15
  - Description:
-->
<head>
<title>预约管理</title>
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
						style="margin-top: 5px;" plain="true">本日预约车辆</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[1]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[1]/likeRule"
						value="1" /></td>
					<!-- lookup_type_name -->
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">本周预约车辆</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>
					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">本月预约车辆</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>

					<td class="form_label" id="lookup_type_name">车牌号：</td>
					<td colspan="3"><input class="nui-textbox" name="isDisabled"
						emptyText="请输入..." /> <input class="nui-hidden"
						name="criteria/_expr[2]/_op" value="=" /> <input
						class="nui-hidden" name="criteria/_expr[2]/likeRule" value="0" />
					</td>
					<td property="footer"><a class="nui-button"
						iconCls="icon-search" onclick="search()">查询（Q）</a></td>

					<td class="nui-button" id="lookup_type_name"
						style="margin-top: 5px;" plain="true">更多</td>
					<td colspan="3"><input class="nui-hidden" name="isDisabled" />
						<input class="nui-hidden" name="criteria/_expr[2]/_op" value="=" />
						<input class="nui-hidden" name="criteria/_expr[2]/likeRule"
						value="0" /></td>

					<td class="form_label" id="lookup_type_name">仅显示本人预约</td>
					<td colspan="3"><input class="nui-checkbox" name="isDisabled" />
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
					onclick="save()">保存（S）</a> <a class="nui-button" id="cancel"
					iconCls="icon-cancel" onclick="cancel()">取消（C）</a> <a
					class="nui-button" id="save" iconCls="" onclick="save()">预约跟踪（G）</a>
					<a class="nui-button" id="save" iconCls="" onclick="save()">转入报价（T）</a>
					<a class="nui-button" id="save" iconCls="" onclick="save()">维修历史（W）</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div class="nui-splitter" style="width: 100%; height: 100%;">
			<div size="25%" showCollapseButton="false">
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
								visible="true" width="30%">车牌号</div>
							<div id="name" field="name" headerAlign="center" allowSort="true"
								visible="true" width="30%">预约状态</div>
							<div id="captainName" field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="30%">预约来厂日期</div>
						</div>
					</div>
				</div>
			</div>
			<div showCollapseButton="false">

				<div class="nui-splitter"
					style="margin: 0; height: 100%; width: 100%;" vertical="true">
					<div size="60%" showCollapseButton="false">
						<div class="nui-panel" title="基本信息" id="div_1"
							style="border-bottom: 0; padding: 0px; width: 100%; height: 100%;">
							<div class="nui-fit">
								<span style="margin-left: 20px; margin-top: 10px;">车牌号：</span> <input
									class="nui-combobox" style="width: 14%; margin-top: 10px;" /> <span
									style="margin-left: 20px; margin-top: 10px;">品牌：</span> <input
									class="nui-combobox" style="width: 14%; margin-top: 10px;" /> </br>

								<span style="margin-left: 20px; margin-top: 10px;">车型：</span> <input
									class="nui-textbox" style="width: 70%; margin-top: 10px;" /></br> <span
									style="margin-left: 20px; margin-top: 10px;">联系人：</span> <input
									class="nui-textbox" style="width: 20%; margin-top: 10px;" /> <span
									style="margin-left: 20px; margin-top: 10px;">联系电话：</span> <input
									class="nui-textbox" style="width: 20%; margin-top: 10px;" /> <span
									style="margin-left: 20px; margin-top: 10px;">预约项目：</span> <input
									class="nui-combobox" style="width: 14%; margin-top: 10px;" /> </br>

								<span style="margin-left: 20px; margin-top: 10px;">预约来厂日期：</span>
								<input id="data" style="margin-top: 10px;"
									class="nui-datepicker" value="" nullValue="null"
									format="yyyy-MM-dd H:mm:ss" timeFormat="H:mm:ss"
									showTime="true" showOkButton="true" showClearButton="false" />
								<span style="margin-left: 20px; margin-top: 10px;">等级日期：</span>
								<input id="data" style="margin-top: 10px;"
									class="nui-datepicker" value="" nullValue="null"
									format="yyyy-MM-dd H:mm:ss" timeFormat="H:mm:ss"
									showTime="true" showOkButton="true" showClearButton="false" />
								<span style="margin-left: 20px; margin-top: 10px;">预约类型：</span>
								<input class="nui-combobox"
									style="width: 20%; margin-top: 10px;" /> </br> <span
									style="margin-left: 20px; margin-top: 10px;">预约单号：</span> <input
									class="nui-textbox" style="width: 5%; margin-top: 10px;" /> <span
									style="margin-left: 20px; margin-top: 10px;">登记人：</span> <input
									class="nui-textbox" style="width: 50%; margin-top: 10px;" /> </br> <span
									style="margin-left: 20px; margin-top: 10px;">客户描述：</span> <input
									class="nui-textarea"
									style="width: 96%; height: 38%; margin: 10px 20px 0 20px;" />

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
								allowSortColumn="true" virtualScroll="true"
								virtualColumns="true">
								<div property="columns">
									<div id="type" field="type" headerAlign="center"
										allowSort="true" visible="true" width="5%">序号</div>
									<div header="基本信息" headerAlign="center">
										<div property="columns">
											<div id="type" field="type" headerAlign="center"
												allowSort="true" visible="true" width="13%">跟踪人</div>
											<div id="name" field="name" headerAlign="center"
												allowSort="true" visible="true" width="13%">跟踪日期</div>
											<div id="captainName" field="captainName"
												headerAlign="center" allowSort="true" visible="true"
												width="13%">跟踪方式</div>
											<div id="isDisabled" field="isDisabled" headerAlign="center"
												allowSort="true" visible="true" width="13%">跟踪结果</div>
											<div id="isDisabled" field="isDisabled" headerAlign="center"
												allowSort="true" visible="true" width="13%">下次跟踪日期</div>
										</div>
									</div>
									<div header="详细信息" headerAlign="center">
										<div property="columns">
											<div id="type" field="type" headerAlign="center"
												allowSort="true" visible="true" width="33%">跟踪内容</div>
										</div>
									</div>
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
    </script>
</body>
</html>